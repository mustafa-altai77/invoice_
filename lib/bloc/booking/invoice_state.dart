

part of 'invoice_bloc.dart';

abstract class InvoiceState extends Equatable{
 const InvoiceState();
  @override
  List<Object> get props => throw UnimplementedError();
}


class InvoiceInial extends InvoiceState{
}


class InvoiceLoading extends InvoiceState{
}

class InvoiceSuccess extends InvoiceState{
 final InvoiceModel? invoice;
  InvoiceSuccess({@required this.invoice}) : assert( invoice != null);

  @override
  List<Object> get props => [invoice!];

}

class InvoiceError extends InvoiceState{
}


class InvoiceFailureMessage extends InvoiceState {
  final String? errorMessage;

  const InvoiceFailureMessage({@required this.errorMessage})
      : assert(errorMessage != null);

  @override
  List<Object> get props => [errorMessage!];
}

