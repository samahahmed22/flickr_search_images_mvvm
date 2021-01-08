import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './views/screens/login_screen.dart';
import './views/screens/image_details_screen.dart';
import './views/screens/search_result_screen.dart';
import './views/screens/search_screen.dart';
import './views/screens/splash_screen.dart';
import './view_models/auth_view_model.dart';
import './view_models/images_list_view_model.dart';
import './models/images_list_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ImagesListModelAdapter());
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => ImagesListViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flickr images',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              headline2: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
              headline3: TextStyle(
                  color: Colors.black45,
                  fontStyle: FontStyle.italic,
                  fontSize: 16),
            ),
      ),
      home: _showScreen(context),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "search": (ctx) => SearchResultScreen(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      routes: {
        ImageDetailsScreen.routeName: (ctx) => ImageDetailsScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        // SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
      },
    );
  }

  Widget _showScreen(context) {
    var provider = Provider.of<AuthViewModel>(context);
  
    switch (provider.authStatus) {
      case AuthStatus.authentecating:
        return SplashScreen();
      case AuthStatus.unAuthenticated:
        return LoginScreen();
      case AuthStatus.authenticated:
        return SearchScreen();
    }
    return Container();
  }
}
