import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:master_app/dashboard.dart';
import 'package:master_app/models/material_button_user_model.dart';
import 'package:master_app/services/api_services.dart';
import 'package:master_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'login_with_uid.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Widget userSelectionButton(
    MaterialButtonUserModel model,
    BuildContext context,
  ) {
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    return MaterialButton(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        loginUser(model.userId, context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: colorPalette.white,
              child: model.imageURL.startsWith('http')
                  ? Image.network(
                      model.imageURL,
                      height: 30,
                      width: 30,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported); // Show fallback image
                      }
                    )
                  : Image.asset(
                      model.imageURL,
                      height: 30,
                      width: 30,
                    ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                model.username,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Login User function must pass userid and authkey should be used only while developing
  loginUser(String userId, context) async {
    Alert.showLoadingIndicatorDialog(context);
    User? user = await CometChat.getLoggedInUser();

    try {
      if (user != null) {
        if (user.uid == userId) {
          Navigator.of(context).pop();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
          return;
        } else {
          await CometChat.logout(
              onSuccess: (_) {},
              onError:
                  (_) {}); //if logging in user is different from logged in user
        }
      }
    } catch (_) {}

    await CometChatUIKit.login(userId, onSuccess: (User loggedInUser) {
      debugPrint("Login Successful from UI : $loggedInUser");
      Navigator.of(context).pop();
      user = loggedInUser;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }, onError: (CometChatException e) {
      Navigator.of(context).pop();
      debugPrint("Login failed with exception:  ${e.message}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    return Scaffold(
      backgroundColor: colorPalette.background1,
      appBar: AppBar(
        backgroundColor: colorPalette.background1,
        leading: const SizedBox(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/cometchat_logo.png",
                height: 100,
                width: 100,
              ),
              Text(
                "CometChat",
                style: TextStyle(
                  color: colorPalette.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Login with one of our sample users",
                style: TextStyle(color: colorPalette.textPrimary),
              ),
              const SizedBox(height: 30.0),
              // Use FutureBuilder to handle async operation and show loader
              FutureBuilder<List<MaterialButtonUserModel>>(
                future: ApiServices.fetchUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MaterialButtonUserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show loader while fetching data
                    return Center(
                      child: Image.asset(
                        AssetConstants.spinner,
                        package: UIConstants.packageName,
                        color: colorPalette.iconSecondary,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Show user selection buttons
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3.0,
                      children: (snapshot.data ?? []).take(4).map((user) {
                        return userSelectionButton(user, context);
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              Text(
                "or continue login with",
                style: TextStyle(color: colorPalette.textPrimary),
              ),
              const SizedBox(height: 30),
              Center(
                child: MaterialButton(
                  color: colorPalette.textHighlight,
                  height: 45,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginWithUID(),
                      ),
                    );
                  },
                  child: Text(
                    "Login using UID",
                    style: TextStyle(
                        color: colorPalette.textPrimary, fontSize: 14.0,),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "New to CometChat? ",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15,
              //         color: colorPalette.textPrimary,
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const SignUp(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         "CREATE NEW",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15,
              //           color: colorPalette.textHighlight,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
