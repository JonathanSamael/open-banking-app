import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_banking_app/providers/transaction_provider.dart';

class OperationModal extends ConsumerStatefulWidget {
  final String type;
  final String accountId;

  const OperationModal({
    super.key,
    required this.type,
    required this.accountId,
  });

  @override
  ConsumerState<OperationModal> createState() => _OperationModalState();
}

class _OperationModalState extends ConsumerState<OperationModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _toAccountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isTransfer = widget.type == 'transfer';
    final label = switch (widget.type) {
      'deposit' => 'Depósito',
      'withdraw' => 'Saque',
      _ => 'Transferência',
    };

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 16,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                prefixText: 'R\$ ',
              ),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Informe um valor' : null,
            ),
            if (isTransfer)
              TextFormField(
                controller: _toAccountController,
                decoration: const InputDecoration(
                  labelText: 'Conta de destino',
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Informe o ID da conta destino'
                    : null,
              ),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;

                final amount = double.parse(_amountController.text);

                final body = {
                  'type': widget.type,
                  'amount': amount,
                  'fromAccountId': widget.accountId,
                  if (isTransfer) 'toAccountId': _toAccountController.text,
                };

                await ref
                    .read(transactionsProvider.notifier)
                    .createTransaction(
                      body: body
                    );

                if (mounted) Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
