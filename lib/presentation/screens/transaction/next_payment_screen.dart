import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../../domain/entities/transaction_journey.dart';
import '../../config/enums.dart';
import '../../../domain/calls/transaction_calls.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';

GlobalNav globalNav = GlobalNav.instance;

class NextPaymentScreen extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const NextPaymentScreen(this.refreshDashboard, this.account, {super.key});

  @override
  State<NextPaymentScreen> createState() => _NextPaymentScreenState();
}

class _NextPaymentScreenState extends State<NextPaymentScreen> {
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
          globalNav.transactionJourney.modelData.step1 = controller.text;
          globalNav.setDashboardWidget(globalNav.transactionJourney[TransIndex.step2.index](widget.refreshDashboard, widget.account), NavIndex.transactions.index);
        },
        enableButton: true,
        label: 'Continue',
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Step One', style: footerBig),
            const SizedBox(height: 50),
            textFormField(
              controller: controller,
              editComplete: () {},
              onChanged: () {},
              thisNode: focusNode,
              labelText: 'Next Payment Date',
            ),
          ],
        ),
      ),
    );
  }
}
