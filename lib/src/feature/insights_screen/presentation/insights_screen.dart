import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _predictionHistory = [
    {'date': '2025-09-01', 'plateletCount': 140000, 'result': 'Positive'},
    {'date': '2025-09-02', 'plateletCount': 180000, 'result': 'Negative'},
    {'date': '2025-09-03', 'plateletCount': 130000, 'result': 'Positive'},
    {'date': '2025-09-04', 'plateletCount': 200000, 'result': 'Negative'},
  ];

  @override
  Widget build(BuildContext context) {
    int positiveCount = _predictionHistory.where((e) => e['result'] == 'Positive').length;
    int negativeCount = _predictionHistory.length - positiveCount;

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prediction Trends',),
            SizedBox(height: 8),
            Row(
              children: [
                _buildTrendCard('Positive Cases', positiveCount, Colors.redAccent),
                SizedBox(width: 16),
                _buildTrendCard('Negative Cases', negativeCount, Colors.green),
              ],
            ),
            SizedBox(height: 24),
            Text('Recent Predictions',),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                  itemCount: _predictionHistory.length,
                  itemBuilder: (context, index) {
                    final prediction = _predictionHistory[index];
                    final isPositive = prediction['result'] == 'Positive';
                    return Card(
                      color: isPositive ? Colors.red.shade50 : Colors.green.shade50,
                      child: ListTile(
                        leading: Icon(isPositive ? Icons.warning : Icons.check_circle,
                            color: isPositive ? Colors.red : Colors.green),
                        title: Text('${prediction['result']}'),
                        subtitle: Text('Platelet Count: ${prediction['plateletCount']}'),
                        trailing: Text(prediction['date']),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendCard(String title, int count, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(count.toString(), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 16, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
