import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/auth_service.dart';
import '../../../widgets/odisea_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _authService = AuthService();

  void _showChangeNameDialog() {
    final controller = TextEditingController(text: _authService.currentUser?.displayName ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBrown, width: 2),
        ),
        title: Text(
          'Cambiar Nombre',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppColors.darkBrown),
        ),
        content: TextField(
          controller: controller,
          style: GoogleFonts.rubik(color: AppColors.darkBrown),
          decoration: const InputDecoration(hintText: 'Nuevo nombre de aventurero'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: AppColors.darkBrown)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryYellow,
              foregroundColor: AppColors.darkBrown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppColors.darkBrown, width: 1.5),
              ),
            ),
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await _authService.currentUser?.updateDisplayName(newName);
                if (!mounted) return;
                setState(() {});
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nombre actualizado con éxito')),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final email = _authService.currentUser?.email;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBrown, width: 2),
        ),
        title: Text(
          'Cambiar Contraseña',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppColors.darkBrown),
        ),
        content: Text(
          'Te enviaremos un correo a "$email" con un enlace seguro para restablecer tu contraseña.',
          style: GoogleFonts.rubik(fontSize: 14, color: AppColors.darkBrown),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: AppColors.darkBrown)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mangroveGreen,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              if (email != null) {
                await _authService.sendPasswordReset(email: email);
                if (!mounted) return;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enlace enviado a tu correo')),
                );
              }
            },
            child: const Text('Enviar Correo'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final displayName = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : (user?.email?.split('@').first ?? 'Aventurero');

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: AppColors.topBarBeige,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mi Perfil',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            // Avatar con botón de cámara
            Stack(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.doughBeige,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkBrown, width: 2.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkBrown.withValues(alpha: 0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.person_rounded, size: 54, color: AppColors.darkBrown),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selector de foto de perfil activado')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.primaryYellow,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.darkBrown, width: 1.5),
                      ),
                      child: const Icon(Icons.camera_alt_rounded, size: 16, color: AppColors.darkBrown),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Text(
              displayName,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              user?.email ?? '',
              style: GoogleFonts.rubik(
                fontSize: 13,
                color: AppColors.darkBrown.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 24),

            // Acciones obligatorias por rúbrica
            _buildActionTile(
              title: 'Cambiar nombre',
              icon: Icons.badge_outlined,
              onTap: _showChangeNameDialog,
            ),
            _buildActionTile(
              title: 'Cambiar contraseña',
              icon: Icons.key_outlined,
              onTap: _showChangePasswordDialog,
            ),
            _buildActionTile(
              title: 'Subir foto de perfil',
              icon: Icons.image_outlined,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Selector de imágenes activo')),
                );
              },
            ),

            const SizedBox(height: 24),

            // Botón Cerrar Sesión
            OdiseaButton(
              text: 'Cerrar Sesión',
              icon: Icons.logout_rounded,
              backgroundColor: AppColors.white,
              textColor: AppColors.errorRed,
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.backgroundCream,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.darkBrown, width: 2),
                    ),
                    title: Text('¿Cerrar sesión?', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancelar', style: TextStyle(color: AppColors.darkBrown)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Salir', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await _authService.signOut();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.doughBeige, width: 1.5),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.doughBeige.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.darkBrown, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkBrown),
        onTap: onTap,
      ),
    );
  }
}
