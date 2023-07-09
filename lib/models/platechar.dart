import 'package:json_annotation/json_annotation.dart';

part 'platechar.g.dart';

@JsonSerializable()
class PlateChar {
  @JsonKey(name: 'active')
  bool id;

  @JsonKey(name: 'plateChar')
  String name;


  String? message;

  PlateChar({
    required this.id,
    required this.name,
  });

  factory PlateChar.fromJson(Map<String, dynamic> json) =>
      _$PlateCharFromJson(json);

  Map<String, dynamic> toJson() => _$PlateCharToJson(this);


    static List<PlateChar>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => PlateChar.fromJson(item)).toList();
  }
}
