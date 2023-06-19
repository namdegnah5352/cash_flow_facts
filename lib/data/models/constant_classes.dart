import 'package:flutter/material.dart';

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
