import 'package:yearly_flow/domain/src/util/parser.dart';

import 'inspiration_content.dart';

class Note implements InspirationContent {

  Note({this.title = '', this.text = ''});

  @override
  factory Note.fromJson(Map<String, dynamic> json) {
    final String? parsedTitle = Parser.getString(json, 'title');
    final String? parsedText = Parser.getString(json, 'text');

    return Note(
      title: parsedTitle ?? '',
      text: parsedText ?? '',
    );
  }

  String title;
  String text;
}