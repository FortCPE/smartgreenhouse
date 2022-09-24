// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smartgreenhouse/models/profile.dart';
import 'package:smartgreenhouse/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile(
      username: "null",
      email: "null",
      password: "null",
      confirmpassword: "null");
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(child: Text("${snapshot.error}")),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              body: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: SafeArea(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        // WELCOME MSG
                        SizedBox(height: 30),
                        Image.asset("assets/images/logo.png"),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(children: <Widget>[
                              Text(
                                "REGISTER",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )
                            ]),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "กรุณากรอกอีเมลด้วยครับ"),
                                  EmailValidator(
                                      errorText:
                                          "กรุณากรอกอีเมลให้ถูกต้องด้วยครับ")
                                ]),
                                onSaved: (email) {
                                  profile.email = email.toString();
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email..."),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // USERNAME
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: "กรุณากรอกรหัสผ่านด้วยครับ"),
                                onSaved: (password) {
                                  profile.password = password.toString();
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password..."),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // USERNAME
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(80.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                validator: RequiredValidator(
                                    errorText: "กรุณายืนยันรหัสผ่านด้วยครับ"),
                                onSaved: (confirmpassword) {
                                  profile.confirmpassword =
                                      confirmpassword.toString();
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm Password..."),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width * 0.37,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        gradient: LinearGradient(colors: [
                                          Color.fromARGB(255, 91, 46, 0),
                                          Color.fromARGB(255, 139, 73, 19)
                                        ])),
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      formkey.currentState?.save();
                                      if (profile.password ==
                                          profile.confirmpassword) {
                                        try {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: profile.email,
                                                  password: profile.password)
                                              .then((value) {
                                            formkey.currentState?.reset();
                                            Fluttertoast.showToast(
                                                msg:
                                                    "สมัครสมาชิกเรียบร้อยแล้วครับ",
                                                gravity: ToastGravity.BOTTOM);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return LoginScreen();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          print(e.code);
                                          if (e.code == "weak-password") {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "กรุณากรอกรหัสผ่านอย่างต่ำ 6 ตัวอักษรครับ",
                                                gravity: ToastGravity.BOTTOM);
                                          } else if (e.code ==
                                              "email-already-in-use") {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "ขออภัยครับ, อีเมลนี้ถูกใช้งานแล้ว",
                                                gravity: ToastGravity.BOTTOM);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "ขออภัยครับ, ไม่สามารถสมัครสมาชิกได้",
                                                gravity: ToastGravity.BOTTOM);
                                          }
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "รหัสผ่านไม่ตรงกันค่ะ",
                                            gravity: ToastGravity.BOTTOM);
                                      }
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: size.width * 0.37,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        gradient: LinearGradient(colors: [
                                          Color.fromARGB(255, 0, 91, 11),
                                          Color.fromARGB(255, 0, 62, 32)
                                        ])),
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        // PASSWORD

                        // LOGIN BUTTON

                        // NO MEMBER
                      ])),
                ),
              ));
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
