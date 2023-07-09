import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/bloc/auth/register/register_bloc.dart';
import 'package:invoice/bloc/booking/invoice_bloc.dart';
import 'package:invoice/models/gridmenu.dart';
import 'package:invoice/repositories/invoice_repository.dart';
import 'package:invoice/repositories/user_repository.dart';
import 'package:invoice/screens/auth/register_form.dart';
import 'package:invoice/screens/invoice_screen/invoice_form.dart';

class InvoiceScreen extends StatelessWidget {
  static final String id="InvoiceScreen"; 
  
  final InvoiceRepository? invoiceRepository;
  final MyGridMenu? fuelType;
  // final int? fuelTypeId;

  const InvoiceScreen({this.fuelType,this.invoiceRepository,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("${fuelType} In Screen");
    return BlocProvider<InvoiceBloc>(
      create: (context) => InvoiceBloc(invoiceRepository:  invoiceRepository),
      child: InvoiceForm(fuelType: fuelType),
    );
  }
}
