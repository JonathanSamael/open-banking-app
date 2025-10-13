import 'package:json_annotation/json_annotation.dart';
part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String id;
  final String accountId;
  final String type;
  final double amount;
  final String description;
  final String toAccountId;
  final String date;

  TransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.description,
    required this.toAccountId,
    required this.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}