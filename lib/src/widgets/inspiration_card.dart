import 'package:flutter/material.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/widgets/card_content.dart';

class InspirationCard extends StatelessWidget {
  InspirationCard(
      {required this.inspiration, this.isEditing = false, this.onTap,
        this.onDatePicked});

  final InspirationModel inspiration;
  final bool isEditing;
  final GestureTapCallback? onTap;
  final Function? onDatePicked;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: CardContent(
          inspiration: inspiration,
          isEditing: isEditing,
          onDatePicked: onDatePicked,
        ),
      ),
    );
  }
}
