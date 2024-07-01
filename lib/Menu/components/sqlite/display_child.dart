// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:daycare_app/database/helper.dart';

class DisplayChildPage extends StatefulWidget {
  const DisplayChildPage({super.key});

  @override
  _DisplayChildPageState createState() => _DisplayChildPageState();
}

class _DisplayChildPageState extends State<DisplayChildPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _records = [];

  @override
  void initState() {
    super.initState();
    _loadChildData();
  }

  _loadChildData() async {
    try {
      final records = await _dbHelper.getRecords();
      setState(() {
        _records = records;
      });
    } catch (e) {
      debugPrint('Error loading child data: $e');
    }
  }

  _deleteChildData(int id) async {
    try {
      debugPrint('Deleting record with ID: $id');
      await _dbHelper.deleteRecord(id);
      _loadChildData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
    } catch (e) {
      debugPrint('Error deleting child data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Anak'),
      ),
      body: _records.isEmpty
          ? const Center(child: Text('Tidak ada data anak'))
          : ListView.builder(
              itemCount: _records.length,
              itemBuilder: (context, index) {
                final record = _records[index];
                final recordId = record['id'];
                debugPrint('Record ID: $recordId'); 
                return ListTile(
                  title: Text(record['name']),
                  subtitle: Text('Tanggal Kedatangan: ${record['date_arrival']}\nSuhu Tubuh: ${record['body_temperature']}\nKondisi: ${record['condition']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      if (recordId == null) {
                        debugPrint('Error: Record ID is null');
                        return;
                      }
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Tidak'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Ya'),
                              ),
                            ],
                          );
                        },
                      );
                      if (shouldDelete ?? false) {
                        _deleteChildData(recordId);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
