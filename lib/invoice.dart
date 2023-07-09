

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/auth/authentication/authentication_bloc.dart';
import 'package:invoice/bloc/booking/invoice_bloc.dart';
import 'package:invoice/models/gridmenu.dart';
import 'package:invoice/repositories/invoice_repository.dart';
import 'package:invoice/repositories/user_repository.dart';
import 'package:invoice/screens/auth/forgot_password_screen.dart';
import 'package:invoice/screens/auth/login_screen.dart';
import 'package:invoice/screens/auth/register_screen.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:invoice/screens/invoice_screen/invoice_screen.dart';
import 'package:invoice/screens/specialty_screen.dart';
import 'package:invoice/screens/splash_screen.dart';
import 'package:invoice/theme/app_theme.dart';
import 'package:invoice/theme/bloc/theme_bloc.dart';

import 'bloc/auth_profile/auth_profile_bloc.dart';
import 'bloc/invoice_list/invoice_list_bloc.dart';
import 'bloc/printer/print_bloc.dart';
import 'bloc/profile/profile/profile_bloc.dart';

class Invoice extends StatefulWidget{
  final UserRepository? userRepository;


  const Invoice({Key? key,  this.userRepository}) : super(key: key);


  @override
  _InvoiceState createState() => _InvoiceState();
}


class _InvoiceState extends State<Invoice>{
  AuthenticationBloc? _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc =
        AuthenticationBloc(userRepository: widget.userRepository);
    _authenticationBloc!.add(AuthenticationStarted());
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        // BlocProvider<TweetBloc>(
        //   create: (context) => TweetBloc(
        //     tweetRepository: TweetRepository(),
        //   ),
        // ),
        BlocProvider<AuthProfileBloc>(
          create: (context) =>
              AuthProfileBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<InvoiceBloc>(
          create: (context) =>
              InvoiceBloc(invoiceRepository: InvoiceRepository()),
        ),
        // BlocProvider<SpecialtyBloc>(
        //   create: (context) => SpecialtyBloc(specialtyRepository: SpecialtyRepository()),
        // ),
        BlocProvider<ProfileBloc>(
          create: (context) =>
              ProfileBloc(userRepository: widget.userRepository),
        ),
        BlocProvider<PrintBloc>(
          create: (context) => PrintBloc(),
        ),
        // BlocProvider<DoctorProfileBloc>(
        //   create: (context) => DoctorProfileBloc(
        //     doctorRepository: DoctorRepository(),
        //   )
        //   ),
        BlocProvider<InvoiceListBloc>(
          create: (context) =>
              InvoiceListBloc(specialtyRepository:  InvoiceRepository()),
        ),
        // BlocProvider<TweetSearchBloc>(
        //   create: (context) =>
        //       TweetSearchBloc(searchRepository: SearchRepository()),
        // ),
        // BlocProvider<MentionBloc>(
        //   create: (context) =>
        //       MentionBloc(userRepository: widget.userRepository),
        // ),
        // BlocProvider<ChatBloc>(
        //   create: (context) => ChatBloc(chatRepository: ChatRepository()),
        // )
      ],
      child: _buildWithTheme(context),
    );
}
  Widget _buildWithTheme(BuildContext context) {
    return BlocBuilder<ThemeBloc, AppTheme>(
      builder: (context, appTheme) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,          
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (settings){
              print('args ');
            if(settings.name == InvoiceScreen.id ){
              final args=settings.arguments as MyGridMenu;
              print('args :  $args');
              return MaterialPageRoute(builder: (context){
                return InvoiceScreen(
                  fuelType: args,
                  invoiceRepository: InvoiceRepository()
                );
              });
            }
            // if(settings.name == BookinScreen.id ){
            //   final args=settings.arguments;
            //   print('args :  $args');
            //   return MaterialPageRoute(builder: (context){
            //     return BookinScreen(
            //       bookingData: args,
            //     );
            //   });
            // }


            assert(false, 'Need to implement ${settings.name}');
            return null;
          },
          title: tr("app_name"),
          theme: appThemeData[appTheme],
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthenticationFailure) {
                  // return BookingListScreen();
                  return LoginScreen(userRepository: widget.userRepository!);
                }
                if (state is AuthenticationSuccess) {
                  return HomeScreen();
                  // return BookinScreen(doctor: Doctor(
                  //   name: "alrasheed rasta",
                  //   address: "Khartoum-Ombad-18",
                  //   image: "ana.jpg",
                  //   price: 1500,
                  //   specialty: Specialty(name: "eraha"),
                    
                  // ),);
                }
                return MySplashScreen();
              });
            },
            '/register': (context) =>
                RegisterScreen(userRepository: widget.userRepository!),
            // '/profile': (context) => ProfileWrapper(),
            // '/publish-tweet': (context) => PublishTweetScreen(),
            // '/settings': (context) => SettingsScreen(),
            // SpecialtyScreen.id: (context) => SpecialtyScreen(),
            // SpecialtyScreen.id: (context) => SpecialtyScreen(),
            // ProfileDoctor.id: (context) => ProfileDoctor(doctorId: null,),
            // InvoiceScreen.id: (context) => InvoiceScreen(invoiceRepository: InvoiceRepository(),),
            '/forgot-password': (context) => ForgotPasswordScreen(),
          },
        );
      },
    );
  }
}