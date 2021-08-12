import 'package:yearly_flow/domain/src/util/parser.dart';

import 'inspiration_content.dart';

class BulletList implements InspirationContent {

  BulletList(this.title, this.bulletPoints);

  @override
  factory BulletList.fromJson(Map<String, dynamic> json) {
    final String? parsedTitle = Parser.getString(json, 'title');
    final List<String> parsedBulletPoints =  List<String>.from(Parser.getList
    (json, 'bulletPoints'));

    return BulletList(
      parsedTitle ?? '',
      parsedBulletPoints
    );
  }

  String title = '';
  List<String> bulletPoints = <String>[];
}