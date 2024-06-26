// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';

class InputChildDataScreen extends StatefulWidget {
  const InputChildDataScreen({super.key});

  @override
  _InputChildDataScreenState createState() => _InputChildDataScreenState();
}

class _InputChildDataScreenState extends State<InputChildDataScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _childName;
  late DateTime _childDate = DateTime.now();
  late String _childArrival;
  late double _childBodyTemperature;
  late String _childConditions;

  _saveChildDataLocally(FormData childData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('childName', childData.name);
    await prefs.setString('childDate', childData.date.toString());
    await prefs.setString('childArrival', childData.arrival);
    await prefs.setDouble('childBodyTemperature', childData.bodyTemperature);
    await prefs.setString('childConditions', childData.conditions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Anak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => _childName = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: false,
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _childDate,
                    firstDate: DateTime(2010),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _childDate) {
                    setState(() {
                      _childDate = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_childDate)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Arrival'),
                onSaved: (value) => _childArrival = value!,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Body Temperature'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter body temperature';
                  }
                  return null;
                },
                onSaved: (value) => _childBodyTemperature = double.parse(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Conditions'),
                onSaved: (value) => _childConditions = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    FormData childData = FormData(
                      name: _childName,
                      date: _childDate,
                      arrival: _childArrival,
                      bodyTemperature: _childBodyTemperature,
                      conditions: _childConditions,
                      meals: [],
                      toilets: [],
                      rests: [],
                      bottles: [],
                      shower: '',
                      vitamin: '',
                      notesForParents: '',
                      itemsNeeded: [],
                    );
                    _saveChildDataLocally(childData);
                    Navigator.pop(context, childData);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
