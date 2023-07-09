import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/auth/register/register_bloc.dart';
import 'package:invoice/screens/auth/register_images_form.dart';
import 'package:invoice/utils/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';



class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterBloc? _registerBloc;

  bool isButtonEnabled(RegisterState state) {
    return state is! RegisterLoading;
  }

  bool _autovalidate = false;
  final passKey = GlobalKey<FormFieldState>();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  String? _name;
  String? _username;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  @override
  void initState() {
    super.initState();
    _registerBloc = context.read<RegisterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
          title: Text(
            tr('invoiceform.title'),
            style: Theme.of(context).appBarTheme.textTheme!.caption,
          ),
          centerTitle: true,
        ),
        body: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
          if (state is RegisterFailureMessage) {
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
                        state.errorMessage,
                      ),
                    ],
                  ),
                ),
              );
          }
          if (state is RegisterLoading) {
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
                        'Registering...',
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
          if (state is RegisterSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: _registerBloc,
                  child: RegisterImagesForm(),
                ),
              ),
            );
          }
        }, child: BlocBuilder<RegisterBloc, RegisterState>(
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
                            return val!.trim().isEmpty
                                ? 'Name cannot be empty'
                                : null;
                          },
                          onSaved: (value) => _name = value,
                        ),
                        SizedBox(height: 20.0),


              ///BottomSheet Mode with no searchBox
              DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                items: [
                  "النيل",
                  "امان",
                  "قادرة",
                  'بشائر',
                  'اويل اينرجي',
                  'بيترولا',
                  'سيدون',
                  'ماثيو',
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_company'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: tr('invoiceform.hint_company'),
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
                
              ),

                        SizedBox(height: 20.0),

              ///BottomSheet Mode with no searchBox
              DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                items: [
                  "2000",
                  "40000",
                  "60000",
                  '80000',
                  '90000',
                  '30000',
                  '100000',
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_quantity'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: tr('invoiceform.hint_quantity'),
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
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tr('invoiceform.lbl_quantities'),
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
              ),

                        SizedBox(height: 20.0),


