import 'package:flutter/material.dart';
import 'package:interfaces/common/colors.dart';

class ResultsPrompt extends StatelessWidget {
  final String inputText;
  const ResultsPrompt({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "These are the results for the following category: ",
              style: TextStyle(
                fontSize: 19,
                height: 1.5,
                color: AppColors.letterColor,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              inputText,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  height: 0.9,
                  fontSize: 90,
                  color: AppColors.letterColor),
            )
          ]),
    );
  }
}
