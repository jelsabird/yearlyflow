import 'package:hive_flutter/hive_flutter.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';
import 'package:yearly_flow/src/models/month_section_model.dart';

class DataController{
  static DataController instance = DataController();
  late Box<Note> noteBox;
  late Box<BulletList> bulletListBox;
  late Box<Recipe> recipeBox;
  late Box<Birthday> birthdayBox;
  bool isInitiated = false;

  Future<void> initDatabase() async {
    await Hive.initFlutter();

    Hive.registerAdapter(NoteAdapter());
    Hive.registerAdapter(BulletListAdapter());
    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(BirthdayAdapter());
    Hive.registerAdapter(InspirationTypeAdapter());
    Hive.registerAdapter(MonthAdapter());
    Hive.registerAdapter(TimeOfMonthAdapter());

    await openBoxes();

    isInitiated = true;
    return Future.value();
  }

  Future<void> openBoxes() async{
    noteBox = await Hive.openBox<Note>('1noteBox');
    bulletListBox = await Hive.openBox<BulletList>('1bulletListBox');
    recipeBox = await Hive.openBox<Recipe>('1recipeBox');
    birthdayBox = await Hive.openBox<Birthday>('1birthdayBox');

    return Future.value();
  }

  Future<MonthSectionModel> fetchAllInspirations() async {
    if(!isInitiated){
      await initDatabase();
    }
    var monthSection = MonthSectionModel();
    monthSection.inspirationCards.addAll(noteBox.values);
    monthSection.inspirationCards.addAll(bulletListBox.values);
    monthSection.inspirationCards.addAll(recipeBox.values);
    monthSection.inspirationCards.addAll(birthdayBox.values);

    return monthSection;
  }

  void save(Inspiration inspiration){
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

  void _addNote(Inspiration note){
    noteBox.put(note.key, note as Note);
  }

  void _addBulletList(Inspiration bulletList){
    bulletListBox.put(bulletList.key, bulletList as BulletList);
  }

  void _addRecipe(Inspiration recipe){
    recipeBox.put(recipe.key, recipe as Recipe);
  }

  void _addBirthday(Inspiration birthday){
    birthdayBox.put(birthday.key, birthday as Birthday);
  }

  void delete(Inspiration inspiration){
    switch (inspiration.inspirationType) {
      case InspirationType.Note:
        noteBox.delete(inspiration.key);
        break;
      case InspirationType.BulletList:
        bulletListBox.delete(inspiration.key);
        break;
      case InspirationType.Recipe:
        recipeBox.delete(inspiration.key);
        break;
      case InspirationType.Birthday:
        birthdayBox.delete(inspiration.key);
        break;
    }
  }
}