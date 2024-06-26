// ignore_for_file: library_private_types_in_public_api

import 'package:daycare_app/Menu/components/InputData/input_activity_screen.dart';
import 'package:daycare_app/Menu/components/InputData/input_child_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_activity_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';

class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({super.key});

  @override
  _CaregiverScreenState createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  bool _isChildDataSubmitted = false;
  FormData? _childData;
  FormData? _activityData;

  _saveChildDataLocally(FormData childData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('childName', childData.name);
    await prefs.setString('childDate', childData.date.toString());
    await prefs.setString('childArrival', childData.arrival);
    await prefs.setDouble('childBodyTemperature', childData.bodyTemperature);
    await prefs.setString('childConditions', childData.conditions);
  }

  _loadChildData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _childData = FormData(
        name: prefs.getString('childName') ?? '',
        date: DateTime.tryParse(prefs.getString('childDate') ?? '') ?? DateTime.now(),
        arrival: prefs.getString('childArrival') ?? '',
        bodyTemperature: prefs.getDouble('childBodyTemperature') ?? 0.0,
        conditions: prefs.getString('childConditions') ?? '',
        meals: [],
        toilets: [],
        rests: [],
        bottles: [],
        shower: '',
        vitamin: '',
        notesForParents: '',
        itemsNeeded: [],
      );
      _isChildDataSubmitted = _childData!.name.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadChildData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final formData = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputChildDataScreen()),
                );
                if (formData != null) {
                  setState(() {
                    _isChildDataSubmitted = true;
                    _childData = formData;
                  });
                  await _saveChildDataLocally(formData);
                }
              },
              child: const Text('Input Data (Anak)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputActivityScreen()),
                );
                if (result != null && result is FormData) {
                  setState(() {
                    _activityData = result;
                  });
                }
              },
              child: const Text('Input Kegiatan (Pengasuh)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChildActivityScreen(
                      childData: _childData,
                      activityData: _activityData,
                    ),
                  ),
                );
              },
              child: const Text('Kegiatan Anak (Ortu)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isChildDataSubmitted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayChildDataScreen(
                        childName: _childData!.name,
                        childDate: _childData!.date,
                        childArrival: _childData!.arrival,
                        childBodyTemperature: _childData!.bodyTemperature,
                        childConditions: _childData!.conditions,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan input data anak terlebih dahulu'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Lihat Data Anak'),
            ),
          ],
        ),
      ),
    );
  }
}
