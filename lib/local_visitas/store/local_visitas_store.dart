import 'package:mobx/mobx.dart';
part 'local_visitas_store.g.dart';

class LocalVisitasStore = _LocalVisitasStoreBase with _$LocalVisitasStore;

abstract class _LocalVisitasStoreBase with Store {
  ObservableList listaVisitasAgenteLocal = ObservableList();

  @action
  void setAddAllListaVisitasAgenteLocal(_element) {
    listaVisitasAgenteLocal.clear();
    listaVisitasAgenteLocal.addAll(_element);
  }

  @action
  void setAddListaVisitasAgenteLocal(element) {
    if (element != null) {
      if (!listaVisitasAgenteLocal.contains(element)) {
        listaVisitasAgenteLocal.add(element);
      }
    }
  }
}
