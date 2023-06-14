import 'package:flutter/material.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../../domain/usecases/calls.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/style/app_colors.dart';
import '../../config/constants.dart';
import 'package:intl/intl.dart';
import '../../link/accounts/account_link.dart';

class AccountListTile extends StatelessWidget {
  final Account account;
  // String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);
  const AccountListTile(this.account, {super.key});

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
          numb.format(
            account.balance,
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
          title: Text(account.accountName),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(context);
                    navigateToExistingAccount(account);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pop(context);
                    GlobalNav.instance.accountLink!.linkDeleteAccount(account);
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
