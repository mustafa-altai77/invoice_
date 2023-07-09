import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/booking/invoice_bloc.dart';
import 'package:invoice/models/company.dart';
import 'package:invoice/models/gridmenu.dart';
import 'package:invoice/models/locality.dart';
import 'package:invoice/models/platechar.dart';
import 'package:invoice/models/station.dart';
import 'package:invoice/preferences/preferences.dart';
import 'package:invoice/screens/auth/register_images_form.dart';
import 'package:invoice/utils/numberic_text_input_formatter.dart';
import 'package:invoice/utils/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:pdf/pdf.dart';

class InvoiceForm extends StatefulWidget {
  @override
  final MyGridMenu? fuelType;

    const InvoiceForm({this.fuelType ,Key? key}) : super(key: key);
  _InvoiceFormState createState() => _InvoiceFormState();
  // print("$fuelTypeId");
}

class _InvoiceFormState extends State<InvoiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InvoiceBloc? _invoiceBloc;

  bool isButtonEnabled(InvoiceState state) {
    return state is! InvoiceLoading;
  }

  bool _autovalidate = false;
  final invoiceIdKey = GlobalKey<FormFieldState>();
  final quantityKey = GlobalKey<FormFieldState>();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  String? _name;
  String? _username;
  String? _email;
  String? _password;
  String? _passwordConfirmation;
  int? _companyId;
  double? _quantutyId;
  int? _localityId;
  int? _stationId;
  String? _platNumber;
  int?_vehicleId;
  String? _note;
  int? _invoiceId;
  String? _driverName;
  String? _driverPhone;
  List<Locality>? _localitiesList;
  List<Station>? _stationList;
  List<PlateChar>? _plateCharList;
  String? _plateChar;
  bool _loading=false;
  @override
  void initState() {
    super.initState();
    _invoiceBloc = context.read<InvoiceBloc>();
    getLocality(null);
    getPlateChar("");
    print("init");
  }

  @override
  Widget build(BuildContext context) {
  print("$widget.fuelType");

    return Scaffold(
        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: true,
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child:BlocBuilder<InvoiceBloc, InvoiceState>(
          builder: (context, state) { 
          return Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: isButtonEnabled(state) ? _onFormSubmitted : null,
                  child: Text(
                        tr('invoiceform.btn_send_save'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0),
                            
                  ),
                )
              ),
              SizedBox(
                  height: 60,
                  width:10,
                  child: Container(
                    color: Colors.white30,
                  ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    print("$state");
                    if(isButtonEnabled(state))  
                      _onFormSubmitted() ;
                  _formKey.currentState!.reset();                    
                  
                  },
                  child: Text(
                        tr('invoiceform.btn_send'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0),
                            
                  ),
                )
              )


            ],
          );
          }),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
          title: Text(
            tr('invoiceform.title')+" ( ${widget.fuelType!.name} ) ",
            style: Theme.of(context).appBarTheme.textTheme!.caption,
          ),
          centerTitle: true,
        ),
        body: BlocListener<InvoiceBloc, InvoiceState>(
            listener: (context, state) {
          if (state is InvoiceFailureMessage) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "state.errorMessage",
                      ),
                    ],
                  ),
                ),
              );
          }
          if (state is InvoiceLoading) {
          SweetAlert.show(context,subtitle: tr("loading_send"), style: SweetAlertStyle.loading);

                    // new Future.delayed(new Duration(seconds: 2),(){
                      // SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
                    // });            
            // Scaffold.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(
            //     SnackBar(
            //       elevation: 6.0,
            //       behavior: SnackBarBehavior.floating,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.0)),
            //       backgroundColor: Colors.black26,
            //       content: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Registering...',
            //           ),
            //           CircularProgressIndicator(
            //             valueColor: new AlwaysStoppedAnimation<Color>(
            //               Colors.white,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   );
          }
          if (state is InvoiceSuccess) {
            SweetAlert.show(context,subtitle: tr("success"), style: SweetAlertStyle.success,
            showCancelButton: false,
            confirmButtonText: "تم"
            );
              invoiceIdKey.currentState!.reset();
              quantityKey.currentState!.reset();
            // setState(() {
            //   // _invoiceId=null;
            // });            
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => BlocProvider.value(
            //       value: _invoiceBloc,
            //       child: RegisterImagesForm(),
            //     ),
            //   ),
            // );
          }
        }, child: BlocBuilder<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(12.0),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    autovalidateMode: _autovalidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        Text(
                          tr('invoiceform.lbl_id'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              color:Colors.black, 
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
                            hintText: tr('invoiceform.hint_id'),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            if(val!.trim().isEmpty)
                              return tr("validation.required");
                            // if()  
                          },
                          onSaved: (value) => _invoiceId =   int.parse(value!),
                          key: invoiceIdKey,
                        ),
                        SizedBox(height: 20.0),


              ///BottomSheet Mode with no searchBox
              DropdownSearch<Company>(
                mode: Mode.BOTTOM_SHEET,
                emptyBuilder: (context, searchEntry) => Center(child:Text("لا يوجد بيانات استخدم كلمات اخرى")),
                popupBackgroundColor: Colors.white,
                onFind: (filter) async {
              var token = Prefer.prefs!.getString('token');
                      final response = await http.Client().get(
                        "http://62.12.101.94:8080/api/companys",
                        headers: {
                          HttpHeaders.contentTypeHeader: 'application/json',
                          HttpHeaders.acceptHeader: 'application/json',
                          HttpHeaders.authorizationHeader: 'Bearer $token'
                        },
                      );
                      // print(response.body);    
                      //if                  
                      var models = Company.fromJsonList(jsonDecode(response.body) as  List);
                    print(models);                      
                      return models!;
                    },
                    itemAsString: (c) => c!.name,
                   dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_company'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (companySelected){
                  setState(() {
                  _companyId = companySelected!.id;
                  print("company  $companySelected");
                  });
                },
                // selectedItem: tr('invoiceform.hint_company'),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(8, 12, 12, 0),
                    labelText: tr('invoiceform.lbl_search'),
                  ),
                ),
                
                popupTitle: Container(
                  height: 50,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('invoiceform.lbl_companies'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),

                validator: (company){
                  if(company == null){
                    return tr("validation.required");                    
                  }
                  return null;
                },
                
              ),

                        SizedBox(height: 20.0),

                        Text(
                          "${tr('invoiceform.lbl_quantity')} ( ${tr("lbl_letter")} )",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            // Text(tr("lbl_letter"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),

                            Expanded(
                              child: TextFormField(
                                key: quantityKey,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  NumbericTextInputFormatter(),
                                ],
                                style: TextStyle(
                                    color:Colors.black, 
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
                                  hintText: tr('invoiceform.hint_quantity'),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                validator: (val) {
                                  return val!.trim().isEmpty
                                      ? tr("validation.required")
                                      : null;
                                },
                                onSaved: (value) => _quantutyId =   double.parse(value!.replaceAll(',','')), //print(value!.replaceAll(',','')),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),


DropdownSearch<Locality>(
    mode: Mode.MENU,
    // showSelectedItems: true,
    items:  _localitiesList,
    // onFind: (fillter) => getLocality(fillter),
    itemAsString:(locality) => locality!.name,
    label: tr('invoiceform.lbl_locality'),
    // hint: "country in menu mode",
    // popupItemDisabled: (Locality s) => s.startsWith('I'),
    // onChanged: print,
    dropdownSearchDecoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
      border: OutlineInputBorder(),
    ),
    // selectedItem: tr('invoiceform.hint_locality')),
    onChanged: (selected){
      setState(() {
        _localityId = selected!.id;
        getSation(selected.id,"");
      });
    },
      validator: (company){
      if(company == null){
      return tr("validation.required");                    
      }
      return null;
      },
  ),
                        SizedBox(height: 20.0),


              ///BottomSheet Mode with no searchBox
              DropdownSearch<Station>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                // items:_stationList,
                onFind: (f)=>getSation(_localityId!, f),
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_station'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (selected){
                  setState(() {
                    _stationId = selected!.id;
                  });
                },
                itemAsString: (s) => s!.name,
                // selectedItem: tr('invoiceform.hint_station'),
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(8, 12, 12, 0),
                    labelText: tr('invoiceform.lbl_search'),
                  ),
                ),
                popupTitle: Container(
                  height: 50,
                  decoration: BoxDecoration(
                     color:Theme.of(context).primaryColorDark,
                    // color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('invoiceform.lbl_stations'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),

                validator: (company){
                  if(company == null){
                    return tr("validation.required");                    
                  }
                  return null;
                },

              ),


                       SizedBox(height: 20.0),

                        Text(
                          tr('invoiceform.lbl_driver_name'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          // keyboardType: TextInputType.phone,
                          style: TextStyle(
                              color:Colors.black, 
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
                            hintText: tr('invoiceform.hint_driver_name'),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            if(val!.trim().isEmpty)
                              return tr("validation.required");

                            // return val!.trim().isEmpty
                            //     ? 'Name cannot be empty'
                            //     : null;
                          },
                          onSaved: (value) => _driverName = value,
                        ),
                        SizedBox(height: 20.0),

                        Text(
                          tr('invoiceform.lbl_driver_phone'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                              color:Colors.black, 
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
                            hintText: tr('invoiceform.hint_driver_phone'),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            if(val!.trim().isEmpty)
                                return tr("validation.required");
                            // if(Validators.isValidPhone(val))    
                            //     return tr("validation.phone");
                            
                            return null;
                          },
                          onSaved: (value) => _driverPhone=value,
                        ),
                        SizedBox(height: 20.0),




              ///BottomSheet Mode with no searchBox
              DropdownSearch<PlateChar>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                // items: _plateCharList,
                onFind: (fillter) => getPlateChar(fillter),
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.hint_plate_char'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  setState(() {
                    _plateChar= value!.name;
                  });
                },
                // selectedItem: tr('invoiceform.hint_plate_number'),
                itemAsString: (p) => p!.name,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(8, 12, 12, 0),
                    labelText: tr('invoiceform.lbl_search'),
                  ),
                ),
                popupTitle: Container(
                  height: 50,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color:Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('invoiceform.hint_plate_char'),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                validator: (company){
                  if(company == null){
                    return tr("validation.required");                    
                  }
                  return null;
                },                
              ),

                        SizedBox(height: 20.0),


                        Text(
                          tr('invoiceform.lbl_plate_number'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      color:Colors.black, 
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
                                    hintText: tr('invoiceform.hint_plate_number'),
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  validator: (val) {
                                    return val!.trim().isEmpty
                                        ? tr("validation.required")
                                        : null;
                                  },
                                  onSaved: (value) => _platNumber=value,
                                ),
                              ),
                               IconButton(
                                icon: Icon(Icons.search)
                                , onPressed: () { 
                                    getCarData();
                                 },
                              ),                              
                            ],
                          ),
                        ),



                        SizedBox(height: 20.0),

                        Text(
                          tr('invoiceform.lbl_note'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            filled: true,
                            focusColor: Colors.white,
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
                            hintText: tr('invoiceform.hint_note'),
                            
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              
                            ),
                          ),
                          maxLines: 5,
                          // validator: (val) {
                          //   return val!.trim().isEmpty
                          //       ? 'Username cannot be empty'
                          //       : null;
                          // },
                          onSaved: (value) => _note = value,
                        ),
                        SizedBox(height: 20.0),

                        // SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(20.0),
                  //   child: Material(
                  //     color: Theme.of(context).primaryColor,
                  //     child: InkWell(
                  //       onTap: isButtonEnabled(state) ? _onFormSubmitted : null,
                  //       child: SizedBox(
                  //         height: 50.0,
                  //         width: MediaQuery.of(context).size.width,
                  //         child: Center(
                  //           child: Text(
                  //             tr('invoiceform.btn_send'),
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 18.0,
                  //                 letterSpacing: 1.0),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        )));
  }

  Future<List<Locality>> getLocality(String? fillter) async{ 
      var token = Prefer.prefs!.getString('token');
      final response = await http.Client().get(
      "http://62.12.101.94:8080/api/localities?StateId=1",
      headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      );

      print(response.body);                      
      if(response.statusCode == 200){
      var models = Locality.fromJsonList(jsonDecode(response.body)['result'] as  List );
      setState(() {
      _localitiesList=models;
      });
      return models!;
      }
      print("models ${response.statusCode}");                      
      return [];
  }



  Future<List<Station>> getSation(int localityId,String? fillter) async{ 
      var token = Prefer.prefs!.getString('token');
      print("http://62.12.101.94:8080/api/station/all?LocalityId=$_companyId&CompanyId=$_localityId");

      final response = await http.Client().get(
      "http://62.12.101.94:8080/api/station/all?LocalityId=$_companyId&CompanyId=$_localityId",
      headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      );

      print(response.body);                      
      if(response.statusCode == 200){
      var models = Station.fromJsonList(jsonDecode(response.body)['result'] as  List );
      setState(() {
      _stationList=models;
      });
      return models!;
      }
      print("models ${response.statusCode}");                      
      return [];
  }

  Future<List<PlateChar>> getPlateChar(String? fillter) async{ 
      var token = Prefer.prefs!.getString('token');
      final response = await http.Client().get(
      "http://62.12.101.94:8080/api/platechar?query=$fillter",
      headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      );
      print(response.body);                      
      if(response.statusCode == 200){
      var models = PlateChar.fromJsonList(jsonDecode(response.body)['result'] as  List );
      // setState(() {
      // _plateCharList=models;
      // });
      return models!;
      }
      print("models ${response.statusCode}");                      
      return [];
  }


  Future<void> getCarData() async{ 
      var token = Prefer.prefs!.getString('token');
      final response = await http.Client().get(
      "http://62.12.101.94:8080/api/cars?plateChar=$_plateChar&plateNumber=$_platNumber",
      headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
      },
      );
      print(response.body);                      
      if(response.statusCode == 200){
        _vehicleId=jsonDecode(response.body)['result']['vehicleId'] ;
      var models = jsonDecode(response.body)['result'] ;
      // setState(() {
      // _plateCharList=models;
      // });
      // return models!;
      print("models ${_vehicleId}");                      
      }
      // return [];
  }

  void _onFormSubmitted() async{
      // _formKey.currentState!.save();


    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _vehicleId=0;
      _invoiceBloc!.add(
        InvoiceSubmitedEvent(
          companyId: _companyId!,
          invoiceId: _invoiceId!,
          localityId: _localityId!,
          plateNumber: _platNumber!,
          quantitty: _quantutyId!,
          stationId: _stationId!,
          note: _note!,
          driverName: _driverName!,
          driverPhone: _driverPhone!,
          fuelTyeId: widget.fuelType!.id!,
          gasAgentID: 0,
          plateChar: _plateChar!,
          vehicleID: _vehicleId!,
        ),
      );
    } else {

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 6.0,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("validation.required_other"),
                      ),
                    ],
                  ),
                ),
              );


      setState(() {
        _autovalidate = true;
      });
    }


    // _loading=true;
    //     ScaffoldMessenger.of(context)
    //         // Scaffold.of(context)
    //           ..hideCurrentSnackBar()
    //           ..showSnackBar(
    //             SnackBar(
    //               elevation: 6.0,
    //               behavior: SnackBarBehavior.floating,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10.0)),
    //               backgroundColor: Colors.black26,
    //               content: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     ' جاري ارسال البيانات ',
    //                   ),
    //                   CircularProgressIndicator(
    //                     valueColor: new AlwaysStoppedAnimation<Color>(
    //                       Colors.white,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           );

    // print("$_invoiceId  -- $_quantutyId --- $_plateChar -- $_platNumber");
    // print("$_companyId  -- $_localityId --- $_stationId -- $_driverName -- $_driverPhone");

    //           var token = Prefer.prefs!.getString('token');
    //                   final response = await http.Client().post(
    //                     "http://62.12.101.94:8080/api/invoice",
    //                     headers: {
    //                       HttpHeaders.contentTypeHeader: 'application/json',
    //                       HttpHeaders.acceptHeader: 'application/json',
    //                       HttpHeaders.authorizationHeader: 'Bearer $token'
    //                     },
    //           body: jsonEncode(
    //         <String, dynamic>{
    //           'PlateNumber': _platNumber!,
    //           'PlateChar': _plateChar,
    //           'Note': _note,
    //           'VehicleID': 0,
    //           'GasAgentID': 0,
    //           'Quantitty': _quantutyId,
    //           'CompanyId': _companyId,
    //           'LocalityId': _localityId,
    //           'DriverName': _driverName,
    //           'DriverPhone': _driverPhone,
    //           'StationId': _stationId
    //         },
    //       ),
    //     );

    // print(response.statusCode);
    // if (response.statusCode != 200) {
    //     ScaffoldMessenger.of(context)
    //           ..hideCurrentSnackBar()
    //           ..showSnackBar(
    //             SnackBar(
    //               elevation: 6.0,
    //               behavior: SnackBarBehavior.floating,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10.0)),
    //               backgroundColor: Colors.red,
    //               content: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     "حدث خطاء اثنا الارسال حاول ثانية",
    //                   ),
    //                 ],
    //               ),
    //             )
    //             );

    // print(response.body);
    // }

    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   Navigator.pop(context);
    // }    
    // if (response.statusCode == 422) {
    //   var errorJson = jsonDecode(response.body)['errors'];
    //   print(errorJson);
    //   if (errorJson['email'] != null) {
    //     throw Exception(errorJson['email'][0]);
    //   } else if (errorJson['password_confirmation'] != null) {
    //     throw Exception(errorJson['password_confirmation'][0]);
    //   } else if (errorJson['user_name'] != null) {
    //     throw Exception(errorJson['user_name'][0]);
    //   } else
    //     throw Exception('Error registering account');
    // } else if (response.statusCode != 200) {
    //   throw Exception('Error registering account');
    // }

    // final authJson = jsonDecode(response.body);
  
    // print(response.statusCode);
    // return Auth.fromJson(authJson);

    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    //   _invoiceBloc!.add(
    //     InvoiceSubmitedEvent(
    //       companyId: "_name",
    //       invoiceId: "_name",
    //       localityId: "_name",
    //       plateNumber: "_name",
    //       quantity: 0,
    //       stationId: "_name",
    //     ),
    //   );
    // } else {
    //   setState(() {
    //     _autovalidate = true;
    //   });
    // }
  }
}
