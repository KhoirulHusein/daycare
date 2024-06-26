// ignore_for_file: library_private_types_in_public_api

import 'package:daycare_app/Menu/components/ScreensData/display_child_activity_screen.dart';
import 'package:daycare_app/Menu/components/ScreensData/display_child_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daycare_app/models/form_data.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen({super.key});

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  FormData? _childData;
  FormData? _activityData;

  // _saveChildDataLocally(FormData childData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('childName', childData.name);
  //   await prefs.setString('childDate', childData.date.toString());
  //   await prefs.setString('childArrival', childData.arrival);
  //   await prefs.setDouble('childBodyTemperature', childData.bodyTemperature);
  //   await prefs.setString('childConditions', childData.conditions);
    
  //   List<String> mealsJson = childData.meals.map((meal) => meal.toJson().toString()).toList();
  //   await prefs.setStringList('activityMeals', mealsJson);
  //   List<String> toiletsJson = childData.toilets.map((toilet) => toilet.toJson().toString()).toList();
  //   await prefs.setStringList('activityToilets', toiletsJson);
  //   await prefs.setString('activityShower', childData.shower);
  //   await prefs.setString('activityVitamin', childData.vitamin);
  //   await prefs.setString('activityNotesForParents', childData.notesForParents);
  //   await prefs.setStringList('activityItemsNeeded', childData.itemsNeeded);
  // }

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

        // meals: [
        //   Meal(
        //       type: MealType.breakfast,
        //       food: '',
        //       quantity: MealQuantity.none,
        //       comments: ''),
        // ],
        // toilets: [
        //   Toilet(
        //       time: '',
        //       type: ToiletType.diaper,
        //       condition: ToiletCondition.wet,
        //       notes: ''),
        // ],
        // rests: [Rest(start: '', end: '')],
        // bottles: [
        //   Bottle(
        //       time: '',
        //       ml: '',
        //       type: BottleType.breast,
        //       quantity: ''),
        // ],
        // shower: '',
        // vitamin: '',
        // notesForParents: '',
        // itemsNeeded: [],
      );
    });
  }

  _loadActivityData() async {
    // bingung masukin apa
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
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
              },
              child: const Text('Lihat Data Anak'),
            ),
            const SizedBox(height: 20),
          //   ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => ChildActivityScreen(
          //             childData: _childData,
          //             activityData: _activityData,
          //           ),
          //         ),
          //       );
          //     },
          //     child: const Text('Kegiatan Anak (Ortu)'),
          //   ),
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
          ],
        ),
      ),
    );
  }
}
