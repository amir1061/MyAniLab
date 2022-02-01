import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
          children: [
            const Icon(Icons.sentiment_neutral, size: 80),
            const SizedBox(height: 10),
            const Text(
              'Please login using your MyAnimeList account to get access to this feature!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            FloatingActionButton.extended(
              onPressed: () {
                final uri = Uri(
                  scheme: 'https',
                  host: 'myanimelist.net',
                  path: 'v1/oauth2/authorize',
                  queryParameters: {
                    'response_type': 'code',
                    'client_id': dotenv.env['clientId'],
                    'code_challenge': dotenv.env['codeVerifier'],
                    'state': dotenv.env['state'],
                  },
                );
                launchUrl(uri.toString());
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
