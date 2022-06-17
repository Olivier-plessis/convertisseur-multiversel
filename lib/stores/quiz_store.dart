import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itiwittiwtt_quiz_app/common/json_util.dart';
import 'package:itiwittiwtt_quiz_app/models/category.dart';
import 'package:itiwittiwtt_quiz_app/models/question.dart';
import 'package:itiwittiwtt_quiz_app/models/quiz.dart';
import 'package:itiwittiwtt_quiz_app/models/quiz_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizStore {
  static SharedPreferences? prefs;
  static const String quizHistoryListKey = "QuizHistoryListKey";
  static var cheat = true;
  final String categoryJsonFileName = "assets/data/category.json";
  final String quizJsonFileName = "assets/data/quiz.json";

  static bool getCheat() {
    return cheat;
  }

  static Color getColor(bool isCorrect) {
    return cheat ? isCorrect ? Color(0xfff28d09) : Colors.deepPurple : Colors.deepPurple;
  }

  static Future<void> toggleCheat() async {
     cheat = !cheat;
  }

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<List<Category>> loadCategoriesAsync() async {
    List<Category> categoryList = [];
    categoryList = await JsonUtil.loadFromJsonAsync<Category>(
        categoryJsonFileName, Category.jsonToObject);
    return categoryList;
  }

  Future<List<Quiz>> loadQuizListByCategoryAsync(int categoryId) async {
    List<Quiz> quizList = [];
    quizList = await JsonUtil.loadFromJsonAsync<Quiz>(
        quizJsonFileName, Quiz.jsonToObject);
    var categoryQuizList =
        quizList.where((element) => element.categoryId == categoryId).toList();
    return categoryQuizList;
  }

  Future<List<QuizHistory>> loadQuizHistoryAsync() async {
    List<QuizHistory> quizHistoryList = [];
    var ifExists = QuizStore.prefs!.containsKey(quizHistoryListKey);
    if (ifExists) {
      var quizHistoryJson = QuizStore.prefs!.getString(quizHistoryListKey);
      if (quizHistoryJson != null) {
        quizHistoryList = await JsonUtil.loadFromJsonStringAsync<QuizHistory>(
            quizHistoryJson, QuizHistory.jsonToObject);
        quizHistoryList = quizHistoryList.reversed.toList();
      }
    }
    return quizHistoryList;
  }

  Future<Category> getCategoryAsync(int categoryId) async {
    List<Category> categoryList = [];
    categoryList = await JsonUtil.loadFromJsonAsync<Category>(
        categoryJsonFileName, Category.jsonToObject);
    return categoryList.where((element) => element.id == categoryId).first;
  }

  Future<Quiz> getRandomQuizAsync() async {
    List<Quiz> quizList = [];
    List<Question> questionsList = [];
    quizList = await JsonUtil.loadFromJsonAsync<Quiz>(
        quizJsonFileName, Quiz.jsonToObject);
    for (var i = 0; i < 10; i++) {
      var index = Random().nextInt(quizList.length);
      var quizItem = quizList[index];
      var questions = quizItem.questions;
      var indexQ = Random().nextInt(questions.length);
      var q = questions[indexQ];
      questionsList = [...questionsList, q];
    }
    return Quiz(1, "Toutes categories", "Toutes categories", true, "", 1,
        questionsList);
  }

  Future<void> saveQuizHistory(QuizHistory history) async {
    var historyList = await loadQuizHistoryAsync();
    historyList.add(history);
    var historyJson = jsonEncode(historyList);
    prefs!.setString(quizHistoryListKey, historyJson);
  }

  Future<Quiz> getQuizByIdAsync(int quizId, int categoryId) async {
    var quizList = await loadQuizListByCategoryAsync(categoryId);
    var quiz = quizList.where((element) => element.id == quizId).first;
    return quiz;
  }
}
