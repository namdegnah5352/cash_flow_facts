import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/calls.dart';
import 'user_list_tile.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  const UserList(this.users, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.black26),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  Navigator.pop(context);
                  navigateToNewUser();
                },
              ),
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 265,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Users',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/user.png'),
                    scale: 1.25,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return UserListTile(users[index]);
              },
              childCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
