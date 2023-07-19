// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/home/store/home_store.dart';
import 'package:componets_kombat/requests/services/serices_get.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// import 'package:componets_kombat/componets_kombat_export.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/local_storage/local.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:provider/provider.dart';

import 'widget/home_widgets.dart';

class HomeVigPage extends StatefulWidget {
  final Function rebirth;
  const HomeVigPage({
    Key? key,
    required this.rebirth,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeVigPageState createState() => _HomeVigPageState();
}

class _HomeVigPageState extends State<HomeVigPage> {
  bool _carregando = true;
  bool _init = true;
  late HomeVigStore homevigStore;
  void init() async {
    final local = await LocalPathStore().visitasImovelOffline;
    if (await local.exists()) {
      // ignore: use_build_context_synchronously
      await GlobalsAlerts(context).alertInfoProducao();
    }
    _init = false;

    // ignore: use_build_context_synchronously
    if (!await ServiceGetRequestApp(context).iniciaGetsApp()) {
      // ignore: use_build_context_synchronously
      if (await GlobalsFunctions(context).verificaInternet()) {
        setState(() {
          _carregando = false;
        });
        // ignore: use_build_context_synchronously, void_checks
        return await GlobalsAlerts(context).alertErro(
            'Sem Conexão com a Internet',
            "Verifique sua conexão com a internet. Algumas funcionalidades podem não funcionar corretamente.");
      }
    }
    setState(() {
      _carregando = false;
    });
    homevigStore.setLoading(false);
  }

  @override
  void didChangeDependencies() {
    homevigStore = Provider.of<HomeVigStore>(context, listen: true);
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
