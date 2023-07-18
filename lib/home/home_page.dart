// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// import 'package:componets_kombat/componets_kombat_export.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/theme/theme_mode.dart';

import 'home_widgets.dart';

class HomeVigPage extends StatefulWidget {
  final Function rebirth;
  const HomeVigPage({
    Key? key,
    required this.rebirth,
  }) : super(key: key);

  @override
  _HomeVigPageState createState() => _HomeVigPageState();
}

class _HomeVigPageState extends State<HomeVigPage> {
  bool _carregando = true;
  bool _init = true;
  // Future<Timer> simulateInitialDataLoading() async {
  //   return Timer(
  //     const Duration(seconds: 7),
  //     () => Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => LoginScreen(
  //           contextPage: context,
  //           rebirth: () {},
  //           initPage: () {
  //             print("davizr");
  //             widget.rebirth;
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void init() async {
    final local = await LocalPathStore().visitasImovelOffline;
    // await simulateInitialDataLoading();
    if (await local.exists()) {
      // await GlobalsAlerts(context).alertInfoProducao();
    }
    _init = false;
    await Future.delayed(Duration(seconds: 4));

    setState(() {
      _carregando = false;
    });
  }

  @override
  void didChangeDependencies() {
    // homevigStore = Provider.of<HomeVigStore>(context, listen: true);

    if (_init) {
      init();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final _gInfos = Provider.of<GlobalUserInfos>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _carregando
          // ?
          ? Container(
              color: KThemeModeApp.of(context).primaryBackground,
              child: DefaultTextStyle(
                style: KThemeModeApp.of(context).headlineLarge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/itajuba_contorno.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20.0, height: 100.0),
                        AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            RotateAnimatedText(
                              // 'Olá, ${_gInfos.displayName}',
                              'Olá, ',
                            ),
                            RotateAnimatedText('Bem vindo(a) de volta ao'),
                            RotateAnimatedText('KOMBAT',
                                textStyle: KThemeModeApp.of(context)
                                    .headlineLarge
                                    .copyWith(
                                      color:
                                          KThemeModeApp.of(context).primaryText,
                                      fontWeight: FontWeight.bold,
                                    )),
                            RotateAnimatedText('Sistema de Vigilância'),
                            RotateAnimatedText('Aguarde... '),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Observer(builder: (_) {
              return Scaffold(
                bottomSheet: GlobalsWidgets(context)
                    .logoBottomBar(), // LOGO DA PARTE INFERIOR DA TELA
                body: _carregando
                    ? GlobalsWidgets(context).loadingPrincipal()
                    : HomeVigWidgets(context).widgetPrincipal(),
              );
            }),
    );
  }
}
