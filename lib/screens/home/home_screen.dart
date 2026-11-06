import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          DashboardTab(onNavigateToTab: (index) => setState(() => _currentIndex = index)),
          CharactersTab(onBack: () => setState(() => _currentIndex = 0)),
          MapTab(onBack: () => setState(() => _currentIndex = 0)),
          const ProfileTab(),
        ],
      ),
      // BARRA DE NAVEGACIÓN INFERIOR (Propuesta B: Inicio, Personajes, Mapa, Perfil)
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
          onTap: (index) => setState(() => _currentIndex = index),
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
    );
  }
}
