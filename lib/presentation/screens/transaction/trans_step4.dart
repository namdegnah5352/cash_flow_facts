import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep4 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep4(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep4> createState() => _TransStep4State();
}

class _TransStep4State extends State<TransStep4> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    String? data = GlobalNav.instance.transactionJourney.modelData.step4;
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
          globalNav.transactionJourney.modelData.step4 = controller.text;
          globalNav.setDashboardWidget(
            globalNav.transactionJourney[TransIndex.step5.index](widget.refreshDashboard, widget.account),
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
                  globalNav.transactionJourney[TransIndex.step3.index](widget.refreshDashboard, widget.account),
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
              Text('Gap between transactions', style: footerBig),
              const SizedBox(height: 50),
              textFormField(
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: focusNode,
                labelText: 'Time duration between transactions',
                validator: isRequired('You must select either no further transactions or the gap till the next one'),
                helperText: 'The amount of time before the next transaction',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
