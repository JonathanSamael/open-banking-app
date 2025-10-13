import 'package:json_annotation/json_annotation.dart';
part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  final String id;
  final String userId;
  final String type;
  final double balance;
  final String createdAt;

  AccountModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.balance,
    required this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
