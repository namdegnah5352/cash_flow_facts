import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../../domain/entities/transaction_journey.dart';

class NextPaymentScreen extends StatefulWidget {
  final Function callback;
  const NextPaymentScreen(this.callback, {super.key});

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
          GlobalNav.instance.transactionJourney.modelData.step1 = controller.text;
          await GlobalNav.instance.transactionJourney[TransactionEnum.step2.index](widget.callback);
        },
        enableButton: true,
        label: 'Continue',
      ),
      appBar: AppBar(title: const Text('Next Payment Date')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
