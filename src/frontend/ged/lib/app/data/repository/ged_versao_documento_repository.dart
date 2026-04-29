import 'package:ged/app/infra/constants.dart';
import 'package:ged/app/data/provider/api/ged_versao_documento_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_versao_documento_drift_provider.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedVersaoDocumentoRepository {
  final GedVersaoDocumentoApiProvider gedVersaoDocumentoApiProvider;
  final GedVersaoDocumentoDriftProvider gedVersaoDocumentoDriftProvider;

  GedVersaoDocumentoRepository({required this.gedVersaoDocumentoApiProvider, required this.gedVersaoDocumentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gedVersaoDocumentoDriftProvider.getList(filter: filter);
    } else {
      return await gedVersaoDocumentoApiProvider.getList(filter: filter);
    }
  }

  Future<GedVersaoDocumentoModel?>? save({required GedVersaoDocumentoModel gedVersaoDocumentoModel}) async {
    if (gedVersaoDocumentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gedVersaoDocumentoDriftProvider.update(gedVersaoDocumentoModel);
      } else {
        return await gedVersaoDocumentoApiProvider.update(gedVersaoDocumentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gedVersaoDocumentoDriftProvider.insert(gedVersaoDocumentoModel);
      } else {
        return await gedVersaoDocumentoApiProvider.insert(gedVersaoDocumentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gedVersaoDocumentoDriftProvider.delete(id) ?? false;
    } else {
      return await gedVersaoDocumentoApiProvider.delete(id) ?? false;
    }
  }
}