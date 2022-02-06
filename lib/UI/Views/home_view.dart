import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:myanilab/Core/Models/token.dart';
// import 'package:myanilab/Core/Models/token.dart';
// import 'package:myanilab/Core/Providers/token_provider.dart';
// import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            final scaffoldState =
                context.findRootAncestorStateOfType<ScaffoldState>()!;
            scaffoldState.openDrawer();
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              const storage = FlutterSecureStorage();
              final refreshToken = await storage.read(key: 'refreshToken');

              await storage.write(
                key: 'refreshToken',
                value: '${refreshToken}ksjdfks',
              );
              GetIt.I.registerSingleton<Token>((await Token.fromStorage())!);
            },
            label: const Text('Mess up refresh token'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: () async {
              const storage = FlutterSecureStorage();
              final accessToken = await storage.read(key: 'accessToken');

              await storage.write(
                key: 'accessToken',
                value: '${accessToken}ksjdfks',
              );
              GetIt.I.registerSingleton<Token>((await Token.fromStorage())!);
            },
            label: const Text('Mess up access token'),
          ),
        ],
      ),
    );
  }
}
