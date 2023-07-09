
part of 'invoice_list_bloc.dart';

@immutable
abstract class InvoiceListState extends Equatable {
  const InvoiceListState();
  @override
  List<Object> get props => [];
}




class InvoiceListInitial extends InvoiceListState {}

class InvoiceListLoading extends InvoiceListState {}

class InvoiceListLoaded extends InvoiceListState {
  final List<InvoiceModel>? invoices;

  const InvoiceListLoaded({@required this.invoices}) : assert ( invoices != null );
}


class InvoiceListError extends InvoiceListState {
  final String? message;
  const InvoiceListError({@required this.message} ); 
}
