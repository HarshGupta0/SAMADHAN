import 'package:flutter/material.dart';
import 'package:testgih/Signup.dart';
import 'package:testgih/firebase_functions.dart';
import 'package:testgih/widgets/CustomButtom.dart';
import 'package:testgih/widgets/CustomTextFeild.dart';

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
          color: Color(0xFFB3B1D3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                    child:Text("SAMADHAN")
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
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
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Email"),
                          ),
                          CustomTextField(
                            hintText: "",
                            isPassword: false,
                            textEditingController: emailController,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Password"),
                          ),
                          CustomTextField(
                            hintText: "",
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
                                  style: TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context)=> SignUpView()
                                      )
                                  );
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 16, color: Colors.blue, decoration: TextDecoration.underline, decorationColor: Colors.blue),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "image/Vector.png",
                                height: 250,
                                width: 250,
                              )
                            ],
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
