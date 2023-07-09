


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/printer/print_bloc.dart';
import 'package:invoice/models/invoice_list.dart';

class InvoiceDetailsScreen extends StatefulWidget{
  static final   String id="invoice_details_screen";
  final InvoiceModel invoiceDetails;   

  
  InvoiceDetailsScreen({ Key? key,required this.invoiceDetails}) :super(key: key);

  @override             
  _InvoiceDetailsScreenSatte createState() => _InvoiceDetailsScreenSatte();

}


class _InvoiceDetailsScreenSatte extends State<InvoiceDetailsScreen>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final namePationKey = GlobalKey<FormFieldState>();

  late PrintBloc _printBloc;
  bool _autovalidate = false;

  // String _name;
  // String phone;



  @override
  void initState() {
    super.initState();
    setState(() {
    // phoneKey.currentState.setValue(Prefer.prefs.getString('phone'));
    // namePationKey.currentState.setValue(Prefer.prefs.getString('userName'));
    });
    // String specialtyId=ModalRoute.of(context).settings.arguments;
    _printBloc=context.read<PrintBloc>();
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
         title: Text(tr("invoice_details")),
      ),
    bottomNavigationBar: Container(
      // padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.07,
      child: Row(
        children: [
          Expanded(
            child: IconButton(onPressed: (){}, 
            icon: Icon(Icons.print,size: 35,),
            color: Colors.blueAccent,
          )),

          Expanded(
            child: IconButton(onPressed: (){}, 
            icon: Icon(Icons.picture_as_pdf,size: 35,),
            color: Colors.blueAccent,
          )),


          Expanded(
            child: IconButton(onPressed: (){}, 
            icon: Icon(Icons.share,size: 35,),
            color: Colors.blueAccent,
          ))


        ],
      ),
      // child: TextButton(
      //   style: ButtonStyle(
      //     backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent),
      //     foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
      //     overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      //   ),
      //   onPressed: (){
      //     _onFormSubmitted();
      //   }, 
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("print_pdf",style: TextStyle(fontSize: 16,),),
      //       Icon(Icons.picture_as_pdf_outlined,size: 30,),
      //     ],
      //   ),
      //   // icon: Icon(Icons.book_online),

      // ),
    ),
    body:BlocListener<PrintBloc,PrintState>(
      listener: (context,state){
        if(state is PrintFailure){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.red,
                  content: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Error While Printing Try Again",
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 8,
                      ),
                    ],
                  ),
                ),
              );          
        }

        if(state is PrintLoading){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.black26,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Printing...',
                      ),
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              );
        }

        if(state is PrintSuccess){
          print("sucess");
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => BlocProvider.value(
            //       value: _printBloc,
            //       child: BookingListScreen(),
            //     ),
            //   ),
            // );
          }          
      },

      child: BlocBuilder<PrintBloc,PrintState>(
        builder: (context,state){
          return 
    ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8,left: 8),
          child: Row(
            children: [
              Text("  "+tr("invoice_data")+" (${widget.invoiceDetails.invoiceId}) "),
              Text(" * ",style: TextStyle(fontSize: 14, color: Colors.redAccent),)
            ],
          ),
        ),


          ListTile(
            title: Row(
              children: [
                Text(tr("company")+" - "),
                Text("${widget.invoiceDetails.name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Row(
              children: [
                Text(tr("fueltype")+"  - "),
                Text("${widget.invoiceDetails.priceConfigName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(tr("quantity")+"  -  "),
                Text("${widget.invoiceDetails.approvedLiter}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.redAccent, )),

              ],
            ),
            leading: Icon(Icons.person,size: 40,),
          ),

        Divider(
          color: Colors.black12,
          thickness: 5,
          // height: MediaQuery.of(context).size.height * 0.04,
        ),


        Padding(
          padding: const EdgeInsets.only(top: 8,left: 8),
          child: Row(
            children: [
              Text(tr("vehicle_data")),
              Text(" * ",style: TextStyle(fontSize: 14, color: Colors.redAccent),)
            ],
          ),
        ),

        Divider(
          color: Colors.black12,
          thickness: 1,
          height: MediaQuery.of(context).size.height * 0.04,
            ),


          ListTile(
            title: Row(
              children: [
                Text(tr("invoiceform.lbl_driver_name")+" - "),
                Text("${widget.invoiceDetails.driverName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Row(
              children: [
                Text(tr("invoiceform.lbl_plate_number")+"  - "),
                Text("${widget.invoiceDetails.plateChar} - ${widget.invoiceDetails.plateNumber}",style: 
                TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.redAccent, )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                // Text(tr("quantity")+"  -  "),
                // Text("${widget.invoiceDetails.approvedLiter}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.redAccent, )),

              ],
            ),
            leading: Icon(Icons.person,size: 40,),
            trailing: Icon(Icons.call,size: 40,),
          ),



        Divider(
          color: Colors.black12,
          thickness: 5,
          // height: MediaQuery.of(context).size.height * 0.04,
        ),


        Padding(
          padding: const EdgeInsets.only(top: 8,left: 8),
          child: Row(
            children: [
              Text("  بيانات  "+tr("distenation")),
              Text(" * ",style: TextStyle(fontSize: 14, color: Colors.redAccent),)
            ],
          ),
        ),

        Divider(
          color: Colors.black12,
          thickness: 1,
          height: MediaQuery.of(context).size.height * 0.04,
            ),


              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                  // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_pin,size: 30,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.invoiceDetails.lcName} - ${widget.invoiceDetails.stName}",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold), ),
                              Divider(
                              height: MediaQuery.of(context).size.height * 0.01,
                              ),                                
                              Text("عرض اسم المنشاة او المخبز هنا",style: TextStyle(fontSize: 14),),
                            ],
                        ),
                      ),
                    ],
                  )
                ),
              ),




        Divider(
          color: Colors.black12,
          thickness: 1,
          height: MediaQuery.of(context).size.height * 0.04,
            ),




              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Container(
                  // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_pin,size: 30,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${widget.invoiceDetails.dateAdded}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18), ),
                              Divider(
                              height: MediaQuery.of(context).size.height * 0.01,
                              ),                                
                              Text("تمت الاضافة من قبل ${widget.invoiceDetails.userAdded}",style: TextStyle(fontSize: 15),),
                            ],
                        ),
                      ),
                    ],
                  )
                ),
              ),

        Divider(
          color: Colors.black12,
          thickness: 1,
          height: MediaQuery.of(context).size.height * 0.08,
            ),


           
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                // BlocBuilder<PrintBloc,PrintState>(
                //   builder: (context,state){
                //     // if(stat)
                //   },
                // ),
                  Container(
                    padding: EdgeInsets.all(10),
                      child:Center(
                        child:Icon(Icons.qr_code,size: 90,) ,
                      )
                  ),

            ],
          ),
      ]
    );
      },
    ),
  ), 
 );
  }




  void _onFormSubmitted() {
      _printBloc.add(
        PrintPdf(

        ),
      );
    } 

}