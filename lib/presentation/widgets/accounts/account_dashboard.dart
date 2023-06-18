import 'package:flutter/material.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/navigation/global_nav.dart';
import 'accounts_list.dart';
import '../transactions/transaction_list.dart';
import '../../config/enums.dart';

GlobalNav globalNav = GlobalNav.instance;

class AccountDashboard extends StatefulWidget {
  final List<Account> accounts;
  const AccountDashboard(this.accounts, {super.key});

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  int _selectedIndex = 0;
  int _accountId = 0;

  void _onItemTapped(int index) async {
    setState(() {
      if (index == NavIndex.accounts.index && widget.accounts.isNotEmpty) {
        widgetOptions[NavIndex.accounts.index] = AccountList(widget.accounts, setAccountTab, getSelectedIndex, setAccountId);
      }
      _selectedIndex = index;
    });
  }

  void setAccountTab(Future<Widget> futureWidget, int index) async {
    Widget widget = await futureWidget;
    setState(() {
      widgetOptions[index] = widget;
    });
  }

  void setAccountId(int index) => _accountId = index;
  int getSelectedIndex() => _accountId;

  @override
  void initState() {
    widgetOptions[NavIndex.accounts.index] = AccountList(widget.accounts, setAccountTab, getSelectedIndex, setAccountId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _onItemTapped(index);
        },
        destinations: appBarDestinations,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
    );
  }
}

List<Widget> widgetOptions = [const NoAccounts(), const NoTransactions(), const NoMoveMoney(), const NoSettings()];

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.widgets_outlined),
    label: 'Account',
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.format_paint_outlined),
    label: 'Transactions',
    selectedIcon: Icon(Icons.format_paint),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.text_snippet_outlined),
    label: 'Move Money',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.invert_colors_on_outlined),
    label: 'Settings',
    selectedIcon: Icon(Icons.opacity),
  )
];

class NoAccounts extends StatelessWidget {
  const NoAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Accounts please create one')),
    );
  }
}

class NoTransactions extends StatelessWidget {
  const NoTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Transactions please create one or select an account')),
    );
  }
}

class NoMoveMoney extends StatelessWidget {
  const NoMoveMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Move Money, please create one')),
    );
  }
}

class NoSettings extends StatelessWidget {
  const NoSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Settings for this account')),
    );
  }
}
