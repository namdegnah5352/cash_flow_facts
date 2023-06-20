import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';
import '../../../core/util/date_time_extension.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep2 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep2(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep2> createState() => _TransStep2State();
}

class _TransStep2State extends State<TransStep2> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 25);
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    String? data = GlobalNav.instance.transactionJourney.modelData.step2;
    if (data != null && data.isNotEmpty) {
      controller.text = data;
      selectedDate = convertFormattedDate(controller.text);
    }
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
          globalNav.transactionJourney.modelData.step2 = controller.text;
          globalNav.setDashboardWidget(
            globalNav.transactionJourney[TransIndex.step3.index](widget.refreshDashboard, widget.account),
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
                  globalNav.transactionJourney[TransIndex.step1.index](widget.refreshDashboard, widget.account),
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
              Text('Next Payment Date', style: footerBig),
              const SizedBox(height: 50),
              textFormField(
                readOnlyOption: true,
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: null,
                labelText: 'Payment Date',
                validator: isRequired('You must select a payment date'),
                helperText: 'The date for the next payment',
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: _firstDate,
                    lastDate: _lastDate,
                  );
                  setState(() {
                    selectedDate = date;
                    if (selectedDate != null) {
                      controller.text = formattedDate.format(date!);
                    }
                  });
                },
                child: const Text('Choose Date'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
