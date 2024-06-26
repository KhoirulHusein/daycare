
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:daycare_app/models/form_data.dart';

class ChildActivityScreen extends StatelessWidget {
  final FormData? childData;
  final FormData? activityData;

  const ChildActivityScreen({Key? key, required this.childData, required this.activityData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kegiatan Anak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (activityData != null) ...[
              Text('Name: ${childData!.name}'),
              const SizedBox(height: 8.0),
              Text('Date: ${childData!.date}'),
              const SizedBox(height: 8.0),
              Text('Arrival: ${childData!.arrival}'),
              const SizedBox(height: 8.0),
              Text('Body Temperature: ${childData!.bodyTemperature}'),
              const SizedBox(height: 8.0),
              Text('Conditions: ${childData!.conditions}'),
              const SizedBox(height: 16.0),
              const Text('Meals:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...activityData!.meals.map((meal) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Food: ${meal.food}'),
                  Text('Quantity: ${meal.quantity.toString().split('.').last}'),
                  Text('Comments: ${meal.comments}'),
                  const SizedBox(height: 8.0),
                ],
              )),
              const SizedBox(height: 16.0),
              const Text('Toilets:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...activityData!.toilets.map((toilet) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time: ${toilet.time}'),
                  Text('Condition: ${toilet.condition.toString().split('.').last}'),
                  Text('Notes: ${toilet.notes}'),
                  const SizedBox(height: 8.0),
                ],
              )),
              const SizedBox(height: 16.0),
              const Text('Others', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Shower Time: ${activityData!.shower}'),
              Text('Vitamin: ${activityData!.vitamin}'),
              Text('Notes for Parents: ${activityData!.notesForParents}'),
              Text('Items Needed: ${activityData!.itemsNeeded}'),
              // Include other fields as necessary
            ] else
              const Text('No activity data available'),
          ],
        ),
      ),
    );
  }
}
