import 'package:sped/app/infra/constants.dart';
import 'package:sped/app/data/provider/api/sped_fiscal_api_provider.dart';
import 'package:sped/app/data/provider/drift/sped_fiscal_drift_provider.dart';
import 'package:sped/app/data/model/model_imports.dart';

class SpedFiscalRepository {
  final SpedFiscalApiProvider spedFiscalApiProvider;
  final SpedFiscalDriftProvider spedFiscalDriftProvider;

  SpedFiscalRepository({required this.spedFiscalApiProvider, required this.spedFiscalDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await spedFiscalDriftProvider.getList(filter: filter);
    } else {
      return await spedFiscalApiProvider.getList(filter: filter);
    }
  }

  Future<SpedFiscalModel?>? save({required SpedFiscalModel spedFiscalModel}) async {
    if (spedFiscalModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await spedFiscalDriftProvider.update(spedFiscalModel);
      } else {
        return await spedFiscalApiProvider.update(spedFiscalModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await spedFiscalDriftProvider.insert(spedFiscalModel);
      } else {
        return await spedFiscalApiProvider.insert(spedFiscalModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await spedFiscalDriftProvider.delete(id) ?? false;
    } else {
      return await spedFiscalApiProvider.delete(id) ?? false;
    }
  }
}