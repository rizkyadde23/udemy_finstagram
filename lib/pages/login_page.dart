import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginPageState();
  }

  const LoginPage({super.key});
}

class _loginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? email, password;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleText(),
                _loginForm(),
                SizedBox(height: _deviceHeight! * 0.4),
                _loginButton(),
                _registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.2,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_emailFormField(), _passwordFormField()],
        ),
      ),
    );
  }

  Widget _emailFormField() {
    return TextFormField(
      decoration: const InputDecoration(label: Text("Email")),
      onSaved: (newValue) => setState(() {
        email = newValue;
      }),
      validator: (value) {
        bool result = value!.contains(
          RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
          ),
        );
        return result ? null : "Masukkan Email Dengan Benar!";
      },
    );
  }

  Widget _passwordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(label: Text("Password")),
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

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
      color: Colors.blueAccent,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.05,
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _titleText() {
    return Text(
      "FINSTAGRAM",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result = await _firebaseService!.loginUser(
        email: email!,
        password: password!,
      );
      if (_result) Navigator.popAndPushNamed(context, 'home');
    }
  }

  Widget _registerPageLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'register');
      },
      child: Text(
        "Don't Have An Account?",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
