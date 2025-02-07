import Flutter
import UserNotifications

func getFlutterError(_ error: Error) -> FlutterError {
    let e = error as NSError
    return FlutterError(code: "Error: \(e.code)", message: e.domain, details: error.localizedDescription)
}

@objc public class FlutterApnsPlugin: NSObject, FlutterPlugin, UNUserNotificationCenterDelegate {
    internal init(channel: FlutterMethodChannel) {
        self.channel = channel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_apns", binaryMessenger: registrar.messenger())
        let instance = FlutterApnsPlugin(channel: channel)
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    let channel: FlutterMethodChannel
    var launchNotification: [String: Any]?
    var resumingFromBackground = false
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "requestNotificationPermissions":
            requestNotificationPermissions(call, result: result)
        case "configure":
            assert(
                UNUserNotificationCenter.current().delegate != nil,
                "UNUserNotificationCenter.current().delegate is not set. Check readme at https://pub.dev/packages/flutter_apns."
            )
            UIApplication.shared.registerForRemoteNotifications()

            // check for onLaunch notification *after* configure has been ran
            if let launchNotification = launchNotification {
                channel.invokeMethod("onLaunch", arguments: launchNotification)
                self.launchNotification = nil
                return
            }
            result(nil)
        case "getAuthorizationStatus":
            getAuthorizationStatus(result)
        case "unregister":
            UIApplication.shared.unregisterForRemoteNotifications()
            result(nil)
        case "setNotificationCategories":
            setNotificationCategories(arguments: call.arguments!)
            result(nil)
        default:
            assertionFailure(call.method)
            result(FlutterMethodNotImplemented)
        }
    }

    func setNotificationCategories(arguments: Any) {
        let arguments = arguments as! [[String: Any]]
        func decodeCategory(map: [String: Any]) -> UNNotificationCategory {
            return UNNotificationCategory(
                identifier: map["identifier"] as! String,
                actions: (map["actions"] as! [[String: Any]]).map(decodeAction),
                intentIdentifiers: map["intentIdentifiers"] as! [String],
                options: decodeCategoryOptions(data: map["options"] as! [String])
            )
        }
        func decodeCategoryOptions(data: [String]) -> UNNotificationCategoryOptions {
            let mapped = data.compactMap {
                UNNotificationCategoryOptions.stringToValue[$0]
            }
            return .init(mapped)
        }

        func decodeAction(map: [String: Any]) -> UNNotificationAction {
            return UNNotificationAction(
                identifier: map["identifier"] as! String,
                title: map["title"] as! String,
                options: decodeActionOptions(data: map["options"] as! [String])
            )
        }

        func decodeActionOptions(data: [String]) -> UNNotificationActionOptions {
            let mapped = data.compactMap {
                UNNotificationActionOptions.stringToValue[$0]
            }
            return .init(mapped)
        }

        let categories = arguments.map(decodeCategory)
        UNUserNotificationCenter.current().setNotificationCategories(Set(categories))
    }

    func getAuthorizationStatus(_ result: @escaping FlutterResult) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                result("authorized")
            case .denied:
                result("denied")
            case .notDetermined:
                result("notDetermined")
            default:
                result("unsupported")
            }
        }
    }
    
    func requestNotificationPermissions(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let center = UNUserNotificationCenter.current()
        let application = UIApplication.shared
        
        func readBool(_ key: String) -> Bool {
            (call.arguments as? [String: Any])?[key] as? Bool ?? false
        }
        
        assert(center.delegate != nil)
        
        var options = [UNAuthorizationOptions]()
        
        if readBool("sound") {
            options.append(.sound)
        }
        if readBool("badge") {
            options.append(.badge)
        }
        if readBool("alert") {
            options.append(.alert)
        }
        
        var provisionalRequested = false
        if #available(iOS 12.0, *) {
            if readBool("provisional") {
                options.append(.provisional)
                provisionalRequested = true
            }
        }

        
        let optionsUnion = UNAuthorizationOptions(options)
        
        center.requestAuthorization(options: optionsUnion) { (granted, error) in
            if let error = error {
                result(getFlutterError(error))
                return
            }
            
            center.getNotificationSettings { (settings) in
                let map = [
                    "sound": settings.soundSetting == .enabled,
                    "badge": settings.badgeSetting == .enabled,
                    "alert": settings.alertSetting == .enabled,
                    "provisional": granted && provisionalRequested
                ]
                
                self.channel.invokeMethod("onIosSettingsRegistered", arguments: map)
            }
            
            result(granted)
        }
        
        application.registerForRemoteNotifications()
    }
    
    //MARK:  - AppDelegate
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        if let launchNotification = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: Any] {
            self.launchNotification = FlutterApnsSerialization.remoteMessageUserInfo(toDict: launchNotification)
        }
        return true
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        resumingFromBackground = true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        resumingFromBackground = false
        UIApplication.shared.applicationIconBadgeNumber = -1;
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        channel.invokeMethod("onToken", arguments: deviceToken.hexString)
    }
    
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        let userInfo = FlutterApnsSerialization.remoteMessageUserInfo(toDict: userInfo)
        
        if resumingFromBackground {
            onResume(userInfo: userInfo)
        } else {
            channel.invokeMethod("onMessage", arguments: userInfo)
        }
        
        completionHandler(.noData)
        return true
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        guard userInfo["aps"] != nil else {
            return
        }
        
        let dict = FlutterApnsSerialization.remoteMessageUserInfo(toDict: userInfo)
        
        channel.invokeMethod("willPresent", arguments: dict) { (result) in
            let shouldShow = (result as? Bool) ?? false
            if shouldShow {
                completionHandler([.alert, .sound])
            } else {
                completionHandler([])
                let userInfo = FlutterApnsSerialization.remoteMessageUserInfo(toDict: userInfo)
                self.channel.invokeMethod("onMessage", arguments: userInfo)
            }
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        var userInfo = response.notification.request.content.userInfo
        guard userInfo["aps"] != nil else {
            return
        }
        
        userInfo["actionIdentifier"] = response.actionIdentifier
        let dict = FlutterApnsSerialization.remoteMessageUserInfo(toDict: userInfo)
        
        if launchNotification != nil {
            launchNotification = dict
            return
        }

        onResume(userInfo: dict)
        completionHandler()
    }
    
    func onResume(userInfo: [AnyHashable: Any]) {
        channel.invokeMethod("onResume", arguments: userInfo)
    }
}

