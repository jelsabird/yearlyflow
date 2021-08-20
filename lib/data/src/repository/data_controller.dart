import 'package:hive_flutter/hive_flutter.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';

class DataController{
  static DataController instance = DataController();
  late Box<Note> noteBox;
  late Box<BulletList> bulletListBox;
  late Box<Recipe> recipeBox;
  late Box<Birthday> birthdayBox;

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

    return Future.value();
  }

  Future<void> openBoxes() async{
    noteBox = await Hive.openBox<Note>('noteBox');
    bulletListBox = await Hive.openBox<BulletList>('bulletListBox');
    recipeBox = await Hive.openBox<Recipe>('recipeBox');
    birthdayBox = await Hive.openBox<Birthday>('birthdayBox');

    return Future.value();
  }
}