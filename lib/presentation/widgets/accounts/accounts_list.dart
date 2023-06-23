import 'package:cash_flow_facts/presentation/config/constants.dart';
import 'package:flutter/material.dart';
import '../../../domain/calls/account_calls.dart';
import '../../../domain/entities/accounts/account.dart';
import 'account_list_tile.dart';
import '../../config/enums.dart';
import '../../config/navigation/global_nav.dart';

class AccountList extends StatefulWidget {
  final List<Account> accounts;
  final Function dashboardAccountIndex;
  final Function setAccountIdOnDashboard;
  final Function rebuildDashboard;
  const AccountList(this.accounts, this.dashboardAccountIndex, this.setAccountIdOnDashboard, this.rebuildDashboard, {Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  int? accountId;

  @override
  void initState() {
    accountId ??= widget.dashboardAccountIndex();
    super.initState();
  }

  void listCallback(int index) async {
    accountId = index;
    widget.setAccountIdOnDashboard(index);
    setState(() {});
  }

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
                          GlobalNav.instance.setDashboardWidget(result.loadThis, NavIndex.accounts.index);
                          widget.rebuildDashboard();
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
                return AccountListTile(
                  account: widget.accounts[index],
                  listCallback: listCallback,
                  selectedAccountId: accountId!,
                  rebuildDashboard: widget.rebuildDashboard,
                );
              },
              childCount: widget.accounts.length,
            ),
          ),
        ],
      ),
    );
  }
}
