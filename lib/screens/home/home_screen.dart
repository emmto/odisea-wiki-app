import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/characters_tab.dart';
import 'tabs/map_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _dashboardNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 1. Si el navegador de Inicio tiene sub-pantallas (Historia, Niveles, Receta...), retroceder allí:
        if (_currentIndex == 0 &&
            _dashboardNavigatorKey.currentState?.canPop() == true) {
          _dashboardNavigatorKey.currentState?.pop();
          return;
        }

        // 2. Si estamos en otra pestaña (Personajes, Mapa, Perfil), regresar a Inicio:
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return;
        }

        // 3. Si ya estamos en la raíz de Inicio, salir de la app:
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundCream,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            // Pestaña 0: Inicio con su propio Navigator interno para mantener la barra inferior visible siempre
            Navigator(
              key: _dashboardNavigatorKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => DashboardTab(
                    onNavigateToTab: (index) =>
                        setState(() => _currentIndex = index),
                  ),
                );
              },
            ),
            CharactersTab(onBack: () => setState(() => _currentIndex = 0)),
            MapTab(onBack: () => setState(() => _currentIndex = 0)),
            const ProfileTab(),
          ],
        ),
        // BARRA DE NAVEGACIÓN INFERIOR (Visible permanentemente en toda la app)
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.topBarBeige,
            border: const Border(
              top: BorderSide(color: AppColors.darkBrown, width: 1.5),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkBrown.withValues(alpha: 0.08),
                offset: const Offset(0, -3),
                blurRadius: 8,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index == _currentIndex && index == 0) {
                // Si toca "Inicio" cuando ya está en Inicio, regresar al Dashboard principal
                _dashboardNavigatorKey.currentState
                    ?.popUntil((route) => route.isFirst);
              } else {
                setState(() => _currentIndex = index);
              }
            },
            backgroundColor: AppColors.topBarBeige,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: AppColors.darkBrown,
            unselectedItemColor: AppColors.darkBrown.withValues(alpha: 0.45),
            selectedLabelStyle: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                activeIcon: Icon(Icons.groups_rounded),
                label: 'Personajes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map_rounded),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
