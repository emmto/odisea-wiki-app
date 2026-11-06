import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verify all 17 storyboard assets exist and can be loaded from bundle',
      () async {
    final prologoAssets = [
      for (int i = 1; i <= 8; i++)
        'assets/images/Historieta/Prologo/Prologo_$i.jpg',
    ];

    final mercadoAssets = [
      for (int i = 1; i <= 6; i++)
        'assets/images/Historieta/Acto I_ Mercado/mercado_$i.jpg',
    ];

    final salidaAssets = [
      for (int i = 1; i <= 3; i++)
        'assets/images/Historieta/Mercado Salida/MercadoSalida_$i.jpg',
    ];

    final allAssets = [...prologoAssets, ...mercadoAssets, ...salidaAssets];
    expect(allAssets.length, 17);

    for (final path in allAssets) {
      final byteData = await rootBundle.load(path);
      expect(byteData.lengthInBytes, greaterThan(1000),
          reason: 'Asset should exist: $path');
    }
  });
}
