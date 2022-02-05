import 'package:flutter/material.dart';
import 'package:myanilab/UI/Widgets/mal_drawer_header.dart';
import 'package:provider/provider.dart';

class MalDrawer extends StatelessWidget {
  const MalDrawer({Key? key}) : super(key: key);

  static const items = ['Home', 'Top Anime', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ValueNotifier<int>>(
      builder: (context, activePage, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MalDrawerHeader(),
            ...List.generate(
              items.length,
              (index) => ListTile(
                selectedTileColor: theme.colorScheme.primary.withOpacity(.3),
                selected: activePage.value == index,
                leading: const Icon(Icons.home),
                title: Text(items[index]),
                onTap: () {
                  Navigator.pop(context);
                  if (activePage.value != index) activePage.value = index;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
