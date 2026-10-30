import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/validation_utils.dart';
import '../../services/auth_service.dart';
import '../../widgets/odisea_button.dart';
import '../../widgets/odisea_logo_badge.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_isLoading) return; // Prevenir múltiples envíos por doble click
    FocusScope.of(context).unfocus(); // Ocultar teclado

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signUpWithEmail(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
      );
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
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
          'Nuevo Usuario',
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: OdiseaLogoBadge(size: 80)),
                  const SizedBox(height: 16),

                  Text(
                    'Crea tu Perfil',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Únete a la expedición y guarda tus secretos de horneado',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      color: AppColors.darkBrown.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Banner de error si falla Firebase
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

                  // Campo Nombre de usuario
                  Text(
                    'Nombre de usuario',
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.rubik(color: AppColors.darkBrown),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ_ ]')),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Ej. UlisesElValiente',
                      prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.darkBrown),
                    ),
                    validator: ValidationUtils.validateUsername,
                  ),
                  const SizedBox(height: 16),

                  // Campo Correo
                  Text(
                    'Correo electrónico',
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
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.rubik(color: AppColors.darkBrown),
                    inputFormatters: [
                      // No permitir espacios bajo ninguna circunstancia
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'panadero@ejemplo.com',
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.darkBrown),
                    ),
                    validator: ValidationUtils.validateEmail,
                  ),
                  const SizedBox(height: 16),

                  // Campo Contraseña
                  Text(
                    'Contraseña',
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.rubik(color: AppColors.darkBrown),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(32),
                      // Bloquear espacios en la contraseña
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Mínimo 6 caracteres (letras y números)',
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.darkBrown),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: AppColors.darkBrown.withValues(alpha: 0.6),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: ValidationUtils.validateSignUpPassword,
                  ),
                  const SizedBox(height: 16),

                  // Campo Confirmar Contraseña
                  Text(
                    'Confirmar contraseña',
                    style: GoogleFonts.rubik(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleSignUp(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: GoogleFonts.rubik(color: AppColors.darkBrown),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(32),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.darkBrown),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: AppColors.darkBrown.withValues(alpha: 0.6),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          });
                        },
                      ),
                    ),
                    validator: (val) => ValidationUtils.validateConfirmPassword(val, _passwordController.text),
                  ),
                  const SizedBox(height: 28),

                  // Botón Registrarse (Verde Manglar)
                  OdiseaButton(
                    text: 'Crear Cuenta',
                    icon: Icons.person_add_alt_1_rounded,
                    backgroundColor: AppColors.mangroveGreen,
                    textColor: AppColors.white,
                    isLoading: _isLoading,
                    onPressed: _handleSignUp,
                  ),
                  const SizedBox(height: 20),

                  // Enlace a Iniciar Sesión
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes cuenta? ',
                        style: GoogleFonts.rubik(
                          color: AppColors.darkBrown.withValues(alpha: 0.7),
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Inicia sesión',
                          style: GoogleFonts.rubik(
                            color: AppColors.darkBrown,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
