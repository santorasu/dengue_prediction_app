import 'package:flutter/material.dart';
import '../widgets/dengue_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? predictionResult;

  void _onPrediction(String result) {
    setState(() {
      predictionResult = result;
    });
  }

  void _onReset() {
    setState(() {
      predictionResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPositive = predictionResult?.toLowerCase().contains('positive') ?? false;
    final backgroundColor = isPositive ? Color(0xFFFFE7E7) : Color(0xFFF2E9FE);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DengueForm(
          onPredict: _onPrediction,
          onReset: _onReset,
          predictionResult: predictionResult,
        ),
      ),
    );
  }
}
