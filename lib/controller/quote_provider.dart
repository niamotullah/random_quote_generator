import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:quote_generator/model/quote.dart';

final kDio = Dio();
final kRandGenerator = Random();

class QuoteProvider {
  List<QuoteModel>? _quotes;
  static final QuoteProvider _instance = QuoteProvider._internal();

  factory QuoteProvider() => _instance;

  QuoteProvider._internal();

  /// returns [null] when there's no quote
  QuoteModel? get quoteRand {
    if (_quotes == null || _quotes!.isEmpty) return null;
    final randNum = kRandGenerator.nextInt(_quotes!.length);
    return _quotes![randNum];
  }

  Future<List<QuoteModel>> loadQuotes() async {
    if (_quotes != null) return _quotes!;

    await Future.delayed(Duration(seconds: 1));

    try {
      final downloadUrl =
          'https://raw.githubusercontent.com/dwyl/quotes/refs/heads/main/quotes.json';
      final response = await kDio.get(downloadUrl);

      final List<dynamic> data = jsonDecode(response.data);
      _quotes = data.map((json) => QuoteModel.fromJson(json)).toList();
    } catch (e) {
      print('failed to load quotes! : \n$e');
    }

    return _quotes!;
  }
}
