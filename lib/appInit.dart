import 'package:cms_mobile/utilities/theme_data.dart';
import 'package:cms_mobile/utilities/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/user_database.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return Provider<AppDatabase>(
              create: (BuildContext context) => AppDatabase(),
              child: MaterialApp(
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: CMS(),
                debugShowCheckedModeBanner: false,
              ));
        },
      ),
    );
  }
}
