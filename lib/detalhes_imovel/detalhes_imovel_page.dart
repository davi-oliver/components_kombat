// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'widget/detalhes_imovel_widgets.dart';

class DetalhesImovelPage extends StatefulWidget {
  @override
  _DetalhesImovelPage createState() => _DetalhesImovelPage();
}

class _DetalhesImovelPage extends State<DetalhesImovelPage> {
  late IniciaVisitaStore iniciaVisitaStore;
  late IniciaVisitaStore iniciaVisitaStoreT;
  final formState = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    iniciaVisitaStore = Provider.of<IniciaVisitaStore>(context, listen: false);
    iniciaVisitaStoreT = Provider.of<IniciaVisitaStore>(context, listen: true);

    iniciaVisitaStore.setLoad(false);
    iniciaVisitaStore.setVisibilidadeBotaoFechado(true);
    iniciaVisitaStore.setVisibilidadeBotaoRecusado(true);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Observer(builder: (_) {
          return Scaffold(
              bottomSheet: GlobalsWidgets(context).logoBottomBar(),
              body: Stack(children: [
                iniciaVisitaStoreT.load
                    ? Visibility(
                        visible: iniciaVisitaStoreT.load,
                        child: GlobalsWidgets(context).loadingPrincipal(),
                      )
                    : DetalhesImovelWidgets(context).widgetPrincipal(
                        formState,
                      )
              ]));
        }));
  }
}
