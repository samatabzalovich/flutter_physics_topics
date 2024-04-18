import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/details_page.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/practice_page.dart';
import 'package:flutter_application_1/pages/video_page.dart';
import 'package:flutter_application_1/pages/quiz.dart';
import 'package:flutter_application_1/pages/quiz_result.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async {
  await Hive.initFlutter();
  var box = await Hive.openBox('appBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(),
        '/quiz': (context) => const QuizPage(),
        '/result': (context) => const ResultPage(),
        '/video': (context) => const VideoPage(),
        '/practice': (context) => const PracticePage(),
      },
    );
  }
}
