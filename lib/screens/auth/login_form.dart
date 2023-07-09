import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:invoice/bloc/auth/authentication/authentication_bloc.dart';
import 'package:invoice/bloc/auth/login/login_bloc.dart';
import 'package:invoice/screens/home_screen.dart';
import 'package:invoice/widgets/wave.dart';
import 'package:google_fonts_arabic/google_fonts_arabic.dart';
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc? _loginBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  bool isForgotPasswordEnabled(LoginState state) {
    return state.isEmailValid && _emailController.text.isNotEmpty;
  }

  bool _isPasswordHidden = true;
 
  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _toggleVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state.isFailure) {
          // Navigator.pushNamed(context, '/register');
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    elevation: 6.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Invalid Credentials!'),
                          Icon(Icons.error)
                        ]),
                    backgroundColor: Colors.red),
              );
          }
          if (state.isPasswordResetFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    elevation: 6.0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'error',
                          ),
                          Icon(Icons.error)
                        ]),
                    backgroundColor: Colors.red),
              );
          }
          if (state.isPasswordResetMailSent) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Password reset mail has been sent to your email address'),
                      Icon(Icons.check)
                    ],
                  ),
                  backgroundColor: Colors.red));
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Color(0xFF5d74e3),
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tr('login_form.msg.loading')),
                        CircularProgressIndicator()
                      ])));
          }
          if (state.isSuccess) {
            context.read<AuthenticationBloc>().add(AuthenticationLoggedIn());
          }
        }, child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Container(
                  height: size.height - 350,
                  color: Color(0xff4A64FE),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 3.7 : 0.0,
                  child: Wave(
                    size: size,
                    yOffset: size.height / 3.0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        // fit: StackFit.passthrough,
                        overflow: Overflow.visible,

                        children: [
                        Positioned(
                            top: -30,
                            child:Text(
                            tr('app_name'),
                            style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                        ),
                      ),

                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,30,0,0),
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.black,
                                    // Theme.of(context)
                                    //     .textSelectionTheme
                                    //     .cursorColor,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    filled: true,
                                    focusColor: Theme.of(context).primaryColor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.grey),
                                    hintText: tr('login_form.lbl_name')
                                    ),
                                controller: _emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                validator: (_) {
                                  if (!state.isEmailValid) {
                                    return ('Invalid Email');
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              TextFormField(
                                style: TextStyle(
                                    color:Colors.black, 
                                    // Theme.of(context)
                                    //     .textSelectionTheme
                                    //     .cursorColor,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    filled: true,
                                    focusColor: Colors.black,//Theme.of(context).primaryColor,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Colors.grey),
                                    suffixIcon: IconButton(
                                        icon: _isPasswordHidden
                                            ? Icon(Icons.visibility_off,
                                                color: Colors.grey)
                                            : Icon(Icons.visibility,
                                                color: Colors.grey),
                                        onPressed: () {
                                          _toggleVisibility();
                                        }),
                                    hintText: tr('login_form.lbl_password')
                                    ),
                                obscureText: _isPasswordHidden,
                                controller: _passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autocorrect: false,
                                validator: (_) {
                                  if (!state.isPasswordValid) {
                                    return ('Invalid Password');
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50.0),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Material(
                            color: Theme.of(context).primaryColor,
                            child: InkWell(
                              onTap: isLoginButtonEnabled(state)
                                  ? _onFormSubmitted
                                  : null,
                              child: SizedBox(
                                height: 50.0,
                                width: size.width,
                                child: Center(
                                  child: Text(
                                    tr('login_form.btn_send'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        letterSpacing: 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(" ",
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 16.0)),
                            SizedBox(width: 10.0),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                                // Navigator.push(context, 
                                //   MaterialPageRoute(builder: (context)=> HomeScreen())
                                // );
                              },
                              child: Text(' ',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0)),
                            )
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: Text(
                              tr('forget_password_form.title'),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0)),
                          ),
                        )
                      ]),
                )
              ],
            );
          },
        )));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    print("ana  : "+_emailController.text);
    _loginBloc!.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc!.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    // Navigator.pushNamed(context, '/register');
    _loginBloc!.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}
