import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/models/invoice_list.dart';
import 'package:invoice/repositories/invoice_repository.dart';

part 'invoice_list_state.dart';
part 'invoice_list_event.dart';


class InvoiceListBloc extends Bloc<InvoiceListEvent,InvoiceListState>{
  final InvoiceRepository _specialtyRepository;

  InvoiceListBloc({required InvoiceRepository? specialtyRepository}) :assert(specialtyRepository != null), 
  this._specialtyRepository = specialtyRepository??InvoiceRepository(),
  super(InvoiceListInitial());

  @override
  Stream<InvoiceListState> mapEventToState(InvoiceListEvent event) async*{
    if(event is FetchInvoiceList ){
      yield InvoiceListLoading();
      try{
        print(_specialtyRepository);
        final specialties = await _specialtyRepository.getInvoiceList();
        yield InvoiceListLoaded(invoices: specialties); 
      }catch(e){
                  print("eeee   :  "+e.toString());

          yield InvoiceListError(message: e.toString());
      }
    }


  }

}