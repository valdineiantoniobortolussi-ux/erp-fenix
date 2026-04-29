import 'package:gondolas/app/infra/constants.dart';
import 'package:gondolas/app/data/provider/api/gondola_estante_api_provider.dart';
import 'package:gondolas/app/data/provider/drift/gondola_estante_drift_provider.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaEstanteRepository {
  final GondolaEstanteApiProvider gondolaEstanteApiProvider;
  final GondolaEstanteDriftProvider gondolaEstanteDriftProvider;

  GondolaEstanteRepository({required this.gondolaEstanteApiProvider, required this.gondolaEstanteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaEstanteDriftProvider.getList(filter: filter);
    } else {
      return await gondolaEstanteApiProvider.getList(filter: filter);
    }
  }

  Future<GondolaEstanteModel?>? save({required GondolaEstanteModel gondolaEstanteModel}) async {
    if (gondolaEstanteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await gondolaEstanteDriftProvider.update(gondolaEstanteModel);
      } else {
        return await gondolaEstanteApiProvider.update(gondolaEstanteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await gondolaEstanteDriftProvider.insert(gondolaEstanteModel);
      } else {
        return await gondolaEstanteApiProvider.insert(gondolaEstanteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await gondolaEstanteDriftProvider.delete(id) ?? false;
    } else {
      return await gondolaEstanteApiProvider.delete(id) ?? false;
    }
  }
}