import 'package:flutter/material.dart';

class LoadingScaffold extends StatelessWidget {
  final String title;

  const LoadingScaffold({Key? key, required this.title}) : super(key: key);

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
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
