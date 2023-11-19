import 'package:flutter/material.dart';
import 'package:theree_in_one_complete_app/all_my_app/Quiz/screens/quiz_screen.dart';
import 'package:theree_in_one_complete_app/material/color.dart';

class QuizWelcome extends StatelessWidget {
  const QuizWelcome({Key? key}) : super(key: key);

  void startQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        backgroundColor: mainColor,
        elevation: 1,
        toolbarHeight: 50,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the welcome image from assets
            Image.asset(
              'assets/icons/quiz.jpg', // Replace with your image file path
              width: 200, // Set the width as per your requirement
              height: 200, // Set the height as per your requirement
            ),
            SizedBox(height: 20),
            // "Start" button
            ElevatedButton(
              onPressed: () {
                startQuiz(context);
              },
              child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}
