import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/util/bullet_list_helper.dart';

class BulletListCardContent extends StatefulWidget {
  const BulletListCardContent({
    Key? key,
    required this.bulletList,
    this.isEditing = false,
  }) : super(key: key);

  final BulletListModel bulletList;
  final bool isEditing;

  @override
  _BulletListCardContentState createState() => _BulletListCardContentState();
}

class _BulletListCardContentState extends State<BulletListCardContent> {
  late TextEditingController _titleController;
  late TextEditingController _bulletListController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.bulletList.title);
    _bulletListController = TextEditingController(
        text:
            BulletListHelper.convertListToText(widget.bulletList.bulletPoints));
  }

  @override
  void dispose(){
    _titleController.dispose();
    _bulletListController.dispose();
    super.dispose();
  }

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
            controller: _titleController,
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
            controller: _bulletListController,
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
      return Text(
        BulletListHelper.formatStringFromList(widget.bulletList.bulletPoints),
        overflow: TextOverflow.fade,
      );
      /*Column(
              children: BulletListHelper.getTextRows(
                  widget.bulletList.bulletPoints)),*/
    }
  }
}
