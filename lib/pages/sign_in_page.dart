import 'package:firebase/pages/sign_up_page.dart';
import 'package:firebase/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signInuser() {
    String email = _emailController.text.trim().toString();
    String password = _passwordController.text.trim().toString();

    AuthService.signInUser(email, password).then((value) =>{
      responsesignIn(value!)
    });
  }

  responsesignIn(User firebaseUser) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return HomePage();
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Firebase',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 26,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey)),
            child: TextField(
              controller: _emailController,
              decoration:
              InputDecoration(hintText: "Email", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 56,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey)),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  hintText: "Password", border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: signInuser,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignUpPage();
                      }));
                    },
                    child: Text("Sign Up"))
              ],
            ),
          )
        ],
      ),
    );
  }
}