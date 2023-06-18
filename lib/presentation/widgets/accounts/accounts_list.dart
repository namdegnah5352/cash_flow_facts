import 'package:flutter/material.dart';
import '../../../domain/calls/account_calls.dart';
import '../../../domain/entities/accounts/account.dart';
import 'account_list_tile.dart';

class AccountList extends StatelessWidget {
  final List<Account> accounts;
  final Function callback;
  const AccountList(this.accounts, this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: null,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: Colors.black26),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () async {
                    showAccountTypeDialog(context).then(
                      (result) {
                        if (result != null) {
                          callback(result.loadThis);
                        }
                      },
                    );
                  }),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Bank Accounts',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/strongboxA.png'),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return AccountListTile(accounts[index]);
              },
              childCount: accounts.length,
            ),
          ),
        ],
      ),
    );
  }

  // Future<int> _showAccountTypeDialog(BuildContext context) async {
  //   return await showDialog(
  //     context: context,
  //     builder: (_) => SimpleDialog(
  //       title: Text('Account Types Dialog'), // Could this be central? Why is it bold and bigger? Colour maybe
  //       children: _convertAccountType(context),
  //       contentPadding: EdgeInsets.all(15),
  //       elevation: 2.0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(
  //           8.0,
  //         ),
  //         side: BorderSide(width: 2.0, color: Colors.grey),
  //       ),
  //     ),
  //   );
  // }

  // List<Widget> _convertAccountType(BuildContext context) {
  //   List<Widget> lsdo = [];
  //   for (AccountType accountType in db.accountTypes!) {
  //     lsdo.add(Row(
  //       children: <Widget>[
  //         SizedBox(
  //           width: 5,
  //         ),
  //         IconListImage(accountType.iconPath, 25),
  //         SizedBox(
  //           width: 3,
  //         ),
  //         SimpleDialogOption(
  //           child: Text(accountType.typeName),
  //           onPressed: () => Navigator.pop(context, accountType.id),
  //         ),
  //       ],
  //     ));
  //     lsdo.add(Divider(
  //       thickness: 1,
  //     ));
  //   }
  //   if (lsdo.isNotEmpty) lsdo.removeLast();
  //   return lsdo;
  // }
}
