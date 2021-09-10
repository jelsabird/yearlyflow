import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:yearly_flow/service_locator.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/models/models.dart';
import 'package:yearly_flow/src/screens/details_screen.dart';
import 'package:yearly_flow/src/screens/home_screen.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:mocktail/mocktail.dart';

class FakeInspirationsEvent extends Fake implements InspirationsEvent {}

class FakeInspirationsState extends Fake implements InspirationsState {}

class MockInspirationsBloc
    extends MockBloc<InspirationsEvent, InspirationsState>
    implements InspirationsBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue<InspirationsEvent>(FakeInspirationsEvent());
    registerFallbackValue<InspirationsState>(FakeInspirationsState());
  });

  group('HomeScreen', () {
    late InspirationsBloc inspirationsBloc;
    Year testYear = Year([NoteModel(title: "Note")]);

    setUp(() {
      inspirationsBloc = MockInspirationsBloc();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      when(() => inspirationsBloc.state)
          .thenReturn(InspirationsLoadSuccess(testYear));
      await tester.pumpWidget(
        BlocProvider<InspirationsBloc>.value(
          value: inspirationsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: HomeScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(Strings.app_title), findsOneWidget);
      expect(find.byKey(YearlyFlowKeys.monthSectionsList), findsOneWidget);
      var monthHeaders = find.byKey(YearlyFlowKeys.monthHeader);
      expect(monthHeaders.evaluate().length, 12);
      expect(find.byKey(YearlyFlowKeys.addButton), findsOneWidget);
    });
  });

  group("Unit tests", () {
    setUpAll(() {
      setupLocator();
      locator.allowReassignment = true;
    });
  });
}
