

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/models/auth.dart';
import 'package:invoice/preferences/preferences.dart';
import 'package:invoice/repositories/user_repository.dart';
import 'package:invoice/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository? userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository??UserRepository(),
        super(LoginState.empty());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }
 
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ForgotPasswordPressed) {
      yield* _mapForgotPasswordPressedToState(event.email);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapForgotPasswordPressedToState(String email) async* {
    try {
      yield LoginState.passwordResetMailSent();
    } catch (_) {
      yield LoginState.passwordResetFailure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    required String email,
    required String password,
  }) async* {
    yield LoginState.loading();
    try {
      final Auth auth =
          await _userRepository.loginWithCredentials(email, password);
      storeUserData(auth.token, auth.userID, auth.username);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  void storeUserData(String token, int userID, String userName) async {
    Prefer.prefs = await SharedPreferences.getInstance();
    Prefer.prefs!.setString('token', token);
    Prefer.prefs!.setInt('userID', userID);
    Prefer.prefs!.setString('userName', userName);
    Prefer.prefs!.setString('phone', '092912124');
  }
}
