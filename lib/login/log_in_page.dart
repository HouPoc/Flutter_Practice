import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_demo/user_repository/user_repository.dart';
import 'package:login_demo/authentication/authentication.dart';
import 'package:login_demo/login/log_in.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository}) : assert (userRepository != null), super(key:key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(authenticationBloc: _authenticationBloc, 
                userRepositiory: _userRepository);
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text('Login'),),
      body: LoginForm (authenticationBloc: _authenticationBloc, loginBloc: _loginBloc),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

}