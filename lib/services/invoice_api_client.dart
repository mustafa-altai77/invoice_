import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:invoice/constants/api_constants.dart';
import 'package:invoice/invoice.dart';
import 'package:invoice/models/invoice_list.dart';
import 'package:invoice/preferences/preferences.dart';
import 'package:path/path.dart';


class InvoiceApiClient {
  static const baseUrl = ApiConstants.BASE_URL+'/api';
  static final userName = Prefer.prefs!.getString('userName');
  final http.Client httpClient;

  InvoiceApiClient({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();


  Future<InvoiceModel> createInvoice(
{int? invoiceId,int? localityId,int? stationId,int? companyId
,double? quantity,String? plateNuber,String? driverName,String? driverPhone,String? note,
String? plateChar,int? vehicleID,int? fuelTyeId,int? gasAgentID
}
    ) async {
    final url = '$baseUrl/invoice';

    final token = Prefer.prefs!.getString('token');

    final response = await this.httpClient.post(
          url,
          headers: requestHeaders(token),
          body: jsonEncode(
            {
              'PlateNumber': plateNuber,
              'PlateChar': plateChar,
              'Note': note,
              'VehicleID': vehicleID,
              'GasAgentID': gasAgentID,
              'FualTypeID': fuelTyeId,
              'Quantitty': quantity,
              'CompanyId': companyId,
              'LocalityId': localityId,
              'DriverName': driverName,
              'DriverPhone': driverPhone,
              'StationId': stationId,
              'InvoiceId': invoiceId
            },
          ),
        );
      print("status : ${jsonDecode(response.body)}");
    if (response.statusCode != 200) {
      throw Exception('Error sending message');
    }

    return InvoiceModel.fromJson(jsonDecode(response.body));
  }

  Future<List<InvoiceModel>> fetchBooings() async {
    final url = '$baseUrl/invoice';
    print("ana");
    final token = Prefer.prefs!.getString('token');

    final response = await this.httpClient.get(
          url,
          headers: requestHeaders(token),
        );
      print(jsonDecode(response.body));

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Invalid Credentials');
    }

    final specialtiesJson = jsonDecode(response.body)['result'] as List;
    return specialtiesJson
        .map((specialties) => InvoiceModel.fromJson(specialties))
        .toList();
  }




}