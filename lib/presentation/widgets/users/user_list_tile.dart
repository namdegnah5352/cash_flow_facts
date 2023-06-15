import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/user_calls.dart';
import '../../config/navigation/global_nav.dart';
import '../../config/style/app_colors.dart';
import '../../config/constants.dart';

class UserListTile extends StatelessWidget {
  final Function refresh;
  final User user;

  const UserListTile(this.user, this.refresh, {Key? key}) : super(key: key);

  Widget _isDefaultUser(BuildContext context, int id, int duc) {
    String numb;
    Color background;
    if (id == duc) {
      numb = "Chosen";
      background = clred;
    } else {
      numb = id.toString();
      background = cltx;
    }
    return GestureDetector(
      onTap: () {
        GlobalNav.instance.sharedPreferences!.setInt(AppConstants.userId, user.id);
        refresh();
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
    int duc = GlobalNav.instance.sharedPreferences!.getInt(AppConstants.userId)!;
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
