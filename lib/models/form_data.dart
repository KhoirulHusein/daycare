class FormData {
  String name;
  DateTime date;
  String arrival;
  double bodyTemperature;
  String conditions;
  List<Meal> meals;
  List<Toilet> toilets;
  List<Rest> rests;
  List<Bottle> bottles;
  String shower;
  String vitamin;
  String notesForParents;
  List<String> itemsNeeded;

  FormData({
    required this.name,
    required this.date,
    required this.arrival,
    required this.bodyTemperature,
    required this.conditions,
    required this.meals,
    required this.toilets,
    required this.rests,
    required this.bottles,
    required this.shower,
    required this.vitamin,
    required this.notesForParents,
    required this.itemsNeeded,
  });
}

enum MealType { breakfast, snack, lunch, dinner, fluids, other }
enum MealQuantity { none, some, lots }

class Meal {
  MealType type;
  String food;
  MealQuantity quantity;
  String comments;

  Meal({
    required this.type,
    required this.food,
    required this.quantity,
    required this.comments,
  });

  static fromJson(Map<String, dynamic> map) {}

  toJson() {}
}

enum ToiletType { diaper, potty }
enum ToiletCondition { wet, dry, bm }

class Toilet {
  String time;
  ToiletType type;
  ToiletCondition condition;
  String notes;

  var comments;

  Toilet({
    required this.time,
    required this.type,
    required this.condition,
    required this.notes,
  });
}

// class Toilet {
//   String time;
//   ToiletType type;
//   ToiletCondition condition;
//   String notes;

//   Toilet({
//     required this.time,
//     required this.type,
//     required this.condition,
//     required this.notes,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'time': time,
//       'type': type.toString().split('.').last,
//       'condition': condition.toString().split('.').last,
//       'notes': notes,
//     };
//   }
// }

class Rest {
  String start;
  String end;

  Rest({
    required this.start,
    required this.end,
  });
}

enum BottleType { breast, formula, milk }

class Bottle {
  String time;
  String ml;
  BottleType type;

  Bottle({
    required this.time,
    required this.ml,
    required this.type, required String quantity,
  });

  set quantity(String quantity) {}
}

