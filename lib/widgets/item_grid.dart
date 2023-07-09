import 'package:flutter/cupertino.dart';

class CustomItemGrid extends StatelessWidget {
  const CustomItemGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: EdgeInsets.only(top:  40),
        child: Container(
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * .2,
       child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/icons/doctor.png'),

            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Clinic Visit',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 18
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
