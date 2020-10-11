import 'package:flutter/material.dart';
import 'package:thetamedbot/models/myuser.dart';
import 'package:thetamedbot/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class AccPage extends StatefulWidget {
  final AsyncSnapshot<MyUser> userSnapshot;

  const AccPage({Key key, @required this.userSnapshot}) : super(key: key);

  @override
  _AccPageState createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final wX = constraints.maxWidth;
      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Profile',
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () {
                return Navigator.pop(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            padding:
                EdgeInsets.fromLTRB(changePadX(wX), 16.0, changePadX(wX), 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Email Verified ${widget.userSnapshot.data.emailVerified}",
                        style: theme.textTheme.subtitle1,
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        "${widget.userSnapshot.data.email}",
                        style: theme.textTheme.caption,
                      ),
                    ),
                  ),
                ),
                if (!widget.userSnapshot.data.emailVerified)
                  GestureDetector(
                    onTap: () async {
                      final auth = context.read<FirebaseAuthService>();
                      await auth.verifyEmailSend();
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                            "Email verification sent, Please check your email."),
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        title: Center(
                          child: Text(
                            'Email Verify',
                            style: theme.textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () async {
                    final auth = context.read<FirebaseAuthService>();
                    await auth.signOut();
                    Navigator.pop(context);
                  },
                  child: Card(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          'Logout',
                          style: theme.textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }

  double changePadX(double width) {
    if (width > 900) {
      return 128;
    } else if (width < 900 && width > 600) {
      return 64;
    } else {
      return 16;
    }
  }
}
