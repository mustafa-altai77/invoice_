

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:invoice/models/gridmenu.dart';
import 'package:invoice/repositories/invoice_repository.dart';
import 'package:invoice/screens/invoice_screen/invoice_screen.dart';
import 'package:invoice/widgets/buttons/avatar_button.dart';


class MainHome extends StatefulWidget{
  final GlobalKey<ScaffoldState> scaffoldKey;
  const MainHome({Key? key,required this.scaffoldKey});
  @override
  _MainHome createState() => _MainHome();
}


class _MainHome extends State<MainHome>{
  List _gridList=[MyGridMenu(name:tr('invoice_gas'),id:1),MyGridMenu(name:tr('invoice_jas'),id:2),MyGridMenu(name:tr('invoice_ben'),id:2),MyGridMenu(name:tr('invoice_reports'),id:4)];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).textSelectionTheme.cursorColor,
          ),
          leading: AvatarButton(
            scaffoldKey: widget.scaffoldKey,
          ),

          title: Text(
            tr('app_name'),
            style: Theme.of(context).appBarTheme.textTheme!.caption,
          ),
          centerTitle: true,
        ),
        body: Container(
                  height: MediaQuery.of(context).size.height ,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2 ,
                        children: List.generate(4,(index){
                          return Container(
                            child: Center(
          child: GestureDetector(
            onTap: (){
              if(_gridList[index].id == 3)
                return;
              if(_gridList[index].id == 4)
                return;  
              // Navigator.push(context, 
              //   MaterialPageRoute(builder: (context)=> InvoiceScreen(fuelTypeId: x,invoiceRepository: InvoiceRepository(),))
              // );
              Navigator.pushNamed(context, InvoiceScreen.id,arguments:_gridList[index]);
              //  MyGridMenu(
              //  id :_gridList[index] == tr("invoice_gas") ? 1 : _gridList[index] == tr("invoice_gas")?2:3,
              //  name:_gridList[index] 
              // ));
            },
            child: Card(

            child: Column(children: <Widget>[
              Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fill
                ),
              ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0,2,0,0),
            child: Text(_gridList[index].name! ,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
            ),
        )
      ]),
            ),
          )),
                          );

                        }),
                      ),
                    ),
        )
    );
  }

}