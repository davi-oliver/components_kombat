// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeVigStore on _HomeVigStoreBase, Store {
  late final _$loadAtom =
      Atom(name: '_HomeVigStoreBase.load', context: context);

  @override
  bool get load {
    _$loadAtom.reportRead();
    return super.load;
  }

  @override
  set load(bool value) {
    _$loadAtom.reportWrite(value, super.load, () {
      super.load = value;
    });
  }

  late final _$_HomeVigStoreBaseActionController =
      ActionController(name: '_HomeVigStoreBase', context: context);

  @override
  void setLoading(dynamic _value) {
    final _$actionInfo = _$_HomeVigStoreBaseActionController.startAction(
        name: '_HomeVigStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_HomeVigStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
load: ${load}
    ''';
  }
}
