import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/calls.dart';
import '../../config/navigation/global_nav.dart';

class UserListTile extends StatelessWidget {
  @required
  final User user;

  const UserListTile(this.user, {Key? key}) : super(key: key);

  Widget _isDefaultUser(BuildContext context, int id, int duc) {
    String numb;
    Color background;
    if (id == duc) {
      numb = "Chosen";
      background = Colors.red;
    } else {
      numb = id.toString();
      background = Colors.grey.shade400;
    }
    return GestureDetector(
      onTap: () {
        // sl<SharedPreferences>().setInt(AppConstants.userId, user.id);
      },
      child: CircleAvatar(
          backgroundColor: background,
          maxRadius: 25,
          minRadius: 20,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              numb,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = user.id;
    // int duc = sl<SharedPreferences>().getInt(AppConstants.userId)!;
    int duc = 1;
    return Column(
      children: <Widget>[
        ListTile(
          leading: _isDefaultUser(context, id, duc),
          title: Text(user.name),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pop(context);
                    navigateToExistingUser(user);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pop(context);
                    GlobalNav.instance.userLink!.linkDeleteUser(id);
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
