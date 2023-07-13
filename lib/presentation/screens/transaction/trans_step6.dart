import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/style/text_styles.dart';
import '../../../core/util/validators.dart';
import '../../../core/util/date_time_extension.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';
import '../../../domain/calls/transaction_calls.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransStep6 extends StatefulWidget {
  final Function refreshDashboard;
  final Account account;
  const TransStep6(this.refreshDashboard, this.account, {super.key});

  @override
  State<TransStep6> createState() => _TransStep6State();
}

class _TransStep6State extends State<TransStep6> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(DateTime.now().year + 25);
  @override
  void initState() {
    controller = TextEditingController();
    // see here if the object has any data
    DateTime? data = GlobalNav.instance.transactionJourney.modelData.endDate;
    if (data != null) {
      controller.text = formattedDate.format(data);
      selectedDate = data;
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
          globalNav.transactionJourney.modelData.endDate = convertFormattedDate(controller.text);
          createOrUpdate(globalNav, widget.account, widget.refreshDashboard);
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
                  globalNav.transactionJourney[TransIndex.step5.index](widget.refreshDashboard, widget.account),
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
              Text('End Date for these transactions', style: getContextStyle(context)),
              const SizedBox(height: 50),
              textFormField(
                readOnlyOption: true,
                controller: controller,
                editComplete: () {},
                onChanged: () {
                  setState(() {});
                },
                thisNode: focusNode,
                labelText: 'End date',
                validator: isRequired('You must select an end date'),
                helperText: 'When do these transactions end?',
                helperStyle: getContextHelperStyle(context),
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
                      globalNav.transactionJourney.modelData.endDate = selectedDate;
                    }
                  });
                },
                child: const Text('Choose End Date'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
