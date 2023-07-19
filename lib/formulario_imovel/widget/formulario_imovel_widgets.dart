import 'dart:developer';

import 'package:componets_kombat/formulario_imovel/func/formulario_imovel_functions.dart';
import 'package:componets_kombat/func/globals_func.dart';
import 'package:componets_kombat/globals_widgets.dart';
import 'package:componets_kombat/inicia_visita_store/inicia_visita_store.dart';
import 'package:componets_kombat/login/widget/components.dart';
import 'package:componets_kombat/requests/services/serices_get.dart';
import 'package:componets_kombat/requests/services/services_post.dart';
import 'package:componets_kombat/theme/theme_mode.dart';
import 'package:componets_kombat/widget/alerts/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import '../store/formulario_imovel_store.dart';

class FormularioImovelWidgets {
  BuildContext context;
  FormularioImovelWidgets(this.context);

  Widget widgetPrincipal(formState) {
    return Column(
      children: [
        Expanded(
          child: ListView(children: [
            // APPBAR
            GlobalsWidgets(context).appBar("Cadastrar Imóvel", true, true),

            // FORMULÁRIO DE CADASTRO DE IMÓVEL
            FormularioImovel(formState: formState),

            // DROPDOWN DE TIPOS DE IMÓVEL
            _tipoImovel(),

            const SizedBox(height: 80),

            // BOTÃO DE CADASTRO E ENVIO DOS DADOS IMÓVEIS
            _botaoCadastrar(formState),
            const SizedBox(height: 120),
          ]),
        ),
      ],
    );
  }

  // DROPDOWN DE TIPOS DE IMÓVEL
  Widget _tipoImovel() {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    return Column(children: [
      Container(
          margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(3, 4),
                  blurRadius: 0.5,
                  spreadRadius: 0.5)
            ],
          ),
          child: Column(
            children: [
              Observer(builder: (_) {
                return Container(
                  decoration: BoxDecoration(
                      color: KThemeModeApp.of(context).primaryBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey)),
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: DropdownButton(
                    iconSize: 30,
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    isExpanded: true,
                    style: KThemeModeApp.of(context).bodyLarge,
                    value: infoImovelStore.tipo,
                    items: infoImovelStore.tipoImovelList,
                    hint: const Text(
                      'TIPO DE IMÓVEL',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      // ALTERA VALOR SELECIONADO NO DROPDOWN
                      log("message: $value");
                      infoImovelStore.setTipo(value);

                      log('infoTipoId? ${infoImovelStore.tipo}');
                    },
                  ),
                );
              }),
            ],
          ))
    ]);
  }

  // BOTÃO DE CADASTRO E ENVIO DOS DADOS IMÓVEIS
  Widget _botaoCadastrar(formState) {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final iniciaVisitaStore =
        Provider.of<IniciaVisitaStore>(context, listen: false);

    return Column(
      children: [
        KitButton(
          widgetCenter: Text(
            "CADASTRAR",
            style: KThemeModeApp.of(context)
                .bodyLarge
                .copyWith(color: KThemeModeApp.of(context).primaryBtnText),
          ),
          iconPrefix: Icon(
            FontAwesomeIcons.save,
            color: KThemeModeApp.of(context).primaryBackground,
          ),
          iconSufix:
              const Icon(FontAwesomeIcons.save, color: Colors.transparent),
          onTap: () async {
            log("qRCode Imovel a cadastrar é : ${iniciaVisitaStore.valorQr}");

            infoImovelStore.setLoad(true);
            bool conexao = await GlobalsFunctions(context).verificaInternet();
            if (conexao) {
              // ignore: use_build_context_synchronously
              if (!(await FormularioImovelFunctions(context).validador())) {
                infoImovelStore.setLoad(false);
                // ignore: use_build_context_synchronously
                return GlobalsAlerts(context).alertErro(
                    "Atenção", "Preencha todos os campos para proseguir");
              }
              log("SEM INTERNET CAIU AQUI :>>>>>>>>>>>>>>>>>>>");
              infoImovelStore.setLoad(false);

              // ignore: use_build_context_synchronously
              return await FormularioImovelFunctions(context)
                  .cadastraImovelSemInternet(context);
            } else {
              // ignore: use_build_context_synchronously
              await ServicesRequestPostApp(context).cadastraImovel();
            }

            infoImovelStore.setLoad(false);
          },
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          iconPrefixPadding: const EdgeInsets.only(left: 15),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          decorationButton: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                KThemeModeApp.of(context).accent2,
                KThemeModeApp.of(context).accent1,
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(3, 3),
                blurRadius: 6,
                spreadRadius: 1,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: KThemeModeApp.of(context).primary,
          ),
        ),
      ],
    );
  }
}

