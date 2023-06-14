import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/accounts/account.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/util/validators.dart';
import 'package:flutter/services.dart';
import '../config/navigation/global_nav.dart';

class AccountScreen extends StatefulWidget {
  final Account account;
  const AccountScreen({required this.account, super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final formKey = GlobalKey<FormState>();
  late final MultiValidator accountNameValidator;
  late final MultiValidator accountDescriptionValidator;
  List<TextEditingController> controllers = [];
  List<String? Function(String?)?> validators = [];
  List<List<TextInputFormatter>?> formatters = [];
  late final TextEditingController _accountNameController;
  late final TextEditingController _accountDescriptionController;
  late final TextEditingController _accountBalanceController;
  late final TextEditingController _usedInCashFlowController;
  @override
  void initState() {
    accountNameValidator = requiredAndLength(error: 'Name must contain at least 5 characters', length: 5);
    accountDescriptionValidator = requiredAndLength(error: 'Description must contain at least 2 characters', length: 2);
    _accountNameController = TextEditingController();
    _accountDescriptionController = TextEditingController();
    _accountBalanceController = TextEditingController();
    _usedInCashFlowController = TextEditingController();
    validators.addAll([accountNameValidator, accountDescriptionValidator]);
    formatters.addAll([null, null]);
    super.initState();
  }

  @override
  void dispose() {
    _accountBalanceController.dispose();
    _accountDescriptionController.dispose();
    _accountNameController.dispose();
    _usedInCashFlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          IconButton.filledTonal(
            icon: const Icon(Icons.save_outlined),
            selectedIcon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                widget.account.accountName = _accountNameController.text;
                widget.account.description = _accountDescriptionController.text;
                widget.account.balance = double.tryParse(_accountBalanceController.text)!;
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                formKey.currentState!.save();
                if (widget.account.id == AppConstants.createIDConstant) {
                  // GlobalNav.instance.userLink!.linkCreateUser(widget.user);
                } else {
                  // GlobalNav.instance.userLink!.linkUpdateUser(widget.user);
                }
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ...UserFields.values.map((userField) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      key: Key(userField.key),
                      controller: controllers[userField.index],
                      validator: validators[userField.index],
                      inputFormatters: formatters[userField.index] ?? justLength36,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: userField.labelText,
                        hintText: userField.hintText,
                        helperText: userField.helperText,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),

              // balance needs numeric keyboard
              // in cash flow, material
            ],
          ),
        ),
      ),
    );
  }
}

enum UserFields {
  name('accountNameKey', 'Account Name', 'enter account name', 'the name for this account'),
  description(
      'accountDescriptionKey', 'Account Description', 'enter the description', 'description must contain at least 2 characters');

  const UserFields(this.key, this.labelText, this.hintText, this.helperText);
  final String key;
  final String labelText;
  final String hintText;
  final String helperText;
}
