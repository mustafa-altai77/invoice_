import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  @JsonKey(name: 'companyID')
  int id;

  @JsonKey(name: 'companyName')
  String name;


  String? message;

  Company({
    required this.id,
    required this.name,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);


    static List<Company>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => Company.fromJson(item)).toList();
  }
}
