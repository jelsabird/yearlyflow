import 'package:flutter/material.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/presentation/src/widgets/card_content.dart';

class InspirationCard extends StatefulWidget {
  InspirationCard(this.inspiration, {this.isEditing = false, this.onTap});

  final Inspiration inspiration;
  final bool isEditing;
  final GestureTapCallback? onTap;

  @override
  _InspirationCardState createState() => _InspirationCardState();
}

class _InspirationCardState extends State<InspirationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: widget.onTap,
        child: CardContent(widget.inspiration, isEditing: widget.isEditing,)
      )
    );
  }
}
