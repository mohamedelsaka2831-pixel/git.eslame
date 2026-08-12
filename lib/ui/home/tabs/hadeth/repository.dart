import 'dart:convert';
import 'package:flutter/services.dart';
import 'model.dart';

class HadethRepository {
  static List<HadethModel>? _cache;

  static Future<List<HadethModel>> loadHadeth() async {
    if (_cache != null) return _cache!;

    final String jsonString =
    await rootBundle.loadString('assets/data/hadeth.json');
    final List<dynamic> data = jsonDecode(jsonString);

    _cache = data
        .map((e) => HadethModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return _cache!;
  }
}