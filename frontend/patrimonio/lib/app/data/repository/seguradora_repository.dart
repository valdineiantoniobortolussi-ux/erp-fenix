import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/seguradora_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/seguradora_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class SeguradoraRepository {
  final SeguradoraApiProvider seguradoraApiProvider;
  final SeguradoraDriftProvider seguradoraDriftProvider;

  SeguradoraRepository({required this.seguradoraApiProvider, required this.seguradoraDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await seguradoraDriftProvider.getList(filter: filter);
    } else {
      return await seguradoraApiProvider.getList(filter: filter);
    }
  }

  Future<SeguradoraModel?>? save({required SeguradoraModel seguradoraModel}) async {
    if (seguradoraModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await seguradoraDriftProvider.update(seguradoraModel);
      } else {
        return await seguradoraApiProvider.update(seguradoraModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await seguradoraDriftProvider.insert(seguradoraModel);
      } else {
        return await seguradoraApiProvider.insert(seguradoraModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await seguradoraDriftProvider.delete(id) ?? false;
    } else {
      return await seguradoraApiProvider.delete(id) ?? false;
    }
  }
}