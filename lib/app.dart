import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/restaurant_template.dart';
import 'screens/restaurant_detail_page.dart';
import 'screens/settings.dart';
import 'screens/dark_theme_provider.dart';
import 'screens/styles.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'HungryHippos',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => Home(),
              '/restaurants': (BuildContext context) => Restaurants(),
              '/details': (BuildContext context) => RestaurantDetailPage(),
              '/settings': (BuildContext context) => Settings(),
            },
          );
        },
      ),
    );
  }
}
