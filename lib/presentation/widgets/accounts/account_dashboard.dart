import 'package:flutter/material.dart';
import '../../../domain/entities/accounts/account.dart';
import '../../config/navigation/global_nav.dart';
import 'accounts_list.dart';

GlobalNav globalNav = GlobalNav.instance;

class AccountDashboard extends StatefulWidget {
  final List<Account> accounts;
  const AccountDashboard(this.accounts, {super.key});

  @override
  State<AccountDashboard> createState() => _AccountDashboardState();
}

class _AccountDashboardState extends State<AccountDashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    setState(() {
      if (index == NavIndex.accounts.index && widget.accounts.isNotEmpty) {
        widgetOptions[NavIndex.accounts.index] = AccountList(widget.accounts, setAccountTab);
      }
      _selectedIndex = index;
    });
  }

  void setAccountTab(Future<Widget> futureWidget) async {
    Widget widget = await futureWidget;
    setState(() {
      widgetOptions[NavIndex.accounts.index] = widget;
    });
  }

  @override
  void initState() {
    _onItemTapped(NavIndex.accounts.index);
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

List<Widget> widgetOptions = [const NoAccouts(), const NoTransactions(), const NoMoveMoney(), const NoSettings()];
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

class NoAccouts extends StatelessWidget {
  const NoAccouts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Accounts please create one')),
    );
  }
}

enum NavIndex { accounts, transactions, movemoney, settings }

class NoTransactions extends StatelessWidget {
  const NoTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('No Transactions please create one or select and account')),
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
