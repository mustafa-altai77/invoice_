



import 'package:invoice/models/invoice_list.dart';
import 'package:invoice/services/invoice_api_client.dart';

class InvoiceRepository {
  final InvoiceApiClient _bookingApiClient;

  InvoiceRepository({InvoiceApiClient? bookingApiClient})
      : _bookingApiClient =
            bookingApiClient??InvoiceApiClient();

  Future<InvoiceModel> createNewInvoice(
{int? invoiceId,int? localityId,int? stationId,int? companyId
,double? quantity,String? plateNuber,String? driverName,String? driverPhone,String? note,
String? plateChar,int? vehicleID,int? fuelTyeId,int? gasAgentID
}
  ) async {
    return _bookingApiClient.createInvoice(
      companyId: companyId,
      invoiceId: invoiceId,
      localityId: localityId,
      plateNuber: plateNuber,
      quantity: quantity,
      stationId: stationId,
      driverName: driverName,
      driverPhone: driverPhone,
      fuelTyeId: fuelTyeId,
      gasAgentID: gasAgentID,
      note: note,
      plateChar: plateChar,
      vehicleID: vehicleID,

    );
  }


    Future<List<InvoiceModel>> getInvoiceList() async {
    return _bookingApiClient.fetchBooings();
  }
}
