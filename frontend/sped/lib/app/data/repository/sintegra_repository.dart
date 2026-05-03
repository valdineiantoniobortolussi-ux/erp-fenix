import 'package:sped/app/infra/constants.dart';
import 'package:sped/app/data/provider/api/sintegra_api_provider.dart';
import 'package:sped/app/data/provider/drift/sintegra_drift_provider.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SintegraRepository {
  final SintegraApiProvider sintegraApiProvider;
  final SintegraDriftProvider sintegraDriftProvider;

  SintegraRepository({required this.sintegraApiProvider, required this.sintegraDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await sintegraDriftProvider.getList(filter: filter);
    } else {
      return await sintegraApiProvider.getList(filter: filter);
    }
  }

  Future<SintegraModel?>? save({required SintegraModel sintegraModel}) async {
    if (sintegraModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await sintegraDriftProvider.update(sintegraModel);
      } else {
        return await sintegraApiProvider.update(sintegraModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await sintegraDriftProvider.insert(sintegraModel);
      } else {
        return await sintegraApiProvider.insert(sintegraModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await sintegraDriftProvider.delete(id) ?? false;
    } else {
      return await sintegraApiProvider.delete(id) ?? false;
    }
  }
}