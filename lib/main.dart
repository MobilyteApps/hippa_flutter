import 'package:app/common/navigator_service.dart';
import 'package:app/language/application.dart';
import 'package:app/providers/loader_provider.dart';
import 'package:app/providers/login_provider.dart';
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
   AppTranslationsDelegate _newLocaleDelegate;
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
     return   MultiProvider(
      providers: [
          ChangeNotifierProvider<DarkThemeProvider>(create: (_) => themeChangeProvider),
        ChangeNotifierProvider<LoaderProvider>(create: (_) => LoaderProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),

          ],
      child:
    
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
       locale: Locale('es'),   //choose language
      localizationsDelegates: [
        _newLocaleDelegate,
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

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
     
        title: Text("jjj"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
           
          ],
        ),
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
