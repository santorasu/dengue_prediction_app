import 'package:flutter/material.dart';

void main() {
  runApp(DenguePredictorApp());
}

class DenguePredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dengue Fever Predictor',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DengueFormPage(),
    );
  }
}

class DengueFormPage extends StatefulWidget {
  @override
  _DengueFormPageState createState() => _DengueFormPageState();
}

class _DengueFormPageState extends State<DengueFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  String? _sex;
  final _ageController = TextEditingController();
  final _hbController = TextEditingController();
  final _wbcController = TextEditingController();
  final _plateletCountController = TextEditingController();
  final _pctController = TextEditingController();
  final _lymphocytesController = TextEditingController();
  final _monocytesController = TextEditingController();

  String? _predictionResult;

  @override
  void dispose() {
    _ageController.dispose();
    _hbController.dispose();
    _wbcController.dispose();
    _plateletCountController.dispose();
    _pctController.dispose();
    _lymphocytesController.dispose();
    _monocytesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Normally here you would send data to backend and get prediction
      // For demonstration, we simulate a prediction randomly or fixed
      setState(() {
        // For example, just a dummy logic based on platelet count
        double plateletCount = double.parse(_plateletCountController.text);
        if (plateletCount < 150000) {
          _predictionResult = "Positive for Dengue Fever";
        } else {
          _predictionResult = "Negative for Dengue Fever";
        }
      });
    }
  }

  Widget _buildResultSection() {
    if (_predictionResult == null) {
      return SizedBox.shrink();
    }

    Color resultColor =
    _predictionResult!.toLowerCase().contains('positive') ? Colors.red : Colors.green;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.all(16.0),
      decoration:
      BoxDecoration(color: resultColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(
            _predictionResult!.toLowerCase().contains('positive') ? Icons.warning : Icons.check_circle,
            color: resultColor,
            size: 36,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              _predictionResult!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: resultColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, String? Function(String?) validator, {TextInputType keyboardType = TextInputType.number}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dengue Fever Predictor'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Sex",
                  border: OutlineInputBorder(),
                ),
                value: _sex,
                items: ['Male', 'Female']
                    .map((sex) => DropdownMenuItem(value: sex, child: Text(sex)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sex = value;
                  });
                },
                validator: (value) => value == null ? 'Please select your sex' : null,
              ),
              SizedBox(height: 16),
              _buildTextField("Age", "Enter age in years", _ageController, (value) {
                if (value == null || value.isEmpty) return 'Please enter age';
                if (int.tryParse(value) == null) return 'Please enter a valid integer';
                if (int.parse(value) <= 0) return 'Age must be positive';
                return null;
              }, keyboardType: TextInputType.number),
              SizedBox(height: 16),
              _buildTextField("Hemoglobin (Hb%)", "e.g., 14.5", _hbController, (value) {
                if (value == null || value.isEmpty) return 'Please enter hemoglobin level';
                if (double.tryParse(value) == null) return 'Please enter a valid number';
                return null;
              }),
              SizedBox(height: 16),
              _buildTextField("Total WBC count (/cumm)", "e.g., 4500", _wbcController, (value) {
                if (value == null || value.isEmpty) return 'Please enter WBC count';
                if (int.tryParse(value) == null) return 'Please enter a valid integer';
                return null;
              }),
              SizedBox(height: 16),
              _buildTextField("Platelet Count", "e.g., 150000", _plateletCountController, (value) {
                if (value == null || value.isEmpty) return 'Please enter platelet count';
                if (int.tryParse(value) == null) return 'Please enter a valid integer';
                return null;
              }),
              SizedBox(height: 16),
              _buildTextField("PCT (%)", "e.g., 0.1", _pctController, (value) {
                if (value == null || value.isEmpty) return 'Please enter PCT percentage';
                if (double.tryParse(value) == null) return 'Please enter a valid number';
                return null;
              }),
              SizedBox(height: 16),
              _buildTextField("Lymphocytes", "e.g., 40", _lymphocytesController, (value) {
                if (value == null || value.isEmpty) return 'Please enter lymphocytes count';
                if (int.tryParse(value) == null) return 'Please enter a valid integer';
                return null;
              }),
              SizedBox(height: 16),
              _buildTextField("Monocytes", "e.g., 10", _monocytesController, (value) {
                if (value == null || value.isEmpty) return 'Please enter monocytes count';
                if (int.tryParse(value) == null) return 'Please enter a valid integer';
                return null;
              }),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Predict Dengue Fever', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              _buildResultSection(),
            ],
          ),
        ),
      ),
    );
  }
}
