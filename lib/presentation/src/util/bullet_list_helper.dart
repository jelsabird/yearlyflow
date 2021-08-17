import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

class BulletListHelper {
  static convertTextToList(String text) {
    LineSplitter lineSplitter = LineSplitter();
    return lineSplitter.convert(text.trim());
  }

  static List<Widget> getTextRows(List<String> textList) {
    final List<Widget> rows = <Widget>[];
    for (final String text in textList) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: Styles.cardBodyStyle,
          ),
          Expanded(
              child: Text(
            text,
            style: Styles.cardBodyStyle,
          ))
        ],
      ));
    }
    return rows;
  }
}
