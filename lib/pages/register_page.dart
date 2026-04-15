import 'package:file_picker/file_picker.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _registerPageState();
  }

  const RegisterPage({super.key});
}

class _registerPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String? username, email, password;
  File? _image;
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
                _imageProfile(),
                _registerForm(),
                _registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageProfile() {
    var _imageProvider = _image != null
        ? FileImage(_image!)
        : AssetImage("assets/images/profile.png");
    return GestureDetector(
      onTap: () {
        FilePicker.pickFiles(type: FileType.image).then((value) {
          setState(() {
            _image = File(value!.files.first.path!);
          });
        });
      },
      child: Container(
        height: _deviceHeight! * 0.10,
        width: _deviceWidth! * 0.20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: _imageProvider as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.247,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_nameFormField(), _emailFormField(), _passwordFormField()],
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

  Widget _nameFormField() {
    return TextFormField(
      decoration: InputDecoration(label: Text("Username")),
      onSaved: (newValue) => setState(() {
        username = newValue;
      }),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username Cannot Be Empty";
        }
        return null;
      },
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

  Widget _registerButton() {
    return MaterialButton(
      onPressed: _registerUser,
      color: Colors.blueAccent,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.05,
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

  void _registerUser() async {
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
      bool _result = await _firebaseService!.registerUser(
        name: username!,
        email: email!,
        password: password!,
        image: _image!,
      );
      if (_result) Navigator.pop(context);
    }
  }
}
