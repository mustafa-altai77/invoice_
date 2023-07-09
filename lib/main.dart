import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/auth/authentication/authentication_bloc.dart';
import 'package:invoice/invoice.dart';
import 'package:invoice/preferences/preferences.dart';
import 'package:invoice/repositories/user_repository.dart';
import 'package:invoice/services/user_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'blocs/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;
Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  // Bloc.observer = SimpleBlocObserver();
    int initialThemeIndex =
      WidgetsBinding.instance!.window.platformBrightness == Brightness.light
          ? 0
          : 1;
  
  Prefer.init();
  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs!.getInt('theme') ?? initialThemeIndex;

  final UserRepository userRepository = UserRepository();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar'), Locale('en')],
      path: 'assets/translations', // <-- change the path of the translation files 
      startLocale: Locale('ar'),
      useOnlyLangCode:true,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted()),
        child: Invoice(userRepository: userRepository)),
    ),
  );
  // runApp(
    
  //   BlocProvider(
  //       create: (context) => AuthenticationBloc(userRepository: userRepository)
  //         ..add(AuthenticationStarted()),
  //       child: Invoice(userRepository: userRepository)),
  // );
}
