import 'package:flutter/material.dart';
import 'package:open_banking_app/utils/app_colors.dart';

ButtonStyle buttonStyled(BuildContext context, {Color? background}) {
    return ElevatedButton.styleFrom(
      backgroundColor: background ?? Colors.white,
      foregroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      minimumSize: const Size(120, 40),
      padding: const EdgeInsets.symmetric(vertical: 12),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      elevation: 0.0,
    );
  }

  InputDecoration inputDecoration({
    required IconData icon,
    required String label,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.inputElements),
      label: Text(label, style: TextStyle(color: AppColors.inputElements)),
      filled: true,
      fillColor: AppColors.cardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.accentColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
      ),
    );
  }