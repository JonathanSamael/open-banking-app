class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Digite um email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value.trim()) ? null : 'Email inválido';
  }

  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) return 'Digite uma senha';

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasDigits = RegExp(r'[0-9]').hasMatch(value);
    final hasSpecialChar =
        RegExp(r'[!@#\$&*~%^()_+={}\[\]:;"\"<>,.?\\/-]').hasMatch(value);
    final hasMinLength = value.length >= 6;

    if (!hasUppercase) return 'A senha precisa de uma letra maiúscula';
    if (!hasDigits) return 'A senha precisa de ao menos um número';
    if (!hasSpecialChar) return 'A senha precisa de um caractere especial';
    if (!hasMinLength) return 'A senha precisa de no mínimo 7 caracteres';

    return null;
  }
}