extension UNNotificationCategoryOptions {
    static let stringToValue: [String: UNNotificationCategoryOptions] = {
        var r: [String: UNNotificationCategoryOptions] = [:]
        r["UNNotificationCategoryOptions.customDismissAction"] = .customDismissAction
        r["UNNotificationCategoryOptions.allowInCarPlay"] = .allowInCarPlay
        if #available(iOS 11.0, *) {
            r["UNNotificationCategoryOptions.hiddenPreviewsShowTitle"] = .hiddenPreviewsShowTitle
        }
        if #available(iOS 11.0, *) {
            r["UNNotificationCategoryOptions.hiddenPreviewsShowSubtitle"] = .hiddenPreviewsShowSubtitle
        }
        if #available(iOS 13.0, *) {
            r["UNNotificationCategoryOptions.allowAnnouncement"] = .allowAnnouncement
        }
        return r
    }()
}

extension UNNotificationActionOptions {
    static let stringToValue: [String: UNNotificationActionOptions] = {
        var r: [String: UNNotificationActionOptions] = [:]
        r["UNNotificationActionOptions.authenticationRequired"] = .authenticationRequired
        r["UNNotificationActionOptions.destructive"] = .destructive
        r["UNNotificationActionOptions.foreground"] = .foreground
        return r
    }()
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
