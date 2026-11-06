import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odisea_wiki_app/screens/levels/levels_screen.dart';
import 'package:odisea_wiki_app/screens/levels/level_detail_screen.dart';
import 'package:odisea_wiki_app/screens/levels/widgets/level_placeholder_banner.dart';

void main() {
  testWidgets('LevelsScreen displays 3 level cards and navigates to LevelDetailScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LevelsScreen(),
      ),
    );

    // 1. Verificar Top Bar de LevelsScreen: flecha volver y título centrado "Niveles"
    expect(find.text('Niveles'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);

    // 2. Verificar que muestra los 3 niveles en Cards (como las partes de la historia)
    expect(find.text('Niveles de la Odisea'), findsOneWidget);
    expect(find.text('Nivel 1: El Mercado Vertical'), findsOneWidget);
    expect(find.text('Nivel 2: El Asedio a la Panadería'), findsOneWidget);
    expect(find.text('Nivel 3: Carrera por La Tovara'), findsOneWidget);

    // 3. Tocar el Nivel 1 para navegar a su vista individual
    await tester.tap(find.text('Nivel 1: El Mercado Vertical'));
    await tester.pumpAndSettle();

    // 4. Verificar LevelDetailScreen del Nivel 1
    expect(find.byType(LevelDetailScreen), findsOneWidget);

    // Top bar coincide: solo flecha y título centrado
    expect(find.text('Nivel 1'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);

    // Placeholder de la imagen
    expect(find.byType(LevelPlaceholderBanner), findsOneWidget);

    // Tarjeta Retos
    expect(find.text('Retos'), findsOneWidget);
    expect(
      find.textContaining('Ascenso vertical continuo evitando las cáscaras de plátano'),
      findsOneWidget,
    );

    // Tarjeta Características
    expect(find.text('Características'), findsOneWidget);
    expect(find.textContaining('Tipo:'), findsOneWidget);
    expect(find.textContaining('Salto vertical de reflejos'), findsOneWidget);
    expect(find.textContaining('Ingrediente final:'), findsOneWidget);
    expect(find.textContaining('Racimo de plátano macho'), findsOneWidget);

    // Ficha técnica & diseño de niveles.txt
    expect(find.text('Ficha Técnica & Diseño'), findsOneWidget);

    // 5. Probar navegación a Nivel 2
    final nextButton = find.text('Nivel 2');
    await tester.ensureVisible(nextButton);
    await tester.pumpAndSettle();
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    // Ahora en Nivel 2
    expect(find.text('Nivel 2'), findsWidgets);
    expect(find.textContaining('El Asedio a la Panadería'), findsWidgets);
    expect(find.textContaining('Micro Tower Defense'), findsOneWidget);
    expect(find.textContaining('Proteger el horno de leña'), findsOneWidget);

    // 6. Volver a LevelsScreen usando la flecha de la topbar
    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();

    expect(find.byType(LevelDetailScreen), findsNothing);
    expect(find.byType(LevelsScreen), findsOneWidget);
  });
}
