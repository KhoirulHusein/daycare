// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, prefer_const_constructors

import 'package:daycare_app/Menu/components/sqlite/display_activity.dart';
import 'package:daycare_app/Menu/components/sqlite/input_activity.dart';
import 'package:daycare_app/Screens/Login/login_screen.dart';
import 'package:daycare_app/database/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';
import 'package:daycare_app/weather/weather_service.dart';
import 'package:daycare_app/constants.dart';
import 'package:weather/weather.dart';

class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({super.key});

  @override
  _CaregiverScreenState createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  bool _isChildDataSubmitted = false;
  FormData? _childData;
  FormData? _activityData;
  Weather? _currentWeather;

  final WeatherService _weatherService = WeatherService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  _loadChildData() async {
    try {
      final records = await _dbHelper.getRecords();
      if (records.isNotEmpty) {
        setState(() {
          _childData = FormData(
            name: records[0]['name'],
            date: DateTime.tryParse(records[0]['date_arrival']) ?? DateTime.now(),
            arrival: records[0]['date_arrival'],
            bodyTemperature: records[0]['body_temperature'],
            conditions: records[0]['condition'],
            meals: [],
            toilets: [],
            rests: [],
            bottles: [],
            shower: '',
            vitamin: '',
            notesForParents: '',
            itemsNeeded: [],
          );
          _isChildDataSubmitted = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading child data: $e');
    }
  }

  _loadWeatherData() async {
    Weather? weather = await _weatherService.getCurrentWeather("Jakarta");
    setState(() {
      _currentWeather = weather;
    });
  }

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _loadChildData();
    _loadWeatherData();
  }

  void _initDatabase() async {
    await _dbHelper.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver Menu'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _buildWeatherCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [    
                  Expanded(
                    child: _buildCard(
                      title: 'Input Kegiatan Anak',
                      icon: Icons.event,
                      color: const Color.fromARGB(255, 222, 141, 236),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const InputActivity()),
                        );
                        if (result != null && result is FormData) {
                          setState(() {
                            _activityData = result;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildCard(
                      title: 'Kegiatan Anak',
                      icon: Icons.child_friendly,
                      color: const Color.fromARGB(255, 222, 141, 236),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayActivity(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.headset_mic, color: Colors.white),
              onPressed: () {
                // Aksi ketika tombol Support ditekan
              },
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {
                // Aksi ketika tombol Share ditekan
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: _logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      color: color,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 200.0,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Card(
      color: const Color.fromARGB(255, 135, 206, 235),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              _currentWeather != null
                  ? "${_currentWeather!.areaName}, ${_currentWeather!.country}\n${_currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C\n${_currentWeather!.weatherDescription}, Wind ${_currentWeather!.windSpeed?.toString()} m/s"
                  : "Loading...",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
    await prefs.remove('userRole');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
