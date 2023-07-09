

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/invoice_list/invoice_list_bloc.dart';
import 'package:invoice/models/invoice_list.dart';
import 'package:invoice/screens/invoice_detaails_screen.dart';
import 'package:invoice/widgets/loading_indicator.dart';
import 'package:invoice/widgets/refresh.dart';
import 'package:provider/src/provider.dart';
import 'package:invoice/widgets/buttons/avatar_button.dart';
import 'package:easy_localization/easy_localization.dart';

class SpecialtyScreen extends StatefulWidget{
  static final String id = "Specialties";
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SpecialtyScreen({Key? key,required this.scaffoldKey,});  
  @override
  _SpecialtyScreen createState() => _SpecialtyScreen();
}



class _SpecialtyScreen extends State<SpecialtyScreen>{
  TextEditingController teSearch=TextEditingController();
var items=[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<InvoiceListBloc>().add(
          FetchInvoiceList(),
        );
  }

 void filterData(String query){
 }

  @override
  Widget build(BuildContext context) {

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
    //     floatingActionButton: TextButton(
    //       clipBehavior: ClipRRect(borderRadius: BorderRadius.all(20),),
    //     style: ButtonStyle(
          
    //       backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent),
    //       foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    //       overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue),
    //     ),
    //     onPressed: (){
    //       // _onFormSubmitted();
    //     },
    //      child: Icon(Icons.qr_code_2),
    // ), 
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
             onChanged: (value){
                setState(() {
                  filterData(value);
                });
              },
              controller: teSearch,
              decoration: InputDecoration(
                hintText: tr("lbl_search_invoice"),
                labelText: tr("hint_search_invoice"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )
              ),
            ),
          ),

        Expanded(
             child: BlocBuilder<InvoiceListBloc,InvoiceListState>(
               builder: (context,state ){
                 if(state is InvoiceListLoading){

                   return LoadingIndicator();
                 }
                 if(state is InvoiceListLoaded){
                   return _createSpecialtyList(state.invoices!);
                 }
                 if(state is InvoiceListError){

                  return   Refresh(
                    title: ' يعمل عليها الان ',
                    onPressed: () {
                      context.read<InvoiceListBloc>().add(
                            FetchInvoiceList(),
                          );
                    },
                  );
                 }
                   return LoadingIndicator();
               }
             ),
        )
        ],
      ),
    );
  }

  ListView _createSpecialtyList(List<InvoiceModel> items) {
    return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context,index){
                // if(index == 0)
                // return Card(
                //   margin: EdgeInsets.all(1),
                //     child: ListTile(
                //     title: Text('Specilaties More Visited ',style: TextStyle(fontSize: 15),),
                //     // subtitle: Text('${items[index]['icon']}'),
                //   ),
                  
                // );

                // if(index == 3)
                // return Card(
                //   margin: EdgeInsets.all(1),
                //     child: ListTile(
                //     title: Text('Others Specialties',style: TextStyle(fontSize: 15),),
                //     // subtitle: Text('${items[index]['icon']}'),
                //   ),
                  
                // );

                  // Specialty task=Specialty.fromMap(items[index]);
                return Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=> InvoiceDetailsScreen(invoiceDetails: items[index],))
                      );
                    },
                    child: Card(
                      
                      // shape: ShapeDecoration(),
                      // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                Text(tr("invoice_id")+" : "),
                                Text('${items[index].invoiceId}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                                ),                                
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                Text(tr("company")+" : "),
                                Text('${items[index].name}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                                ),                                
                                  ],
                                ),
                              ),

                            ],
                          ),
                         
                         
                          Row(
                            children: [
                              Expanded(
                                flex:2,
                                child: Row(
                                  children: [
                                Text(tr("distenation")+" : ",style: TextStyle(fontSize: 12),),
                                Text('${items[index].lcName} - ${items[index].stName}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                ),
                                ),                                
                                  ],
                                ),
                              ),

                              Expanded(
                                
                                child: Row(
                                  children: [
                                Text(tr("fueltype")+" : ",style: TextStyle(fontSize: 12),),
                                Text('${items[index].priceConfigName}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                ),
                                ),                                
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                Text(tr("quantity")+" : ",style: TextStyle(fontSize: 12),),
                                Text('${items[index].approvedLiter}',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                                ),
                                ),                                
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //   child: ListTile(
                  //   title: Text('${items[index].driverName}',style: TextStyle(fontSize: 15),),
                  //   // subtitle: Text('${items[index]['icon']}'),
                  //   leading: CircleAvatar(
                  //           backgroundImage: AssetImage('assets/images/logo.png'),
                  //           child: GestureDetector(onTap: () {}),
                  //           ),
                  //   onTap: (){
                  //     // Navigator.of(context).pushNamed(DoctorsScreen.id,arguments: items[index].id);
                  //   },
                  // ),
                  
                );
              }
           );
  }

}