import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odisea_wiki_app/screens/story/story_screen.dart';
import 'package:odisea_wiki_app/screens/story/story_detail_screen.dart';

void main() {
  testWidgets('StoryScreen renders top bar without button text and displays all 4 parts',
      (WidgetTester tester) async {
    bool backed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StoryScreen(
          onBack: () {
            backed = true;
          },
        ),
      ),
    );

    // 1. Top bar: Solo flecha de volver (Icons.arrow_back_rounded) y título centrado 'Historia'
    expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
    expect(find.text('Historia'), findsOneWidget);
    // Verificamos que no haya un botón con el texto 'Volver' o '← Volver'
    expect(find.text('Volver'), findsNothing);
    expect(find.text('← Volver'), findsNothing);

    // 2. Título de la sección del mockup
    expect(find.text('El Llamado a la Cocina'), findsOneWidget);

    // 3. Placeholder de Imagen / Banner
    expect(find.text('Boceto de Arte • Escena Principal'), findsOneWidget);

    // 4. Las 4 partes de la historia presentes como cards
    expect(find.text('Prólogo: El Decreto del Viejo Horno'), findsOneWidget);
    expect(find.text('Acto I: La Cueva del Mercado y el Fruto Prohibido'), findsOneWidget);
    expect(find.text('Acto II: El Asedio a la Panadería de Piedra'), findsOneWidget);
    expect(find.text('Acto III: Carrera Desesperada por los Manglares de La Tovara'), findsOneWidget);

    // 5. Test del botón volver
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();
    expect(backed, isTrue);

    // 6. Test del botón de información de la historia
    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Guía de la Historia'), findsOneWidget);
    expect(find.text('¡Entendido!'), findsOneWidget);

    // Cerrar diálogo
    await tester.tap(find.text('¡Entendido!'));
    await tester.pumpAndSettle();
    expect(find.text('Guía de la Historia'), findsNothing);
  });

  testWidgets('Tapping a story card navigates to full StoryDetailScreen with full text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: StoryScreen(),
      ),
    );

    // Tocar la card del Prólogo
    await tester.tap(find.text('Prólogo: El Decreto del Viejo Horno'));
    await tester.pumpAndSettle();

    // Debe estar en StoryDetailScreen
    expect(find.byType(StoryDetailScreen), findsOneWidget);
    expect(find.text('El Decreto del Viejo Horno'), findsOneWidget);
    expect(find.text('Puerto de San Blas • Panadería de Don Lupe'), findsOneWidget);

    // Verificar fragmentos del texto original completo
    expect(
      find.textContaining('En el puerto de San Blas, donde el aire huele a salitre'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Ulises, un joven panadero local cuya destreza con las masas'),
      findsOneWidget,
    );
    expect(
      find.textContaining('custodia de la pala de oro del horno de piedra'),
      findsAtLeastNWidgets(1),
    );

    // Verificar botón siguiente acto (Acto I)
    final nextButtonFinder = find.widgetWithText(ElevatedButton, 'Acto I');
    await tester.ensureVisible(nextButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(nextButtonFinder);
    await tester.pumpAndSettle();

    // Ahora estamos en Acto I
    expect(find.text('La Cueva del Mercado y el Fruto Prohibido'), findsOneWidget);
    expect(find.textContaining('Mercado Municipal de San Blas'), findsAtLeastNWidgets(1));
    expect(
      find.textContaining('El amanecer revienta en el Mercado Municipal de San Blas'),
      findsOneWidget,
    );

    // Volver hacia atrás usando la flecha de la top bar (sin texto en el botón)
    await tester.tap(find.byTooltip('Volver'));
    await tester.pumpAndSettle();

    // Debe regresar a StoryScreen
    expect(find.byType(StoryScreen), findsOneWidget);
    expect(find.text('El Llamado a la Cocina'), findsOneWidget);
  });
}
