import 'package:flutter/material.dart';
import 'package:myanilab/UI/Widgets/mal_drawer_header.dart';
import 'package:provider/provider.dart';

class MalDrawer extends StatelessWidget {
  const MalDrawer({Key? key}) : super(key: key);

  static const items = {
    'Home': Icons.home,
    'Top Anime': Icons.trending_up,
    'Seasonal Anime': Icons.calendar_today,
    'Profile': Icons.person,
  };

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
                leading: Icon(items.values.toList()[index]),
                title: Text(items.keys.toList()[index]),
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
