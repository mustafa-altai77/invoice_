// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) {
  return InvoiceModel(
    invoiceId  : json['invoiceId'] as int,
    wareHouseId  : json['wareHouseId'] as int ,
    houseName  : json['houseName'] as String,
    companyId  : json['companyId'] as int,
    name  : json['name'] as String, 
    localityId  : json['localityId'] as int,
    lcName  : json['lcName'] as String,
    stationId  : json['stationId'] as int ,
    stName  : json['stName'] as String,
    gasAgentId  : json['gasAgentId'] as int,
    facilityId  : json['facilityId'] as int,
    vehicleId  : json['vehicleId'] as int, 
    plateChar  : json['plateChar'] as String,
    plateNumber  : json['plateNumber'] as int,
    driverName  : json['driverName'] as String,
    driverPhone  : json['driverPhone'] as String,
    fuelTypeId  : json['fuelTypeId'] as int,
    priceConfigName  : json['priceConfigName'] as String,
    approvedLiter  : json['approvedLiter'] as double,
    note  : json['note'] as String,
    statusId  : json['statusId'] as int,
    qrcode  : json['qrcode'] as String,
    claimId  : json['claimId'] as String,
    printed  : json['printed'] as bool,
    dateAdded  : json['dateAdded'] as String,
    userAdded  : json['userAdded'] as String
  );
}

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) => <String, dynamic>{
    'invoiceId' : instance.invoiceId,
    'wareHouseId' : instance.wareHouseId,
    'houseName' : instance.houseName,
    'companyId' : instance.companyId,
    'name' : instance.name,
    'localityId' : instance.localityId,
    'lcName' : instance.lcName,
    'stationId' : instance.stationId,
    'stName' : instance.stName,
    'gasAgentId' : instance.gasAgentId,
    'facilityId' : instance.facilityId,
    'vehicleId' : instance.vehicleId,
    'plateChar' : instance.plateChar,
    'plateNumber' : instance.plateNumber,
    'driverName' : instance.driverName,
    'driverPhone' : instance.driverPhone,
    'fuelTypeId' : instance.fuelTypeId,
    'priceConfigName' : instance.priceConfigName,
    'approvedLiter' : instance.approvedLiter,
    'note' : instance.note,
    'statusId' : instance.statusId,
    'qrcode' : instance.qrcode,
    'claimId' : instance.claimId,
    'printed' : instance.printed,
    'dateAdded' : instance.dateAdded,
    'userAdded' : instance.userAdded,

    };
