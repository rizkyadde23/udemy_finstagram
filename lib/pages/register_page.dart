import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _registerPageState();
  }
  const RegisterPage({super.key});
}

class _registerPageState extends State<RegisterPage> {
  double? _deviceHeight,_deviceWidth;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String? username,email,password;

 @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _deviceWidth!*0.05),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _titleText(),
                        _registerForm(),
                        _registerButton(),
                      ],
                    ),
                  ),
                ),
            ),
      );
  }

  Widget _registerForm(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth!*0.05),
      height: _deviceHeight!*0.247,
      child: Form(
        key: _registerFormKey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _nameFormField(),
          _emailFormField(),
          _passwordFormField(),
        ],
      )
      ),
    );
  }

  Widget _emailFormField(){
    return TextFormField(
      decoration: const InputDecoration(
        label: Text("Email"),
      ),
      onSaved: (newValue) => setState(() {
        email = newValue;
      }),
      validator: (value) {
        bool result = value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return result ? null : "Masukkan Email Dengan Benar!";
      },
    );
  }

  Widget _passwordFormField(){
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
        label: Text("Password"),
      ),
      onSaved: (newValue) => setState(() {
        password = newValue;
      }),
      validator: (value) {
        if (value == null || value.length < 6) {
          return "Password harus lebih dari 6 karakter";
        }
        return null;
      },
    );
  }
  
  Widget _nameFormField(){
    return TextFormField(
      decoration: InputDecoration(
        label: Text("Username",),
      ),
      onSaved: (newValue) => setState(() {
        username = newValue;
      }),
      validator: (value) {
        if (value == null || value.isEmpty ) {
          return "Username Cannot Be Empty";
        }
        return null;
      },
    );
  }

  Widget _titleText(){
    return Text(
      "FINSTAGRAM",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color:Colors.black, 
      ),
      );
  }

Widget _registerButton(){
    return MaterialButton(
      onPressed: _registerUser,
      color: Colors.blueAccent,
      minWidth: _deviceWidth!*0.7,
      height: _deviceHeight!*0.05,
      child: Text(
        "Register",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        ),
      );
  }

  void _registerUser(){
    if (_registerFormKey.currentState!.validate()) {
      
    }
  }

}