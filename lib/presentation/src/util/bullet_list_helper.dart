import 'dart:convert';

class BulletListHelper {
  static convertTextToList(String text){
    LineSplitter lineSplitter = new LineSplitter();
    return lineSplitter.convert(text.trim());
  }
}