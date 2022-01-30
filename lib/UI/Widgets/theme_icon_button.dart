import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeIconButton extends StatelessWidget {
  final Color? color;
  const ThemeIconButton({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueNotifier<ThemeMode>>(
      builder: (_, themeModeProvider, __) {
        final mode = themeModeProvider.value;
        return IconButton(
          onPressed: () {
            switch (mode) {
              case ThemeMode.system:
                themeModeProvider.value = ThemeMode.dark;
                return;
              case ThemeMode.dark:
                themeModeProvider.value = ThemeMode.light;
                return;
              case ThemeMode.light:
                themeModeProvider.value = ThemeMode.system;
            }
          },
          icon: Icon(
            mode == ThemeMode.system
                ? Icons.brightness_4
                : mode == ThemeMode.light
                    ? Icons.brightness_auto
                    : Icons.brightness_7,
          ),
          color: color,
        );
      },
    );
  }
}
