import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/n_input.dart';

class UIView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIViewState();
}

class _UIViewState extends State<UIView> {
  int _n = 0;

  void _onNSubmit(int number) {
    setState(() {
      _n = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _n == 0
        ? NInput(onSubmit: _onNSubmit)
        : Center(child: LayoutBuilder(builder: (context, constraints) {
            return RotatingSquares(
                n: _n,
                height: constraints.maxHeight,
                width: constraints.maxWidth);
          }));
  }
}

class RotatingSquares extends StatelessWidget {
  const RotatingSquares(
      {super.key, required this.n, required this.height, required this.width});

  final int n;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    double squareSideLength = getOptimalSideLength(n, height, width);
    int localN = n;
    int rows = (height / squareSideLength).floor();
    int columns = (width / squareSideLength).floor();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(columns, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(rows, (index) {
            if (localN > 0) {
              localN--;
              return RotatingSquare(length: squareSideLength);
            } else {
              return Container();
            }
          }),
        );
      }),
    );
  }

  double getOptimalSideLength(int n, double width, double height) {
    double sizePerSquare = width * height / n;
    double squareSideLength = sqrt(sizePerSquare);
    double smallerSideLength = min(height, width);
    double biggerSideLength = max(height, width);
    if (squareSideLength <= smallerSideLength &&
        squareSideLength <= biggerSideLength / n) {
      return squareSideLength;
    }
    int rows = 1;
    double smallerSideCellLength = 0;
    double biggerSideCellLength = 0;
    double nextSmallerSideCellLength = 0;
    while (biggerSideCellLength <= nextSmallerSideCellLength) {
      smallerSideCellLength = smallerSideLength / rows;
      biggerSideCellLength = biggerSideLength / (n / rows).ceil();
      nextSmallerSideCellLength = smallerSideLength / (rows + 1);
      rows++;
    }
    return min(smallerSideCellLength, biggerSideCellLength);
  }

  Widget createColumnWithAnimatedSquares(int rowNumber, double length, int n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rowNumber, (index) {
        if (n > 0) {
          n--;
          return RotatingSquare(length: length);
        } else {
          return Container();
        }
      }),
    );
  }
}

class RotatingSquare extends StatefulWidget {
  const RotatingSquare({super.key, required this.length});

  final double length;

  @override
  State<RotatingSquare> createState() => _RotatingSquareState();
}

class _RotatingSquareState extends State<RotatingSquare>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
        height: widget.length,
        width: widget.length,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            color: Colors.blue),
      ),
    );
  }
}
