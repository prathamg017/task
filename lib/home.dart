import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movieapp/signup.dart';
import 'package:movieapp/textfield.dart';

import 'button.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final TextEditingController email = TextEditingController();

  final pin = TextEditingController();

  void SignUserIn() async {
    // print('Entered');
    // print(email.text);
    // print(pin.text);
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pin.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Center(
            child: Text(
              message,
              // style: const TextStyle(color: Colors.white),
            ),
          ));
        });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text('data'),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Icon(
                      Icons.lock,
                      size: 100,
                    ),
                  ),
                  textfield(
                    controller: email,
                    hintText: 'UserName',
                    obscureText: false,
                  ),
                  textfield(
                    controller: pin,
                    hintText: 'Password',
                    obscureText: false,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: TextField(
                  //     controller: email,
                  //     decoration: InputDecoration(
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.grey)),
                  //         fillColor: Colors.grey.shade200,
                  //         filled: true,
                  //         hintText: 'Enter Email',
                  //         hintStyle: TextStyle(
                  //             color: Color.fromARGB(255, 64, 64, 64))),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Forgot Password?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 64, 64, 64)))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buttons(
                      onTap: SignUserIn,
                      text: 'SignIn',
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Or continue with'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        _googleSignIn.signIn().then((value) {
                          String username = value!.displayName!;
                        });
                      },
                      child: Text('data')),
                  // Image.asset('assets/images/google.png'),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.goog)),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('lib/images/google.png'),
                      Text('Not a Member?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => signupPage()));
                          },
                          child: Text('Register now !'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
