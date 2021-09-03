import 'package:flutter/material.dart';
import 'package:yearly_flow/src/core/core.dart';

class MonthHeader extends StatelessWidget {
  MonthHeader(this.monthTitle);

  final String monthTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorScheme.backgroundDark,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(monthTitle, style: Styles.monthHeaderStyle),
        ),
      ),
    );
  }
}
