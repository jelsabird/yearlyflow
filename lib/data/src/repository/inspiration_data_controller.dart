import 'dart:convert';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class InspirationDataController {

  Future<List<Inspiration>> readJson() async {
    final String response =
    await rootBundle.loadString('assets/mock_data.json');
    final dynamic data = const JsonDecoder().convert(response);

    if (data is Map<String, dynamic>) {
      
      final List<Map<String, dynamic>> list = getInspirationList(data, 'inspirations');
      final List<Inspiration> inspirationList = <Inspiration>[];

      for (int i = 0;i<list.length;i++) {

        inspirationList.add(Inspiration.fromJson(list[i]));
      }

      return Future<List<Inspiration>>.value(inspirationList);
    }
    throw const FormatException('Json format could not be read.');
  }

  static List<Map<String, dynamic>> getInspirationList(Map<String, dynamic> obj, String
  key) {
    if(obj == null) {
      return <Map<String, dynamic>>[];
    }

    final List<Map<String, dynamic>>? list;
    list = (obj[key] as List<dynamic>).map((dynamic item) => item as
    Map<String, dynamic>).toList();

    if (list != null) {
      return list;
    }

    return <Map<String, dynamic>>[];
  }
}