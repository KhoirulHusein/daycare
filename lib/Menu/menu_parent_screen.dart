import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_activity_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_data_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daycare App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParentScreen(),
    );
  }
}

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  FormData? _childData;
  FormData? _activityData;

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
    });
  }

  _loadActivityData() async {
    // Implementasikan logika untuk memuat data aktivitas jika diperlukan
  }

  @override
  void initState() {
    super.initState();
    _loadChildData();
    _loadActivityData();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCard(
                    title: 'Lihat Data Anak',
                    icon: Icons.person_add,
                    color: const Color.fromARGB(255, 179, 106, 192),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayChildDataScreen(
                            childName: _childData?.name ?? '',
                            childDate: _childData?.date ?? DateTime.now(),
                            childArrival: _childData?.arrival ?? '',
                            childBodyTemperature: _childData?.bodyTemperature ?? 0.0,
                            childConditions: _childData?.conditions ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  _buildCard(
                    title: 'Kegiatan Anak (Ortu)',
                    icon: Icons.event,
                    color: const Color.fromARGB(255, 222, 141, 236),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChildActivityScreen(
                            childData: null,
                            activityData: null,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildButton(
                title: 'Location',
                icon: Icons.location_on,
                onPressed: () {
                  // Implementasi aksi ketika tombol Location ditekan
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                title: 'Support',
                icon: Icons.headset_mic,
                onPressed: () {
                  // Implementasi aksi ketika tombol Support ditekan
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                title: 'Share',
                icon: Icons.share,
                onPressed: () {
                  // Implementasi aksi ketika tombol Share ditekan
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                title: 'Help',
                icon: Icons.help,
                onPressed: () {
                  // Implementasi aksi ketika tombol Help ditekan
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
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
          width: 200.0, // Lebar card
          height: 200.0, // Tinggi card
          padding: const EdgeInsets.all(16.0), // Tambahkan padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0, color: Colors.white), // Warna teks putih
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity, // Lebar button mengisi penuh
          height: 50.0, // Tinggi button
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
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Page'),
      ),
      body: Center(
        child: Text('This is the help page.'),
      ),
    );
  }
}