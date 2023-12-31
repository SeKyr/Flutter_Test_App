import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/n_input.dart';

class Node {
  int data;
  Node? left;
  Node? right;

  Node(this.data, {this.left, this.right});
}

class CalculationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalculationWidget(
              algorithmImplementation: fibonacciAlgorithm,
              algorithmName: 'Fib',
            ),
            CalculationWidget(
              algorithmImplementation: matrixMultiplicationAlgorithm,
              algorithmName: 'Matrix',
            ),
            CalculationWidget(
              algorithmImplementation: binarySearchTreeAlgorithm,
              algorithmName: 'Binary',
            ),
            CalculationWidget(
              algorithmImplementation: reverseArrayAlgorithm,
              algorithmName: 'Array',
            )
          ],
        ),
      )
    );
  }

  int fibonacciAlgorithm(int n) {
    var stopwatch = Stopwatch();
    stopwatch.start();
    fib(n);
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }

  int fib(int n) {
    if (n <= 2) {
      return 1;
    }
    return fib(n - 1) + fib( n - 2 ) ;
  }

  int matrixMultiplicationAlgorithm(int n) {
    List<List<int>> firstMatrix = List.generate(n, (row) => List.generate(n, (column) => (row + 1) * (column + 1)));
    List<List<int>> secondMatrix = List.generate(n, (row) => List.generate(n, (column) => (row + 1) + (column + 1)));
    List<List<int>> resultMatrix = List.generate(n, (_) => List.filled(n, 0));
    var stopwatch = Stopwatch();
    stopwatch.start();
    for (int row = 0; row < n; row++) {
      for (int col = 0; col < n; col++) {
        int cell = 0;
        for (int h = 0; h < n; h++) {
          cell += firstMatrix[row][h] * secondMatrix[h][col];
        }
        resultMatrix[row][col] = cell;
      }
    }
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }

  int binarySearchTreeAlgorithm(int n) {
    List<int> data = List.generate(n, (i) => ((sin(i)-sin(i+1)) * 1000).toInt());
    root = null;
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    for (var element in data) {
      insert(element);
    }
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }
  Node? root;

  void insert(int data) {
    Node newNode = Node(data);
    if(root == null) {
      root = newNode;
      return;
    } else {
      Node? current = root;

      while (current != null) {
        if(data < current.data) {
          if(current.left != null) {
            current = current.left;
          } else {
            current.left = newNode;
            return;
          }
        } else {
          if(current.right != null) {
            current = current.right;
          } else {
            current.right = newNode;
            return;
          }
        }
      }
      return;
    }
  }

  int reverseArrayAlgorithm(int n) {
    List<int> array = List.generate(n, (index) => index);
    var stopwatch = Stopwatch();
    stopwatch.start();
    reverse(array);
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }

  List<int> reverse(List<int> toReverse) {
    if(toReverse.isEmpty) {
      return [];
    }
    int first = toReverse.removeAt(0);
    List<int> reversed = reverse(toReverse);
    reversed.add(first);
    return reversed;
  }
}

class CalculationWidget extends StatefulWidget {
  const CalculationWidget(
      {super.key, required this.algorithmName, required this.algorithmImplementation});

  final String algorithmName;

  final int Function(int) algorithmImplementation;

  @override
  State<StatefulWidget> createState() => _CalculationWidgetState();

}
class _CalculationWidgetState extends State<CalculationWidget> {
  int? executionTime;
  int? n;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 50, child: Text('${widget.algorithmName}:  '),),
        NInput(onSubmit: onSubmit),
        Container(
          width: 100,
          child: executionTime != null
              ? Text('${executionTime}ms; n = $n') : null,
        ),
      ],
    );
  }

  void onSubmit(int n) {
    setState(() {
      this.n = n;
      executionTime = widget.algorithmImplementation(n);
    });
  }


}
