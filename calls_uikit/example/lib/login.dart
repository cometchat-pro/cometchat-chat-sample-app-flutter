import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_calls_uikit_example/dashboard.dart';
import 'package:cometchat_calls_uikit_example/sign_up.dart';
import 'package:cometchat_calls_uikit_example/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<MaterialButtonUserModel> userModelList = [
    MaterialButtonUserModel(
        "superhero1", "SUPERHERO1", "assets/ironman_avatar.png"),
    MaterialButtonUserModel(
        "superhero2", "SUPERHERO2", "assets/captainamerica_avatar.png"),
    MaterialButtonUserModel(
        "superhero3", "SUPERHERO3", "assets/spiderman_avatar.png"),
    MaterialButtonUserModel(
        "superhero4", "SUPERHERO4", "assets/cyclops_avatar.png"),
  ];
  String customUidLogin = "";
  String customAuthToken = "";
  String createUserId = "";

  @override
  void initState() {
    super.initState();

    //CometChat SDk should be initialized at the start of application. No need to initialize it again

    initialize();
    // AppSettings appSettings = (AppSettingsBuilder()
    //       ..subscriptionType = CometChatSubscriptionType.allUsers
    //       ..region = CometChatConstants.region
    //       ..autoEstablishSocketConnection = true)
    //     .build();
    //
    // CometChat.init(CometChatConstants.appId, appSettings,
    //     onSuccess: (String successMessage) {
    //   debugPrint("Initialization completed successfully  $successMessage");
    // }, onError: (CometChatException excep) {
    //   debugPrint("Initialization failed with exception: ${excep.message}");
    // });
    //initialization end
  }

  initialize() async {
    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = CometChatConstants.region
          ..autoEstablishSocketConnection = true
          ..appId = CometChatConstants.appId
          // ..adminHost =
          //     "${CometChatConstants.appId}.api-${CometChatConstants.region}.cometchat-staging.com/v3.0"
          // ..clientHost =
          //     "${CometChatConstants.appId}.apiclient-${CometChatConstants.region}.cometchat-staging.com/v3.0"
          ..authKey = CometChatConstants.authKey
          ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions()
          ..callingExtension = CometChatCallingExtension())
        .build();

    CometChatUIKit.init(
        uiKitSettings: uiKitSettings,
        onSuccess: (String successMessage) {
          debugPrint("Initialization completed successfully  $successMessage");
          if (CometChatUIKit.loggedInUser != null) {
            navigate();
          }
        },
        onError: (CometChatException e) {
          debugPrint("Initialization failed with exception: ${e.message}");
        });
  }

  navigate() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DashBoard()));
  }

  //Login User function must pass userid and authkey should be used only while developing
  loginUser(String userId) async {
    showLoadingIndicatorDialog();
    User? user = await CometChat.getLoggedInUser();
    try {
      if (user != null) {
        await CometChatUIKit.logout(onSuccess: (_) {}, onError: (_) {});
      }
    } catch (_) {}

    // await CometChatUIKit.login(userId, onSuccess: (User loggedInUser) {
    //   debugPrint("Login Successful from UI : $loggedInUser");
    //   _user = loggedInUser;
    // }, onError: (CometChatException e) {
    //   Navigator.of(context).pop();
    //   debugPrint("Login failed with exception:  ${e.message}");
    // });
    user = await CometChatUIKit.login(userId);

    // await CometChat.login(userId, CometChatConstants.authKey,
    //     onSuccess: (User loggedInUser) {
    //   debugPrint("Login Successful : $loggedInUser");
    //   _user = loggedInUser;
    // }, onError: (CometChatException e) {
    //   debugPrint("Login failed with exception:  ${e.message}");
    // });

    if (mounted) {
      Navigator.of(context).pop();
    }

    //if login is successful
    if (user != null && mounted) {
      //USERID = _user!.uid;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
      // context, MaterialPageRoute(builder: (context) => const SlackUseCase()));
    }
  }

  loginUserWithAuthToken(String userId) async {
    showLoadingIndicatorDialog();

    User? user = await CometChat.getLoggedInUser();
    // print("Login Successful");
    try {
      if (user != null) {
        await CometChatUIKit.logout(onSuccess: (_) {}, onError: (_) {});
      }
    } catch (_) {}

    await CometChatUIKit.loginWithAuthToken(userId,
        onSuccess: (User loggedInUser) {
      debugPrint("Login Successful : $loggedInUser");
      user = loggedInUser;
    }, onError: (CometChatException e) {
      debugPrint("Login failed with exception:  ${e.message}");
    });

    if (mounted) {
      Navigator.of(context).pop();
    }

    //if login is successful
    if (user != null && mounted) {
      //USERID = _user!.uid;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
      // context, MaterialPageRoute(builder: (context) => const SlackUseCase()));
    }
  }

  Widget userSelectionButton(MaterialButtonUserModel model) {
    return MaterialButton(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        loginUser(model.userId);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              model.imageURL,
              height: 30,
              width: 30,
            ),
          ),
          Text(
            model.userId,
            style: const TextStyle(color: Colors.white, fontSize: 14.0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/cometchat_logo.png", height: 100, width: 100),
              const Text(
                "CometChat",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Sample App",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Wrap(
                children: [
                  Text(
                    "Login with one of our sample user",
                    style: TextStyle(color: Colors.black38, fontSize: 30),
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),

              //All available user Ids in grid
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3.0,
                children: List.generate(userModelList.length,
                    (index) => userSelectionButton(userModelList[index])),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New to cometchat? "),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const Wrap(
                children: [
                  Text(
                    "Login with Custom UID",
                    style: TextStyle(color: Colors.black38, fontSize: 25),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 46,
                child: TextFormField(
                  onChanged: (val) {
                    customUidLogin = val;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UID',
                    hintText: 'UID',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.black,
                  height: 45,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    if (customUidLogin.isNotEmpty) {
                      loginUser(customUidLogin);
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),

              const Divider(),
              const Wrap(
                children: [
                  Text(
                    "Login with Auth token",
                    style: TextStyle(color: Colors.black38, fontSize: 25),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 46,
                child: TextFormField(
                  onChanged: (val) {
                    customAuthToken = val;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Auth token',
                    hintText: 'Auth token',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.black,
                  height: 45,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    if (customAuthToken.isNotEmpty) {
                      loginUserWithAuthToken(customAuthToken);
                    }
                  },
                  child: const Text(
                    "Auth token",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),

              const Divider(),

              Center(
                child: MaterialButton(
                  color: Colors.black,
                  height: 45,
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    User user = User(uid: "usrrr1", name: "Nya user");

                    CometChatUIKit.createUser(user, onSuccess: (User user) {
                      debugPrint("Create User successful $user");
                    }, onError: (CometChatException e) {
                      debugPrint(
                          "Create User Failed with exception ${e.message}");
                    });
                  },
                  child: const Text(
                    "Create User",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              )
            ],
          )),
        ),
      )),
    );
  }

  showLoadingIndicatorDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 220,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 45,
                    child: Image.asset("assets/cometchat_logo.png"),
                  ),
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class MaterialButtonUserModel {
  String username;
  String userId;
  String imageURL;

  MaterialButtonUserModel(this.username, this.userId, this.imageURL);
}
