class ValidationUtils {
  // Regex estándar para validación estricta de correo electrónico
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
  );

  // Regex para nombre de usuario: letras (con acentos/ñ), números y espacios simples intermedios (sin emojis ni símbolos)
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]+(?: [a-zA-Z0-9áéíóúÁÉÍÓÚñÑ]+)*$',
  );

  // Validador de Nombre de Usuario
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre de usuario es obligatorio';
    }
    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Debe tener al menos 3 caracteres';
    }
    if (trimmed.length > 25) {
      return 'No puede superar los 25 caracteres';
    }
    if (value.startsWith(' ') || value.endsWith(' ')) {
      return 'No debe iniciar ni terminar con espacios';
    }
    if (value.contains('  ')) {
      return 'No debe contener espacios dobles consecutivos';
    }
    if (!_usernameRegExp.hasMatch(trimmed)) {
      return 'Solo letras, números y espacios simples (sin emojis ni símbolos)';
    }
    return null;
  }

  // Validador de Correo Electrónico
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo electrónico es obligatorio';
    }
    final trimmed = value.trim();
    if (trimmed.contains(' ')) {
      return 'El correo no puede contener espacios';
    }
    if (!_emailRegExp.hasMatch(trimmed)) {
      return 'Ingresa un formato de correo válido';
    }
    return null;
  }

  // Validador de Contraseña en Registro (Más estricto)
  static String? validateSignUpPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    if (value.trim().isEmpty) {
      return 'La contraseña no puede consistir solo de espacios';
    }
    if (value.contains(' ')) {
      return 'La contraseña no puede contener espacios';
    }
    if (value.length < 6) {
      return 'Mínimo 6 caracteres';
    }
    if (value.length > 32) {
      return 'Máximo 32 caracteres';
    }
    // Verificar que contenga al menos una letra y un número
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(value);
    final hasDigit = RegExp(r'[0-9]').hasMatch(value);
    if (!hasLetter || !hasDigit) {
      return 'Debe contener al menos una letra y un número';
    }
    return null;
  }

  // Validador de Contraseña en Login
  static String? validateSignInPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu contraseña';
    }
    if (value.trim().isEmpty) {
      return 'Ingresa una contraseña válida';
    }
    if (value.length < 6) {
      return 'Mínimo 6 caracteres';
    }
    return null;
  }

  // Validador de Confirmación de Contraseña
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }
    if (value != originalPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
