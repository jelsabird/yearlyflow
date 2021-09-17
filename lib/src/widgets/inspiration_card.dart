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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset('assets/torn_paper.png'),
            Padding(
              padding: EdgeInsets.only(left: 32, top: 16, right: 4, bottom:
              16),
              child: CardContent(
                inspiration: inspiration,
                isEditing: isEditing,
                onDatePicked: onDatePicked,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
