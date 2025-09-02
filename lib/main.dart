import 'package:dengue_prediction_app/src/feature/home_screen/presentation/home_screen.dart';
import 'package:dengue_prediction_app/src/feature/import_screen/presentation/import_screen.dart';
import 'package:dengue_prediction_app/src/feature/insights_screen/presentation/insights_screen.dart';
import 'package:dengue_prediction_app/src/feature/profie_screen/presentation/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DenguePredictorApp());
}

class DenguePredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dengue Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF2E9FE), // light purple background
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    ImportScreen(),
    InsightsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<String> _titles = <String>[
    'Home',
    'Import',
    'Insights',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_titles[_selectedIndex],style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Roboto',
          letterSpacing: 1.5,
        ),)),
        backgroundColor: Colors.deepPurple,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Import'),
          BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Insights'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
