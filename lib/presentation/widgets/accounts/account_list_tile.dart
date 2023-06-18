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
  final Function dashboardCallback;
  final int selectedAccountId;
  const AccountListTile({
    required this.account,
    required this.listCallback,
    required this.dashboardCallback,
    required this.selectedAccountId,
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
            dashboardCallback(returTransactionsScreen(account), NavIndex.transactions.index);
            // toggle thme selected colour, by running the function from the account_list.dart
            // this loads the transaction page
            // use the dashboardCallback to load the transactionsList into NavIndex.transactions.index
          },
          tileColor: selectedAccountId == account.id ? Colors.black12 : Colors.white,
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
