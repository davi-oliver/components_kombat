import 'package:componets_kombat/detalhes_imovel/widget/detalhes_imovel_widgets.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../inicia_visita_store/inicia_visita_store.dart';
import '../../view_model/view_model_store.dart';

class ListaImoveisPage extends StatefulWidget {
  const ListaImoveisPage({super.key});

  @override
  State<ListaImoveisPage> createState() => _ListaImoveisPageState();
}

class _ListaImoveisPageState extends State<ListaImoveisPage> {
  late IniciaVisitaStore iniciaVisitaStore;
  late ViewModelStore viewModelStoreT;
  bool initi = false;
  bool _carregando = true;

  @override
  void didChangeDependencies() {
    iniciaVisitaStore = Provider.of<IniciaVisitaStore>(context, listen: false);
    viewModelStoreT = Provider.of<ViewModelStore>(context, listen: true);

    if (!initi) {
      initi = true;
      setState(() {
        _carregando = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: GlobalsWidgets(context).logoBottomBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              _carregando
                  ? GlobalsWidgets(context).loadingPrincipal()
                  : DetalhesImovelWidgets(context)
                      .widgetListaImoveisMesmoEndereco(),
            ]),
          ),
        ));
  }
}
