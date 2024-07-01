// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:daycare_app/models/form_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:daycare_app/database/helper.dart';

class RecordFormPage extends StatefulWidget {
  final Map<String, dynamic>? record;

  const RecordFormPage({super.key, this.record});

  @override
  _RecordFormPageState createState() => _RecordFormPageState();
}

class _RecordFormPageState extends State<RecordFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateArrivalController = TextEditingController();
  final TextEditingController _bodyTemperatureController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    if (widget.record != null) {
      _nameController.text = widget.record!['name'];
      _dateArrivalController.text = widget.record!['date_arrival'];
      _bodyTemperatureController.text = widget.record!['body_temperature'].toString();
      _conditionController.text = widget.record!['condition'];
    }
  }

  void _saveRecord() async {
    try {
      final record = {
        'name': _nameController.text,
        'date_arrival': _dateArrivalController.text,
        'body_temperature': double.parse(_bodyTemperatureController.text),
        'condition': _conditionController.text,
      };

      if (widget.record == null) {
        final id = await _dbHelper.insertRecord(record);
        debugPrint('Berhasil menambahkan record dengan ID $id: $record');
      } else {
        record['id'] = widget.record!['id'];
        await _dbHelper.updateRecord(record);
        debugPrint('Berhasil mengupdate record: $record');
      }

      final formData = FormData(
        name: _nameController.text,
        date: DateTime.parse(_dateArrivalController.text),
        arrival: _dateArrivalController.text,
        bodyTemperature: double.parse(_bodyTemperatureController.text),
        conditions: _conditionController.text,
        meals: [],
        toilets: [],
        rests: [],
        bottles: [],
        shower: '',
        vitamin: '',
        notesForParents: '',
        itemsNeeded: [],
      );

      Navigator.pop(context, formData);
    } catch (e) {
      debugPrint('Error saving record: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record == null ? 'Tambah Data Anak' : 'Edit Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dateArrivalController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Kedatangan',
                hintText: 'Pilih tanggal',
              ),
              keyboardType: TextInputType.datetime,
              readOnly: true, // Membuat field hanya bisa dibaca
              onTap: () async {
                // Memunculkan date picker ketika field diklik
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    // Memformat tanggal yang dipilih ke dalam format yang diinginkan
                    _dateArrivalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _bodyTemperatureController,
              decoration: const InputDecoration(labelText: 'Suhu Tubuh'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _conditionController,
              decoration: const InputDecoration(labelText: 'Kondisi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveRecord,
              child: Text(widget.record == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
