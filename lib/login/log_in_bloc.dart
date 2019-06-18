import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:login_demo/user_repository/user_repository.dart';
import 'package:login_demo/authentication/authentication.dart';
import 'package:login_demo/login/log_in.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepositiory;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepositiory,
    @required this.authenticationBloc
  }) : assert(userRepositiory !=null), assert(authenticationBloc !=null);
  
  @override
  LoginState get initialState => LoginInitial();

  @override 
  Stream<LoginState> mapEventToState(
      LoginState state, LoginEvent event
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepositiory.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }

    }
  }
}

