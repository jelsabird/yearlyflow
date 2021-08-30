import 'package:mockito/mockito.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/item_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';
import 'package:yearly_flow/src/resources/repository.dart';
import 'package:yearly_flow/src/util/event_bus_utils.dart';

class MockDataController extends Mock implements IDataController {}
class MockRepository extends Mock implements IRepository {}
class MockEventBus extends Mock implements EventBusUtils {}

class FakeRepository extends Fake implements IRepository {
  @override
  Future<ItemModel> fetchAllInspirations() async {
    var itemModel = ItemModel();
    itemModel.inspirations.add(NoteModel(month: Month.January));
    itemModel.inspirations.add(NoteModel(month: Month.February));
    itemModel.inspirations.add(BulletListModel(month: Month.February));
    itemModel.inspirations.add(RecipeModel(month: Month.March));
    itemModel.inspirations.add(BirthdayModel(month: Month.November));

    return Future.value(itemModel);
  }
}
