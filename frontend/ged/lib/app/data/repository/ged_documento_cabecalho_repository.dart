import 'package:ged/app/infra/constants.dart';
import 'package:ged/app/data/provider/api/ged_documento_cabecalho_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_documento_cabecalho_drift_provider.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedDocumentoCabecalhoRepository {
  final GedDocumentoCabecalhoApiProvider gedDocumentoCabecalhoApiProvider;
  final GedDocumentoCabecalhoDriftProvider gedDocumentoCabecalhoDriftProvider;

  GedDocumentoCabecalhoRepository({required this.gedDocumentoCabecalhoApiProvider, required this.gedDocumentoCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gedDocumentoCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await gedDocumentoCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<GedDocumentoCabecalhoModel?>? save({required GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel}) async {
    if (gedDocumentoCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gedDocumentoCabecalhoDriftProvider.update(gedDocumentoCabecalhoModel);
      } else {
        return await gedDocumentoCabecalhoApiProvider.update(gedDocumentoCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gedDocumentoCabecalhoDriftProvider.insert(gedDocumentoCabecalhoModel);
      } else {
        return await gedDocumentoCabecalhoApiProvider.insert(gedDocumentoCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gedDocumentoCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await gedDocumentoCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}