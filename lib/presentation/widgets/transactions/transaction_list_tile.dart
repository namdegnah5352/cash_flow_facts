import 'package:flutter/material.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/calls/transaction_calls.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/style/app_colors.dart';
import 'package:intl/intl.dart';
import '../../config/enums.dart';
import '../../../domain/entities/accounts/account.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  final Function rebuildDashboard;
  final Account account;
  const TransactionListTile(this.transaction, this.rebuildDashboard, this.account, {super.key});

  Widget _getCirclePricedCurrency() {
    var numb;

    if (transaction.amount < 1000) {
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
          numb.format(
            transaction.amount,
          ),
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
          leading: _getCirclePricedCurrency(),
          title: Text(transaction.title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(context);
                    navigateToExistingTransaction(transaction);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    GlobalNav.instance.transactionLink!.deleteTransaction(transaction).then((_) {
                      rebuildDashboard();
                    });
                    globalNav.setDashboardWidget(returnTransactionsScreen(account, rebuildDashboard), NavIndex.transactions.index);
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
        )
      ],
    );
  }
}
