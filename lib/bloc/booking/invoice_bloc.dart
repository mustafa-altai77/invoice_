

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:invoice/models/invoice_list.dart';
import 'package:invoice/repositories/invoice_repository.dart';



part 'invoice_state.dart';
part 'invoice_event.dart';

class InvoiceBloc extends Bloc<InvoiceEvent,InvoiceState>{
  InvoiceRepository? invoiceRepository;
  InvoiceBloc({@required this.invoiceRepository}) :assert(invoiceRepository != null ) ,super(InvoiceInial());

  @override
  Stream<InvoiceState> mapEventToState(InvoiceEvent event) async *{
      if(event is InvoiceSubmitedEvent){
          yield InvoiceLoading();
          print("create");

        try{
            final invoice = await invoiceRepository!.createNewInvoice(
              companyId: event.companyId,
              invoiceId:   event.invoiceId,
              localityId: event.localityId,
              stationId: event.stationId,
              quantity: event.quantitty,
              driverName: event.driverName,
              driverPhone: event.driverPhone,
              fuelTyeId: event.fuelTyeId,
              note: event.note,
              plateChar: event.plateChar,
              plateNuber: event.plateNumber,
              vehicleID: event.vehicleID,
              gasAgentID: event.gasAgentID,
              // stationId: event.stationId
            );
          yield InvoiceSuccess(invoice: invoice);

        }catch(ex){
          print(ex.toString());
          yield InvoiceFailureMessage(errorMessage: ex.toString());
        }  
      }

  }
  @override
  void onTransition(Transition<InvoiceEvent, InvoiceState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}