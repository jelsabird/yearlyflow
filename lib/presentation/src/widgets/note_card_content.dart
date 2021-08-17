import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

class NoteCardContent extends StatefulWidget {
  const NoteCardContent({
    Key? key,
    required this.note,
    this.isEditing = false,
  }) : super(key: key);

  final Note note;
  final bool isEditing;

  @override
  State<StatefulWidget> createState() => _NoteCardContentState();
}

class _NoteCardContentState extends State<NoteCardContent> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateNote({String? title, String? text}) {
    if (title != null) {
      widget.note.title = title.trim();
    }
    if (text != null) {
      widget.note.text = text.trim();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      return Column(
        children: <Widget>[
          TextField(
            onChanged: (String editedTitle) {
              setState(() {
                _updateNote(title: editedTitle);
              });
            },
            autofocus: true,
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
            onChanged: (String editedText) {
              setState(() {
                _updateNote(text: editedText);
              });
            },
            minLines: 5,
            maxLines: 10,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
                hintText: Strings.cardContent_text,
                hintStyle: Styles.cardBodyStyle),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            widget.note.title,
            style: Styles.cardTitleStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.note.text,
            style: Styles.cardBodyStyle,
          ),
        ],
      );
    }
  }
}
