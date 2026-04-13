import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _registerPageState();
  }
  const RegisterPage({super.key});
}

class _registerPageState extends State<RegisterPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
              color: Colors.blue,
              ),
            );
  }

}