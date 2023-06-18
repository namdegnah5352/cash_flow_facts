import 'package:flutter/material.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/calls/transaction_calls.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/style/app_colors.dart';
import 'package:intl/intl.dart';

class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  // String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
  const TransactionListTile(this.transaction, {super.key});

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
                    Navigator.pop(context);
                    GlobalNav.instance.transactionLink!.linkDeleteTransaction(transaction);
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
