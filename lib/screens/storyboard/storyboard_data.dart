import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StoryboardScene {
  final String id;
  final String imagePath;
  final int sceneNumber;
  final String title;
  final String description;
  final String? characterFocus;

  const StoryboardScene({
    required this.id,
    required this.imagePath,
    required this.sceneNumber,
    required this.title,
    required this.description,
    this.characterFocus,
  });
}

enum StoryboardChapterStatus {
  available,
  upcoming,
}

class StoryboardChapter {
  final String id;
  final String orderLabel;
  final String title;
  final String subtitle;
  final String? levelReference;
  final String summary;
  final StoryboardChapterStatus status;
  final List<StoryboardScene> scenes;
  final Color badgeColor;
  final IconData icon;

  const StoryboardChapter({
    required this.id,
    required this.orderLabel,
    required this.title,
    required this.subtitle,
    this.levelReference,
    required this.summary,
    required this.status,
    this.scenes = const [],
    required this.badgeColor,
    required this.icon,
  });

  bool get isAvailable => status == StoryboardChapterStatus.available;
  int get sceneCount => scenes.length;
}

class StoryboardData {
  static const String overviewTitle = 'Storyboard & Cinemáticas';
  static const String overviewSubtitle =
      'Bocetos de escenas, guiones gráficos y flujo visual de La Odisea del Pan de Plátano.';

