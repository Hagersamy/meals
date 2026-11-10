import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Meals extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 100)();

  TextColumn get imageUrl => text()();

  RealColumn get rate => real().withDefault(const Constant(0))();

  TextColumn get time => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Meals])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(driftDatabase(name: 'meals_db'));

  static final AppDatabase instance = AppDatabase._();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch(
        (b) => b.insertAll(meals, [
          MealsCompanion.insert(
            name: 'Vegetable Bowl',
            imageUrl: _seedImg,
            rate: const Value(4.8),
            time: '20 min',
          ),
          MealsCompanion.insert(
            name: 'Chicken Salad',
            imageUrl: _seedImg,
            rate: const Value(4.5),
            time: '15 min',
          ),
          MealsCompanion.insert(
            name: 'Pasta Primavera',
            imageUrl: _seedImg,
            rate: const Value(4.6),
            time: '30 min',
          ),
          MealsCompanion.insert(
            name: 'Grilled Salmon',
            imageUrl: _seedImg,
            rate: const Value(4.9),
            time: '25 min',
          ),
        ]),
      );
    },
  );

  static const _seedImg = 'lib/core/assets/images/home_item_img.png';

  Stream<List<Meal>> watchAllMeals() =>
      (select(meals)..orderBy([(m) => OrderingTerm.desc(m.createdAt)])).watch();

  Future<List<Meal>> getAllMeals() => select(meals).get();

  Future<Meal?> getMealById(int id) =>
      (select(meals)..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<int> insertMeal(MealsCompanion meal) => into(meals).insert(meal);

  Future<bool> updateMeal(Meal meal) => update(meals).replace(meal);

  Future<int> deleteMeal(int id) =>
      (delete(meals)..where((m) => m.id.equals(id))).go();
}
