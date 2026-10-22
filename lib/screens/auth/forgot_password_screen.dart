import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../services/auth_service.dart';
import '../../widgets/odisea_button.dart';
import '../../widgets/odisea_logo_badge.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  bool _emailSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.sendPasswordReset(email: _emailController.text);
      if (mounted) {
        setState(() {
          _emailSent = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: AppColors.topBarBeige,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.darkBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Recuperar Contraseña',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
            child: _emailSent ? _buildSuccessView() : _buildFormView(),
          ),
        ),
      ),
    );
  }

  // Vista de confirmación cuando el correo ya fue despachado
  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.mangroveGreen.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_rounded,
            color: AppColors.mangroveGreen,
            size: 42,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          '¡Enlace Enviado!',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Hemos enviado las instrucciones para restablecer tu contraseña al correo:',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            fontSize: 14,
            color: AppColors.darkBrown.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.doughBeige, width: 1.5),
          ),
          child: Text(
            _emailController.text.trim(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Revisa tu bandeja de entrada (o carpeta de spam) y sigue el enlace para definir tu nueva clave.',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            fontSize: 13,
            color: AppColors.darkBrown.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 32),
        OdiseaButton(
          text: 'Volver a Iniciar Sesión',
          icon: Icons.arrow_back_rounded,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  // Vista del formulario inicial para ingresar el correo
  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: OdiseaLogoBadge(size: 80)),
          const SizedBox(height: 20),
          Text(
            '¿Olvidaste tu Receta Secreta?',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ingresa tu correo registrado y te enviaremos un enlace seguro para restablecer tu contraseña.',
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              fontSize: 14,
              color: AppColors.darkBrown.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 28),

          // Banner de error si falla
          if (_errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: AppColors.errorRed, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: GoogleFonts.rubik(
                        fontSize: 13,
                        color: AppColors.errorRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],

          Text(
            'Correo electrónico registrado',
            style: GoogleFonts.rubik(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.rubik(color: AppColors.darkBrown),
            decoration: const InputDecoration(
              hintText: 'panadero@ejemplo.com',
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.darkBrown),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Ingresa tu correo registrado';
              }
              if (!val.contains('@') || !val.contains('.')) {
                return 'Ingresa un correo electrónico válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 26),

          OdiseaButton(
            text: 'Enviar Enlace de Recuperación',
            icon: Icons.send_rounded,
            isLoading: _isLoading,
            onPressed: _handleResetPassword,
          ),
          const SizedBox(height: 20),

          Center(
            child: TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.darkBrown),
              label: Text(
                'Regresar al Inicio de Sesión',
                style: GoogleFonts.rubik(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
