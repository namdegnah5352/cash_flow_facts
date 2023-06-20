import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep20 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep20(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep20> createState() => _TransStep20State();
}

class _TransStep20State extends State<TransStep20> {
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    String? data = GlobalNav.instance.transactionJourney.modelData.step2;
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
          globalNav.setDashboardWidget(globalNav.transactionJourney[TransIndex.step3.index](widget.refreshDashboard, widget.account), NavIndex.transactions.index);
          widget.refreshDashboard();
        },
        enableButton: true,
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
                globalNav.setDashboardWidget(globalNav.transactionJourney[TransIndex.step1.index](widget.refreshDashboard, widget.account), NavIndex.transactions.index);
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
            Text('Step Two', style: footerBig),
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
