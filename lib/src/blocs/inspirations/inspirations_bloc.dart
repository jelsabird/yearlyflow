import 'package:bloc/bloc.dart';
import 'package:yearly_flow/src/blocs/inspirations/inspirations_events.dart';
import 'package:yearly_flow/src/blocs/inspirations/inspirations_states.dart';
import 'package:yearly_flow/src/resources/repository.dart';
import 'package:yearly_flow/src/models/models.dart';

class InspirationsBloc extends Bloc<InspirationsEvent, InspirationsState> {
  final IRepository repository;

  InspirationsBloc({required this.repository})
      : super(InspirationsLoadInProgress());

  @override
  Stream<InspirationsState> mapEventToState(InspirationsEvent event) async* {
    if (event is InspirationsLoaded) {
      yield* _mapInspirationsLoadedToState();
    } else if (event is InspirationAdded) {
      yield* _mapInspirationAddedToState(event);
    } else if (event is InspirationUpdated) {
      yield* _mapInspirationUpdatedToState(event);
    } else if (event is InspirationDeleted) {
      yield* _mapInspirationDeletedToState(event);
    }
  }

  Stream<InspirationsState> _mapInspirationsLoadedToState() async* {
    try {
      final inspirations = await this.repository.fetchAllInspirations();
      yield InspirationsLoadSuccess(inspirations);
    } catch (_) {
      yield InspirationsLoadFailure();
    }
  }

  Stream<InspirationsState> _mapInspirationAddedToState(
      InspirationAdded event) async* {
    if (state is InspirationsLoadSuccess) {
      final List<InspirationModel> updatedInspirations = List.from((state as
      InspirationsLoadSuccess).year.inspirations);
      Year year = Year(updatedInspirations);
      year.addInspiration(event.inspiration);

      yield InspirationsLoadSuccess(year);

      _saveInspiration(event.inspiration);
    }
  }

  Stream<InspirationsState> _mapInspirationUpdatedToState(
      InspirationUpdated event) async* {
    if (state is InspirationsLoadSuccess) {
      final List<InspirationModel> updatedInspirations = List.from((state as
      InspirationsLoadSuccess).year.inspirations);
      Year year = Year(updatedInspirations);
      year.updateInspiration(event.inspiration);

      yield InspirationsLoadSuccess(year);

      _saveInspiration(event.inspiration);
    }
  }

  Stream<InspirationsState> _mapInspirationDeletedToState(
      InspirationDeleted event) async* {
    if (state is InspirationsLoadSuccess) {
      final List<InspirationModel> updatedInspirations = List.from((state as
      InspirationsLoadSuccess).year.inspirations);
      Year year = Year(updatedInspirations);
      year.removeInspiration(event.inspiration.key);

      yield InspirationsLoadSuccess(year);

      _deleteInspiration(event.inspiration);
    }
  }

  void _saveInspiration(InspirationModel inspiration) {
    return repository.save(inspiration);
  }

  void _deleteInspiration(InspirationModel inspiration) {
    return repository.delete(inspiration);
  }
}
