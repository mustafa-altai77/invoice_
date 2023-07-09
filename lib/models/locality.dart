import 'package:json_annotation/json_annotation.dart';

part 'locality.g.dart';

@JsonSerializable()
class Locality {
  @JsonKey(name: 'localityId')
  int id;

  @JsonKey(name: 'localityName')
  String name;


  String? message;

  Locality({
    required this.id,
    required this.name,
  });

  factory Locality.fromJson(Map<String, dynamic> json) =>
      _$LocalityFromJson(json);

  Map<String, dynamic> toJson() => _$LocalityToJson(this);


    static List<Locality>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Locality.fromJson(item)).toList();
  }
}
