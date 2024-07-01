// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:daycare_app/Menu/components/sqlite/display_activity.dart';
import 'package:daycare_app/Menu/components/sqlite/input_child.dart';
import 'package:daycare_app/Screens/Login/login_screen.dart';
import 'package:daycare_app/constants.dart';
import 'package:daycare_app/database/helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';
import 'package:daycare_app/weather/weather_service.dart';
import 'package:weather/weather.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  bool _isChildDataSubmitted = false;
  FormData? _childData;
  FormData? _activityData;
  Weather? _currentWeather;

  final WeatherService _weatherService = WeatherService();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  
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

  _saveChildDataToDB(FormData childData) async {
    try {
      await _dbHelper.insertRecord({
        'name': childData.name,
        'date_arrival': childData.date.toString(),
        'arrival': childData.arrival,
        'body_temperature': childData.bodyTemperature,
        'condition': childData.conditions,
      });
      setState(() {
        _childData = childData;
        _isChildDataSubmitted = true;
      });
    } catch (e) {
      debugPrint('Error saving child data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan data anak')),
      );
    }
  }

  _loadWeatherData() async {
    Weather? weather = await _weatherService.getCurrentWeather("Jakarta");
    setState(() {
      _currentWeather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Menu'),
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
                  _buildCard(
                    title: 'Input Data Anak',
                    icon: Icons.person_add,
                    color: const Color.fromARGB(255, 222, 141, 236),
                    onPressed: () async {
                      final formData = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecordFormPage()),
                      );
                      if (formData != null && formData is FormData) {
                        await _saveChildDataToDB(formData);
                       ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data Berhasil Diinput')),
                      );
                      } else {
                        // Handle case where formData is null or not of type FormData
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data tidak valid')),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildCard(
                    title: 'Lihat Kegiatan Anak',
                    icon: Icons.event,
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
                  MaterialPageRoute(builder: (context) => const ParentScreen()),
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
          width: 165.0, // Hapus lebar tetap
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
        width: 425,
        height: 200, // Tinggi ditingkatkan menjadi 100.0
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 50, color: Colors.white),
            const SizedBox(height: 10), // Mengurangi jarak dari ikon ke teks
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
