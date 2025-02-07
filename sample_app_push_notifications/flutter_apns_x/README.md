# flutter_apnsX

A new Flutter project for IOS Notification using apns token

The flutter_apns plugin has been migrated and deprecated issue Resolved 👍

✅ DEPRECATED ISSUE RESOLVED ✅

This package is not longer maintained.
Please write message or GitHub issue if you want to take it over and end deprecated state.

Plugin to implement APNS push notifications on iOS and Firebase on Android.

## Why this plugin was made?

Currently, the only available push notification plugin is `firebase_messaging`. This means that, even on iOS, you will need to setup firebase and communicate with Google to send push notification. This plugin solves the problem by providing native APNS implementation while leaving configured Firebase for Android.

## Usage
1. Configure firebase on Android according to instructions: https://pub.dartlang.org/packages/firebase_messaging.
2. On iOS, make sure you have correctly configured your app to support push notifications, and that you have generated certificate/token for sending pushes. For more infos see section [How to run example app on iOS](#how-to-run-example-app-on-ios)

3. Add the following lines to the `didFinishLaunchingWithOptions` method in the AppDelegate.m/AppDelegate.swift file of your iOS project

Objective-C:
```objc
if (@available(iOS 11.0, *)) {
  [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
}
```

Swift:
```swift
if #available(iOS 11.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
```

4. Add `flutter_apns` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
5. Using `createPushConnector()` method, configure push service according to your needs. `PushConnector` closely resembles `FirebaseMessaging`, so Firebase samples may be useful during implementation. You should create the connector as soon as possible to get the onLaunch callback working on closed app launch.
```dart
import 'package:flutter_apnsX/flutter_apns/flutter_apns_only_x.dart';

final connector = createPushConnector();

  connector.configureApns(
    onLaunch: (data) => onPush('onResume', data.payload.values.single),
    onResume: (data) => onPush('onResume', data.payload.values.single),
    onMessage: (data) => onPush('onResume', data.payload.values.single),
    onBackgroundMessage: (data) => onPush('onMessage', data.payload.values.single,)
  );
  //requestNotificationPermissions//
  connector.requestNotificationPermissions()
  //token value get//
  connector.token.addListener(() {
      print('Token ${connector.token.value}');
  });
```
6. Build on device and test your solution using Firebase Console (Android) and CURL (iOS, see [How to run example app on iOS](#how-to-run-example-app-on-ios)).

## Additional APNS features:
### Displaying notification while in foreground

```dart
final connector = createPushConnector();
if (connector is ApnsPushConnector) {
  connector.shouldPresent = (x) => Future.value(true);
}
```

### Handling predefined actions

Firstly, configure supported actions:
```dart
final connector = createPushConnector();
if (connector is ApnsPushConnector) {
  connector.setNotificationCategories([
    UNNotificationCategory(
      identifier: 'MEETING_INVITATION',
      actions: [
        UNNotificationAction(
          identifier: 'ACCEPT_ACTION',
          title: 'Accept',
          options: [],
        ),
        UNNotificationAction(
          identifier: 'DECLINE_ACTION',
          title: 'Decline',
          options: [],
        ),
      ],
      intentIdentifiers: [],
      options: [],
    ),
  ]);
}
```

Then, handle possible actions in your push handler:
```dart
Future<dynamic> onPush(String name, RemoteMessage payload) {
  final action = UNNotificationAction.getIdentifier(payload.data);

  if (action == 'MEETING_INVITATION') {
    // do something
  }

  return Future.value(true);
}
```

Note: if user clickes your notification while app is in the background, push will be delivered through onResume without actually waking up the app. Make sure your handling of given action is quick and error free, as execution time in for apps running in the background is very limited.

Check the example project for fully working code.

## Enabling FirebaseCore
If you want to use firebase, but not firebase messaging, add this configuration entry in your Info.plist (to avoid MissingPluginException):

```
<key>flutter_apns.disable_firebase_core</key>
<false/>
```

## flutter_apns_only - APNS without firebase
If only care about apns - use flutter_apns_only plugin. It does not depend on firebase. To ensure no swizzling (which is needed by original plugin to disable firebase) takes place, add this configuration entry in your Info.plist:

```plist
<key>flutter_apns.disable_swizzling</key>
<true/>
```

## Troubleshooting

1. Ensure that you are testing on actual device. NOTE: this may not be needed from 11.4: https://ohmyswift.com/blog/2020/02/13/simulating-remote-push-notifications-in-a-simulator/
2. If onToken method is not being called, add error logging to your AppDelegate, see code below.
3. Open Console app for macOS, connect your device, and run your app. Search for "PUSH registration failed" string in logs. The error message will tell you what was wrong.

*swift*
```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
     NSLog("PUSH registration failed: \(error)")
  }
}

```

*objc*
```objc
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error);
}

@end
```
## How to run example app on iOS
Setting up push notifications on iOS can be tricky since there is no way to permit Apple Push Notification Service (APNS) which requires a complicated certificate setup. The following guide describes a step by step approach to send push notifications from your Mac to an iPhone utilizing the example app of this package. This guide only describes debug environment setup.

1. Open example ios folder with Xcode
2. Select Runner -> Signing & Capabilities
3. Select your development team and add a globally unique bundle identifier. The one on the picture is already occupied:
   ![](example/assets/Xcode_setup.png?raw=true)
4. Go to https://developer.apple.com/account/resources/identifiers/list/bundleId and press on the plus button
5. Select "App IDs" and press continue
   ![](example/assets/register_app.png?raw=true)
6. Select type "App"
7. Select "App ID Prefix" which should be same as "Team ID"
8. Enter description and bundle ID. The latter one needs to be the same as the bundle ID specified in 3.
9. Select push notification capability
   ![](example/assets/select_capability.png?raw=true)
11. Press on "Continue" and then on "Register"
12. Go to https://developer.apple.com/account/resources/certificates and add a new certificate by pressing on the plus-button.
13. Select 'Apple Push Notification service SSL (Sandbox & Production)'
    ![](example/assets/push_notification_setup.png?raw=true)
14. Select the app ID that you hav defined in point 4.-10.
15. Select a Certificate Signing Request (CSR) file. See https://help.apple.com/developer-account/#/devbfa00fef7 on how to create this certificate
16. When having finished, download the newly created Apple Push Services certificate
17. Add certificate to your local keychain by opening the newly downloaded file
18. Press on "login" on the upper left corner of your keychain window and select the tab "My Certificates"
    ![](example/assets/keychain.png?raw=true)
19. Right click on the Apple-Push-Services-certificate and export it as .p12-file
20. Convert p12-file to pem-file by following command. Please consider that "flutterApns" needs to be replaced by your respective certificate name.<br>
    [More info](https://stackoverflow.com/questions/1762555/creating-pem-file-for-apns)
    ```
    openssl pkcs12 -in flutterApns.p12 -out flutterApns.pem -nodes -clcerts
    ```
21. Start example app on physical iPhone device from Xcode or your favorite IDE.
22. Device token gets automatically printed when application was able to retrieve push token from APNS. This happens after accepting notification permission prompt.
23. Send the following CURL from you development Mac. You can execute CURLs by copy-pasting them into Terminal and hit enter.<br>
    [More info](https://gist.github.com/greencoder/16d1f8d7b0fed5b49cf64312ce2b72cc)
    ```curl
    curl -v \
    -d '{"aps":{"alert":"<your_message>","badge":2}}' \
    -H "apns-topic: <bundle_identifier_of_registered_app>" \
    -H "apns-priority: 10" \
    --http2 \
    --cert <file_path_to_downloaded_signed_and_converted_certificate>.pem \
    https://api.development.push.apple.com/3/device/<device_token>
    ```
24. A push notification does appear if the example app is in background.

When not utilizing the example app, you need to additionally [setup push notification capability inside Xcode](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns) and add the code mentioned in [usage](#usage).
