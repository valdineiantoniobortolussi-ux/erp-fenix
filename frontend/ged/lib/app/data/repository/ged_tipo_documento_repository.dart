import 'package:ged/app/infra/constants.dart';
import 'package:ged/app/data/provider/api/ged_tipo_documento_api_provider.dart';
import 'package:ged/app/data/provider/drift/ged_tipo_documento_drift_provider.dart';
import 'package:ged/app/data/model/model_imports.dart';

class GedTipoDocumentoRepository {
  final GedTipoDocumentoApiProvider gedTipoDocumentoApiProvider;
  final GedTipoDocumentoDriftProvider gedTipoDocumentoDriftProvider;

  GedTipoDocumentoRepository({required this.gedTipoDocumentoApiProvider, required this.gedTipoDocumentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gedTipoDocumentoDriftProvider.getList(filter: filter);
    } else {
      return await gedTipoDocumentoApiProvider.getList(filter: filter);
    }
  }

  Future<GedTipoDocumentoModel?>? save({required GedTipoDocumentoModel gedTipoDocumentoModel}) async {
    if (gedTipoDocumentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gedTipoDocumentoDriftProvider.update(gedTipoDocumentoModel);
      } else {
        return await gedTipoDocumentoApiProvider.update(gedTipoDocumentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gedTipoDocumentoDriftProvider.insert(gedTipoDocumentoModel);
      } else {
        return await gedTipoDocumentoApiProvider.insert(gedTipoDocumentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gedTipoDocumentoDriftProvider.delete(id) ?? false;
    } else {
      return await gedTipoDocumentoApiProvider.delete(id) ?? false;
    }
  }
}