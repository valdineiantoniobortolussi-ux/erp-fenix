import 'package:fiscal/app/infra/constants.dart';
import 'package:fiscal/app/data/provider/api/simples_nacional_cabecalho_api_provider.dart';
import 'package:fiscal/app/data/provider/drift/simples_nacional_cabecalho_drift_provider.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class SimplesNacionalCabecalhoRepository {
  final SimplesNacionalCabecalhoApiProvider simplesNacionalCabecalhoApiProvider;
  final SimplesNacionalCabecalhoDriftProvider simplesNacionalCabecalhoDriftProvider;

  SimplesNacionalCabecalhoRepository({required this.simplesNacionalCabecalhoApiProvider, required this.simplesNacionalCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await simplesNacionalCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await simplesNacionalCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<SimplesNacionalCabecalhoModel?>? save({required SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel}) async {
    if (simplesNacionalCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await simplesNacionalCabecalhoDriftProvider.update(simplesNacionalCabecalhoModel);
      } else {
        return await simplesNacionalCabecalhoApiProvider.update(simplesNacionalCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await simplesNacionalCabecalhoDriftProvider.insert(simplesNacionalCabecalhoModel);
      } else {
        return await simplesNacionalCabecalhoApiProvider.insert(simplesNacionalCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await simplesNacionalCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await simplesNacionalCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}