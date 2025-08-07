// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) => QuoteModel(
  text: json['text'] as String,
  author: json['author'] as String?,
  source: json['source'] as String?,
  tags: json['tags'] as String?,
);

Map<String, dynamic> _$QuoteModelToJson(QuoteModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'author': instance.author,
      'source': instance.source,
      'tags': instance.tags,
    };
