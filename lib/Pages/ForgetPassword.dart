import 'dart:convert';
import "package:flutter/material.dart";
import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'WelcomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown[600],
              Colors.brown[700],
              Colors.brown[800],
              Colors.brown[900],
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: GoogleFonts.yanoneKaffeesatz(
                    fontSize: 30,
                    height: 1.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                usernameTextField(),
                SizedBox(
                  height: 15,
                ),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, String> data = {
                      "password": _passwordController.text
                    };
                    print("/user/update/${_usernameController.text}");
                    var response = await networkHandler.patch(
                        "/user/update/${_usernameController.text}", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print("/user/update/${_usernameController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                          (route) => false);
                    }

                    // login logic End here
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                              "Update Password",
                              style: GoogleFonts.yanoneKaffeesatz(
                                fontSize: 20,
                                height: 1.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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

  Widget usernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            controller: _usernameController,
            style: GoogleFonts.yanoneKaffeesatz(
              fontSize: 15,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Username',
              hintStyle: GoogleFonts.yanoneKaffeesatz(
                fontSize: 18,
                height: 1.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        // Text("Username"),
        // TextFormField(
        //   controller: _usernameController,
        //   decoration: InputDecoration(
        //     errorText: validate ? null : errorText,
        //     focusedBorder: UnderlineInputBorder(
        //       borderSide: BorderSide(
        //         color: Colors.black,
        //         width: 2,
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  //  errorText: validate ? null : errorText,

  Widget passwordTextField() {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length <= 7) return "Password Must be greater than 7";
              return null;
            },
            obscureText: !_showPassword,
            style: GoogleFonts.yanoneKaffeesatz(
              fontSize: 15,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _togglevisibility();
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              ),
              hintText: 'Enter your Password',
              hintStyle: GoogleFonts.yanoneKaffeesatz(
                fontSize: 18,
                height: 1.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
