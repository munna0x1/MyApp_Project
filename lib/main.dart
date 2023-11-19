import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theree_in_one_complete_app/all_my_app/calculator/calculator.dart';
import 'package:theree_in_one_complete_app/all_my_app/profile/profile_page.dart';
import 'package:theree_in_one_complete_app/material/color.dart';
import 'package:theree_in_one_complete_app/all_my_app/Quiz/quiz_page.dart';
import 'package:theree_in_one_complete_app/all_my_app/weather/page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: mainColor,
    ));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeActivity(),
    );
  }
}

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int selectedIndex = 0;
  String appBarTitle = "Quiz";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyForIndex(selectedIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: mainColor,
            unselectedItemColor: Colors.blue,
            selectedItemColor: secondColor,
            currentIndex: selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: "Calculator"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Quiz"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: "Weather"),
              
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getBodyForIndex(int index) {
    switch (index) {
      case 0:
        return ProfilePage();
      case 1:
        return CalculatorPage();
      case 2:
        return QuizPage ();
      case 3:
        return WeatherPage();
      default:
        return Center(child: Text("Page not found"));
    }
  }
}
