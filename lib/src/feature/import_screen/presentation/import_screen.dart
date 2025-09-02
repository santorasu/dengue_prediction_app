import 'package:flutter/material.dart';

class ImportScreen extends StatefulWidget {
  @override
  _ImportScreenState createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  // Simulated import state
  bool _hasImportedData = false;
  List<String> _columns = [];
  List<Map<String, String>> _previewData = [];

  void _simulateImport() {
    // Simulate picking a file and detecting columns
    setState(() {
      _hasImportedData = true;
      _columns = ['Sex', 'Age', 'Platelet Count', 'Hemoglobin'];
      _previewData = [
        {'Sex': 'Male', 'Age': '25', 'Platelet Count': '140000', 'Hemoglobin': '14.1'},
        {'Sex': 'Female', 'Age': '30', 'Platelet Count': '160000', 'Hemoglobin': '15.2'},
        {'Sex': 'Male', 'Age': '22', 'Platelet Count': '130000', 'Hemoglobin': '13.7'},
      ];
    });
  }

  void _saveImportedData() {
    // Implement saving logic or callback here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Imported data saved successfully!')),
    );
    // Clear after save
    setState(() {
      _hasImportedData = false;
      _columns = [];
      _previewData = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16),
        child: _hasImportedData ? _buildPreview() : _buildImportButton(),
      ),
    );
  }

  Widget _buildImportButton() {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.upload_file),
        label: Text('Import CSV/Excel File'),
        onPressed: _simulateImport,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Detected Columns:', style: TextStyle(fontWeight: FontWeight.bold),),
        Wrap(
          spacing: 8,
          children: _columns.map((col) => Chip(label: Text(col))).toList(),
        ),
        SizedBox(height: 16),
        Text('Data Preview:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: _previewData.length,
            itemBuilder: (context, index) {
              final row = _previewData[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: _columns.map((col) =>
                        Expanded(child: Text('${row[col]}', textAlign: TextAlign.center))
                    ).toList(),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          icon: Icon(Icons.save),
          label: Text('Save Imported Data'),
          onPressed: _saveImportedData,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _hasImportedData = false;
              _columns = [];
              _previewData = [];
            });
          },
          child: Text('Cancel Import'),
        ),
      ],
    );
  }
}
