import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odisea_wiki_app/screens/home/tabs/characters_tab.dart';

void main() {
  testWidgets('CharactersTab displays all 4 characters correctly across navigation',
      (WidgetTester tester) async {
    bool backed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: CharactersTab(
          onBack: () {
            backed = true;
          },
        ),
      ),
    );

    // 1. Initial page: Ulises
    expect(find.text('Ulises'), findsOneWidget);
    expect(find.text('El Panadero'), findsOneWidget);
    expect(find.text('PROTAGONISTA'), findsOneWidget);
    expect(find.text('LORE'), findsOneWidget);
    expect(find.text('Características'), findsOneWidget);
    expect(find.textContaining('Decidido a honrar la receta tradicional'), findsOneWidget);
    expect(find.textContaining('Arma favorita: Pala de madera'), findsOneWidget);

    // Test back button
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(backed, isTrue);

    // Test navigating to second character (Don Lupe)
    await tester.tap(find.byTooltip('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Don Lupe'), findsOneWidget);
    expect(find.text('El Maestro Panadero'), findsOneWidget);
    expect(find.text('ALIADO'), findsOneWidget);
    expect(find.textContaining('Veterano dueño de la panadería tradicional'), findsOneWidget);
    expect(find.textContaining('Puesto: Maestro Hornero'), findsOneWidget);

    // Test navigating to third character (Madame Circe)
    await tester.tap(find.byTooltip('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Madame Circe'), findsOneWidget);
    expect(find.text('La Chef Rival'), findsOneWidget);
    expect(find.text('ENEMIGA'), findsOneWidget);
    expect(find.textContaining('Cocinera corporativa y pretenciosa'), findsOneWidget);
    expect(find.textContaining('Debilidad: Sabor artesanal'), findsOneWidget);

    // Test navigating to fourth character (Polifemo)
    await tester.tap(find.byTooltip('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.text('Polifemo'), findsOneWidget);
    expect(find.text('El Estibador del Mercado'), findsOneWidget);
    expect(find.text('ANTAGONISTA'), findsOneWidget);
    expect(find.textContaining('Gigantesco y malhumorado comerciante'), findsOneWidget);
    expect(find.textContaining('Peligro: Lanzamiento de huacales'), findsOneWidget);

    // Verify info dialog opens
    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Guía de Personajes'), findsOneWidget);
    expect(find.text('¡Entendido!'), findsOneWidget);

    // Close info dialog
    await tester.tap(find.text('¡Entendido!'));
    await tester.pumpAndSettle();
    expect(find.text('Guía de Personajes'), findsNothing);
  });
}
