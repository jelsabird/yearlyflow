import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';
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
            style: Styles.cardTitleStyle,
            decoration: InputDecoration(
              hintText: Strings.cardContent_title,
              hintStyle: Styles.cardTitleStyle,
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
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
              hintText: Strings.inspirationType_bulletList,
              hintStyle: Styles.cardBodyStyle,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            widget.bulletList.title,
            style: Styles.cardTitleStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Column(children: BulletListHelper.getTextRows(widget.bulletList
          .bulletPoints)),
        ],
      );
    }
  }
}
