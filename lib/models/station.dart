import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable()
class Station {
  @JsonKey(name: 'stationId')
  int id;

  @JsonKey(name: 'stationName')
  String name;


  String? message;

  Station({
    required this.id,
    required this.name,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);

  Map<String, dynamic> toJson() => _$StationToJson(this);


    static List<Station>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Station.fromJson(item)).toList();
  }
}
