import 'package:contabil/app/infra/constants.dart';
import 'package:contabil/app/data/provider/api/contabil_encerramento_exe_cab_api_provider.dart';
import 'package:contabil/app/data/provider/drift/contabil_encerramento_exe_cab_drift_provider.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class ContabilEncerramentoExeCabRepository {
  final ContabilEncerramentoExeCabApiProvider contabilEncerramentoExeCabApiProvider;
  final ContabilEncerramentoExeCabDriftProvider contabilEncerramentoExeCabDriftProvider;

  ContabilEncerramentoExeCabRepository({required this.contabilEncerramentoExeCabApiProvider, required this.contabilEncerramentoExeCabDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilEncerramentoExeCabDriftProvider.getList(filter: filter);
    } else {
      return await contabilEncerramentoExeCabApiProvider.getList(filter: filter);
    }
  }

  Future<ContabilEncerramentoExeCabModel?>? save({required ContabilEncerramentoExeCabModel contabilEncerramentoExeCabModel}) async {
    if (contabilEncerramentoExeCabModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await contabilEncerramentoExeCabDriftProvider.update(contabilEncerramentoExeCabModel);
      } else {
        return await contabilEncerramentoExeCabApiProvider.update(contabilEncerramentoExeCabModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await contabilEncerramentoExeCabDriftProvider.insert(contabilEncerramentoExeCabModel);
      } else {
        return await contabilEncerramentoExeCabApiProvider.insert(contabilEncerramentoExeCabModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await contabilEncerramentoExeCabDriftProvider.delete(id) ?? false;
    } else {
      return await contabilEncerramentoExeCabApiProvider.delete(id) ?? false;
    }
  }
}