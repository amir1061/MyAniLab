import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
  }

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
      body: Consumer<UserProvider>(
        builder: (_, userProvider, __) {
          if (userProvider.error != null) {
            return Center(
              child: Text(userProvider.error!.message),
            );
          }
          if (userProvider.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = userProvider.user!;
          return Center(
            child: Text(user.name),
          );
        },
      ),
    );
  }
}
