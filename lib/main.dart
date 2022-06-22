import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'UX/theme_data_packer.dart';
import 'sidemenu/sidemenu.dart';
import 'provider/theme_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider.fromStorage(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: const HomePage(title: 'Home page'),
        builder: (context, themeProvider, child) {
          var activeThemeConfig = themeProvider
              .availableConfigurations[themeProvider.currentThemeIndex];
          return MaterialApp(
            title: 'Flutter Demo',
            theme: buildThemeData(activeThemeConfig),
            home: child,
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                lorem(paragraphs: 6, words: 800),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
