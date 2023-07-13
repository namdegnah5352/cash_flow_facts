import 'package:cash_flow_facts/domain/calls/transaction_calls.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/entities/recurrence.dart';
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
  SaveContinue saveOrContinue = SaveContinue.toSave;
  final formKey = GlobalKey<FormState>();
  OngoingEnd ongoingEnd = OngoingEnd.ongoing;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // To Do if end date set then default to this
    DateTime? data = GlobalNav.instance.transactionJourney.modelData.endDate;
    if (data != null) {
      saveOrContinue = SaveContinue.toContinue;
      ongoingEnd = OngoingEnd.endDate;
    }
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: switch (saveOrContinue) {
        SaveContinue.toSave => getSaveButton(formKey: formKey, refreshDashboard: widget.refreshDashboard, account: widget.account, globalNav: globalNav, enableOverride: true),
        SaveContinue.toContinue => getContinueButton(formKey: formKey, refreshDashboard: widget.refreshDashboard, account: widget.account, enableOverride: true, nextPage: TransIndex.step6),
      },
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
              Text('Ongoing or End Date', style: getContextStyle(context)),
              const SizedBox(height: 10),
              Text(
                'Does this transaction have a finish date or is it ongoing?',
                style: smallPrimary(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              SegmentedButton<OngoingEnd>(
                segments: const [
                  ButtonSegment<OngoingEnd>(
                    value: OngoingEnd.ongoing,
                    label: Text('Ongoing'),
                    icon: Icon(Icons.event_repeat),
                  ),
                  ButtonSegment<OngoingEnd>(
                    value: OngoingEnd.endDate,
                    label: Text('End Date'),
                    icon: Icon(Icons.edit_calendar),
                  ),
                ],
                selected: <OngoingEnd>{ongoingEnd},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    ongoingEnd = newSelection.first;
                    saveOrContinue = switch (ongoingEnd) {
                      OngoingEnd.ongoing => SaveContinue.toSave,
                      OngoingEnd.endDate => SaveContinue.toContinue,
                    };
                    if (ongoingEnd == OngoingEnd.ongoing) globalNav.transactionJourney.modelData.endDate = null;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
