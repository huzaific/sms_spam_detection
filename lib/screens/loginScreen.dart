import 'package:flutter/material.dart';
import 'package:sms_spam_detection/presentation/MatColor.dart';
import 'package:sms_spam_detection/presentation/styles.dart';
import 'package:sms_spam_detection/utils/Apicalls.dart';
import 'package:sms_spam_detection/utils/SharedPrefrences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var loading = false;

  _onLoginClick() async {
    if (emailController.text.isNotEmpty) {
      setState(() {
        loading = true;
      });
      login(emailController.text)
          .then((value) async {
            await SharedPref.setIsUserLoggedIn(true);
            await SharedPref.setUser({"email": emailController.text , "name":'${value["data"][0]["firstName"]}'});
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/import', (route) => false);
          })
          .catchError((err) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$err'),
                ))
              })
          .whenComplete(() => setState(() {
                loading = false;
              }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter email address'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 0.4, 0.6],
              colors: [
                MatColor.primaryLightColor,
                MatColor.primaryColor,
                MatColor.primaryDarkColor,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Login", style: onBoardTitleStyle),
                SizedBox(height: 50),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(height: 50),
                loading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : MaterialButton(
                        onPressed: _onLoginClick,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(20),
                        color: Colors.white,
                        child: Text(
                          'Login',
                          style: TextStyle(color: MatColor.primaryColor),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
