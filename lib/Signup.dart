import 'package:flutter/material.dart';
import 'package:testgih/widgets/CustomButtom.dart';
import 'package:testgih/widgets/CustomTextFeild.dart';

import 'firebase_functions.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController(); // Changed variable name

  final _formKey = GlobalKey<FormState>(); // Added form key

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

                Container(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey, // Assigned the form key
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                              child:Text("SAMADHAN", style: TextStyle(fontFamily: 'Roboto Sheriff', fontSize: 45),)
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              " Create an Account ",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          CustomTextField(
                            hintText: "",
                            isPassword: false,
                            textEditingController: nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          CustomTextField(
                            hintText: '',
                            isPassword: false,
                            textEditingController: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),

                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Password", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          CustomTextField(
                            hintText: "",
                            isPassword: true,
                            textEditingController: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          CustomTextField(
                            textEditingController: passwordController,
                            hintText: "",
                            isPassword: true,
                            validator: (value) {
                              if (value!= passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                createUserWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                  context,
                                );
                              }
                            },
                            ButtonText: "Sign Up",
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Already have Account", style: TextStyle(fontSize: 20),),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Login", style: TextStyle(fontSize: 20),),
                                ),
                              ],
                            ),
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
