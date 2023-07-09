import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/auth/authentication/authentication_bloc.dart';

Future<void> logoutDialog(context, VoidCallback onPressed) {
  return showModal<void>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(),
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(
        'تسجيل الخروج من التطبيق',
        style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
      ),
      content: Text(
        'هل انت متاكد',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textSelectionTheme.cursorColor),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 90.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Colors.red[600],
                child: Text(
                  'خروج',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLoggedOut());
                },
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 90.0,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  color: Color(0xFF4A5568),
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ],
    ),
  );
}
