import 'dart:math';
import 'ShopingPage.dart';
import 'package:appmarket/network/APIservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
  const Login({Key? key}) : super(key: key);
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  String errorMessageEmail = '';
  String errorPassword = '';


  @override
  Widget build(BuildContext context) {
    bool rememberMe = false;

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child:  TextField(
              
              decoration:  InputDecoration(
                errorText: errorMessageEmail == '' ? null : errorMessageEmail,
                prefixIcon: const Icon(Icons.email),
                suffixIcon: const Icon(Icons.check_circle),
                border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                  errorMessageEmail = '';
                });
                print(email);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child:  TextField(
              obscureText: true,
              decoration: const InputDecoration(
                
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Password',
              ),
              onChanged: (value) async {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    }),
                const Text('Remember me'),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                APIservice().Login(email, password).then((value) {
                  if (value != 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ShoppingPage(id: value.toString())));
                  } else {
                    setState(() {
                      errorMessageEmail = 'Email or password is incorrect';
                    });
                  }
                });
              },
              child: const Text('Login'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
