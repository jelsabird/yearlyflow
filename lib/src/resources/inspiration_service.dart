import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';

abstract class IInspirationService {
  Future<void> initDatabase();

  Future<InspirationModel> get(String key);

  Future<List<InspirationModel>> getAll();

  add(InspirationModel inspiration);

  update(InspirationModel inspiration);

  delete(InspirationModel inspiration);
}

class InspirationService implements IInspirationService {
  static InspirationService instance = InspirationService();
  late Box<NoteModel> _noteBox;
  late Box<BulletListModel> _bulletListBox;
  late Box<RecipeModel> _recipeBox;
  late Box<BirthdayModel> _birthdayBox;
  late Uuid _uuid;
  bool _isInitiated = false;

  Future<void> initDatabase() async {
    if (_isInitiated) return Future.value();

    await Hive.initFlutter();

    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(BulletListModelAdapter());
    Hive.registerAdapter(RecipeModelAdapter());
    Hive.registerAdapter(BirthdayModelAdapter());
    Hive.registerAdapter(InspirationTypeAdapter());
    Hive.registerAdapter(MonthAdapter());
    Hive.registerAdapter(TimeOfMonthAdapter());

    await _openBoxes();

    _uuid = Uuid();
    _isInitiated = true;
    return Future.value();
  }

  Future<void> _openBoxes() async {
    _noteBox = await Hive.openBox<NoteModel>('1noteBox');
    _bulletListBox = await Hive.openBox<BulletListModel>('1bulletListBox');
    _recipeBox = await Hive.openBox<RecipeModel>('1recipeBox');
    _birthdayBox = await Hive.openBox<BirthdayModel>('1birthdayBox');

    return Future.value();
  }

  Future<InspirationModel> get(String key) async {
    await initDatabase();

    if (_noteBox.keys.contains(key)) return Future.value(_noteBox.get(key));
    if (_bulletListBox.keys.contains(key)) return Future.value(_bulletListBox.get(key));
    if (_recipeBox.keys.contains(key)) return Future.value(_recipeBox.get(key));
    if (_birthdayBox.keys.contains(key)) return Future.value(_birthdayBox.get(key));
    throw Exception("No element found with key $key");
  }

  Future<List<InspirationModel>> getAll() async {
    await initDatabase();

    var allInspirations = <InspirationModel>[];
    allInspirations.addAll(_noteBox.values);
    allInspirations.addAll(_bulletListBox.values);
    allInspirations.addAll(_recipeBox.values);
    allInspirations.addAll(_birthdayBox.values);

    return allInspirations;
  }

  void add(InspirationModel model) {
    model.key = _uuid.v4();

    switch (model.inspirationType) {
      case InspirationType.Note:
        _noteBox.put(_uuid.v4(), model as NoteModel);
        break;
      case InspirationType.BulletList:
        _bulletListBox.put(_uuid.v4(), model as BulletListModel);
        break;
      case InspirationType.Recipe:
        _recipeBox.put(_uuid.v4(), model as RecipeModel);
        break;
      case InspirationType.Birthday:
        _birthdayBox.put(_uuid.v4(), model as BirthdayModel);
        break;
    }
  }

  void update(InspirationModel model) {
    switch (model.inspirationType) {
      case InspirationType.Note:
        _noteBox.put(model.key, model as NoteModel);
        break;
      case InspirationType.BulletList:
        _bulletListBox.put(model.key, model as BulletListModel);
        break;
      case InspirationType.Recipe:
        _recipeBox.put(model.key, model as RecipeModel);
        break;
      case InspirationType.Birthday:
        _birthdayBox.put(model.key, model as BirthdayModel);
        break;
    }
  }

  void delete(InspirationModel model) {
    switch (model.inspirationType) {
      case InspirationType.Note:
        _noteBox.delete(model.key);
        break;
      case InspirationType.BulletList:
        _bulletListBox.delete(model.key);
        break;
      case InspirationType.Recipe:
        _recipeBox.delete(model.key);
        break;
      case InspirationType.Birthday:
        _birthdayBox.delete(model.key);
        break;
    }
  }
}
