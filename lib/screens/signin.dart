import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/homescreen.dart';
import 'package:news/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String? title) {
    final snackbar = SnackBar(
      content: Text(
        title!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
    );
    ScaffoldMessenger.of(scaffoldKey.currentState!.context)
        .showSnackBar(snackbar);
  }

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final User? user = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      //check error and display message
      //Navigator.pop(context);
      FirebaseAuthException thisEx = ex;
      if (thisEx.code == 'user-not-found') {
        showSnackBar('User not registered');
      } else {
        showSnackBar(thisEx.message);
      }
    }))
        .user;
    if (user != null) {
      //verify login
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users/${user.uid}');
      showSnackBar('Successfully Logged in');
      prefs.setBool('isLoggedIn', true);
      userRef.once().then((DatabaseEvent snapshot) {
        if (snapshot.snapshot.value != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const HomeScreen();
          }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.59,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.41,
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
                      'Sign In',
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
                      children: [
                        const Text(
                          'Email: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
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
                      children: [
                        const Text(
                          'Password: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: TextField(
                            controller: passwordController,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text(
                      'Sign in',
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
                            'or Sign In With',
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
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUp();
                          }));
                        },
                        child: const Text(
                          'Sign Up',
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
