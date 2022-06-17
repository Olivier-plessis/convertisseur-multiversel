import 'package:flutter/material.dart';
import 'package:itiwittiwtt_quiz_app/common/theme_helper.dart';
import 'package:itiwittiwtt_quiz_app/stores/quiz_store.dart';
import 'package:itiwittiwtt_quiz_app/widgets/disco_button.dart';

import 'quiz_category.dart';
import 'quiz_history_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final QuizStore _quizStore = QuizStore();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage("assets/images/welsh_small.png"),
                width: 225,
              ),
              Column(
                children: [
                  SizedBox(height: 30),
                  ...homeScreenButtons(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 56,
          color: ThemeHelper.accentColor,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: ThemeHelper.shadowColor,
                offset: Offset(-5, 5),
                blurRadius: 30)
          ]),
    );
  }

  List<Widget> homeScreenButtons(BuildContext context) {
    return [
      DiscoButton(
        onPressed: () async {
          var quiz = await _quizStore.getRandomQuizAsync();
          Navigator.pushNamed(context, QuizScreen.routeName, arguments: quiz);
        },
        child: Text(
          "Start Quiz",
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
        isActive: true,
      ),
      DiscoButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizCategoryScreen.routeName);
        },
        child: Text(
          "Quiz Category",
          style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
        ),
      ),
      DiscoButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizHistoryScreen.routeName);
        },
        child: Text(
          "Quiz History",
          style: TextStyle(fontSize: 30, color: ThemeHelper.primaryColor),
        ),
      ),
    ];
  }
}
