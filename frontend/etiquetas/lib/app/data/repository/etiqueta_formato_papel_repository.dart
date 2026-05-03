import 'package:etiquetas/app/infra/constants.dart';
import 'package:etiquetas/app/data/provider/api/etiqueta_formato_papel_api_provider.dart';
import 'package:etiquetas/app/data/provider/drift/etiqueta_formato_papel_drift_provider.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaFormatoPapelRepository {
  final EtiquetaFormatoPapelApiProvider etiquetaFormatoPapelApiProvider;
  final EtiquetaFormatoPapelDriftProvider etiquetaFormatoPapelDriftProvider;

  EtiquetaFormatoPapelRepository({required this.etiquetaFormatoPapelApiProvider, required this.etiquetaFormatoPapelDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await etiquetaFormatoPapelDriftProvider.getList(filter: filter);
    } else {
      return await etiquetaFormatoPapelApiProvider.getList(filter: filter);
    }
  }

  Future<EtiquetaFormatoPapelModel?>? save({required EtiquetaFormatoPapelModel etiquetaFormatoPapelModel}) async {
    if (etiquetaFormatoPapelModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await etiquetaFormatoPapelDriftProvider.update(etiquetaFormatoPapelModel);
      } else {
        return await etiquetaFormatoPapelApiProvider.update(etiquetaFormatoPapelModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await etiquetaFormatoPapelDriftProvider.insert(etiquetaFormatoPapelModel);
      } else {
        return await etiquetaFormatoPapelApiProvider.insert(etiquetaFormatoPapelModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await etiquetaFormatoPapelDriftProvider.delete(id) ?? false;
    } else {
      return await etiquetaFormatoPapelApiProvider.delete(id) ?? false;
    }
  }
}