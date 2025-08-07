import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class QuoteModel {
  String text;
  String? author;
  String? source;
  String? tags;
  QuoteModel({required this.text, this.author, this.source, this.tags});

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);
  Map<String, dynamic> get toJson => _$QuoteModelToJson(this);
}