class FormularioImovel extends StatelessWidget with ValidaFormImovel {
  final GlobalKey<FormState>? formState;
  FormularioImovel({super.key, this.formState});

  @override
  Widget build(BuildContext context) {
    final infoImovelStore =
        Provider.of<FormularioImovelStore>(context, listen: false);
    final infoImovelStoreT =
        Provider.of<FormularioImovelStore>(context, listen: true);

    return Observer(builder: (_) {
      return Column(
        children: [
          Text(
            "Informe o Endereço do Imóvel",
            style: KThemeModeApp.of(context).bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
            key: formState,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    style: KThemeModeApp.of(context).bodyMedium,
                    controller: infoImovelStoreT.controllBairro,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: KThemeModeApp.of(context).primary,
                              width: 1.0),
                        ),
                        labelText: "BAIRRO",
                        floatingLabelStyle: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(color: KThemeModeApp.of(context).primary),
                        labelStyle: const TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        )),
                    validator: isNotEmpty,
                    onChanged: FormularioImovelFunctions(context)
                        .filterSearchResultsBairro,
                    onTap: () {
                      infoImovelStore.setVisitbilidadeListaBairros(true);
                    },
                  ),
                ),
                Visibility(
                  visible: infoImovelStoreT.visibilidadeListaBairros,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: infoImovelStoreT.listaBairrosSearch.length <= 2
                        ? null
                        : MediaQuery.of(context).size.height * .3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: infoImovelStoreT.listaBairrosSearch.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color:
                                    KThemeModeApp.of(context).primaryBackground,
                                boxShadow: const [kDefaultShadow],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: GestureDetector(
                                onTap: () async {
                                  // infoImovelStore.setLoad(true);
                                  infoImovelStore
                                      .setVisitbilidadeListaBairros(false);
                                  infoImovelStore.setBairroId(
                                      infoImovelStoreT
                                          .listaBairrosSearch[index].id,
                                      infoImovelStoreT
                                          .listaBairrosSearch[index].nome);

                                  infoImovelStoreT.listaBairrosOrigin
                                      // ignore: avoid_function_literals_in_foreach_calls
                                      .forEach((element) async {
                                    if (element.id ==
                                        infoImovelStoreT.bairroIdSel) {
                                      final items =
                                          await ServiceGetRequestApp(context)
                                              .setDropQuarteirao(
                                                  element.totalQuarteirao);
                                      infoImovelStore.setDropListQuart(items);
                                    }
                                  });

                                  infoImovelStore.setLoad(false);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        infoImovelStoreT
                                                .listaBairrosSearch[index]
                                                .nome ??
                                            "",
                                        style: KThemeModeApp.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextFormField(
                        style: KThemeModeApp.of(context).bodyLarge,
                        controller: infoImovelStoreT.controllRua,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: KThemeModeApp.of(context).primary,
                                  width: 1.0),
                            ),
                            labelText: "RUA",
                            floatingLabelStyle: TextStyle(
                                color: KThemeModeApp.of(context).primary,
                                fontSize: 22),
                            labelStyle: const TextStyle(fontSize: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                            )),
                        validator: isNotEmpty,
                        onChanged: FormularioImovelFunctions(context)
                            .filterSearchResultsRua,
                        onTap: () {
                          infoImovelStore.setVisitbilidadeListaRuas(true);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: TextFormField(
                        style: KThemeModeApp.of(context).bodyLarge,
                        controller: infoImovelStoreT.controllNum,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: KThemeModeApp.of(context).primary,
                                  width: 1.0),
                            ),
                            labelText: "N°",
                            floatingLabelStyle: TextStyle(
                                color: KThemeModeApp.of(context).primary,
                                fontSize: 22),
                            labelStyle: const TextStyle(fontSize: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            alignLabelWithHint: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                            )),
                        validator: isNotEmpty,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: infoImovelStoreT.visibilidadeListaRuas,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: infoImovelStore.listaRuasSearch.length <= 2
                        ? null
                        : MediaQuery.of(context).size.height * .3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: infoImovelStore.listaRuasSearch.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color:
                                    KThemeModeApp.of(context).primaryBackground,
                                boxShadow: const [kDefaultShadow],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: GestureDetector(
                                onTap: () {
                                  infoImovelStore
                                      .setVisitbilidadeListaRuas(false);
                                  infoImovelStore.setRua(infoImovelStoreT
                                      .listaRuasSearch[index].nome);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          infoImovelStoreT
                                              .listaRuasSearch[index].nome!,
                                          style: KThemeModeApp.of(context)
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    style: KThemeModeApp.of(context).bodyLarge,
                    controller: infoImovelStoreT.controllComplemento,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: KThemeModeApp.of(context).primary,
                              width: 1.0),
                        ),
                        labelText: "Complemento",
                        floatingLabelStyle: KThemeModeApp.of(context)
                            .bodyLarge
                            .copyWith(color: KThemeModeApp.of(context).primary),
                        labelStyle: const TextStyle(fontSize: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Observer(builder: (_) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Colors.grey)),
                          height: MediaQuery.of(context).size.height * .071,
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: DropdownButton(
                            iconSize: 30,
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            style: KThemeModeApp.of(context).bodyLarge,
                            value: infoImovelStoreT.quartId,
                            items: infoImovelStoreT.jsonQuart,
                            hint: const Text(
                              'Quarteirao N°',
                              style: TextStyle(color: Colors.grey),
                            ),
                            onChanged: (value) {
                              // ALTERA VALOR SELECIONADO NO DROPDOWN
                              log("message: $value");
                              infoImovelStore.setQuartID(value);

                              log('infoTipoId? ${infoImovelStoreT.quartId}');
                            },
                          ),
                        );
                      }),
                      // Observer(builder: (_) {
                      //   return Container(
                      //     width: MediaQuery.of(context).size.width * 0.4,
                      //     child: TextFormField(
                      //       controller: infoImovelStoreT.controllQuart,
                      //       keyboardType: TextInputType.number,
                      //       decoration: InputDecoration(
                      //           focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: KThemeModeApp.of(context).primary, width: 1.0),
                      //           ),
                      //           labelText: "Quarteirão N°",
                      //           floatingLabelStyle:
                      //               TextStyle(color: KThemeModeApp.of(context).primary, fontSize: 22),
                      //           labelStyle: TextStyle(fontSize: 20),
                      //           floatingLabelBehavior:
                      //               FloatingLabelBehavior.always,
                      //           alignLabelWithHint: true,
                      //           border: OutlineInputBorder(
                      //             borderSide: BorderSide(width: 1.0),
                      //           )),
                      //       validator: isNotEmpty,
                      //       onTap: () {
                      //         // infoImoveslStore.setVisitbilidadeListaRuas(true);
                      //       },
                      //     ),
                      //   );
                      // }),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          style: KThemeModeApp.of(context).bodyLarge,
                          controller: infoImovelStoreT.controllLado,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: KThemeModeApp.of(context).primary,
                                    width: 1.0),
                              ),
                              labelText: "LADO",
                              floatingLabelStyle: TextStyle(
                                  color: KThemeModeApp.of(context).primary,
                                  fontSize: 22),
                              labelStyle: const TextStyle(fontSize: 20),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              )),
                          validator: isNotEmpty,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),
        ],
      );
    });
  }
}
