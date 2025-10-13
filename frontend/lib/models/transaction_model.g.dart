// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      toAccountId: json['toAccountId'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'type': instance.type,
      'amount': instance.amount,
      'description': instance.description,
      'toAccountId': instance.toAccountId,
      'date': instance.date,
    };
