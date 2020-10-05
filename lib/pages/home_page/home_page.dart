import 'package:flutter/material.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<MyUser> userSnapshot;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          actions: [
            IconButton(
              icon: const Icon(Icons.backspace_outlined),
              tooltip: 'Log out',
              onPressed: () async {
                final auth = context.read<FirebaseAuthService>();
                await auth.signOut();
              },
            ),
          ],
        ),
        body: Container());
  }
}
