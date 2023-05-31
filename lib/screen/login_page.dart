import 'dart:html';
import 'dart:html' as html;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/user_data.dart';
import '../provider/detect_renters_IDandName.dart';
import '../widgets/custom_toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    window.location.reload();

    super.dispose();
  }

  // load data here
  @override
  void initState() {
    super.initState();
    final email = html.window.localStorage['email'];
    final password = html.window.localStorage['password'];
    if (email != null && password != null) {
      _emailController.text = email;
      _passwordController.text = password;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    var users = Provider.of<userData>(context, listen: false);
    bool rememberme = false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            width: 400,
            height: 500,
            child: Card(
              elevation: 1,
              color: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                padding: EdgeInsets.all(40),
                alignment: Alignment.center,
                // color: Colors.deepPurpleAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 30, top: 10),
                      child: Text(
                        'Welcome to BT SQUARE',
                        style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Color.fromARGB(255, 24, 92, 209),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),

                    ///////
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 20),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          try {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            if (rememberme == true) {
                              if (html.window.localStorage['email'] == null &&
                                      html.window.localStorage['password'] ==
                                          null ||
                                  html.window.localStorage['email'] == '' &&
                                      html.window.localStorage['password'] ==
                                          '') {
                                // Save email and password to localStorage
                                html.window.localStorage['email'] = email;
                                html.window.localStorage['password'] = password;
                              }
                            }

                            String type =
                                users.userChacking(email, password) as String;
                            _emailController.clear();
                            _passwordController.clear();

                            if (type != 'No') {
                              final myProvider =
                                  Provider.of<DetectRentersIdandName>(
                                context,
                                listen: false,
                              );
                              myProvider.type = type;

                              Navigator.of(context).pushNamed(
                                '/MainPageScreen',
                              );
                            } else {
                              CustomToast.showToast(
                                context,
                                'Wrong password or Mail, please try again!',
                                2,
                              );
                              print('gg');
                            }
                          } catch (e) {
                            CustomToast.showToast(
                              context,
                              'Something is wrong, please try again!' +
                                  e.toString(),
                              2,
                            );
                            print(e.toString());
                          }
                        },
                        label: const Text('Login'),
                        icon: const Icon(
                          Icons.login,
                          size: 25,
                        ),
                        backgroundColor: Color.fromARGB(255, 24, 92, 209),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          rememberme = true;

                          // Add your onPressed code here
                        },
                        backgroundColor: Color.fromARGB(255, 131, 240, 88),
                        label: const Text(
                          'Add',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: const Icon(
                          Icons.save,
                          size: 15,
                        ),
                      ),
                    ),

                    Container(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          html.window.localStorage.remove('email');
                          html.window.localStorage.remove('password');

                          setState(() {
                            _emailController.text = '';
                            _passwordController.text = '';
                          });

                          // Add your onPressed code here
                        },
                        backgroundColor: Color.fromARGB(255, 244, 142, 135),
                        label: const Text(
                          'Remove',
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: const Icon(
                          Icons.delete,
                          size: 15,
                        ),
                      ),
                    ),

                    //////
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
