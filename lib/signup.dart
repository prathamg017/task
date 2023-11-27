import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/textfield.dart';

import 'button.dart';

class signupPage extends StatefulWidget {
  signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  final TextEditingController email = TextEditingController();

  final pin = TextEditingController();
  final cpin = TextEditingController();

  void SignUserUp() async {
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
    if (pin.text != cpin.text) {
      Navigator.pop(context);
      showErrorMessage("Passwords do not match");
      return;
    }
    try {
      if (pin.text == cpin.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text, password: pin.text);
        Navigator.pop(context);
      }
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
                    padding: const EdgeInsets.all(20.0),
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
                  textfield(
                    controller: cpin,
                    hintText: 'Confirm Password',
                    obscureText: false,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buttons(
                      onTap: SignUserUp,
                      text: 'SignUp',
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
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('lib/images/google.png'),
                      Text('Already a Member?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => signupPage()));
                          },
                          child: Text('Login now !'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
