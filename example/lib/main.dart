import 'package:flutter/material.dart';
import 'package:componets_kombat/login/login_view_componet.dart'
    as componets_kombat_ui;
import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart'
    as componets_kombat_formulario_store;
import 'package:componets_kombat/globals_informations.dart'
    as componets_kombat_globals_informations;
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart'
    as componets_kombat_inicia_visita_store;
import 'package:componets_kombat/formulario_questoes_visita/store/forumario_questoes_visita_store.dart'
    as componets_kombat_formulario_questoes_visita_store;
import 'package:componets_kombat/detalhes_imovel/valida_qrcode/store/valida_qrcode_store.dart'
    as componets_kombat_valida_qrcode_store;
import 'package:componets_kombat/home/store/home_store.dart'
    as componets_kombat_home_store;
import 'package:componets_kombat/view_model/view_model_store.dart'
    as componets_kombat_view_model_store;
import 'package:componets_kombat/local_visitas/store/local_visitas_store.dart'
    as components_kombat_local_visitas_store;

import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  TextEditingController controllerLogin = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiProvider(
      providers: [
        //++++++++++++++++++++++ ORDENAÇÃO ALFABÉTICA ++++++++++++++++++++

        //FUNCTIONS

        //STORE

        Provider<componets_kombat_valida_qrcode_store.ValidaQrCodeStore>(
            create: (_) =>
                componets_kombat_valida_qrcode_store.ValidaQrCodeStore()),
        Provider<
                componets_kombat_formulario_questoes_visita_store
                    .FormularioQuestoesVisitaStore>(
            create: (_) => componets_kombat_formulario_questoes_visita_store
                .FormularioQuestoesVisitaStore()),

        Provider<componets_kombat_formulario_store.FormularioImovelStore>(
            create: (_) =>
                componets_kombat_formulario_store.FormularioImovelStore()),
        Provider<componets_kombat_inicia_visita_store.IniciaVisitaStore>(
            create: (_) =>
                componets_kombat_inicia_visita_store.IniciaVisitaStore()),
        Provider<componets_kombat_home_store.HomeVigStore>(
            create: (_) => componets_kombat_home_store.HomeVigStore()),
        // Provider<AnalyticsService>(create: (_) => AnalyticsService()),
        Provider<componets_kombat_globals_informations.GlobalUserInfos>(
            create: (_) =>
                componets_kombat_globals_informations.GlobalUserInfos()),
        Provider<components_kombat_local_visitas_store.LocalVisitasStore>(
            create: (_) =>
                components_kombat_local_visitas_store.LocalVisitasStore()),
        // Provider<ProducaoDiariaStore>(create: (_) => ProducaoDiariaStore()),
        Provider<componets_kombat_view_model_store.ViewModelStore>(
            create: (_) => componets_kombat_view_model_store.ViewModelStore()),
      ],
      child: MaterialApp(
        home: componets_kombat_ui.LoginScreenComponets(
          contextPage: context,
        ),
      ),
    );
  }
}
