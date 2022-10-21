import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/screens/profile_page.dart';
import 'package:flutter_authentication/screens/register_page.dart';
import 'package:flutter_authentication/utils/fire_auth.dart';
import 'package:flutter_authentication/utils/validator.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
appBar: AppBar(backgroundColor: const Color(0xff59BEE6),

  title: Text('Flutter Movies App'),
),
          body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                    children:[   Container(

                      padding: const EdgeInsets.only(left: 140, top: 80),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 33),
                      ),
                    ),SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 35,
                            left: 35,
                            top: MediaQuery.of(context).size.height * 0.25),
                        child: Column(

                          children: [

                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _emailTextController,
                                    focusNode: _focusEmail,
                                    validator: (value) => Validator.validateEmail(
                                      email: value,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 25.0),
                                  TextFormField(
                                    controller: _passwordTextController,
                                    focusNode: _focusPassword,
                                    obscureText: true,
                                    validator: (value) => Validator.validatePassword(
                                      password: value,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 40.0),
                                  _isProcessing
                                      ? CircularProgressIndicator()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  _focusEmail.unfocus();
                                                  _focusPassword.unfocus();

                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      _isProcessing = true;
                                                    });

                                                    User? user = await FireAuth
                                                        .signInUsingEmailPassword(
                                                      email: _emailTextController.text,
                                                      password:
                                                          _passwordTextController.text,
                                                    );

                                                    setState(() {
                                                      _isProcessing = false;
                                                    });

                                                    if (user != null) {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyHomePage(user: user),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 24.0),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterPage(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Register',
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )],

                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
