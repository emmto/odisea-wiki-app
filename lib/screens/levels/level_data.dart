import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'level_model.dart';

class LevelData {
  static const String levelsOverviewTitle = 'Niveles de la Odisea';
  static const String levelsSubtitle =
      'Recorre los 3 niveles del videojuego, sus mecánicas de juego, retos y objetivos culinarios.';

  /// Lista oficial de niveles extraídos de los mockups y de niveles.txt
  static const List<LevelItem> levels = [
    // -------------------------------------------------------------
    // NIVEL 1: El Mercado Vertical
    // -------------------------------------------------------------
    LevelItem(
      number: 1,
      id: 'nivel_1',
      name: 'El Mercado Vertical',
      challenge:
          'Ascenso vertical continuo evitando las cáscaras de plátano lanzadas por Madame Circe.',
      characteristics: [
        LevelCharacteristic(
          label: 'Tipo',
          value: 'Salto vertical de reflejos',
          icon: Icons.height_rounded,
        ),
        LevelCharacteristic(
          label: 'Ingrediente final',
          value: 'Racimo de plátano macho',
          icon: Icons.eco_rounded,
        ),
      ],
      spatialDesign:
          'Construido como un nivel de plataformas vertical con perspectiva de diorama. El escenario simula los enormes estantes de madera de un mercado local de Nayarit, con grúas y poleas de fondo.',
      mechanics:
          'Sirve como tutorial para asimilar los controles básicos (movimiento lateral, salto, doble salto y recolección). La progresión es de abajo hacia arriba.',
      obstaclesAndEnemies:
          'Peligros ambientales menores, como cajas tambaleantes, charcos que resbalan o sacos de harina inestables. Están diseñados para enseñar el ritmo del juego sin penalizaciones severas.',
      itemsAndClimax:
          'El jugador debe recolectar los ingredientes base (harina, huevos, azúcar). El nivel culmina en la plataforma más alta, donde se encuentra el ítem fundamental para cerrar el nivel y la receta: el Plátano Macho.',
      locationZone: 'El Mercado Central',
      icon: Icons.storefront_rounded,
      badgeColor: AppColors.primaryYellow,
    ),

    // -------------------------------------------------------------
    // NIVEL 2: El Asedio a la Panadería
    // -------------------------------------------------------------
    LevelItem(
      number: 2,
      id: 'nivel_2',
      name: 'El Asedio a la Panadería',
      challenge:
          'Defensa táctica contra enjambres de jejenes, ratas de bodega y cocodrilos desorientados.',
      characteristics: [
        LevelCharacteristic(
          label: 'Tipo',
          value: 'Micro Tower Defense',
          icon: Icons.shield_rounded,
        ),
        LevelCharacteristic(
          label: 'Objetivo',
          value: 'Proteger el horno de leña durante el leudado',
          icon: Icons.fireplace_rounded,
        ),
      ],
      spatialDesign:
          'Un nivel de supervivencia y Tower Defense estático con perspectiva isométrica. El escenario es el patio de una casa humilde. El elemento principal, el horno legendario de piedra, se encuentra posicionado estratégicamente de forma céntrica sobre el lado izquierdo del camino, dejando un área abierta a la derecha por donde llegarán las amenazas.',
      mechanics:
          'El jugador debe proteger el pan de plátano mientras la barra de cocción avanza. Se introducen mecánicas de ataque a distancia y colocación de barricadas.',
      obstaclesAndEnemies:
          'Oleadas progresivas de fauna local hambrienta (cangrejos ermitaños gigantes, mapaches, gaviotas en picada) que avanzan hacia el horno intentando robar la masa.',
      itemsAndClimax:
          'Leña adicional para acelerar la cocción (reduciendo el tiempo del nivel) y utensilios de cocina que sirven como trampas o muros temporales para frenar el avance enemigo.',
      locationZone: 'El Horno de Piedra',
      icon: Icons.local_fire_department_rounded,
      badgeColor: AppColors.primaryYellow,
    ),

    // -------------------------------------------------------------
    // NIVEL 3: Carrera por La Tovara
    // -------------------------------------------------------------
    LevelItem(
      number: 3,
      id: 'nivel_3',
      name: 'Carrera por La Tovara',
      challenge:
          'Carrera de precisión a través de las raíces de mangle y los puentes colgantes de La Tovara.',
      characteristics: [
        LevelCharacteristic(
          label: 'Tipo',
          value: 'Runner de plataformas y ritmo',
          icon: Icons.directions_run_rounded,
        ),
        LevelCharacteristic(
          label: 'Meta',
          value: 'Llegar al stand de la Feria antes del cierre',
          icon: Icons.flag_rounded,
        ),
      ],
      spatialDesign:
          'Transición a un formato side-scroller 2D de perfil (con una cámara lateral cercana y profunda, inspirada en la distribución visual de plataformas de juegos como Hollow Knight, pero manteniendo el estilo cartoon del proyecto). El entorno es oscuro, húmedo y lleno de vegetación espesa.',
      mechanics:
          'Nivel de tipo Runner de desplazamiento automático o de alta velocidad desde el punto A (el horno) al punto B (el muelle de San Blas). Exige reflejos y precisión milimétrica.',
      obstaclesAndEnemies:
          'El entorno interactivo es la principal amenaza. El jugador debe calcular saltos precisos sobre lianas sueltas y cocodrilos con las fauces abiertas que sirven como plataformas temporales, así como agacharse o deslizarse rápidamente por debajo de ramas bajas y raíces de mangle puntiagudas.',
      itemsAndClimax:
          'Hojas de plátano mágicas que otorgan un escudo de un solo golpe (para no perder el pan) y tazas de café de olla que otorgan multiplicadores de velocidad temporales.',
      locationZone: 'Manglares de La Tovara',
      icon: Icons.water_rounded,
      badgeColor: AppColors.mangroveGreen,
    ),
  ];

  static LevelItem? getByNumber(int number) {
    try {
      return levels.firstWhere((lvl) => lvl.number == number);
    } catch (_) {
      return null;
    }
  }

  static LevelItem? getPreviousLevel(int currentNumber) {
    return getByNumber(currentNumber - 1);
  }

  static LevelItem? getNextLevel(int currentNumber) {
    return getByNumber(currentNumber + 1);
  }
}
