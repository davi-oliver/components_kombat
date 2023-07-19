import 'package:componets_kombat/formulario_imovel/store/formulario_imovel_store.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../widget/sucess_widget.dart';

class InfoSalvaPage extends StatefulWidget {
  const InfoSalvaPage({Key? key}) : super(key: key);

  @override
  _InfoSalvaPage createState() => _InfoSalvaPage();
}

class _InfoSalvaPage extends State<InfoSalvaPage> {
  @override
  Widget build(BuildContext context) {
    final formularioImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomSheet: GlobalsWidgets(context).logoBottomBar(),
          body: Observer(builder: (_) {
            return Stack(children: [
              formularioImovelStore.load
                  ? Visibility(
                      visible: formularioImovelStore.load,
                      child: GlobalsWidgets(context).loadingPrincipal(),
                    )
                  : InfoSalvaWidget(context).widgetPrincipal()
            ]);
          })),
    );
  }
}
