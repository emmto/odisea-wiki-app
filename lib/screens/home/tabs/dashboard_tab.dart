import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/odisea_action_card.dart';

class DashboardTab extends StatelessWidget {
  final Function(int) onNavigateToTab;

  const DashboardTab({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. TOP BAR GRANDE Y DESTACADA (Respetando el notch y barra de estado)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: topPadding + 16, // Margen dinámico que empuja el texto abajo de la barra de notificaciones
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: AppColors.topBarBeige,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'La Odisea del Pan de\nPlátano',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkBrown,
                    height: 1.15,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkBrown.withValues(alpha: 0.15),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    'Wiki',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkBrown,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. CONTENIDO PRINCIPAL: 5 TARJETAS DE ACCIÓN LIMPIAS (Fondo liso Crema)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
            child: Column(
              children: [
                // Tarjeta 1: Ver Historia
                OdiseaActionCard(
                  title: 'Ver Historia',
                  subtitle: 'Resumen de la aventura, objetivos de la odisea y cronología principal',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Abriendo Historia y Cronología...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                // Tarjeta 2: Personajes (Navega a la Pestaña 1 de Personajes)
                OdiseaActionCard(
                  title: 'Personajes',
                  subtitle: 'Fichas técnicas, estadísticas y relaciones de Ulises y aliados',
                  onTap: () => onNavigateToTab(1),
                ),

                // Tarjeta 3: Storyboard
                OdiseaActionCard(
                  title: 'Storyboard',
                  subtitle: 'Bocetos de escenas, guiones gráficos y flujo de cinemáticas',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bocetos de escenas en preparación...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                // Tarjeta 4: Receta del Pan de Plátano
                OdiseaActionCard(
                  title: 'Receta del Pan de Plátano',
                  subtitle: 'Ingredientes, pasos y secretos de repostería',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Consultando Receta Secreta...'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),

                // Tarjeta 5: Mapa (Navega a la Pestaña 2 del Mapa)
                OdiseaActionCard(
                  title: 'Mapa',
                  subtitle: 'Mapa interactivo. Aprende del mundo que te rodea',
                  onTap: () => onNavigateToTab(2),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
