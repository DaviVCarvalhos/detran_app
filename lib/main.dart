import 'package:detranapp/Pages/HomePage.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:detranapp/models/infracao_provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';
import 'package:detranapp/Service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:detranapp/Pages/InfracoesPage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final userProvider = UserProvider();
  await userProvider.checkUserSession();

  final notificationService = NotificationService(navigatorKey);
  await notificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => userProvider),
        ChangeNotifierProvider<VeiculoProvider>(
            create: (_) => VeiculoProvider()),
        ChangeNotifierProvider<InfracaoProvider>(
            create: (_) => InfracaoProvider()),
        ChangeNotifierProvider<AgendamentoProvider>(
            create: (_) => AgendamentoProvider()),
      ],
      child: MyApp(notificationService: notificationService),
    ),
  );
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  MyApp({required this.notificationService});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('pt', 'BR'),
      ],
      home: HomePage(),
      routes: {
        '/infracoes': (context) => InfracoesPage(),
      },
    );
  }
}