  static const List<StoryboardChapter> chapters = [
    // -------------------------------------------------------------------------
    // 1. PRÓLOGO: EL DECRETO DEL VIEJO HORNO
    // -------------------------------------------------------------------------
    StoryboardChapter(
      id: 'prologo',
      orderLabel: 'Prólogo',
      title: 'El Decreto del Viejo Horno',
      subtitle: 'Cinemática Inicial • San Blas',
      levelReference: 'Introducción del Juego',
      summary:
          'Don Lupe convoca al taller ante la amenaza industrial. Ulises acepta el desafío del pan definitivo frente al desprecio de Madame Circe.',
      status: StoryboardChapterStatus.available,
      badgeColor: AppColors.primaryYellow,
      icon: Icons.fireplace_rounded,
      scenes: [
        StoryboardScene(
          id: 'prologo_1',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_1.jpg',
          sceneNumber: 1,
          title: 'El Puerto de San Blas',
          description:
              'Amanecer en el puerto de San Blas donde el salitre y la tradición resisten el avance de cadenas industriales.',
          characterFocus: 'San Blas',
        ),
        StoryboardScene(
          id: 'prologo_2',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_2.jpg',
          sceneNumber: 2,
          title: 'El Cansancio de Don Lupe',
          description:
              'Don Lupe contempla las brasas de su horno rústico tras décadas de leña, harina y sudor.',
          characterFocus: 'Don Lupe',
        ),
        StoryboardScene(
          id: 'prologo_3',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_3.jpg',
          sceneNumber: 3,
          title: 'El Decreto de la Pala de Oro',
          description:
              'Don Lupe lanza su ultimátum: quien elabore el pan de plátano supremo para el Festival ganará la pala de oro.',
          characterFocus: 'Don Lupe',
        ),
        StoryboardScene(
          id: 'prologo_4',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_4.jpg',
          sceneNumber: 4,
          title: 'El Llamado de Ulises',
          description:
              'Ulises asume el desafío como un designio del destino; no utilizará sustitutos ni atajos químicos.',
          characterFocus: 'Ulises',
        ),
        StoryboardScene(
          id: 'prologo_5',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_5.jpg',
          sceneNumber: 5,
          title: 'Los Frutos de la Costa',
          description:
              'La receta exige la fruta más selecta: los legendarios plátanos machos reales del mercado central.',
          characterFocus: 'Receta Tradicional',
        ),
        StoryboardScene(
          id: 'prologo_6',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_6.jpg',
          sceneNumber: 6,
          title: 'Aparición de Madame Circe',
          description:
              'Madame Circe irrumpe con batidoras cromadas y aires de superioridad corporativa.',
          characterFocus: 'Madame Circe',
        ),
        StoryboardScene(
          id: 'prologo_7',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_7.jpg',
          sceneNumber: 7,
          title: 'La Advertencia Soberbia',
          description:
              'Circe se mofa de las recetas tradicionales y advierte que aplastará a cualquier panadero local.',
          characterFocus: 'Madame Circe',
        ),
        StoryboardScene(
          id: 'prologo_8',
          imagePath: 'assets/images/Historieta/Prologo/Prologo_8.jpg',
          sceneNumber: 8,
          title: 'Comienza la Carrera',
          description:
              'Ulises ajusta su delantal gastado y parte hacia el mercado central. La odisea ha comenzado.',
          characterFocus: 'Ulises',
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 2. ACTO I: LA CUEVA DEL MERCADO (NIVEL 1)
    // -------------------------------------------------------------------------
    StoryboardChapter(
      id: 'acto_1_mercado',
      orderLabel: 'Acto I',
      title: 'La Cueva del Mercado',
      subtitle: 'Nivel 1: El Mercado Vertical',
      levelReference: 'Nivel 1: El Mercado Vertical',
      summary:
          'Amanecer ensordecedor en el Mercado Municipal. Ulises trepa balanzas y vigas esquivando cáscaras arrojadas por Circe hacia el racimo dorado.',
      status: StoryboardChapterStatus.available,
      badgeColor: AppColors.mangroveGreen,
      icon: Icons.storefront_rounded,
      scenes: [
        StoryboardScene(
          id: 'mercado_1',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_1.jpg',
          sceneNumber: 1,
          title: 'El Laberinto de Huacales',
          description:
              'El bullicio revienta en la nave central del mercado entre lonas coloradas, pregones y cajas apiladas.',
          characterFocus: 'Mercado Municipal',
        ),
        StoryboardScene(
          id: 'mercado_2',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_2.jpg',
          sceneNumber: 2,
          title: 'La Cima de Polifemo',
          description:
              'En lo más alto cuelga el mítico racimo de plátano macho, custodiado por el gigante Polifemo.',
          characterFocus: 'Polifemo',
        ),
        StoryboardScene(
          id: 'mercado_3',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_3.jpg',
          sceneNumber: 3,
          title: 'El Ascenso Vertical',
          description:
              'Ulises inicia la escalada saltando sobre balanzas colgantes que oscilan violentamente.',
          characterFocus: 'Ulises',
        ),
        StoryboardScene(
          id: 'mercado_4',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_4.jpg',
          sceneNumber: 4,
          title: 'Emboscada de Madame Circe',
          description:
              'Circe aparece entre las vigas superiores arrojando cajas vacías y cáscaras resbaladizas.',
          characterFocus: 'Madame Circe',
        ),
        StoryboardScene(
          id: 'mercado_5',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_5.jpg',
          sceneNumber: 5,
          title: 'Acrobacias en la Soga',
          description:
              'Con reflejos de panadero, Ulises aprovecha el vaivén de cuerdas de carga para esquivar la trampa.',
          characterFocus: 'Ulises',
        ),
        StoryboardScene(
          id: 'mercado_6',
          imagePath: 'assets/images/Historieta/Acto I_ Mercado/mercado_6.jpg',
          sceneNumber: 6,
          title: 'Duelo en las Alturas',
          description:
              'Frente a frente con la silueta descomunal de Polifemo resguardando la cosecha dorada.',
          characterFocus: 'Ulises & Polifemo',
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 3. ACTO I - SALIDA: LA HUIDA DEL MERCADO (CLÍMAX NIVEL 1)
    // -------------------------------------------------------------------------
    StoryboardChapter(
      id: 'mercado_salida',
      orderLabel: 'Acto I • Salida',
      title: 'Huida del Mercado',
      subtitle: 'Transición de Nivel 1 a Nivel 2',
      levelReference: 'Clímax del Nivel 1',
      summary:
          'Ulises estalla un costal de harina desorientando a Polifemo, arrebata los plátanos machos reales y escapa con el botín rumbo al taller.',
      status: StoryboardChapterStatus.available,
      badgeColor: AppColors.mangroveGreen,
      icon: Icons.exit_to_app_rounded,
      scenes: [
        StoryboardScene(
          id: 'salida_1',
          imagePath: 'assets/images/Historieta/Mercado Salida/MercadoSalida_1.jpg',
          sceneNumber: 1,
          title: 'Cortina Blanca de Harina',
          description:
              'Un costal de harina revienta en una nube espesa que ciega momentáneamente a Polifemo.',
          characterFocus: 'Ulises',
        ),
        StoryboardScene(
          id: 'salida_2',
          imagePath: 'assets/images/Historieta/Mercado Salida/MercadoSalida_2.jpg',
          sceneNumber: 2,
          title: 'El Racimo Conquistado',
          description:
              'Ulises arranca el racimo dorado de plátano macho justo antes de que Circe intente bloquearlo.',
          characterFocus: 'Racimo Dorado',
        ),
        StoryboardScene(
          id: 'salida_3',
          imagePath: 'assets/images/Historieta/Mercado Salida/MercadoSalida_3.jpg',
          sceneNumber: 3,
          title: 'Escape Hacia el Taller',
          description:
              'Con el morral repleto de especias y la fruta sagrada, Ulises cruza la salida del mercado.',
          characterFocus: 'Ulises',
        ),
      ],
    ),

    // -------------------------------------------------------------------------
    // 4. ACTO II: EL ASEDIO A LA PANADERÍA (NIVEL 2) - PRÓXIMAMENTE
    // -------------------------------------------------------------------------
    StoryboardChapter(
      id: 'acto_2_panaderia',
      orderLabel: 'Acto II',
      title: 'El Asedio a la Panadería',
      subtitle: 'Nivel 2: El Asedio a la Panadería',
      levelReference: 'Nivel 2: El Asedio a la Panadería',
      summary:
          'El aroma dulce desata el caos: ratas, jejenes voraces y cocodrilos rodean el horno. Ulises defiende las brasas con rodillo, jarabe y ventiladores.',
      status: StoryboardChapterStatus.upcoming,
      badgeColor: AppColors.darkBrown,
      icon: Icons.outdoor_grill_rounded,
    ),

    // -------------------------------------------------------------------------
    // 5. ACTO III: CARRERA POR LA TOVARA (NIVEL 3) - PRÓXIMAMENTE
    // -------------------------------------------------------------------------
    StoryboardChapter(
      id: 'acto_3_tovara',
      orderLabel: 'Acto III',
      title: 'Carrera Desesperada por La Tovara',
      subtitle: 'Nivel 3: Carrera por La Tovara',
      levelReference: 'Nivel 3: Carrera por La Tovara',
      summary:
          'A contrarreloj sobre pasarelas carcomidas y raíces de mangle esquivando cocodrilos y tormenta para llevar el pan caliente al jurado.',
      status: StoryboardChapterStatus.upcoming,
      badgeColor: AppColors.mangroveGreen,
      icon: Icons.water_rounded,
    ),
  ];

  /// Lista aplanada de todas las viñetas disponibles en orden secuencial de la historia
  static List<StoryboardScene> get allAvailableScenes {
    final list = <StoryboardScene>[];
    for (final chapter in chapters) {
      if (chapter.isAvailable) {
        list.addAll(chapter.scenes);
      }
    }
    return list;
  }

  /// Total de viñetas disponibles
  static int get totalAvailableScenesCount => allAvailableScenes.length;

  /// Obtener capítulo por ID
  static StoryboardChapter? getChapterById(String id) {
    try {
      return chapters.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Obtener capítulo al que pertenece una escena
  static StoryboardChapter? getChapterForScene(String sceneId) {
    for (final chapter in chapters) {
      if (chapter.scenes.any((s) => s.id == sceneId)) {
        return chapter;
      }
    }
    return null;
  }
}
