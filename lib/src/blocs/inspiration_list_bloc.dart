import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/item_model.dart';
import 'package:yearly_flow/src/resources/repository.dart';

abstract class IInspirationListBloc {
  Stream<ItemModel> get allInspirations;
  Map<Month, List<InspirationModel>> monthMap = <Month,
      List<InspirationModel>>{};

  Future<void> fetchAllInspirations();

  delete(InspirationModel inspiration);

  dispose();
}

class InspirationListBloc implements IInspirationListBloc {
  InspirationListBloc(this._repository, this._inspirationsFetcher);

  final IRepository _repository;
  final PublishSubject<ItemModel> _inspirationsFetcher;

  Stream<ItemModel> get allInspirations => _inspirationsFetcher.stream;

  Map<Month, List<InspirationModel>> monthMap = <Month,
      List<InspirationModel>>{};

  Future<void> fetchAllInspirations() async {
    ItemModel itemModel = await _repository.fetchAllInspirations();
    _inspirationsFetcher.sink.add(itemModel);

    monthMap.clear();
    _map(itemModel.inspirations);

  }

  void _map(List<InspirationModel> inspirations) {
    for (InspirationModel inspiration in inspirations) {
      if (monthMap.containsKey(inspiration.month)) {
        monthMap[inspiration.month]!.add(inspiration);
      } else {
        monthMap[inspiration.month] = <InspirationModel>[inspiration];
      }
    }
  }

  void delete(InspirationModel inspiration) {
    _repository.delete(inspiration);
  }

  void dispose() {
    _inspirationsFetcher.close();
  }
}

final bloc = locator.get<IInspirationListBloc>();
