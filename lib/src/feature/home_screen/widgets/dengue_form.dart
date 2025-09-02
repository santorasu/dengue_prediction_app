import 'package:dengue_prediction_app/src/feature/home_screen/widgets/denue_text_field.dart';
import 'package:dengue_prediction_app/src/feature/home_screen/widgets/result_screen.dart';
import 'package:flutter/material.dart';

class DengueForm extends StatefulWidget {
  final void Function(String) onPredict;
  final VoidCallback onReset;
  final String? predictionResult;

  DengueForm({
    required this.onPredict,
    required this.onReset,
    this.predictionResult,
  });

  @override
  _DengueFormState createState() => _DengueFormState();
}

class _DengueFormState extends State<DengueForm> {
  final _formKey = GlobalKey<FormState>();
  String? _sex;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hbController = TextEditingController();
  final TextEditingController _wbcController = TextEditingController();
  final TextEditingController _plateletCountController = TextEditingController();
  final TextEditingController _pctController = TextEditingController();
  final TextEditingController _lymphocytesController = TextEditingController();
  final TextEditingController _monocytesController = TextEditingController();

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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      double plateletCount = double.parse(_plateletCountController.text);
      String result =
      plateletCount < 150000 ? "Positive for Dengue Fever" : "Negative for Dengue Fever";
      widget.onPredict(result);
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
    _ageController.clear();
    _hbController.clear();
    _wbcController.clear();
    _plateletCountController.clear();
    _pctController.clear();
    _lymphocytesController.clear();
    _monocytesController.clear();
    setState(() {
      _sex = null;
    });
    widget.onReset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Sex', border: OutlineInputBorder()),
            value: _sex,
            items: ['Male', 'Female', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => setState(() => _sex = val),
            validator: (val) => val == null ? 'Please select your sex' : null,
          ),
          SizedBox(height: 16),
          DengueTextField(label: "Age", hint: "Enter age in years", controller: _ageController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter age';
            int? age = int.tryParse(val);
            if (age == null || age <= 0) return 'Please enter a positive integer';
            return null;
          }, keyboardType: TextInputType.number),
          SizedBox(height: 16),
          DengueTextField(label: "Hemoglobin (Hb%)", hint: "e.g., 14.5", controller: _hbController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter hemoglobin level';
            if (double.tryParse(val) == null) return 'Please enter a valid number';
            return null;
          }),
          SizedBox(height: 16),
          DengueTextField(label: "Total WBC Count (/cumm)", hint: "e.g., 4500", controller: _wbcController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter WBC count';
            if (int.tryParse(val) == null) return 'Please enter a valid integer';
            return null;
          }),
          SizedBox(height: 16),
          DengueTextField(label: "Platelet Count", hint: "e.g., 150000", controller: _plateletCountController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter platelet count';
            if (int.tryParse(val) == null) return 'Please enter a valid integer';
            return null;
          }),
          SizedBox(height: 16),
          DengueTextField(label: "PCT (%)", hint: "e.g., 0.1", controller: _pctController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter PCT percentage';
            if (double.tryParse(val) == null) return 'Please enter a valid number';
            return null;
          }),
          SizedBox(height: 16),
          DengueTextField(label: "Lymphocytes", hint: "e.g., 40", controller: _lymphocytesController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter lymphocytes count';
            if (int.tryParse(val) == null) return 'Please enter a valid integer';
            return null;
          }),
          SizedBox(height: 16),
          DengueTextField(label: "Monocytes", hint: "e.g., 10", controller: _monocytesController, validator: (val) {
            if (val == null || val.isEmpty) return 'Please enter monocytes count';
            if (int.tryParse(val) == null) return 'Please enter a valid integer';
            return null;
          }),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text('Predict Dengue Fever', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _reset,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: Text('Reset'),
                ),
                style: ElevatedButton.styleFrom(
                 // primary: Colors.grey,

                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 18),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  side: BorderSide(color: Colors.grey),
                 // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
          if (widget.predictionResult != null) ...[
            SizedBox(height: 20),
            ResultSection(result: widget.predictionResult!),
          ],
        ],
      ),
    );
  }
}
