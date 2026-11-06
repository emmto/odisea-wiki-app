import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odisea_wiki_app/screens/storyboard/storyboard_screen.dart';
import 'package:odisea_wiki_app/screens/storyboard/storyboard_viewer_screen.dart';
import 'package:odisea_wiki_app/screens/storyboard/storyboard_data.dart';

void main() {
  testWidgets('StoryboardScreen renders top bar without button text and all chapters in story order',
      (WidgetTester tester) async {
    bool backed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StoryboardScreen(
          onBack: () {
            backed = true;
          },
        ),
      ),
    );

    // 1. Top bar: Solo flecha de volver (Icons.arrow_back_rounded) y título centrado 'Storyboard'
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    expect(find.text('Storyboard'), findsOneWidget);
    expect(find.text('Volver'), findsNothing);
    expect(find.text('← Volver'), findsNothing);

    // 2. Banner de bienvenida
    expect(find.text(StoryboardData.overviewTitle), findsOneWidget);
    expect(find.text('17 viñetas en orden de la historia'), findsOneWidget);

    // 3. Capítulos agrupados en orden de la historia
    expect(find.text('El Decreto del Viejo Horno'), findsOneWidget);
    expect(find.text('La Cueva del Mercado'), findsOneWidget);
    expect(find.text('Huida del Mercado'), findsOneWidget);
    expect(find.text('El Asedio a la Panadería'), findsOneWidget);
    expect(find.text('Carrera Desesperada por La Tovara'), findsOneWidget);

    // 4. Test del botón volver
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(backed, isTrue);

    // 5. Test del botón de información del Storyboard
    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Guía del Storyboard'), findsOneWidget);
    expect(find.text('¡Entendido!'), findsOneWidget);

    // Cerrar diálogo
    await tester.tap(find.text('¡Entendido!'));
    await tester.pumpAndSettle();
    expect(find.text('Guía del Storyboard'), findsNothing);
  });

  testWidgets('Tapping Ver Storyboard Completo opens StoryboardViewerScreen with 17 scenes',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StoryboardScreen(),
      ),
    );

    // Tocar el botón para ver el storyboard completo
    final playAllButton = find.text('Ver Storyboard Completo (17 Viñetas)');
    expect(playAllButton, findsOneWidget);
    await tester.tap(playAllButton);
    await tester.pumpAndSettle();

    // Debe abrir StoryboardViewerScreen
    expect(find.byType(StoryboardViewerScreen), findsOneWidget);
    expect(find.text('Viñeta 1 de 17'), findsOneWidget);
    expect(find.text('El Puerto de San Blas'), findsOneWidget);

    // Top bar en el visor: solo flecha de volver (sin texto)
    expect(find.byTooltip('Volver'), findsOneWidget);

    // Avanzar a la siguiente viñeta (Viñeta 2)
    final nextButton = find.text('Siguiente');
    expect(nextButton, findsOneWidget);
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(find.text('Viñeta 2 de 17'), findsOneWidget);
    expect(find.text('El Cansancio de Don Lupe'), findsOneWidget);

    // Retroceder con botón anterior
    final prevButton = find.text('Anterior');
    expect(prevButton, findsOneWidget);
    await tester.tap(prevButton);
    await tester.pumpAndSettle();

    expect(find.text('Viñeta 1 de 17'), findsOneWidget);

    // Volver al StoryboardScreen usando la flecha
    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();

    expect(find.byType(StoryboardScreen), findsOneWidget);
  });
}
