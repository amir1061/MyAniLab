import 'package:flutter/material.dart';
import 'package:myanilab/Core/Providers/token_provider.dart';
import 'package:myanilab/Core/Providers/user_provider.dart';
import 'package:myanilab/Core/Utils/helpers.dart';
import 'package:myanilab/UI/Widgets/theme_icon_button.dart';
import 'package:provider/provider.dart';

class MalDrawerHeader extends StatelessWidget {
  const MalDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<TokenProvider>(builder: (_, tokenProvider, __) {
      if (tokenProvider.token == null) {
        return UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: theme.colorScheme.primary),
          currentAccountPicture: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryVariant,
            child: const Icon(Icons.person, size: 40),
          ),
          otherAccountsPictures: [
            IconButton(
              icon: const Icon(Icons.login),
              color: theme.colorScheme.onPrimary,
              onPressed: login,
            ),
            ThemeIconButton(color: theme.colorScheme.onPrimary),
          ],
          accountName: Text(
            'username',
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
          accountEmail: Text(
            'ID: ######',
            style: TextStyle(color: theme.colorScheme.onPrimary),
          ),
        );
      }
      return Consumer<UserProvider>(
        builder: (_, userProvider, __) {
          if (userProvider.error != null) {
            return UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryVariant,
                child: const Icon(Icons.error),
              ),
              otherAccountsPictures: [
                IconButton(
                  icon: const Icon(Icons.login),
                  color: theme.colorScheme.onPrimary,
                  onPressed: login,
                ),
                ThemeIconButton(color: theme.colorScheme.onPrimary),
              ],
              accountName: Text(
                'username',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              accountEmail: Text(
                'ID: ######',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            );
          }
          if (userProvider.user == null) {
            return UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: theme.colorScheme.primary),
              currentAccountPicture: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryVariant,
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              ),
              otherAccountsPictures: [
                ThemeIconButton(color: theme.colorScheme.onPrimary),
              ],
              accountName: Text(
                'username',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
              accountEmail: Text(
                'ID: ######',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            );
          }
          final user = userProvider.user!;
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primary),
            currentAccountPicture: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryVariant,
              backgroundImage:
                  user.picture != null ? NetworkImage(user.picture!) : null,
              child: user.picture == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(Icons.logout),
                color: theme.colorScheme.onPrimary,
                onPressed: () => logout(context),
              ),
              ThemeIconButton(color: theme.colorScheme.onPrimary),
            ],
            accountName: Text(
              user.name,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            accountEmail: Text(
              'ID: ${user.id}',
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
          );
        },
      );
    });
  }
}
