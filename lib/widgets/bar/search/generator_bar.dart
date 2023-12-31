import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interfaces/common/api_service.dart';
import 'package:interfaces/common/colors.dart';

class GeneratorBar extends StatefulWidget {
  final Function(String) callback;
  const GeneratorBar({super.key, required this.callback});

  @override
  State<GeneratorBar> createState() => GeneratorBarState();
}

class GeneratorBarState extends State<GeneratorBar> {
  Future<List<String>>? labelModel;
  late List<String> labelList;
  String item = "";

  int getLabels() {
    log(labelList.length as String);
    return labelList.length;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    labelModel = ApiService()
        .getLabels(); // No es necesario convertirlo a Future<List<String>>
    labelModel?.then((list) {
      if (list.isNotEmpty) {
        List<String> myList = list;
        if (mounted) {
          setState(() {
            labelList = myList;
          });
          setState(() {
            item =
                "${labelList.first[0].toUpperCase()}${labelList.first.substring(1).toLowerCase()}";
          });
          widget.callback(item);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: FutureBuilder<List<String>>(
        future: labelModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading data...");
          } else if (snapshot.hasError) {
            return const Text('An error has ocurred');
          } else {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  iconSize: 40,
                  iconEnabledColor: AppColors.normalSalmon,
                  isExpanded: true,
                  dropdownColor: AppColors.normalWhite,
                  value: item,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  items: labelList
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value:
                              "${e[0].toUpperCase()}${e.substring(1).toLowerCase()}",
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "${e[0].toUpperCase()}${e.substring(1).toLowerCase()}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.letterColor,
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  hint: const Text(
                    "Please choose a topic",
                    style: TextStyle(
                      color: AppColors.letterColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      item = value!;
                    });
                    widget.callback(item); //Actualiza el valor del item
                  },
                ));
          }
        },
      ),
    );
  }
}
