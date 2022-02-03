import 'package:flutter/material.dart';
import 'package:myanilab/Core/Utils/helpers.dart';

class LoginWidget extends StatelessWidget {
  final String title;

  const LoginWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            final scaffoldState =
                context.findRootAncestorStateOfType<ScaffoldState>()!;
            scaffoldState.openDrawer();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.sentiment_neutral, size: 80),
            SizedBox(height: 10),
            Text(
              'Please login using your MyAnimeList account to get access to this feature!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            FloatingActionButton.extended(
              onPressed: login,
              icon: Icon(Icons.login),
              label: Text('Login'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