DropdownSearch<String>(
    mode: Mode.MENU,
    showSelectedItems: true,
    items: ["امبدة", "بحري", "الخرطوم", 'جبل اوليا', 'شرق النيل', 'كرري'],
    label: tr('invoiceform.lbl_locality'),
    // hint: "country in menu mode",
    popupItemDisabled: (String s) => s.startsWith('I'),
    onChanged: print,
    dropdownSearchDecoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
      border: OutlineInputBorder(),

    ),
    selectedItem: tr('invoiceform.hint_locality')),

                        SizedBox(height: 20.0),


              ///BottomSheet Mode with no searchBox
              DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                items: [
                  "كوبر",
                  "الحلفايا الللاسلكى",
                  "شمبات",
                  'واوستى',
                  'سلاح الاشاره ت / ج',
                  'الميرغنية',
                  'بحرى الوسطى الزواده   ت / ب',
                  'الحلفايا العربى ت / ج',
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_station'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: tr('invoiceform.hint_station'),
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
                    color: Theme.of(context).primaryColor,
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
              ),



                        SizedBox(height: 20.0),


              ///BottomSheet Mode with no searchBox
              DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                popupBackgroundColor: Colors.white,
                items: [
                  "خ1-1209",
                  "خ1-2020",
                  "ن1-2091",
                  'خ1-2211',
                  'خ1-2912',
                  'خ1-1248',
                  'ج1-2910',
                  "خ1-1209",
                  "خ1-2020",
                  "ن1-2091",
                  'خ1-2211',
                  'خ1-2912',
                  'خ1-1248',
                  'ج1-2910',
                  "خ1-1209",
                  "خ1-2020",
                  "ن1-2091",
                  'خ1-2211',
                  'خ1-2912',
                  'خ1-1248',
                  'ج1-2910',
                  "خ1-1209",
                  "خ1-2020",
                  "ن1-2091",
                  'خ1-2211',
                  'خ1-2912',
                  'خ1-1248',
                  'ج1-2910',                                    
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: tr('invoiceform.lbl_plate_number'),
                  contentPadding: EdgeInsets.fromLTRB(0, 12, 12, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                selectedItem: tr('invoiceform.hint_plate_number'),
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
                      tr('invoiceform.hint_plate_number'),
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
              ),

                        SizedBox(height: 20.0),

                        Text(
                          tr('invoiceform.lbl_note'),
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .cursorColor,
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
                          validator: (val) {
                            return val!.trim().isEmpty
                                ? 'Username cannot be empty'
                                : null;
                          },
                          onSaved: (value) => _username = value,
                        ),
                        SizedBox(height: 20.0),
                        // Text(
                        //   'Email',
                        //   style: Theme.of(context).textTheme.caption,
                        // ),
                        SizedBox(height: 10.0),
                        // TextFormField(
                        //   style: TextStyle(
                        //       color: Theme.of(context)
                        //           .textSelectionTheme
                        //           .cursorColor,
                        //       fontWeight: FontWeight.w500),
                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       focusColor: Colors.white,
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide(
                        //           width: 2.0,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //       prefixIcon: Icon(
                        //         Icons.mail,
                        //         color: Colors.grey,
                        //       ),
                        //       hintText: 'you@example.com'),
                        //   validator: (val) {
                        //     return !Validators.isValidEmail(val!)
                        //         ? 'Invalid email.'
                        //         : null;
                        //   },
                        //   onSaved: (value) => _email = value,
                        // ),
                        // SizedBox(height: 20.0),
                        // Text(
                        //   'Enter password',
                        //   style: Theme.of(context).textTheme.bodyText2,
                        // ),
                        // SizedBox(height: 10.0),
                        // TextFormField(
                        //   key: passKey,
                        //   style: TextStyle(
                        //       color: Theme.of(context)
                        //           .textSelectionTheme
                        //           .cursorColor,
                        //       fontWeight: FontWeight.w500),
                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       focusColor: Theme.of(context).primaryColor,
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide(
                        //           width: 2.0,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //       prefixIcon:
                        //           Icon(Icons.lock_outline, color: Colors.grey),
                        //       suffixIcon: IconButton(
                        //         color: Colors.grey,
                        //         icon: _isPasswordHidden
                        //             ? Icon(
                        //                 Icons.visibility_off,
                        //               )
                        //             : Icon(Icons.visibility),
                        //         onPressed: () {
                        //           setState(() {
                        //             _isPasswordHidden = !_isPasswordHidden;
                        //           });
                        //         },
                        //       ),
                        //       hintText: '********'),
                        //   obscureText: _isPasswordHidden,
                        //   validator: (val) {
                        //     return val!.trim().isEmpty
                        //         ? 'Password cannot be empty.'
                        //         : null;
                        //   },
                        //   onSaved: (value) => _password = value,
                        // ),
                        // SizedBox(height: 20.0),
                        // Text(
                        //   'Confirm password',
                        //   style: Theme.of(context).textTheme.bodyText2,
                        // ),
                        // SizedBox(height: 10.0),
                        // TextFormField(
                        //   style: TextStyle(
                        //       color: Theme.of(context)
                        //           .textSelectionTheme
                        //           .cursorColor,
                        //       fontWeight: FontWeight.w500),
                        //   decoration: InputDecoration(
                        //       filled: true,
                        //       focusColor: Theme.of(context).primaryColor,
                        //       enabledBorder: UnderlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       errorBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         borderSide: BorderSide(
                        //           width: 2.0,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //       prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        //       suffixIcon: IconButton(
                        //         color: Colors.grey,
                        //         icon: _isConfirmPasswordHidden
                        //             ? Icon(Icons.visibility_off)
                        //             : Icon(Icons.visibility),
                        //         onPressed: () {
                        //           setState(() {
                        //             _isConfirmPasswordHidden =
                        //                 !_isConfirmPasswordHidden;
                        //           });
                        //         },
                        //       ),
                        //       hintText: 'Password Confirmation'),
                        //   obscureText: _isConfirmPasswordHidden,
                        //   validator: (val) {
                        //     if (val!.trim().isEmpty) {
                        //       return 'Password confirmation cannot be empty';
                        //     } else if (val != passKey.currentState!.value) {
                        //       return 'Password confirmation does not match.';
                        //     } else
                        //       return null;
                        //   },
                        //   onSaved: (value) => _passwordConfirmation = value,
                        // ),

                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Material(
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: isButtonEnabled(state) ? _onFormSubmitted : null,
                        child: SizedBox(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              tr('invoiceform.btn_send'),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  letterSpacing: 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )));
  }

  void _onFormSubmitted() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _registerBloc!.add(
        Submitted(
          name: _name!,
          username: _username!,
          email: _email!,
          password: _password!,
          passwordConfirmation: _passwordConfirmation!,
        ),
      );
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
