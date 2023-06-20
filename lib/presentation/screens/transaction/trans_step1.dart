import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/calls/transaction_calls.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep1 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep1(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep1> createState() => _TransStep1State();
}

class _TransStep1State extends State<TransStep1> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    String? data = GlobalNav.instance.transactionJourney.modelData.step1;
    if (data != null && data.isNotEmpty) {
      controller.text = data;
    }
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
          globalNav.transactionJourney.modelData.step1 = controller.text;
          globalNav.setDashboardWidget(
            globalNav.transactionJourney[TransIndex.step2.index](widget.refreshDashboard, widget.account),
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
                GlobalNav.instance.setDashboardWidget(returTransactionsScreen(widget.account, widget.refreshDashboard), NavIndex.transactions.index);
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
              Text('Transaction Title', style: footerBig),
              const SizedBox(height: 50),
              textFormField(
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: focusNode,
                labelText: 'Title',
                validator: requiredAndLength(error: 'Title must be at least 5 characters  ', length: 5),
                helperText: 'Title for this transaction',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
