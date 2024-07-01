import 'package:flutter/material.dart';
import 'package:daycare_app/database/helper_activity.dart';

class DeleteAllActivitiesPage extends StatelessWidget {
  final ActivityDatabaseHelper _dbHelper = ActivityDatabaseHelper.instance;

  DeleteAllActivitiesPage({super.key});

  Future<void> _deleteAllActivities(BuildContext context) async {
    try {
      await _dbHelper.deleteAllActivities();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data activity berhasil dihapus')),
      );
    } catch (e) {
      debugPrint('Error deleting all activities: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menghapus semua data activity')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hapus Semua Data Activity'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _deleteAllActivities(context),
          child: const Text('Hapus Semua Data Activity'),
        ),
      ),
    );
  }
}
