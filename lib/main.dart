import 'package:app/common/navigator_service.dart';
import 'package:app/language/application.dart';
import 'package:app/models/loader.dart';
import 'package:app/network/api_provider.dart';
import 'package:app/providers/signin_provider.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/theme/dark_theme_provider.dart';
import 'package:app/theme/dark_theme_styles.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:app/common/router.dart' as route;
import 'common/get_it.dart';
import 'language/app_translation_delegate.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  runApp(MyApp(
    cameras: cameras,
  ));
}

class MyApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate? _newLocaleDelegate;
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  ApiProvider apiprovider = ApiProvider();

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
    cam();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  void cam() {
    apiprovider.cameras = widget.cameras;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DarkThemeProvider>(
              create: (_) => themeChangeProvider),
          ChangeNotifierProvider<Loader>(
            create: (context) => Loader(),
          ),
          ChangeNotifierProvider<SignInProvider>(
            create: (context) => SignInProvider(),
          ),
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
