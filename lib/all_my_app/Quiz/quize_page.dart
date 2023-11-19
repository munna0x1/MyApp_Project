import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theree_in_one_complete_app/all_my_app/Quiz/quiz_welcome_page.dart';
import 'package:theree_in_one_complete_app/all_my_app/Quiz/screens/quiz_screen.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizWelcome(),
    );
  }
}
