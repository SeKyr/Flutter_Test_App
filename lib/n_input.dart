import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NInput extends StatelessWidget {
  NInput({super.key, required this.onSubmit});

  final void Function(int) onSubmit;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width:50, child: TextField(
            decoration: const InputDecoration(labelText: 'n'),
            keyboardType: TextInputType.number,
            controller: textController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
          )
          ),
          ElevatedButton(
            onPressed: () {
              final int n = int.parse(textController.text);
              if(n > 0) {
                onSubmit(n);
              }
            },
            child: const Text(
              'Start'
            ),
          ),
        ],
      ),
    );
  }
}