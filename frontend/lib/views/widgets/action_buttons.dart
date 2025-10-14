import 'package:flutter/material.dart';
import 'package:open_banking_app/utils/app_colors.dart';
import 'package:open_banking_app/utils/button_styled.dart';
import 'operation_modal.dart';

class ActionButtons extends StatelessWidget {
  final String accountId;

  const ActionButtons({super.key, required this.accountId});

  void _openModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => OperationModal(type: type, accountId: accountId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _openModal(context, 'deposit'),
          icon: const Icon(Icons.arrow_downward, color: AppColors.accentColor),
          label: const Text(
            'Depositar',
            style: TextStyle(color: AppColors.accentColor),
          ),
          style: buttonStyled(context, background: AppColors.primaryColor),
        ),
        SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => _openModal(context, 'withdraw'),
          icon: const Icon(Icons.arrow_upward, color: AppColors.accentColor),
          label: const Text(
            'Sacar',
            style: TextStyle(color: AppColors.accentColor),
          ),
          style: buttonStyled(context, background: AppColors.primaryColor),
        ),
        SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: () => _openModal(context, 'transfer'),
          icon: const Icon(Icons.swap_horiz, color: AppColors.accentColor),
          label: const Text(
            'Transferir',
            style: TextStyle(color: AppColors.accentColor),
          ),
          style: buttonStyled(context, background: AppColors.primaryColor),
        ),
      ],
    );
  }
}
