import 'package:json_annotation/json_annotation.dart';

part 'invoice_list.g.dart';

class InvoiceModel {
  int? invoiceId;
  int? wareHouseId;
  String? houseName;
  int? companyId;
  String? name;
  int? localityId;
  String? lcName;
  int? stationId;
  String? stName;
  int? gasAgentId;
  int? facilityId;
  int? vehicleId;
  String? plateChar;
  int? plateNumber;
  String? driverName;
  String? driverPhone;
  int? fuelTypeId;
  String? priceConfigName;
  double? approvedLiter;
  String? note;
  int? statusId;
  String? qrcode;
  String? claimId;
  bool? printed;
  String? dateAdded;
  String? userAdded;

  InvoiceModel(
      {
      this.invoiceId,
      this.wareHouseId,
      this.houseName,
      this.companyId,
      this.name,
      this.localityId,
      this.lcName,
      this.stationId,
      this.stName,
      this.gasAgentId,
      this.facilityId,
      this.vehicleId,
      this.plateChar,
      this.plateNumber,
      this.driverName,
      this.driverPhone,
      this.fuelTypeId,
      this.priceConfigName,
      this.approvedLiter,
      this.note,
      this.statusId,
      this.qrcode,
      this.claimId,
      this.printed,
      this.dateAdded,
      this.userAdded
      });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}
