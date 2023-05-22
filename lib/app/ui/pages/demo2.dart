import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double _collapsedHeight = 60;
  double _expandedHeight = 200;
  late double
  extentRatio; // Value to control SliverAppBar widget sizes, based on BoxConstraints and
  double minH1 = 40; // Minimum height of the first image.
  double minW1 = 30; // Minimum width of the first image.
  double minH2 = 20; // Minimum height of second image.
  double minW2 = 25; // Minimum width of second image.
  double maxH1 = 60; // Maximum height of the first image.
  double maxW1 = 60; // Maximum width of the first image.
  double maxH2 = 40; // Maximum height of second image.
  double maxW2 = 50; // Maximum width of second image.
  double textWidth = 70; // Width of a given title text.
  double extYAxisOff = 10.0; // Offset on Y axis for both images when sliver is extended.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  collapsedHeight: _collapsedHeight,
                  expandedHeight: _expandedHeight,
                  floating: true,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      extentRatio =
                          (constraints.biggest.height - _collapsedHeight) /
                              (_expandedHeight - _collapsedHeight);
                      double xAxisOffset1 = (-(minW1 - minW2) -
                          textWidth +
                          (textWidth + maxW1) * extentRatio) /
                          2;
                      double xAxisOffset2 = (-(minW1 - minW2) +
                          textWidth +
                          (-textWidth - maxW2) * extentRatio) /
                          2;
                      double yAxisOffset2 = (-(minH1 - minH2) -
                          (maxH1 - maxH2 - (minH1 - minH2)) *
                              extentRatio) /
                          2 -
                          extYAxisOff * extentRatio;
                      double yAxisOffset1 = -extYAxisOff * extentRatio;
                      print(extYAxisOff);
                      // debugPrint('constraints=' + constraints.toString());
                      // debugPrint('Scale ratio is $extentRatio');
                      return FlexibleSpaceBar(
                         titlePadding: EdgeInsets.all(0),
                        // centerTitle: true,
                        title: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: extentRatio < 1 ? 1 : 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Container(
                                    color: Colors.indigo,
                                    width: textWidth,
                                    alignment: Alignment.center,
                                    height: 20,
                                    child: const Text(
                                      "TITLE TEXT",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    transform: Matrix4(
                                        1,0,0,0,
                                        0,1,0,0,
                                        0,0,1,0,
                                        xAxisOffset1,yAxisOffset1,0,1),
                                    width:
                                    minW1 + (maxW1 - minW1) * extentRatio,
                                    height:
                                    minH1 + (maxH1 - minH1) * extentRatio,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    transform: Matrix4(
                                        1,0,0,0,
                                        0,1,0,0,
                                        0,0,1,0,
                                        xAxisOffset2,yAxisOffset2,0,1),

                                    width:
                                    minW2 + (maxW2 - minW2) * extentRatio,
                                    height:
                                    minH2 + (maxH2 - minH2) * extentRatio,
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ),
            ];
          },
          // body: Center(
          //   child: Text("Sample Text"),
          // ),
          body: Padding(
            padding: const EdgeInsets.only(top:80.0),
            child: ListView.builder(
              //shrinkWrap: true,
              itemCount:2,
                itemBuilder: (context, index){
              return Text("item$index");
            }),
          ),
        ),
      ),
    );
  }
}