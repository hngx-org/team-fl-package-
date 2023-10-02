import 'package:flutter/material.dart';

class RoundedBorderedBox extends StatelessWidget {
  final TextInputType? keyboardType;

  const RoundedBorderedBox({
    super.key,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        maxLength: 1,
        buildCounter: (BuildContext context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        onChanged: (value) {
          // Handle the text input here
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          // hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
