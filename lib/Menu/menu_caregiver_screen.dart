// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';
import 'package:daycare_app/Menu/components/InputData/input_activity_screen.dart';
import 'package:daycare_app/Menu/components/InputData/input_child_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_activity_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_data_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caregiver App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CaregiverScreen(),
    );
  }
}

class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildCard(
                    title: 'Input Data (Anak)',
                    icon: Icons.person_add,
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
                  ),
                  _buildCard(
                    title: 'Input Kegiatan (Pengasuh)',
                    icon: Icons.event,
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
                  ),
                  _buildCard(
                    title: 'Kegiatan Anak (Ortu)',
                    icon: Icons.child_friendly,
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
                  ),
                  _buildCard(
                    title: 'Lihat Data Anak',
                    icon: Icons.visibility,
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
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildButton(
                title: 'Location',
                icon: Icons.location_on,
                onPressed: () {
                  // Implementasi aksi ketika tombol Location ditekan
                },
              ),
              SizedBox(height: 20),
              _buildButton(
                title: 'Support',
                icon: Icons.headset_mic,
                onPressed: () {
                  // Implementasi aksi ketika tombol Support ditekan
                },
              ),
              SizedBox(height: 20),
              _buildButton(
                title: 'Share',
                icon: Icons.share,
                onPressed: () {
                  // Implementasi aksi ketika tombol Share ditekan
                },
              ),
              SizedBox(height: 20),
              _buildButton(
                title: 'Help',
                icon: Icons.help,
                onPressed: () {
                  // Implementasi aksi ketika tombol Help ditekan
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required VoidCallback onPressed}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
