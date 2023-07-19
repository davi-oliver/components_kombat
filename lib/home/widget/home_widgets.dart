import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/home/home_page.dart';
import 'package:componets_kombat/home/store/home_store.dart';
import 'package:componets_kombat/login/login_components.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../globals_informations.dart';

class HomeVigWidgets {
  BuildContext context;
  HomeVigWidgets(this.context);

  Widget widgetPrincipal() {
    return Column(children: [
      Expanded(
          child: ListView(
        children: [
          SizedBox(height: 50),
          AppBarHomePage(), // PERFIL DE AVATAR DO AGENTE E CONFIGURAÇÕES
          SizedBox(
            height: 40,
          ),
          _todosBotoes(), // CHAMADA DOS BOTÕES PRINCIPAIS DA HOME
        ],
      ))
    ]);
  }

  Widget _todosBotoes() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.12),
      width: MediaQuery.of(context).size.width * 0.76,
      child: Column(children: [
        // _botao(KThemeModeApp.of(context).primary, FontAwesomeIcons.treeCity, "MINHAS VISITAS",
        //     MinhasVisitas()),

        const SizedBox(
          height: 40,
        ),
        // _botao(Color.fromRGBO(51, 69, 226, 1), FontAwesomeIcons.home,
        //     "CADASTRAR IMÓVEL", FormularioImovelPage()),
        const SizedBox(
          height: 40,
        ),
        _botao(
          KThemeModeApp.of(context).secondary,
          FontAwesomeIcons.play,
          "VISITAS",
          HomeVigPage(
            rebirth: () {},
          ),
        ),
        SizedBox(
          height: 40,
        ),
        _botao(
          KThemeModeApp.of(context).primary,
          Icons.analytics_outlined,
          "PRODUÇÃO DIÁRIA",
          HomeVigPage(
            rebirth: () {},
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        // _botao(Color.fromRGBO(41, 128, 185, 1), FontAwesomeIcons.chartBar,
        //     "PRODUÇÃO DIÁRIA", ProducaoDiariaPage()),
        const SizedBox(
          height: 40,
        ),

        const SizedBox(
          height: 120,
        ),
      ]),
    );
  }

  Widget _botao(Color cor, var icone, String texto, var navi) {
    final homevigStore = Provider.of<HomeVigStore>(context, listen: false);
    return Observer(builder: (_) {
      return GestureDetector(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: KThemeModeApp.of(context).primaryBackground,
              boxShadow: const [kDefaultShadow],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(children: [
              Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 5, right: 10, bottom: 5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(2),
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                        bottomLeft: Radius.circular(7)),
                  ),
                  child: Icon(
                    icone,
                    color: KThemeModeApp.of(context).primaryBackground,
                    size: 16,
                  )),
              Text(
                texto,
                style: KThemeModeApp.of(context).bodyMedium,
              )
            ]),
          ),
          onTap: () async {
            homevigStore.setLoading(true);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => navi));
            homevigStore.setLoading(false);
          });
    });
  }

  Widget botaoSemAtribuicao(Color cor, var icone, String texto, var navi) {
    return GestureDetector(
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: KThemeModeApp.of(context).primaryBackground,
            boxShadow: const [kDefaultShadow],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(children: [
            Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 10, bottom: 5),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: cor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(2),
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7)),
                ),
                child: Icon(
                  icone,
                  color: KThemeModeApp.of(context).primaryBackground,
                  size: 16,
                )),
            Text(
              texto,
              style: KThemeModeApp.of(context).bodyMedium,
            )
          ]),
        ),
        onTap: () async {
          await GlobalsAlerts(context).alertFuncionamento(1);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => navi));
        });
  }
}

class AppBarHomePage extends StatefulWidget {
  const AppBarHomePage({super.key});

  @override
  State<AppBarHomePage> createState() => _AppBarHomePageState();
}

class _AppBarHomePageState extends State<AppBarHomePage> {
  @override
  Widget build(BuildContext context) {
    final userInfos = Provider.of<GlobalUserInfos>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: PopupMenuButton(
                  color: KThemeModeApp.of(context).primaryBackground,
                  shape: Border.all(
                    color: KThemeModeApp.of(context).secondaryText,
                    width: 1.0,
                  ),
                  offset: const Offset(16, 50),
                  child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${userInfos.displayName}",
                                  style: KThemeModeApp.of(context).titleMedium,
                                ),
                                Text("Agente de Combate",
                                    style: KThemeModeApp.of(context).bodySmall),
                              ]),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                "https://ui-avatars.com/api/?name=${userInfos.email}"),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      )),
                  onSelected: (value) {
                    value == 1
                        ? ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("data")))
                        : ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("data")));
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Configurações',
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(
                                          color: KThemeModeApp.of(context)
                                              .secondaryText),
                                ),
                                SizedBox(width: 45),
                                Icon(FontAwesomeIcons.cog,
                                    color: KThemeModeApp.of(context)
                                        .secondaryText),
                              ],
                            ),
                            onTap: () {}),
                        PopupMenuItem(
                            onTap: () async {
                              // await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen(
                                            contextPage: context,
                                            initPage: () {},
                                            rebirth: () {},
                                          )));
                            },
                            value: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Sair',
                                  style: KThemeModeApp.of(context)
                                      .bodyLarge
                                      .copyWith(
                                          color: KThemeModeApp.of(context)
                                              .secondaryText),
                                ),
                                const SizedBox(width: 45),
                                Icon(FontAwesomeIcons.signOutAlt,
                                    color: KThemeModeApp.of(context)
                                        .secondaryText),
                              ],
                            )),
                      ])),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }
}
