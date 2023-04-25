import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines/timelines.dart';

import 'fossil_map.dart';

class TimeLine_fossils extends StatefulWidget {
  const TimeLine_fossils({Key? key}) : super(key: key);

  @override
  State<TimeLine_fossils> createState() => _TimeLine_fossilsState();
}

class _TimeLine_fossilsState extends State<TimeLine_fossils> {
  final List<String> images = [
    'Decomposition.png',
    'Burial.png',
    'Permineralization.png',
    'Recrystallization.png',
    'Replacement.png',
    'Mold_and_Cast_Formation.png',
    'Exposure.png',
  ];
  final List<String> phases = [
    'Decomposition',
    'Burial',
    'Permineralization',
    'Recrystallization',
    'Replacement',
    'Mold and Cast Formation',
    'Exposure',
  ];

  int _currentStep = 0;
  String image = 'Decomposition.png';

  void _onNextPressed() {
    if (_currentStep < 10) {
      setState(() {
        print(image);
        print(_currentStep);
        _currentStep++;
        image = images[_currentStep];
      });
    }
  }

  void _onPrevPressed() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        image = images[_currentStep];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The process of fossilization'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/startpage'),
        ),
      ),
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/$image',
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2),
                BlendMode.lighten), // set low opacity
          ),
        )),
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: TimelinePainter(
                          lineColor: Colors.grey,
                        ),
                      ),
                    ),
                    Timeline.tileBuilder(
                      theme: TimelineThemeData(
                        direction: Axis.horizontal,
                        connectorTheme: const ConnectorThemeData(
                          space: 30.0,
                          thickness: 5.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        itemCount: 10,
                        contentsBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '   ${index + 1}:${phases[index]}   ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        connectorBuilder: (_, index, __) {
                          //Line
                          return DecoratedLineConnector(
                            decoration: BoxDecoration(
                              color: index <= _currentStep
                                  ? const Color.fromRGBO(110, 77, 14, 1)
                                  : Colors.grey,
                            ),
                          );
                        },
                        indicatorBuilder: (_, index) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                width: 25.0,
                                height: 25.0,
                                child: GestureDetector(
                                  onTap: () {
                                    context.go('/time1');
                                  },
                                  child: Container(
                                    width: 25.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      //Circles
                                      shape: BoxShape.circle,
                                      color: index <= _currentStep
                                          ? const Color((0xFFD88B4A))
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: const Center(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onPrevPressed,
                    child: const Text('Prev'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      primary: const Color(0xFFD88B4A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    child: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      primary: const Color((0xFFD88B4A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}

class TimelinePainter extends CustomPainter {
  final int currentStep;
  final int timelineLength;
  final double dotRadius;
  final double lineWidth;
  final Color lineColor;
  final Color completeColor;
  final Color incompleteColor;

  TimelinePainter({
    this.currentStep = 0,
    this.timelineLength = 0,
    this.dotRadius = 12,
    this.lineWidth = 4,
    this.lineColor = Colors.grey,
    this.completeColor = Colors.blue,
    this.incompleteColor = Colors.grey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double halfLineWidth = lineWidth / 2;
    final double dotDiameter = dotRadius * 2;
    final double dotOffset = dotRadius + halfLineWidth;
    final double height = size.height;

    // Draw the line
    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(dotOffset, height / 2),
      Offset(size.width - dotOffset, height / 2),
      linePaint,
    );

    // Draw the completed dots
    final Paint completePaint = Paint()
      ..color = completeColor
      ..style = PaintingStyle.fill;
    for (int i = 0; i < currentStep; i++) {
      final double dx = ((size.width - dotDiameter) / (timelineLength - 1)) * i;
      canvas.drawCircle(
          Offset(dx + dotOffset, height / 2), dotRadius, completePaint);
    }

    // Draw the incomplete dots
    final Paint incompletePaint = Paint()
      ..color = incompleteColor
      ..style = PaintingStyle.fill;
    for (int i = currentStep; i < timelineLength; i++) {
      final double dx = ((size.width - dotDiameter) / (timelineLength - 1)) * i;
      canvas.drawCircle(
          Offset(dx + dotOffset, height / 2), dotRadius, incompletePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
