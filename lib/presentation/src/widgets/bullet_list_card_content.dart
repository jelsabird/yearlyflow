import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/util/bullet_list_helper.dart';

class BulletListCardContent extends StatefulWidget {
  const BulletListCardContent({
    Key? key,
    required this.bulletList,
    this.isEditing = false,
  }) : super(key: key);

  final BulletList bulletList;
  final bool isEditing;

  @override
  _BulletListCardContentState createState() => _BulletListCardContentState();
}

class _BulletListCardContentState extends State<BulletListCardContent> {
  void _updateBulletList({String? title, List<String>? bulletPoints}) {
    if (title != null) {
      widget.bulletList.title = title.trim();
    }
    if (bulletPoints != null) {
      widget.bulletList.bulletPoints = bulletPoints;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return Column(
        children: [
          TextField(
            onChanged: (String editedTitle) {
              setState(() {
                _updateBulletList(title: editedTitle);
              });
            },
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: Strings.cardContent_title,
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            onChanged: (String editedList) {
              setState(() {
                _updateBulletList(
                    bulletPoints:
                        BulletListHelper.convertTextToList(editedList));
              });
            },
            minLines: 5,
            maxLines: 20,
            decoration: InputDecoration(
              hintText: Strings.inspirationType_bulletList,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            widget.bulletList.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(children: _getTextRows(widget.bulletList.bulletPoints)),
        ],
      );
    }
  }

  List<Widget> _getTextRows(List<String> textList) {
    final List<Widget> rows = <Widget>[];
    for (final String text in textList) {
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("• "), Expanded(child: Text(text))],
      ));
    }
    return rows;
  }
}
