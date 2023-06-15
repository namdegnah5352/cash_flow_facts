import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/util/validators.dart';
import 'package:flutter/services.dart';
import '../config/navigation/global_nav.dart';

class AccountScreen extends StatefulWidget {
  final Account account;
  final List<User> users;
  const AccountScreen({required this.account, required this.users, super.key});

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
    controllers.addAll([
      _accountNameController,
      _accountDescriptionController,
      _accountBalanceController,
      _usedInCashFlowController,
    ]);
    validators.addAll([accountNameValidator, accountDescriptionValidator]);
    formatters.addAll([null, null]);
    _accountNameController.text = widget.account.accountName;
    _accountDescriptionController.text = widget.account.description;
    _accountBalanceController.text = widget.account.balance.toString();
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

  void _shareAccount(BuildContext context) {
    _showUsersDialog(context).then((result) async {
      if (result != null) {
        Navigator.pop(context);
        GlobalNav.instance.accountLink!.linkShareAccount(widget.account, result);
      }
    });
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
            icon: const Icon(Icons.share_outlined),
            selectedIcon: const Icon(Icons.share),
            onPressed: () => _shareAccount(context),
          ),
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
                  GlobalNav.instance.accountLink!.linkCreateAccount(widget.account);
                } else {
                  GlobalNav.instance.accountLink!.linkUpdateAccount(widget.account);
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
                value: widget.account.usedForCashFlow,
                onChanged: (value) {
                  setState(() {
                    widget.account.usedForCashFlow = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<User?> _showUsersDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Users Dialog'),
        contentPadding: const EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          side: const BorderSide(width: 2.0, color: Colors.grey),
        ),
        children: _convertUsers(context),
      ),
    );
  }

  List<Widget> _convertUsers(BuildContext context) {
    List<Widget> lsdo = [];
    int userId = GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!;
    for (User user in widget.users) {
      if (user.id != userId) {
        lsdo.add(Row(
          children: <Widget>[
            const SizedBox(width: 5),
            const SizedBox(width: 3),
            SimpleDialogOption(
              child: Text(user.name),
              onPressed: () => Navigator.pop<User>(context, user),
            ),
          ],
        ));
        lsdo.add(const Divider(thickness: 1));
      }
    }
    lsdo.removeLast();
    return lsdo;
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

enum OtherFields {
  balance('accountBalanceKey', 'Account balance', 'enter your balance', 'the balance for this account'),
  usedInCashFlow('accountUsedInCashFlow', '', '', '');

  const OtherFields(this.key, this.labelText, this.hintText, this.helperText);
  final String key;
  final String labelText;
  final String hintText;
  final String helperText;
}
