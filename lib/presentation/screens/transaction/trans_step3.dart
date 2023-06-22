import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep3 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep3(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep3> createState() => _TransStep3State();
}

class _TransStep3State extends State<TransStep3> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    double data = GlobalNav.instance.transactionJourney.modelData.amount;
    controller.text = data.toString();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: simpleButton(
        bottomMargin: 20,
        sideMargin: 20,
        onTap: () async {
          final isValid = formKey.currentState!.validate();
          if (!isValid) return;
          formKey.currentState!.save();
          globalNav.transactionJourney.modelData.amount = double.tryParse(controller.text)!;
          globalNav.setDashboardWidget(
            globalNav.transactionJourney[TransIndex.step4.index](widget.refreshDashboard, widget.account),
            NavIndex.transactions.index,
          );
          widget.refreshDashboard();
        },
        enableButton: controller.text.isNotEmpty,
        label: 'Continue',
      ),
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              selectedIcon: const Icon(Icons.arrow_back),
              onPressed: () {
                globalNav.setDashboardWidget(
                  globalNav.transactionJourney[TransIndex.step2.index](widget.refreshDashboard, widget.account),
                  NavIndex.transactions.index,
                );
                widget.refreshDashboard();
              }),
          const Spacer(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Amount', style: getContextStyle(context)),
              const SizedBox(height: 50),
              textFormField(
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: focusNode,
                labelText: 'Amount of transaction',
                formatter: justNumberFormatter,
                validator: requiredAndLength(error: 'You must enter an amount to transfer', length: 1),
                helperText: 'The amount of money for this transaction',
                helperStyle: getContextHelperStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
