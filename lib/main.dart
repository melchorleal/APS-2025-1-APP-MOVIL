import 'package:aps_2025_1_app_movil/pages/folio_page.dart';
import 'package:aps_2025_1_app_movil/pages/tracking_page.dart';
import 'package:aps_2025_1_app_movil/providers/package_provider.dart';
import 'package:aps_2025_1_app_movil/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: MyColors.bg, // Cambia al color de fondo de arriba, del systema
      systemNavigationBarColor: MyColors.bg, // Cambia al color de abajo, del sistema
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => PackageProvider(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAQExpress Clientes',
      debugShowCheckedModeBanner: false,
      initialRoute: 'folio_page',
      routes: {
        'folio_page': (BuildContext context) => FolioPage(),
        'tracking_page': (BuildContext context) =>  TrackingPage(),
      },
    );
  }
}