import 'package:flutter/material.dart';
import 'package:itiwittiwtt_quiz_app/stores/quiz_store.dart';

class QuestionOption extends StatelessWidget {
  final bool isSelected;
  final String text;
  final String optionText;
  final int index;
  final bool isCorrect;

  const QuestionOption(this.index, this.optionText, this.text, this.isCorrect,
      {Key? key, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: QuizStore.getColor(isCorrect), width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    optionText,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
