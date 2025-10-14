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