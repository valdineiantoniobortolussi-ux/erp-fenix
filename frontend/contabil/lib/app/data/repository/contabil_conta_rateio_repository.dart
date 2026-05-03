import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_conta_rateio_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_conta_rateio_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilContaRateioRepository {
  final ContabilContaRateioApiProvider contabilContaRateioApiProvider;
  final ContabilContaRateioDriftProvider contabilContaRateioDriftProvider;

  ContabilContaRateioRepository({required this.contabilContaRateioApiProvider, required this.contabilContaRateioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilContaRateioDriftProvider.getList(filter: filter);
    } else {
      return await contabilContaRateioApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilContaRateioModel?>? save({required ContabilContaRateioModel contabilContaRateioModel}) async {
    if (contabilContaRateioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilContaRateioDriftProvider.update(contabilContaRateioModel);
      } else {
        return await contabilContaRateioApiProvider.update(contabilContaRateioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilContaRateioDriftProvider.insert(contabilContaRateioModel);
      } else {
        return await contabilContaRateioApiProvider.insert(contabilContaRateioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilContaRateioDriftProvider.delete(id) ?? false;
    } else {
      return await contabilContaRateioApiProvider.delete(id) ?? false;
    }
  }
}