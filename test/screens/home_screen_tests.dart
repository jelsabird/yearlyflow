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

  group('Home screen', () {
    late InspirationsBloc inspirationsBloc;
    Year testYear = Year([NoteModel(month: Month.January, title: "Note")]);

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
      expect(find.byType(MonthSectionsList), findsOneWidget);
      expect(find.byType(MonthHeader), findsWidgets);
      expect(find.byType(InspirationCard), findsOneWidget);
      expect(find.byKey(YearlyFlowKeys.addButton), findsOneWidget);
    });

    testWidgets('navigates to add screen when Floating Action Button is '
        'tapped', (WidgetTester tester) async {
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
      await tester.tap(find.byKey(YearlyFlowKeys.addButton));
      await tester.pumpAndSettle();

      expect(find.byType(AddEditScreen), findsOneWidget);
    });

    testWidgets('navigates to details screen when Inspiration Card is '
        'tapped', (WidgetTester tester) async {
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
      await tester.tap(find.byType(InspirationCard));
      await tester.pumpAndSettle();

      expect(find.byType(DetailsScreen), findsOneWidget);
    });
  });
}