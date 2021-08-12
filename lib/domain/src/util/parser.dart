import 'package:yearly_flow/domain/src/entity/inspiration.dart';

class Parser {

  static String? getString(Map<String, dynamic> obj, String key) {
    if (obj == null) {
      return null;
    }
    if (!obj.containsKey(key)) {
      return null;
    }
    final dynamic res = obj[key];
    if (res is String) {
      return res;
    }
    if (res is num) {
      return res.toString();
    }
    return null;
  }

  static int? getInt(Map<String, dynamic> obj, String key) {
    if (obj == null) {
      return null;
    }
    if (!obj.containsKey(key)) {
      return null;
    }
    final dynamic res = obj[key];
    if (res is int) {
      return res;
    }
    if (res is double) {
      return res.toInt();
    }
    if (res is String) {
      return int.tryParse(res);
    }
    return null;
  }

  static DateTime? getTime(Map<String, dynamic> obj, String key) {
    if (obj == null) {
      return null;
    }
    if (!obj.containsKey(key)) {
      return null;
    }
    final dynamic res = obj[key];
    if (res is num) {
      return DateTime.fromMillisecondsSinceEpoch(res.toInt() * 1000);
    }
    if (res is String) {
      return DateTime.tryParse(res);
    }
    return null;
  }

  static List<dynamic> getList(Map<String, dynamic> obj, String key) {
    if(obj == null) {
      return <dynamic>[];
  }
    final dynamic list = obj[key];
    if(list is List) {
      return list;
    }
    return <dynamic>[];
  }

  static List<Inspiration> getInspirationList(Map<String, dynamic> obj, String
  key) {
    if(obj == null) {
      return <Inspiration>[];
    }

    final List<Inspiration>? list;
    list = (obj[key] as List<dynamic>).map((dynamic item) => item as
    Inspiration).toList();

    if (list != null) {
      return list;
    }

    return <Inspiration>[];
  }
}