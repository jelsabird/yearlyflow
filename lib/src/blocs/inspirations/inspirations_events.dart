import 'package:equatable/equatable.dart';
import 'package:yearly_flow/src/models/models.dart';

abstract class InspirationsEvent extends Equatable {
  const InspirationsEvent();

  @override
  List<Object> get props => [];
}

class InspirationsLoaded extends InspirationsEvent {}

class InspirationAdded extends InspirationsEvent {
  final InspirationModel inspiration;

  const InspirationAdded(this.inspiration);

  @override
  List<Object> get props => [inspiration];

  @override
  String toString() => 'Inspiration added { inspiration: ${inspiration.title},'
      ' ${inspiration.inspirationType} }';
}

class InspirationUpdated extends InspirationsEvent {
  final InspirationModel inspiration;

  const InspirationUpdated(this.inspiration);

  @override
  List<Object> get props => [inspiration];

  @override
  String toString() => 'Inspiration updated { inspiration: ${inspiration
      .title}, ${inspiration.inspirationType} }';
}

class InspirationDeleted extends InspirationsEvent {
  final InspirationModel inspiration;

  const InspirationDeleted(this.inspiration);

  @override
  List<Object> get props => [inspiration];

  @override
  String toString() => 'Inspiration deleted { inspiration: ${inspiration
      .title}, ${inspiration.inspirationType} }';
}