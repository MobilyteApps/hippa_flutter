import 'package:app/common/navigator_service.dart';
import 'package:app/language/application.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/theme/dark_theme_provider.dart';
import 'package:app/theme/dark_theme_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:app/common/router.dart' as route;
import 'common/get_it.dart';
import 'language/app_translation_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate? _newLocaleDelegate;
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DarkThemeProvider>(
              create: (_) => themeChangeProvider),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hippa',
          locale: Locale('es'),
          //choose language
          localizationsDelegates: [
            _newLocaleDelegate!,
            const AppTranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
          supportedLocales: application.supportedLocales(),
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          home: SplashPage(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: route.Router.generateRoute,
        ));
  }
}
