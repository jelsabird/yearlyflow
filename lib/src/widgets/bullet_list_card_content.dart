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
  final String _bullet = String.fromCharCode(0x2022);
  late String _paddedBullet = _bullet + ' ';
  int currentTextLength = 0;
  FocusNode focusNode = FocusNode(
    canRequestFocus: true,
  );

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.bulletList.title);
    _bulletListController = TextEditingController();
    if (widget.isEditing) {
      _bulletListController.text =
          BulletListHelper.formatStringFromList(widget.bulletList.bulletPoints);
    } else {
      _bulletListController.text = _paddedBullet;
      _titleController.text = _paddedBullet;
    }
  }

  @override
  void dispose() {
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

  void _moveCursorToEnd() {
    _bulletListController.selection = TextSelection.fromPosition(
        TextPosition(offset: _bulletListController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return Column(
        mainAxisSize: MainAxisSize.min,
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
              if (editedList[0] != _bullet) {
                _bulletListController.text = _paddedBullet + editedList;
                _moveCursorToEnd();
              }
              if (editedList[editedList.length - 1] == '\n' &&
                  editedList.length > currentTextLength) {
                _bulletListController.text = editedList + _paddedBullet;
                _moveCursorToEnd();
              }
              currentTextLength = _bulletListController.text.length;

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
    }
  }
}
