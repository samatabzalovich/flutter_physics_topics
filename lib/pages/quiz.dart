import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quickalert/quickalert.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var questions = [];
  late int index;
  int trying = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  final _quizBox = Hive.box('appBox');

  void fetchData() {
    questions = [
      {
        "question":
            "Жылу машинасы бір цикл ішінде қыздырғыштан 1 кДж алып, 400 Дж жұмыс атқарады. Жылу машинасы қанша жылу салқындатқышын шығарады?",
        "options": ["40 Дж", "30 Дж", "700 Дж", "600 Дж"],
        "answer": 3
      },
      {
        "question":
            "Қыздырғыштың температурасы 227ºС, суытқыштың температурасы 27ºС болатын жылу машинасының ПӘК-і:",
        "options": ["80%", "60%", "40%", "30%"],
        "answer": 2
      },
      {
        "question":
            "Егер идеал жылулық қозғалтқыш температурасы 127ºС қыздырғыштан 4 кДж жылу алып, 800 Дж жұмыс өндірсе, онда тоңазытқыштың температурасы қандай болады?",
        "options": ["25ºС", "38ºС", "47ºС", "62ºС"],
        "answer": 2
      },
      {
        "question":
            "Карно циклін орындайтын газ қыздырғыштан алған әрбір 2 кДж энергия есебінен 600 Дж жұмыс өндіреді. Қыздырғыштың абсолют температурасы тоңазытқыштың абсолют температурасынан қанша есе үлкен?",
        "options": ["1,3", "1,4", "1,5", "1,6"],
        "answer": 1
      },
      {
        "question":
            "Қыздырғыштан 727ºС және тоңазытқыштан 27ºС температураларынан пайда болатын ПӘК:",
        "options": ["70%", "100%", "43%", "30%"],
        "answer": 0
      },
      {
        "question":
            "Идеал жылу машинасының қыздырғышының температурасы 423 К, ал салқындатқыштың температурасы 293 К болса, қыздырғыштан 105 кДж жылу алған машинаның атқаратын жұмысы:",
        "options": ["20 МДж", "60 МДж", "40 МДж", "30 МДж"],
        "answer": 3
      },
      {
        "question":
            "Тоңазытқыштың температурасы 27ºС. ПӘК-і 80% идеал жылу машинасының қыздырғышының температурасы:",
        "options": ["500 К", "400 К", "1200 К", "1500 К"],
        "answer": 3
      },
      {
        "question":
            "Қыздырғыштың температурасы 500 К идеал двигатель қыздырғыштан алған әрбір килоджоуль энергияның есебінен 350 Дж жұмыс атқарады. Салқындатқыштың температурасын анықтаңыз:",
        "options": ["300 К", "315 К", "325 К", "330 К"],
        "answer": 1
      },
      {
        "question":
            "Қыздырғыштың температурасы 227ºС, ал тоңазытқыштың температурасы 7ºС. Машинасының ПӘК-і:",
        "options": ["0,6", "1", "0,74", "0,44"],
        "answer": 3
      },
      {
        "question":
            "Жылу машинасы 1 циклда қыздырғыштан 100 Дж жылу мөлшерін алып, тоңазытқышқа 75 Дж жылу береді. Машинаның ПӘК-і:",
        "options": ["75%", "25%", "33%", "15%"],
        "answer": 1
      }
    ];
  }

  @override
  void initState() {
    super.initState();
    _quizBox.put('chance', 3);
    fetchData();
    index = Random().nextInt(questions.length);
  }

  void validate(choice) {
    if (choice == questions[index]["answer"]) {
      setState(() {
        correctAnswers++;
        trying++;
      });
    } else {
      setState(() {
        incorrectAnswers++;
        trying++;
        _quizBox.put('chance', _quizBox.get('chance') - 1);
      });
    }

    if (trying == questions.length || _quizBox.get('chance') == 0) {
      Navigator.pushNamed(context, '/result', arguments: {
        "correctAnswers": correctAnswers,
        "incorrectAnswers": incorrectAnswers,
        "totalAnswers": questions.length
      });
    }
    index = Random().nextInt(questions.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Тест'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outlined, color: Colors.black),
            onPressed: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.info,
                text: '${questions.length} термодинамика сұрақтарына жауап бер',
                confirmBtnColor: Theme.of(context).colorScheme.inversePrimary,
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/quiz.jpg',
                    width: 300,
                    height: 300,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: Text(
                        questions[index]["question"],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    validate(0);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  child: Text(
                                    questions[index]["options"][0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      validate(1);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: Text(
                                      questions[index]["options"][1],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    validate(2);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  child: Text(
                                    questions[index]["options"][2],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: 130,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () {
                                      validate(3);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: Text(
                                      questions[index]["options"][3],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "${_quizBox.get("chance")} мүмкіндік қалды",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          )
        ],
      ),
      // }
      // else {
      //   return const Center(
      //     child: CircularProgressIndicator(),
    );
  }
}
