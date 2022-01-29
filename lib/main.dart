import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:myanilab/Core/Providers/token_provider.dart';
import 'package:myanilab/UI/Theme/theme.dart';
import 'package:myanilab/root.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.allowReassignment = true;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValueNotifier(ThemeMode.dark)),
        ChangeNotifierProvider(create: (_) => TokenProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAniLab',
      debugShowCheckedModeBanner: false,
      themeMode: Provider.of<ValueNotifier<ThemeMode>>(context).value,
      theme: MyAniLabTheme.light,
      darkTheme: MyAniLabTheme.dark,
      home: const Root(),
    );
  }
}
