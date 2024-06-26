import 'package:flutter/material.dart';

class DisplayChildDataScreen extends StatelessWidget {
  final String childName;
  final DateTime childDate;
  final String childArrival;
  final double childBodyTemperature;
  final String childConditions;

  const DisplayChildDataScreen({
    super.key,
    required this.childName,
    required this.childDate,
    required this.childArrival,
    required this.childBodyTemperature,
    required this.childConditions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Anak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $childName'),
            Text('Date: ${childDate.toLocal()}'.split(' ')[0]),
            Text('Arrival: $childArrival'),
            Text('Body Temperature: $childBodyTemperature'),
            Text('Conditions: $childConditions'),
          ],
        ),
      ),
    );
  }
}
