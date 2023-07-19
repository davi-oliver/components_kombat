import 'package:componets_kombat/formulario_imovel/widget/formulario_imovel_widgets.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

import 'store/formulario_imovel_store.dart';

class FormularioImovelPage extends StatefulWidget {
  const FormularioImovelPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormularioImovelPage createState() => _FormularioImovelPage();
}

class _FormularioImovelPage extends State<FormularioImovelPage> {
  final formState = GlobalKey<FormState>();

  late FormularioImovelStore formularioImovelStoreT;
  bool _carregando = true;
  bool _inciaDidChange = false;

  @override
  void didChangeDependencies() {
    formularioImovelStoreT =
        Provider.of<FormularioImovelStore>(context, listen: true);
    if (!_inciaDidChange) {
      setState(() {
        _inciaDidChange = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    formState.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    iniciaDados();
    super.initState();
  }

  Future iniciaDados() async {
    _inciaDidChange = true;
    await GlobalsFunctions(context).limpaCampos();
    if (!mounted) return;
    setState(() {
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            bottomSheet: GlobalsWidgets(context).logoBottomBar(),
            body: Stack(children: [
              _carregando
                  ? GlobalsWidgets(context).loadingPrincipal()
                  : FormularioImovelWidgets(context).widgetPrincipal(formState),
              Observer(builder: (_) {
                return Visibility(
                  visible: formularioImovelStoreT.load,
                  child: GlobalsWidgets(context).loadingPrincipal(),
                );
              })
            ])));
  }
}
