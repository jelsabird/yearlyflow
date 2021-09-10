import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yearly_flow/src/core/core.dart';
import 'package:yearly_flow/src/blocs/blocs.dart';
import 'package:yearly_flow/src/screens/screens.dart';
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

  group('Details screen', () {
    late InspirationsBloc inspirationsBloc;
    String testId = "1";
    Year testYear = Year([
      NoteModel(
          key: testId,
          month: Month.January,
          title: "Note")
    ]);

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
              body: DetailsScreen(id: testId),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(Strings.pageTitle_viewCard), findsOneWidget);
      expect(find.byType(InspirationCard), findsOneWidget);
      expect(find.byKey(YearlyFlowKeys.editButton), findsOneWidget);
    });

    testWidgets(
        'navigates to edit screen when Floating Action Button is '
        'tapped', (WidgetTester tester) async {
      when(() => inspirationsBloc.state)
          .thenReturn(InspirationsLoadSuccess(testYear));
      await tester.pumpWidget(
        BlocProvider<InspirationsBloc>.value(
          value: inspirationsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: DetailsScreen(id: testId),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(YearlyFlowKeys.editButton));
      await tester.pumpAndSettle();

      expect(find.byType(AddEditScreen), findsOneWidget);
    });
  });
}
