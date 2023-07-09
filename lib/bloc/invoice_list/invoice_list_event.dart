
part of 'invoice_list_bloc.dart';

abstract class InvoiceListEvent extends Equatable {
  const InvoiceListEvent();
}

class FetchInvoiceList extends InvoiceListEvent {
  @override
  List<Object> get props => [];
}

