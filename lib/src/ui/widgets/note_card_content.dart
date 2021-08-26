import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/ui/core/strings.dart';
import 'package:yearly_flow/src/ui/core/styles.dart';

class NoteCardContent extends StatefulWidget {
  const NoteCardContent({
    Key? key,
    required this.note,
    this.isEditing = false,
  }) : super(key: key);

  final NoteModel note;
  final bool isEditing;

  @override
  State<StatefulWidget> createState() => _NoteCardContentState();
}

class _NoteCardContentState extends State<NoteCardContent> {
  late TextEditingController _titleController;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _textController = TextEditingController(text: widget.note.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
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
            controller: _titleController,
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
            controller: _textController,
            onChanged: (String editedText) {
              setState(() {
                _updateNote(text: editedText);
              });
            },
            minLines: 1,
            maxLines: 20,
            style: Styles.cardBodyStyle,
            decoration: InputDecoration(
                hintText: Strings.cardContent_text,
                hintStyle: Styles.cardBodyStyle),
          ),
        ],
      );
    } else {
      return Text(
          widget.note.text,
          overflow: TextOverflow.fade,
          style: Styles.cardBodyStyle,
      );
    }
  }
}
