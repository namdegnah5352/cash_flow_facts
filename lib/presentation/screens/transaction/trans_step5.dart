import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep5 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep5(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep5> createState() => _TransStep5State();
}

class _TransStep5State extends State<TransStep5> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    String? data = GlobalNav.instance.transactionJourney.modelData.step5;
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
          globalNav.transactionJourney.modelData.step5 = controller.text;
          // this becomes the save and back to transaction list
          // globalNav.setDashboardWidget(
          //   globalNav.transactionJourney[TransIndex.step5.index](widget.refreshDashboard, widget.account),
          //   NavIndex.transactions.index,
          // );
          widget.refreshDashboard();
        },
        enableButton: controller.text.isNotEmpty,
        label: 'Save',
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
                  globalNav.transactionJourney[TransIndex.step4.index](widget.refreshDashboard, widget.account),
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
              Text('End Date for these transactions', style: footerBig),
              const SizedBox(height: 50),
              textFormField(
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: focusNode,
                labelText: 'Either ongoing or and end date',
                validator: isRequired('You must select either ongoing or an end date'),
                helperText: 'When do these transactions end?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
