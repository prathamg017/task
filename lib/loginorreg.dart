import 'package:flutter/src/widgets/framework.dart';
import 'package:movieapp/signup.dart';

import 'home.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool show = true;
  void toggle() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (show) {
      return homepage();
    } else {
      return signupPage();
    }
  }
}
