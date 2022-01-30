import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myanilab/Core/Providers/token_provider.dart';
import 'package:myanilab/Core/Utils/helpers.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            final scaffoldState =
                context.findRootAncestorStateOfType<ScaffoldState>()!;
            scaffoldState.openDrawer();
          },
        ),
      ),
      body: Consumer<TokenProvider>(
        builder: (context, tokenProvider, child) => tokenProvider.token == null
            ? const Center(child: Text('You are not logged In'))
            : const Center(child: Text('Now you are logged in')),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
    );
  }
}
