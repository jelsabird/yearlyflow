import 'package:flutter/material.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/util/parallax_flow_delegate.dart';

class MonthHeader extends StatelessWidget {
  MonthHeader({required this.month, Key? key}) : super(key: key);

  final Month month;
  final GlobalKey _backgroundImageKey = GlobalKey();

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image(
          image: AssetImage(month.imagePath),
          semanticLabel: month.displayTitle,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
          alignment: Alignment.topLeft,
        ),
      ],
    );
  }

  Widget _buildMonthTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 32, top: 24),
        child: Text(month.displayTitle, style: Styles.monthHeaderStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          _buildParallaxBackground(context),
          _buildMonthTitle(),
        ],
      ),
    );
  }
}
