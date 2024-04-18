import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/sections.dart';

import '../widgets/section_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final data = getSections();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ТЕРМОДИНАМИКАНЫҢ ЕКІНШІ БАСТАМАСЫ'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.center,
            children:
                data.map((section) => SectionCard(section: section)).toList(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.inversePrimary,
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
              ),
              child: Row(
                children: [
                const Icon(
                  Icons.menu_book_rounded,
                  size: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 10,), 
                const Text(
                  'Бөлімдер',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],),
            ),
            ListTile(
              title: const Text('Видео Сабақ'),
              onTap: () {
                Navigator.pushNamed(context, '/video');
              },
            ),
            ListTile(
              title: const Text('Зертханалық жұмыс'),
              onTap: () {
                Navigator.pushNamed(context, '/practice');
              },
            ),
            ListTile(
              title: const Text('Өз біліміңді тексер'),
              onTap: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
          ],
        ),
      ),
    );
  }
}
