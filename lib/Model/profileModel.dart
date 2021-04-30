import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String name;
  String username;
  String city;
  String country;
  String phoneNum;
  // ignore: non_constant_identifier_names
  String DOB;
  String titleline;
  String about;
  ProfileModel(
      // ignore: non_constant_identifier_names
      {this.DOB,
      this.about,
      this.name,
      this.country,
      this.phoneNum,
      this.city,
      this.titleline,
      this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
