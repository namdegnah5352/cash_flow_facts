import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/util/validators.dart';
import 'package:flutter/services.dart';
import '../config/navigation/global_nav.dart';

class UserScreen extends StatefulWidget {
  final User user;
  const UserScreen({required this.user, super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [];
  List<String? Function(String?)?> validators = [];
  List<List<TextInputFormatter>?> formatters = [];
  List<bool> obscure = List.filled(UserFields.values.length, false);
  late final MultiValidator userNameValidator;
  late final MultiValidator userEmailValidator;
  late final MultiValidator userPasswordValidator;
  late final TextEditingController _userNameController;
  late final TextEditingController _userEmailController;
  late final TextEditingController _userPasswordController;
  late final TextEditingController _userPasswordCheckController;
  @override
  void initState() {
    userNameValidator = requiredAndLength(error: 'Name must contain at least 5 characters', length: 5);
    userEmailValidator = emailValidator;
    userPasswordValidator = passwordValidator;
    controllers.addAll([
      _userNameController = TextEditingController(),
      _userEmailController = TextEditingController(),
      _userPasswordController = TextEditingController(),
      _userPasswordCheckController = TextEditingController(),
    ]);
    validators.addAll([
      userNameValidator,
      userEmailValidator,
      userPasswordValidator,
      (value) => value! != _userPasswordController.text ? 'Passwords must match' : null,
    ]);
    formatters.addAll([nameFormatter, null, null, null]);
    obscure[UserFields.password.index] = obscure[UserFields.passwordCheck.index] = true;
    _userNameController.text = widget.user.name;
    _userEmailController.text = widget.user.email;
    _userPasswordController.text = widget.user.password;
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordCheckController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          IconButton.filledTonal(
            icon: const Icon(Icons.save_outlined),
            selectedIcon: const Icon(Icons.save),
            onPressed: () {
              setState(() {
                widget.user.name = _userNameController.text;
                widget.user.email = _userEmailController.text;
                widget.user.password = _userPasswordController.text;
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                formKey.currentState!.save();
                if (widget.user.id == AppConstants.createIDConstant) {
                  GlobalNav.instance.userLink!.linkCreateUser(widget.user);
                } else {
                  GlobalNav.instance.userLink!.linkUpdateUser(widget.user);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              ...UserFields.values.map((userField) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      key: Key(userField.key),
                      controller: controllers[userField.index],
                      validator: validators[userField.index],
                      inputFormatters: formatters[userField.index] ?? justLength36,
                      obscureText: obscure[userField.index],
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

enum UserFields {
  name('userNameKey', 'User Name', 'enter user name', 'each user can have many accounts'),
  email('userEmailKey', 'User Email', 'enter user email', 'email must contain @ and . characters'),
  password('userPasswordKey', 'User Password', 'enter user password', 'password must have capital, number and 8 to 16 chrs'),
  passwordCheck('userPasswordCheckKey', 'Password Check', 'enter password again', 'passwords must match');

  const UserFields(this.key, this.labelText, this.hintText, this.helperText);
  final String key;
  final String labelText;
  final String hintText;
  final String helperText;
}
