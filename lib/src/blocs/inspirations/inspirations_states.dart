import 'package:equatable/equatable.dart';
import 'package:yearly_flow/src/models/models.dart';

abstract class InspirationsState extends Equatable {
  const InspirationsState();

  @override
  List<Object> get props => [];
}

class InspirationsLoadInProgress extends InspirationsState {}

class InspirationsLoadSuccess extends InspirationsState {
  final Year year;

  const InspirationsLoadSuccess(this.year);

  @override
  List<Object> get props => [year];

  @override
  String toString() =>
      'InspirationsLoadSuccess { count: ${year.inspirations.length} }';
}

class InspirationsLoadFailure extends InspirationsState {}
