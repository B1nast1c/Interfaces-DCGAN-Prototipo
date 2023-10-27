import 'package:flutter/material.dart';
import 'package:interfaces/common/colors.dart';
import 'package:interfaces/views/main/left_view.dart';
import 'package:interfaces/widgets/bar/navigation/navigation_bar.dart';
import 'package:interfaces/widgets/information/results_prompt.dart';
import 'package:interfaces/widgets/results/generator_results.dart';

class ResultsView extends StatelessWidget {
  final String viewTitle;
  const ResultsView({Key? key, required this.viewTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.normalWhite,
        body: LeftView(
          child: Column(
            children: <Widget>[
              const CustomNavigationBar(active: 2),
              const Divider(
                color: AppColors.lightPink,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    children: <Widget>[
                      ResultsPrompt(inputText: viewTitle),
                      const SizedBox(width: 100),
                      const GeneratorResults()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      // Manejo de excepciones: muestra un mensaje de error en caso de problemas
      return Scaffold(
        body: Center(
          child: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }
}
