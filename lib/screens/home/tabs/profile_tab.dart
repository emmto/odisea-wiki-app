import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  final _imagePicker = ImagePicker();

  bool _isUploadingPhoto = false;
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _photoUrl = _authService.currentUser?.photoURL;
    _fetchFirestoreProfileData();
  }

  Future<void> _fetchFirestoreProfileData() async {
    // 1. Carga inmediata directa desde Firestore
    final directUrl = await _authService.getUserPhotoUrl();
    if (directUrl != null && mounted) {
      setState(() {
        _photoUrl = directUrl;
      });
    }

    // 2. Escucha reactiva en tiempo real de cambios
    final stream = _authService.userDocStream;
    if (stream != null) {
      stream.listen(
        (snapshot) {
          if (snapshot.exists && mounted) {
            final data = snapshot.data();
            if (data != null && data['photoUrl'] != null) {
              setState(() {
                _photoUrl = data['photoUrl'] as String?;
              });
            }
          }
        },
        onError: (e) {
          // Si hay algún problema de red, mantener el valor actual
        },
      );
    }
  }

  // Selector de foto: Cámara, Galería o Avatares del juego
  void _showPhotoOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundCream,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        side: BorderSide(color: AppColors.darkBrown, width: 2),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.darkBrown.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  'Foto de Perfil',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Elige cómo quieres que te vean los demás panaderos:',
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                    color: AppColors.darkBrown.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 18),
                ListTile(
                  leading: _buildModalIcon(Icons.camera_alt_rounded),
                  title: Text(
                    'Tomar foto con la cámara',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.darkBrown),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickAndUploadImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: _buildModalIcon(Icons.photo_library_rounded),
                  title: Text(
                    'Elegir de la galería',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.darkBrown),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickAndUploadImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: _buildModalIcon(Icons.sports_esports_rounded),
                  title: Text(
                    'Elegir avatar del videojuego',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.darkBrown),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showGameAvatarsDialog();
                  },
                ),
                if (_photoUrl != null && _photoUrl!.isNotEmpty)
                  ListTile(
                    leading: _buildModalIcon(Icons.delete_outline_rounded, isDestructive: true),
                    title: Text(
                      'Eliminar foto actual',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: AppColors.errorRed),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      _removePhoto();
                    },
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalIcon(IconData icon, {bool isDestructive = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isDestructive
            ? AppColors.errorRed.withValues(alpha: 0.1)
            : AppColors.primaryYellow.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: isDestructive ? AppColors.errorRed : AppColors.darkBrown,
        size: 22,
      ),
    );
  }

  // Tomar y subir imagen a Firebase
  Future<void> _pickAndUploadImage(ImageSource source) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 256,
        maxHeight: 256,
        imageQuality: 70,
      );

      if (picked == null) return;

      setState(() => _isUploadingPhoto = true);

      final newUrl = await _authService.updateProfilePhoto(picked);

      if (mounted) {
        setState(() {
          _photoUrl = newUrl;
          _isUploadingPhoto = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Foto de perfil actualizada y guardada en Firebase!'),
            backgroundColor: AppColors.mangroveGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploadingPhoto = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar la foto: $e'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  // Selector de avatares temáticos
  void _showGameAvatarsDialog() {
    final avatars = [
      {'id': 'hogaza', 'name': 'Hogaza Dorada', 'icon': Icons.bakery_dining_rounded, 'color': AppColors.primaryYellow},
      {'id': 'ulises', 'name': 'Ulises (Héroe)', 'icon': Icons.person_rounded, 'color': AppColors.mangroveGreen},
      {'id': 'don_lope', 'name': 'Don Lope (Hornero)', 'icon': Icons.fireplace_rounded, 'color': AppColors.darkBrown},
      {'id': 'circe', 'name': 'Madame Circe', 'icon': Icons.science_rounded, 'color': const Color(0xFF8E24AA)},
      {'id': 'polifemo', 'name': 'Polifemo (Gigante)', 'icon': Icons.sports_mma_rounded, 'color': const Color(0xFFD84315)},
    ];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBrown, width: 2),
        ),
        title: Text(
          'Avatares de La Odisea',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppColors.darkBrown),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: avatars.length,
            itemBuilder: (context, index) {
              final a = avatars[index];
              return InkWell(
                onTap: () async {
                  Navigator.pop(ctx);
                  setState(() => _isUploadingPhoto = true);
                  await _authService.updateGameAvatar(a['id'] as String);
                  if (mounted) {
                    setState(() {
                      _photoUrl = 'avatar:${a['id']}';
                      _isUploadingPhoto = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Avatar asignado: ${a['name']}'),
                        backgroundColor: AppColors.mangroveGreen,
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkBrown, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: (a['color'] as Color).withValues(alpha: 0.2),
                        child: Icon(a['icon'] as IconData, color: a['color'] as Color, size: 24),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        a['name'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.darkBrown),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Eliminar foto
  Future<void> _removePhoto() async {
    setState(() => _isUploadingPhoto = true);
    await _authService.removeProfilePhoto();
    if (mounted) {
      setState(() {
        _photoUrl = null;
        _isUploadingPhoto = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto de perfil eliminada')),
      );
    }
  }

  // Renderizado dinámico del avatar según el origen (Storage, Base64, Avatar o Default)
  Widget _buildAvatarContent() {
    if (_isUploadingPhoto) {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryYellow),
          ),
        ),
      );
    }

    final photo = _photoUrl;
    if (photo == null || photo.isEmpty) {
      return const Center(
        child: Icon(Icons.person_rounded, size: 54, color: AppColors.darkBrown),
      );
    }

    // 1. Avatar temático del videojuego
    if (photo.startsWith('avatar:')) {
      final id = photo.replaceFirst('avatar:', '');
      IconData icon = Icons.person_rounded;
      Color color = AppColors.primaryYellow;
      if (id == 'hogaza') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: Image.asset('assets/images/logo.png', width: 96, height: 96, fit: BoxFit.cover),
        );
      } else if (id == 'ulises') {
        icon = Icons.person_rounded;
        color = AppColors.mangroveGreen;
      } else if (id == 'don_lope') {
        icon = Icons.fireplace_rounded;
        color = AppColors.darkBrown;
      } else if (id == 'circe') {
        icon = Icons.science_rounded;
        color = const Color(0xFF8E24AA);
      } else if (id == 'polifemo') {
        icon = Icons.sports_mma_rounded;
        color = const Color(0xFFD84315);
      }
      return Center(child: Icon(icon, size: 50, color: color));
    }

    // 2. Base64 (respaldo directo en Firestore)
    if (photo.startsWith('data:image')) {
      try {
        final base64Str = photo.split(',').last;
        final bytes = base64Decode(base64Str);
        return ClipRRect(
          borderRadius: BorderRadius.circular(48),
          child: Image.memory(bytes, width: 96, height: 96, fit: BoxFit.cover),
        );
      } catch (_) {}
    }

    // 3. URL de Firebase Storage
    if (photo.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(48),
        child: Image.network(
          photo,
          width: 96,
          height: 96,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.primaryYellow),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.person_rounded, size: 54, color: AppColors.darkBrown),
            );
          },
        ),
      );
    }

    return const Center(
      child: Icon(Icons.person_rounded, size: 54, color: AppColors.darkBrown),
    );
  }

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
            // Avatar con botón de cámara y actualización en vivo
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
                  child: _buildAvatarContent(),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _showPhotoOptionsBottomSheet,
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
              subtitle: 'Actualiza tu nombre de aventurero',
              icon: Icons.badge_outlined,
              onTap: _showChangeNameDialog,
            ),
            _buildActionTile(
              title: 'Cambiar contraseña',
              subtitle: 'Actualiza la clave secreta de tu cuenta',
              icon: Icons.key_outlined,
              onTap: _showChangePasswordDialog,
            ),
            _buildActionTile(
              title: 'Subir foto de perfil',
              subtitle: 'Cámara, galería o avatares de la Odisea',
              icon: Icons.image_outlined,
              onTap: _showPhotoOptionsBottomSheet,
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
                    content: const Text('Tendrás que volver a autenticarte para ingresar a la cocina.'),
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
    required String subtitle,
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
        subtitle: Text(
          subtitle,
          style: GoogleFonts.rubik(
            fontSize: 12,
            color: AppColors.darkBrown.withValues(alpha: 0.6),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkBrown),
        onTap: onTap,
      ),
    );
  }
}
