import 'package:etiquetas/app/infra/constants.dart';
import 'package:etiquetas/app/data/provider/api/etiqueta_layout_api_provider.dart';
import 'package:etiquetas/app/data/provider/drift/etiqueta_layout_drift_provider.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaLayoutRepository {
  final EtiquetaLayoutApiProvider etiquetaLayoutApiProvider;
  final EtiquetaLayoutDriftProvider etiquetaLayoutDriftProvider;

  EtiquetaLayoutRepository({required this.etiquetaLayoutApiProvider, required this.etiquetaLayoutDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await etiquetaLayoutDriftProvider.getList(filter: filter);
    } else {
      return await etiquetaLayoutApiProvider.getList(filter: filter);
    }
  }

  Future<EtiquetaLayoutModel?>? save({required EtiquetaLayoutModel etiquetaLayoutModel}) async {
    if (etiquetaLayoutModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await etiquetaLayoutDriftProvider.update(etiquetaLayoutModel);
      } else {
        return await etiquetaLayoutApiProvider.update(etiquetaLayoutModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await etiquetaLayoutDriftProvider.insert(etiquetaLayoutModel);
      } else {
        return await etiquetaLayoutApiProvider.insert(etiquetaLayoutModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await etiquetaLayoutDriftProvider.delete(id) ?? false;
    } else {
      return await etiquetaLayoutApiProvider.delete(id) ?? false;
    }
  }
}