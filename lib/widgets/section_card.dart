import 'package:flutter/material.dart';

import '../models/section_model.dart';

class SectionCard extends StatelessWidget {
  final SectionModel section;

  const SectionCard({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: section);
            },
            child: Column(
              children: [
                SizedBox(
                    width: 500, height: 200, child: Hero(tag: section.title,child: Image.asset(section.imagePaths[0], fit: BoxFit.fill,))),
                Text(section.title, textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.fade
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
