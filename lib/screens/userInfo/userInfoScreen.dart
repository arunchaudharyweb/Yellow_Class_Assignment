import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../services/authentication.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({@required this.user, @required this.disposeBloc});

  final User user;
  final Function disposeBloc;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  User _user;
  bool _isSigningOut = false;

  @override
  void initState() {
    _user = widget.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          child: Image.network(
                            _user.photoURL,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Material(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.person,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                title: Text('Hello ${_user.displayName}'),
                subtitle: Text(
                  _user.email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'You are now signed in using your Google account. To sign out of your account click the "Sign Out" button below.',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.2,
                    height: 1.3,
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  _isSigningOut
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : TextButton.icon(
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                            widget.disposeBloc();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login', (Route<dynamic> route) => false);
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white),
                          ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
