import 'package:flutter/material.dart';

import 'search_bar.dart';

class CreateSubtaskTile extends StatefulWidget {
  final Function(String) onCreate;

  const CreateSubtaskTile({super.key, required this.onCreate});

  @override
  State<CreateSubtaskTile> createState() => _CreateSubtaskTileState();
}

class _CreateSubtaskTileState extends State<CreateSubtaskTile> {
  final _textController = TextEditingController();
  String _text = "";

  _handleOnPressed() {
    widget.onCreate(_textController.text);
    setState(() {
      _textController.clear();
      _text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: _textController,
            hintText: "Add sub task...",
            onChanged: (text) {
              setState(() {
                _text = text;
              });
            },
            onSubmitted: _text.isNotEmpty ? (_) => _handleOnPressed() : null,
          ),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: _text.isNotEmpty ? _handleOnPressed : null,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              backgroundColor: const Color(0xFFC00014),
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              textStyle: const TextStyle(fontSize: 16.0)),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
