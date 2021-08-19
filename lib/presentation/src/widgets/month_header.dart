import 'package:flutter/material.dart';
import 'package:yearly_flow/presentation/src/core/app_color_scheme.dart';
import 'package:yearly_flow/presentation/src/core/styles.dart';

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
