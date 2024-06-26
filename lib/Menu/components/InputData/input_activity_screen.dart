// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:daycare_app/models/form_data.dart';

class InputActivityScreen extends StatefulWidget {
  const InputActivityScreen({super.key});

  @override
  _InputActivityScreenState createState() => _InputActivityScreenState();
}

class _InputActivityScreenState extends State<InputActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final FormData _formData = FormData(
    name: '',
    date: DateTime.now(),
    arrival: '',
    bodyTemperature: 0.0,
    conditions: '',
    meals: [Meal(type: MealType.breakfast, food: '', quantity: MealQuantity.none, comments: '')],
    toilets: [Toilet(time: '', type: ToiletType.diaper, condition: ToiletCondition.wet, notes: '')],
    rests: [Rest(start: '', end: '')],
    bottles: [Bottle(time: '', ml: '', type: BottleType.breast, quantity: '')],
    shower: '',
    vitamin: '',
    notesForParents: '',
    itemsNeeded: [],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Kegiatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Meals section
              const Text('Meals', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              ..._formData.meals.map((meal) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Food'),
                      onSaved: (value) => meal.food = value!,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<MealType>(
                            value: meal.type,
                            decoration: const InputDecoration(labelText: 'Type'),
                            items: MealType.values.map((MealType type) {
                              return DropdownMenuItem<MealType>(
                                value: type,
                                child: Text(type.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (MealType? newValue) {
                              setState(() {
                                meal.type = newValue!;
                              });
                            },
                            onSaved: (value) => meal.type = value!,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<MealQuantity>(
                            value: meal.quantity,
                            decoration: const InputDecoration(labelText: 'Quantity'),
                            items: MealQuantity.values.map((MealQuantity quantity) {
                              return DropdownMenuItem<MealQuantity>(
                                value: quantity,
                                child: Text(quantity.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (MealQuantity? newValue) {
                              setState(() {
                                meal.quantity = newValue!;
                              });
                            },
                            onSaved: (value) => meal.quantity = value!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Comments'),
                      onSaved: (value) => meal.comments = value!,
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _formData.meals.add(Meal(type: MealType.breakfast, food: '', quantity: MealQuantity.none, comments: ''));
                  });
                },
                child: const Text('Add Meal'),
              ),
              const SizedBox(height: 16.0),
              // Toilets section
              const Text('Toilets', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              ..._formData.toilets.map((toilet) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Time'),
                      onSaved: (value) => toilet.time = value!,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<ToiletType>(
                            value: toilet.type,
                            decoration: const InputDecoration(labelText: 'Type'),
                            items: ToiletType.values.map((ToiletType type) {
                              return DropdownMenuItem<ToiletType>(
                                value: type,
                                child: Text(type.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (ToiletType? newValue) {
                              setState(() {
                                toilet.type = newValue!;
                              });
                            },
                            onSaved: (value) => toilet.type = value!,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<ToiletCondition>(
                            value: toilet.condition,
                            decoration: const InputDecoration(labelText: 'Condition'),
                            items: ToiletCondition.values.map((ToiletCondition condition) {
                              return DropdownMenuItem<ToiletCondition>(
                                value: condition,
                                child: Text(condition.toString().split('.').last),
                              );
                            }).toList(),
                            onChanged: (ToiletCondition? newValue) {
                              setState(() {
                                toilet.condition = newValue!;
                              });
                            },
                            onSaved: (value) => toilet.condition = value!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Notes'),
                      onSaved: (value) => toilet.notes = value!,
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _formData.toilets.add(Toilet(time: '', type: ToiletType.diaper, condition: ToiletCondition.wet, notes: ''));
                  });
                },
                child: const Text('Add Toilet'),
              ),
              const SizedBox(height: 16.0),
              const Text('Others', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Shower Time'),
                onSaved: (value) => _formData.shower = value!,
              ),
              const SizedBox(height: 8.0),
              // Vitamin
              TextFormField(
                decoration: const InputDecoration(labelText: 'Vitamin'),
                onSaved: (value) => _formData.vitamin = value!,
              ),
              const SizedBox(height: 8.0),
              // Notes for parents
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes for Parents'),
                onSaved: (value) => _formData.notesForParents = value!,
              ),
              const SizedBox(height: 8.0),
              // Items needed
              TextFormField(
                decoration: const InputDecoration(labelText: 'Items Needed'),
                onSaved: (value) => _formData.itemsNeeded = value!.split(',').map((item) => item.trim()).toList(),
              ),
              const SizedBox(height: 16.0),
              // Save button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, _formData);
                  }
                },
                child: const Text('Save Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
