import 'package:flutter/material.dart';

/// Característica individual de un nivel (e.g. Tipo, Ingrediente final, Objetivo, Meta)
class LevelCharacteristic {
  final String label;
  final String value;
  final IconData icon;

  const LevelCharacteristic({
    required this.label,
    required this.value,
    required this.icon,
  });
}

/// Modelo de datos completo para un nivel del videojuego
class LevelItem {
  final int number;
  final String id;
  final String name;
  final String challenge;
  final List<LevelCharacteristic> characteristics;
  final String spatialDesign;
  final String mechanics;
  final String obstaclesAndEnemies;
  final String itemsAndClimax;
  final String locationZone;
  final IconData icon;
  final Color badgeColor;
  final String? imagePath;

  const LevelItem({
    required this.number,
    required this.id,
    required this.name,
    required this.challenge,
    required this.characteristics,
    required this.spatialDesign,
    required this.mechanics,
    required this.obstaclesAndEnemies,
    required this.itemsAndClimax,
    required this.locationZone,
    required this.icon,
    required this.badgeColor,
    this.imagePath,
  });

  String get displayName => 'Nivel $number';
  String get fullTitle => 'Nivel $number: $name';
}
