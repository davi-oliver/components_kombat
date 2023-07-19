import 'package:componets_kombat/detalhes_imovel/valida_qrcode/store/valida_qrcode_store.dart';
import 'package:componets_kombat/detalhes_imovel/widget/valida_qrcode_widgets.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class ValidaQrCodePage extends StatefulWidget {
  const ValidaQrCodePage({super.key});

  @override
  State<ValidaQrCodePage> createState() => _ValidaQrCodePageState();
}

class _ValidaQrCodePageState extends State<ValidaQrCodePage> {
  late ValidaQrCodeStore validaQrCodeStoreT;
  late ValidaQrCodeStore validaQrCodeStore;

  @override
  void didChangeDependencies() {
    validaQrCodeStoreT = Provider.of<ValidaQrCodeStore>(context, listen: true);
    validaQrCodeStore = Provider.of<ValidaQrCodeStore>(context, listen: false);
    validaQrCodeStore.setLoading(false);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Observer(builder: (_) {
          return Scaffold(
              bottomSheet: GlobalsWidgets(context).logoBottomBar(),
              body: validaQrCodeStoreT.loading
                  ? GlobalsWidgets(context).loadingPrincipal()
                  : ValidaQrCodeWidgets(context).widgetPrincipal());
        }));
  }
}
