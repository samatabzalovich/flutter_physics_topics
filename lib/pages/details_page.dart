import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/section_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SectionModel section =
        ModalRoute.of(context)!.settings.arguments as SectionModel;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(section.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: Hero(
                  tag: section.title,
                  child: Image.asset(section.imagePaths[0]),
                ),
              ),
              Text(
                section.descriptions[0],
                style: const TextStyle(
                    fontFamily: "Times New Roman", fontSize: 25),
              ),
              _buildBody(section),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(SectionModel section) {
    List<Widget> widgets = [];
    for (int i = 1; i < section.descriptions.length; i++) {
      widgets.add(Text(
        section.descriptions[i],
        textAlign: TextAlign.left,
        style: const TextStyle(fontFamily: "Times New Roman", fontSize: 25),
      ));
      widgets.add(Center(child: Image.asset(section.imagePaths[i])));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widgets,
      ],
    );
  }
}
