import 'package:flutter/material.dart';
import 'package:myanilab/UI/Widgets/mal_drawer_header.dart';
import 'package:provider/provider.dart';

class MalDrawer extends StatelessWidget {
  const MalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ValueNotifier<int>>(
      builder: (context, activePage, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MalDrawerHeader(),
            ListTile(
              selectedTileColor: theme.colorScheme.primary.withOpacity(.3),
              selected: activePage.value == 0,
              leading: const Icon(Icons.local_fire_department),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                if (activePage.value != 0) activePage.value = 0;
              },
            ),
            ListTile(
              selectedTileColor: theme.colorScheme.primary.withOpacity(.3),
              selected: activePage.value == 1,
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                if (activePage.value != 1) activePage.value = 1;
              },
            ),
          ],
        ),
      ),
    );
  }
}
