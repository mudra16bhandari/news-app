import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news/screens/signin.dart';

import 'homescreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/images/background.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            color: Colors.white70.withOpacity(0.6),
            colorBlendMode: BlendMode.modulate,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.1),
              child: const Text(
                'Welcome!!',
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              )),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.61,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.39,
                  left: MediaQuery.of(context).size.width * 0.002,
                  right: MediaQuery.of(context).size.width * 0.002),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 13, 71, 161),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    padding:
                    const EdgeInsets.only(right: 15, bottom: 2, left: 15),
                    decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: const [
                        Text('Email: ', style: TextStyle(color: Colors.white),),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    padding:
                    const EdgeInsets.only(right: 15, bottom: 2, left: 15),
                    decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: const [
                        Text('Password: ', style: TextStyle(color: Colors.white),),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    padding:
                    const EdgeInsets.only(right: 15, bottom: 2, left: 15),
                    decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius:
                        const BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: const [
                        Text('Re-enter Password: ', style: TextStyle(color: Colors.white),),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      await addUser();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return const HomeScreen();}));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                  ),
                  Stack(
                    children: [
                      const Divider(
                        color: Colors.black54,
                        thickness: 1,
                        indent: 40,
                        endIndent: 40,
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: null,
                          child: const Text(
                            'or Sign Up With',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.grey[100]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Image.asset(
                          "lib/images/google.png",
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: Image.asset("lib/images/facebook.png"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return const SignIn();}));
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
