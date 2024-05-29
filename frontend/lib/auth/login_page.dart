import 'package:flutter/material.dart';
import 'package:untitled1/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final Function changePage;

  LoginPage(this.changePage);

  @override
  State<StatefulWidget> createState() {
    return _LoginState(changePage);
  }
}

class _LoginState extends State<LoginPage> {
  final Function _changePage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {
    'email': null,
    'password': null
  };

  _LoginState(this._changePage);

  @override
  Widget build(BuildContext context) {
    return _buildLoginWidget(_formKey, context: context);
  }

  Form _buildLoginWidget(GlobalKey<FormState> formKey, {BuildContext context}) {
    InputDecoration _textDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      );
    }

    Widget _buildEmailField() {
      return TextFormField(
        validator: (String value) {
          if (!isEmail(value) || value.trim().isEmpty)
            return 'Please enter a valid email.';
          return null;
        },
        style: TextStyle(color: Colors.white),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: _textDecoration('Email Address'),
        onSaved: (String value) {
          _loginData['email'] = value;
        },
      );
    }

    Widget _buildPasswordField() {
      return TextFormField(
        initialValue: '',
        validator: (String value) {
          if (value.trim().isEmpty) return 'Please enter your password.';
          return null;
        },
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: _textDecoration('Password'),
        onSaved: (String value) {
          _loginData['password'] = value;
        },
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailField(),
          SizedBox(height: 15),
          _buildPasswordField(),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 25, right: 5),
              child: Text(
                'Forgot Password ?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 25),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.white),
            ),
            padding: EdgeInsets.only(left: 50, right: 50),
            textColor: Colors.white,
            child: Text('Login'),
            onPressed: () {
              _formKey.currentState.save();
              if (_formKey.currentState.validate()) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Or',
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            child: Text(
              'Create an account, Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              _changePage(false);
            },
          ),
        ],
      ),
    );
  }
}
