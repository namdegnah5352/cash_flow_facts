import 'package:flutter/material.dart';
import '../../../domain/calls/transaction_calls.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/entities/accounts/account.dart';
import 'transaction_list_tile.dart';
import '../../../core/util/journey_list.dart';
import '../../../domain/entities/transaction_journey.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/enums.dart';
import '../../screens/transaction/trans_step1.dart';

GlobalNav globalNav = GlobalNav.instance;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function rebuildDashboard;
  final Account account;
  const TransactionList(this.transactions, this.rebuildDashboard, this.account, {Key? key}) : super(key: key);

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
                  globalNav.setDashboardWidget(globalNav.transactionJourney.start()(rebuildDashboard, account), NavIndex.transactions.index);
                  rebuildDashboard();
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Transactions',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/transaction.jpg'),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return TransactionListTile(transactions[index], rebuildDashboard, account);
              },
              childCount: transactions.length,
            ),
          ),
        ],
      ),
    );
  }
}

// extension BuyingVerbs on JourneyList<Future<void> Function(Widget), TransactionJourney> {
//   void init(TransactionJourney newJourney) => modelData = newJourney;
// }
