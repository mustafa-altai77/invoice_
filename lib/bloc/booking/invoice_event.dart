part of 'invoice_bloc.dart';

abstract class InvoiceEvent extends Equatable{
  const InvoiceEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}


class InvoiceSubmitedEvent extends InvoiceEvent{

 final int invoiceId;
final String plateNumber;
final String plateChar;
final String note;
final int vehicleID;
final int gasAgentID;
final double quantitty;
final int companyId;
final int localityId;
final String driverName;
final String driverPhone;
final int stationId;
 final int fuelTyeId;

const  InvoiceSubmitedEvent({
  required this.invoiceId,
  required this.companyId,
  required this.localityId,
  required this.plateNumber,
  required this.quantitty,
  required this.stationId,
  required this.driverName,
  required this.gasAgentID,
  required this.driverPhone,
  required this.note,
  required this.plateChar,
  required this.vehicleID,
  required this.fuelTyeId

});

  @override
  List<Object> get props => 
      [];

}