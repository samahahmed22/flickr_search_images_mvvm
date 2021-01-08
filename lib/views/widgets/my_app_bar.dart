import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../view_models/auth_view_model.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;

  MyAppBar(
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthViewModel>(context, listen: false);
    return AppBar(title: Text(title), actions: <Widget>[
      Row(children: <Widget>[
        PopupMenuButton(
          offset: Offset(0, 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          onSelected: (_) async {
            Navigator.of(context).pushReplacementNamed('/');
            await userData.logout();
          },
          icon: ClipOval(
            child: CachedNetworkImage(
              imageUrl: userData.user.photoUrl,
              placeholder: (context, url) => Image.asset('assets/loading.gif'),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Colors.red[600],
              ),
            ),
          ),
          // CircleAvatar(
          //   backgroundImage: NetworkImage(userData.user.photoURL),
          // ),
          itemBuilder: (_) => [
            PopupMenuItem(
              child: Text(
                userData.user.name,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            PopupMenuItem(
              child: Text(
                userData.user.email,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: <Widget>[
                  Text(
                    'Logout ',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    ]);
  }
}
