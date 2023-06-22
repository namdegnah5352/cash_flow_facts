import 'package:cash_flow_facts/presentation/config/enums.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/calls/account_calls.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/style/app_colors.dart';
import 'package:intl/intl.dart';
import '../../../domain/calls/transaction_calls.dart';
import 'package:cash_flow_facts/presentation/config/constants.dart';

class AccountListTile extends StatelessWidget {
  final Account account;
  final Function listCallback;
  final int selectedAccountId;
  final Function rebuildDashboard;
  const AccountListTile({
    required this.account,
    required this.listCallback,
    required this.selectedAccountId,
    required this.rebuildDashboard,
    super.key,
  });

  Widget _getCirclePricedCurrency() {
    var numb;

    if (account.balance < 1000) {
      numb = NumberFormat.currency(symbol: '£', decimalDigits: 2);
    } else {
      numb = NumberFormat.currency(symbol: '£', decimalDigits: 0);
    }
    return CircleAvatar(
      backgroundColor: cltx,
      maxRadius: 25,
      minRadius: 20,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          numb.format(account.balance),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            listCallback(account.id);
            // I think this is built by clicking on the dashboard bottom navigation bar - transaction
            GlobalNav.instance.setDashboardWidget(returnTransactionsScreen(account, rebuildDashboard), NavIndex.transactions.index);
          },
          tileColor: selectedAccountId == account.id ? Theme.of(context).colorScheme.onSurfaceVariant : Theme.of(context).colorScheme.surfaceVariant,
          leading: _getCirclePricedCurrency(),
          title: Text(account.accountName),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(context);
                    navigateToExistingAccount(account);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pop(context);
                    GlobalNav.instance.accountLink!.linkDeleteAccount(account);
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 2, thickness: 2)
      ],
    );
  }
}
