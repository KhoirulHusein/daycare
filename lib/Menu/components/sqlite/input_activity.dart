// ignore_for_file: unnecessary_to_list_in_spreads, use_build_context_synchronously, library_private_types_in_public_api

import 'package:daycare_app/models/form_data.dart';
import 'package:flutter/material.dart';
import 'package:daycare_app/database/helper_activity.dart';
import 'package:daycare_app/database/helper.dart';

class InputActivity extends StatefulWidget {
  const InputActivity({super.key});

  @override
  _InputActivityState createState() => _InputActivityState();
}

class _InputActivityState extends State<InputActivity> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedName;
  final Map<String, dynamic> _activity = {
    'meals': [],
    'toilets': [],
    'rests': [],
    'bottles': [],
    'shower': '',
    'vitamin': '',
    'notesForParents': '',
    'itemsNeeded': [],
  };

  final List<Map<String, dynamic>> _meals = [];
  final List<Map<String, dynamic>> _toilets = [];
  final List<Map<String, dynamic>> _rests = [];
  final List<Map<String, dynamic>> _bottles = [];
  final List<String> _itemsNeeded = [];

  void _addMeal() {
    setState(() {
      _meals.add({
        'type': 'breakfast',
        'food': '',
        'quantity': 'none',
        'comments': ''
      });
      debugPrint('Meal added: ${_meals.last}');
    });
  }

  void _addToilet() {
    setState(() {
      _toilets.add({
        'time': '',
        'type': 'diaper',
        'condition': 'wet',
        'notes': ''
      });
      debugPrint('Toilet added: ${_toilets.last}');
    });
  }

  void _addRest() {
    setState(() {
      _rests.add({
        'start': '',
        'end': '',
        'notes': ''
      });
      debugPrint('Rest added: ${_rests.last}');
    });
  }

  void _addBottle() {
    setState(() {
      _bottles.add({
        'time': '',
        'amount': '',
        'notes': ''
      });
      debugPrint('Bottle added: ${_bottles.last}');
    });
  }

  void _addItemNeeded() {
    setState(() {
      _itemsNeeded.add('');
      debugPrint('Item needed added: ${_itemsNeeded.last}');
    });
  }

  Widget _buildMealForm(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Food'),
          onSaved: (value) {
            _meals[index]['food'] = value ?? '';
            debugPrint('Meal updated: ${_meals[index]}');
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _meals[index]['type'],
          decoration: const InputDecoration(labelText: 'Type'),
          items: MealType.values.map((type) {
            return DropdownMenuItem<String>(
              value: type.toString().split('.').last,
              child: Text(type.toString().split('.').last),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _meals[index]['type'] = newValue ?? 'breakfast';
              debugPrint('Meal type updated: ${_meals[index]}');
            });
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _meals[index]['quantity'],
          decoration: const InputDecoration(labelText: 'Quantity'),
          items: MealQuantity.values.map((quantity) {
            return DropdownMenuItem<String>(
              value: quantity.toString().split('.').last,
              child: Text(quantity.toString().split('.').last),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _meals[index]['quantity'] = newValue ?? 'none';
              debugPrint('Meal quantity updated: ${_meals[index]}');
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Comments'),
          onSaved: (value) {
            _meals[index]['comments'] = value ?? '';
            debugPrint('Meal comments updated: ${_meals[index]}');
          },
        ),
      ],
    );
  }

  Widget _buildToiletForm(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Time'),
          onSaved: (value) {
            _toilets[index]['time'] = value ?? '';
            debugPrint('Toilet updated: ${_toilets[index]}');
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _toilets[index]['type'],
          decoration: const InputDecoration(labelText: 'Type'),
          items: ToiletType.values.map((type) {
            return DropdownMenuItem<String>(
              value: type.toString().split('.').last,
              child: Text(type.toString().split('.').last),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _toilets[index]['type'] = newValue ?? 'diaper';
              debugPrint('Toilet type updated: ${_toilets[index]}');
            });
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _toilets[index]['condition'],
          decoration: const InputDecoration(labelText: 'Condition'),
          items: ToiletCondition.values.map((condition) {
            return DropdownMenuItem<String>(
              value: condition.toString().split('.').last,
              child: Text(condition.toString().split('.').last),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _toilets[index]['condition'] = newValue ?? 'wet';
              debugPrint('Toilet condition updated: ${_toilets[index]}');
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Notes'),
          onSaved: (value) {
            _toilets[index]['notes'] = value ?? '';
            debugPrint('Toilet notes updated: ${_toilets[index]}');
          },
        ),
      ],
    );
  }

  Widget _buildRestForm(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Start Time'),
          onSaved: (value) {
            _rests[index]['start'] = value ?? '';
            debugPrint('Rest updated: ${_rests[index]}');
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'End Time'),
          onSaved: (value) {
            _rests[index]['end'] = value ?? '';
            debugPrint('Rest end time updated: ${_rests[index]}');
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Notes'),
          onSaved: (value) {
            _rests[index]['notes'] = value ?? '';
            debugPrint('Rest notes updated: ${_rests[index]}');
          },
        ),
      ],
    );
  }

  Widget _buildBottleForm(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Time'),
          onSaved: (value) {
            _bottles[index]['time'] = value ?? '';
            debugPrint('Bottle time updated: ${_bottles[index]}');
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Amount'),
          onSaved: (value) {
            _bottles[index]['amount'] = value ?? '';
            debugPrint('Bottle amount updated: ${_bottles[index]}');
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Notes'),
          onSaved: (value) {
            _bottles[index]['notes'] = value ?? '';
            debugPrint('Bottle notes updated: ${_bottles[index]}');
          },
        ),
      ],
    );
  }

  Widget _buildItemNeededForm(int index) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Item ${index + 1}'),
      onSaved: (value) {
        _itemsNeeded[index] = value ?? '';
        debugPrint('Item needed updated: ${_itemsNeeded[index]}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Activity'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.getRecords(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Map<String, dynamic>> records = snapshot.data!;
          debugPrint('Records fetched: $records');
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedName,
                  hint: const Text('Select Name'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedName = newValue;
                      debugPrint('Selected name: $_selectedName');
                    });
                  },
                  items: records.map((record) {
                    return DropdownMenuItem<String>(
                      value: record['name'],
                      child: Text(record['name']),
                    );
                  }).toList(),
                ),
                // Meals Section
                const SizedBox(height: 20),
                const Text('Meals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._meals.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildMealForm(index);
                }).toList(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addMeal,
                  child: const Text('Add Meal'),
                ),
                // Toilets Section
                const SizedBox(height: 20),
                const Text('Toilets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._toilets.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildToiletForm(index);
                }).toList(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addToilet,
                  child: const Text('Add Toilet'),
                ),
                // Rests Section
                const SizedBox(height: 20),
                const Text('Rests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._rests.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildRestForm(index);
                }).toList(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addRest,
                  child: const Text('Add Rest'),
                ),
                // Bottles Section
                const SizedBox(height: 20),
                const Text('Bottles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._bottles.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildBottleForm(index);
                }).toList(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addBottle,
                  child: const Text('Add Bottle'),
                ),
                // Shower Section
                const SizedBox(height: 20),
                const Text('Shower', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Shower'),
                  onSaved: (value) {
                    _activity['shower'] = value ?? '';
                    debugPrint('Shower updated: ${_activity['shower']}');
                  },
                ),
                // Vitamin Section
                const SizedBox(height: 20),
                const Text('Vitamin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Vitamin'),
                  onSaved: (value) {
                    _activity['vitamin'] = value ?? '';
                    debugPrint('Vitamin updated: ${_activity['vitamin']}');
                  },
                ),
                // Notes for Parents Section
                const SizedBox(height: 20),
                const Text('Notes for Parents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Notes for Parents'),
                  onSaved: (value) {
                    _activity['notesForParents'] = value ?? '';
                    debugPrint('Notes for Parents updated: ${_activity['notesForParents']}');
                  },
                ),
                // Items Needed Section
                const SizedBox(height: 20),
                const Text('Items Needed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ..._itemsNeeded.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildItemNeededForm(index);
                }).toList(),
                ElevatedButton(
                  onPressed: _addItemNeeded,
                  child: const Text('Add Item Needed'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _activity['meals'] = _meals;
                      _activity['toilets'] = _toilets;
                      _activity['rests'] = _rests;
                      _activity['bottles'] = _bottles;
                      _activity['itemsNeeded'] = _itemsNeeded;
                      debugPrint('Submitting activity: $_activity');
                      await ActivityDatabaseHelper.instance.insertActivity(_activity);
                      debugPrint('Activity submitted: $_activity');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Activity Added')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
