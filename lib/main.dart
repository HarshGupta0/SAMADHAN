// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'HomePage.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Firebase Request',
//       home: HomePage(),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testgih/widgets/CustomButtom.dart';
import 'package:testgih/widgets/CustomTextFeild.dart';

import 'HomePage.dart';
import 'firebase_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginView();
        }
      },
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check for user persistence on app start
    // checkUserPersistence();
  }

  // Function to check if the user is already logged in
  // void checkUserPersistence() async {
  //   String? uid = await _getUserUid();
  //   if (uid != null && uid.isNotEmpty) {
  //     // User is already logged in, navigate to HomeView
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.lightBlue.shade200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 * .7 + 20,
                  child: Container(
                    // child: LottieBuilder.asset(
                    //   "assets/lottie/lottie3.json",
                    //   width: MediaQuery.of(context).size.width,
                    // ),

                  ),

                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Login Here",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText:"HREEEEE",
                            isPassword: false,
                            textEditingController: emailController,
                          ),
                          CustomTextField(
                            hintText: "HEREEE",
                            isPassword: true,
                            textEditingController: passwordController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forget Password?",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Get.to(() => SignUpView());
                                },
                                child: Text(
                                  "New User!!",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onTap: () {
                              signInWithEmailAndPassword(emailController.text, passwordController.text, context);
                            },
                            ButtonText: "Sign in",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

