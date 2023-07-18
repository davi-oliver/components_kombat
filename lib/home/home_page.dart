import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'home_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeVigPage extends StatefulWidget {
  const HomeVigPage({Key? key}) : super(key: key);

  @override
  _HomeVigPageState createState() => _HomeVigPageState();
}

class _HomeVigPageState extends State<HomeVigPage> {
  bool _carregando = true;
  bool _init = true;

  void init() async {
    final local = await LocalPathStore().visitasImovelOffline;
    if (await local.exists()) {
      // await GlobalsAlerts(context).alertInfoProducao();
    }
    _init = false;

    // if (!await FormularioImovelFunctions(context).iniciaGetsApp()) {
    //   if (await GlobalsFunctions(context).verificaInternet()) {
    //     setState(() {
    //       _carregando = false;
    //     });
    //     return await GlobalsAlerts(context).alertErro(
    //         'Sem Conexão com a Internet',
    //         "Verifique sua conexão com a internet. Algumas funcionalidades podem não funcionar corretamente.");
    //   }
    // }
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
