import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/screens/screens.dart';
import 'package:yearly_flow/src/widgets/note_card_content.dart';
import 'package:yearly_flow/src/widgets/widgets.dart';
import 'package:yearly_flow/src/models/models.dart';

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

  group('Add/edit screen', () {
    late InspirationsBloc inspirationsBloc;
    NoteModel testModel = NoteModel(
        month: Month.February,
        timeOfMonth: TimeOfMonth.End,
        title: "Hello "
            "february!",
        text: "Plan something for spring");
    Year testYear = Year([testModel]);

    setUp(() {
      inspirationsBloc = MockInspirationsBloc();
    });

    testWidgets('renders correctly when editing', (WidgetTester tester) async {
      when(() => inspirationsBloc.state)
          .thenReturn(InspirationsLoadSuccess(testYear));
      await tester.pumpWidget(
        BlocProvider<InspirationsBloc>.value(
          value: inspirationsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AddEditScreen(
                  onSave: (_) => null, inspiration: testModel),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(Strings.pageTitle_editCard), findsOneWidget);
      expect(find.byType(TypeSelector), findsNothing);
      expect(find.byType(InspirationCard), findsOneWidget);
      expect(find.byType(NoteCardContent), findsOneWidget);
      expect(find.text(testModel.title), findsOneWidget);
      expect(find.text(testModel.text), findsOneWidget);
      expect(find.byType(MonthSelector), findsOneWidget);
      expect(find.text(Strings.editMonthAndTime), findsOneWidget);
      expect(find.text(testModel.timeOfMonth.displayString), findsOneWidget);
      expect(find.text(testModel.month.displayTitle.toLowerCase()),
          findsOneWidget);
      expect(find.byKey(YearlyFlowKeys.saveButton), findsOneWidget);
    });

    testWidgets('renders correctly when adding', (WidgetTester tester) async {
      when(() => inspirationsBloc.state)
          .thenReturn(InspirationsLoadSuccess(testYear));
      await tester.pumpWidget(
        BlocProvider<InspirationsBloc>.value(
          value: inspirationsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AddEditScreen(onSave: (_) => null),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(Strings.pageTitle_editCard), findsOneWidget);
      expect(find.byType(TypeSelector), findsOneWidget);
      expect(find.byType(InspirationCard), findsOneWidget);
      expect(find.byType(NoteCardContent), findsOneWidget);
      expect(find.text(testModel.title), findsNothing);
      expect(find.text(testModel.text), findsNothing);
      expect(find.byType(MonthSelector), findsOneWidget);
      expect(find.text(Strings.editMonthAndTime), findsOneWidget);
      expect(find.text(TimeOfMonth.Any.displayString), findsOneWidget);
      expect(
          find.text(Month.January.displayTitle.toLowerCase()), findsOneWidget);
      expect(find.byKey(YearlyFlowKeys.saveButton), findsOneWidget);
    });

    testWidgets('should call onSave when Floating Action Button is tapped',
        (WidgetTester tester) async {
      when(() => inspirationsBloc.state)
          .thenReturn(InspirationsLoadSuccess(testYear));
      var onSavePressed = false;
      await tester.pumpWidget(
        BlocProvider<InspirationsBloc>.value(
          value: inspirationsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: AddEditScreen(
                onSave: (testModel) {
                  onSavePressed = true;
                },
                inspiration: testModel,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(YearlyFlowKeys.saveButton));
      expect(onSavePressed, true);
    });
  });
}
