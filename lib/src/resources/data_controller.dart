import 'package:hive_flutter/hive_flutter.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';
import 'package:yearly_flow/src/models/item_model.dart';

abstract class IDataController {
  Future<void> initDatabase();

  Future<ItemModel> fetchAllInspirations();

  save(InspirationModel inspiration);

  delete(InspirationModel inspiration);
}

class DataController implements IDataController {
  static DataController instance = DataController();
  late Box<NoteModel> _noteBox;
  late Box<BulletListModel> _bulletListBox;
  late Box<RecipeModel> _recipeBox;
  late Box<BirthdayModel> _birthdayBox;
  bool _isInitiated = false;

  Future<void> initDatabase() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(BulletListModelAdapter());
    Hive.registerAdapter(RecipeModelAdapter());
    Hive.registerAdapter(BirthdayModelAdapter());
    Hive.registerAdapter(InspirationTypeAdapter());
    Hive.registerAdapter(MonthAdapter());
    Hive.registerAdapter(TimeOfMonthAdapter());

    await _openBoxes();

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

  Future<ItemModel> fetchAllInspirations() async {
    if (!_isInitiated) {
      await initDatabase();
    }
    var itemModel = ItemModel();
    itemModel.inspirations.addAll(_noteBox.values);
    itemModel.inspirations.addAll(_bulletListBox.values);
    itemModel.inspirations.addAll(_recipeBox.values);
    itemModel.inspirations.addAll(_birthdayBox.values);

    _sortInspirations(itemModel.inspirations);

    return itemModel;
  }

  void _sortInspirations(List<InspirationModel> monthInspirations) {
    monthInspirations.sort((InspirationModel a, InspirationModel b) =>
        a.timeOfMonth.index.compareTo(b.timeOfMonth.index));
  }

  void save(InspirationModel inspiration) {
    switch (inspiration.inspirationType) {
      case InspirationType.Note:
        _addNote(inspiration);
        break;
      case InspirationType.BulletList:
        _addBulletList(inspiration);
        break;
      case InspirationType.Recipe:
        _addRecipe(inspiration);
        break;
      case InspirationType.Birthday:
        _addBirthday(inspiration);
        break;
    }
  }

  void _addNote(InspirationModel note) {
    _noteBox.put(note.key, note as NoteModel);
  }

  void _addBulletList(InspirationModel bulletList) {
    _bulletListBox.put(bulletList.key, bulletList as BulletListModel);
  }

  void _addRecipe(InspirationModel recipe) {
    _recipeBox.put(recipe.key, recipe as RecipeModel);
  }

  void _addBirthday(InspirationModel birthday) {
    _birthdayBox.put(birthday.key, birthday as BirthdayModel);
  }

  void delete(InspirationModel inspiration) {
    switch (inspiration.inspirationType) {
      case InspirationType.Note:
        _noteBox.delete(inspiration.key);
        break;
      case InspirationType.BulletList:
        _bulletListBox.delete(inspiration.key);
        break;
      case InspirationType.Recipe:
        _recipeBox.delete(inspiration.key);
        break;
      case InspirationType.Birthday:
        _birthdayBox.delete(inspiration.key);
        break;
    }
  }
}
