import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: MySliverAppBar(
              title: 'Sample',
              minWidth: 50,
              minHeight: 25,
              leftMaxWidth: 200,
              leftMaxHeight: 100,
              rightMaxWidth: 100,
              rightMaxHeight: 50,
              shrinkedTopPos: 10,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, int i) => Container(
                height: 50,
                color: Color.fromARGB(
                  255,
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                ),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({
    required this.title,
    required this.minWidth,
    required this.minHeight,
    required this.leftMaxWidth,
    required this.leftMaxHeight,
    required this.rightMaxWidth,
    required this.rightMaxHeight,
    this.titleStyle = const TextStyle(fontSize: 26),
    this.shrinkedTopPos = 0,
  });

  final String title;
  final TextStyle titleStyle;
  final double minWidth;
  final double minHeight;
  final double leftMaxWidth;
  final double leftMaxHeight;
  final double rightMaxWidth;
  final double rightMaxHeight;

  final double shrinkedTopPos;

  final GlobalKey _titleKey = GlobalKey();

  double? _topPadding;
  double? _centerX;
  Size? _titleSize;

  double get _shrinkedTopPos => _topPadding! + shrinkedTopPos;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    if (_topPadding == null) {
      _topPadding = MediaQuery.of(context).padding.top;
    }
    if (_centerX == null) {
      _centerX = MediaQuery.of(context).size.width / 2;
    }
    if (_titleSize == null) {
      _titleSize = _calculateTitleSize(title, titleStyle);
    }

    double percent = shrinkOffset / (maxExtent - minExtent);
    percent = percent > 1 ? 1 : percent;

    return Container(
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          _buildTitle(shrinkOffset),
          _buildLeftImage(percent),
          _buildRightImage(percent),
        ],
      ),
    );
  }

  Size _calculateTitleSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Widget _buildTitle(double shrinkOffset) => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: _topPadding!),
      child: Opacity(
        opacity: shrinkOffset / maxExtent,
        child: Text(title, key: _titleKey, style: titleStyle),
      ),
    ),
  );

  double getScaledWidth(double width, double percent) =>
      width - ((width - minWidth) * percent);

  double getScaledHeight(double height, double percent) =>
      height - ((height - minHeight) * percent);

  /// 20 is the padding between the image and the title
  double get shrinkedHorizontalPos =>
      (_centerX! - (_titleSize!.width / 2)) - minWidth - 20;

  Widget _buildLeftImage(double percent) {
    final double topMargin = minExtent;
    final double rangeLeft =
        (_centerX! - (leftMaxWidth / 2)) - shrinkedHorizontalPos;
    final double rangeTop = topMargin - _shrinkedTopPos;

    final double top = topMargin - (rangeTop * percent);
    final double left =
        (_centerX! - (leftMaxWidth / 2)) - (rangeLeft * percent);

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: getScaledWidth(leftMaxWidth, percent),
        height: getScaledHeight(leftMaxHeight, percent),
        color: Colors.black,
      ),
    );
  }

  Widget _buildRightImage(double percent) {
    final double topMargin = minExtent + (rightMaxHeight / 2);
    final double rangeRight =
        (_centerX! - (rightMaxWidth / 2)) - shrinkedHorizontalPos;
    final double rangeTop = topMargin - _shrinkedTopPos;

    final double top = topMargin - (rangeTop * percent);
    final double right =
        (_centerX! - (rightMaxWidth / 2)) - (rangeRight * percent);

    return Positioned(
      right: right,
      top: top,
      child: Container(
        width: getScaledWidth(rightMaxWidth, percent),
        height: getScaledHeight(rightMaxHeight, percent),
        color: Colors.white,
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => _topPadding! + 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}