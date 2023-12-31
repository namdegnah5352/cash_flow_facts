import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/util/validators.dart';
import 'package:flutter/services.dart';
import '../config/navigation/global_nav.dart';
import '../../domain/calls/account_calls.dart';

class AccountScreen extends StatefulWidget {
  final Account account;
  const AccountScreen({required this.account, super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Account? useAccount;
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
    if (widget.account.id == AppConstants.createIDConstant) useAccount = Account.startUp();
    useAccount ??= widget.account;
    accountNameValidator = requiredAndLength(error: 'Name must contain at least 5 characters', length: 5);
    accountDescriptionValidator = requiredAndLength(error: 'Description must contain at least 2 characters', length: 2);
    _accountNameController = TextEditingController();
    _accountDescriptionController = TextEditingController();
    _accountBalanceController = TextEditingController();
    _usedInCashFlowController = TextEditingController();
    controllers.addAll([
      _accountNameController,
      _accountDescriptionController,
      _accountBalanceController,
      _usedInCashFlowController,
    ]);
    validators.addAll([accountNameValidator, accountDescriptionValidator]);
    formatters.addAll([null, null]);
    _accountNameController.text = useAccount!.accountName;
    _accountDescriptionController.text = useAccount!.description;
    _accountBalanceController.text = useAccount!.balance.toString();
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

  // void _shareAccount(BuildContext context) {
  //   showUsersDialog(context, widget.users).then((result) async {
  //     if (result != null) {
  //       Navigator.pop(context);
  //       GlobalNav.instance.accountLink!.linkShareAccount(widget.account, result);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text('Account'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          IconButton.filledTonal(
              icon: const Icon(Icons.arrow_back_outlined),
              selectedIcon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                loadAccounts();
              }),
          const Spacer(),
          IconButton.filledTonal(
            icon: const Icon(Icons.save_outlined),
            selectedIcon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                useAccount!.accountName = _accountNameController.text;
                useAccount!.description = _accountDescriptionController.text;
                useAccount!.balance = double.tryParse(_accountBalanceController.text)!;
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                formKey.currentState!.save();
                if (useAccount!.id == AppConstants.createIDConstant) {
                  GlobalNav.instance.accountLink!.linkCreateAccount(useAccount!);
                } else {
                  GlobalNav.instance.accountLink!.linkUpdateAccount(useAccount!);
                }
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                const SizedBox(height: 20),
                TextFormField(
                  key: Key(OtherFields.balance.key),
                  controller: _accountBalanceController,
                  inputFormatters: justNumberFormatter,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: OtherFields.balance.labelText,
                    hintText: OtherFields.balance.hintText,
                    helperText: OtherFields.balance.helperText,
                    border: const OutlineInputBorder(),
                  ),
                ),
                Switch(
                  key: Key(OtherFields.usedInCashFlow.key),
                  value: useAccount!.usedForCashFlow,
                  onChanged: (value) {
                    setState(() {
                      useAccount!.usedForCashFlow = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UserFields {
  name('accountNameKey', 'Account Name', 'enter account name', 'the name for this account'),
  description('accountDescriptionKey', 'Account Description', 'enter the description', 'description must contain at least 2 characters');

  const UserFields(this.key, this.labelText, this.hintText, this.helperText);
  final String key;
  final String labelText;
  final String hintText;
  final String helperText;
}

enum OtherFields {
  balance('accountBalanceKey', 'Account balance', 'enter your balance', 'the balance for this account'),
  usedInCashFlow('accountUsedInCashFlow', '', '', '');

  const OtherFields(this.key, this.labelText, this.hintText, this.helperText);
  final String key;
  final String labelText;
  final String hintText;
  final String helperText;
}
