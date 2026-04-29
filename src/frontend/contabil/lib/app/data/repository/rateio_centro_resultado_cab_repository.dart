import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/rateio_centro_resultado_cab_api_provider.dart';
import 'package:contabil/app/data/provider/drift/rateio_centro_resultado_cab_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class RateioCentroResultadoCabRepository {
  final RateioCentroResultadoCabApiProvider rateioCentroResultadoCabApiProvider;
  final RateioCentroResultadoCabDriftProvider rateioCentroResultadoCabDriftProvider;

  RateioCentroResultadoCabRepository({required this.rateioCentroResultadoCabApiProvider, required this.rateioCentroResultadoCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await rateioCentroResultadoCabDriftProvider.getList(filter: filter);
    } else {
      return await rateioCentroResultadoCabApiProvider.getList(filter: filter);
    }
  }

  Future<RateioCentroResultadoCabModel?>? save({required RateioCentroResultadoCabModel rateioCentroResultadoCabModel}) async {
    if (rateioCentroResultadoCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await rateioCentroResultadoCabDriftProvider.update(rateioCentroResultadoCabModel);
      } else {
        return await rateioCentroResultadoCabApiProvider.update(rateioCentroResultadoCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await rateioCentroResultadoCabDriftProvider.insert(rateioCentroResultadoCabModel);
      } else {
        return await rateioCentroResultadoCabApiProvider.insert(rateioCentroResultadoCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await rateioCentroResultadoCabDriftProvider.delete(id) ?? false;
    } else {
      return await rateioCentroResultadoCabApiProvider.delete(id) ?? false;
    }
  }
}