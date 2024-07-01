// ignore_for_file: library_private_types_in_public_api

import 'package:daycare_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:daycare_app/database/helper_activity.dart';

class DisplayActivity extends StatefulWidget {
  const DisplayActivity({super.key});

  @override
  _DisplayActivityState createState() => _DisplayActivityState();
}

class _DisplayActivityState extends State<DisplayActivity> {
  late Future<List<Map<String, dynamic>>> _activitiesFuture;

  @override
  void initState() {
    super.initState();
    _activitiesFuture = _fetchActivities();
  }

  Future<List<Map<String, dynamic>>> _fetchActivities() async {
    try {
      List<Map<String, dynamic>> activities = await ActivityDatabaseHelper.instance.getActivities();
      for (var activity in activities) {
        debugPrint('Activity from database: $activity');
      }
      return activities;
    } catch (e) {
      debugPrint('Error fetching activities: $e');
      return []; // Return an empty list on error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Activity'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _activitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No activities found.'));
          } else {
            List<Map<String, dynamic>> activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> activity = activities[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activity ${activity['id']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildStyledText('Meals', activity['meals']),
                        _buildStyledText('Toilets', activity['toilets']),
                        _buildStyledText('Rests', activity['rests']),
                        _buildStyledText('Bottles', activity['bottles']),
                        _buildStyledText('Shower', activity['shower']),
                        _buildStyledText('Vitamin', activity['vitamin']),
                        _buildStyledText('Notes for Parents', activity['notesForParents']),
                        _buildStyledText('Items Needed', activity['itemsNeeded']),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildStyledText(String title, dynamic value) {
    if (value == null || value.toString().isEmpty || value.toString() == '[]' || value.toString() == '{}') {
      return const SizedBox.shrink(); // Don't display anything if the value is null, empty, or empty list/map
    }

    String cleanValue = _cleanValue(value);

    if (cleanValue.isEmpty) {
      return const SizedBox.shrink(); // Don't display anything if cleaned value is empty
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: cleanValue,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _cleanValue(dynamic value) {
    if (value is List) {
      return value
          .where((v) => v.toString().isNotEmpty && v.toString() != '{}' && v.toString() != '[]')
          .map((v) => _cleanValue(v))
          .join(', ');
    } else if (value is Map) {
      return value.entries
          .where((entry) => entry.value.toString().isNotEmpty && entry.value.toString() != '{}' && entry.value.toString() != '[]')
          .map((entry) => '${entry.key}: ${_cleanValue(entry.value)}')
          .join(', ');
    }
    return value.toString().replaceAll(RegExp(r'[\[\]{}]'), '').trim();
  }
}
