import 'package:ordem_servico/app/infra/constants.dart';
import 'package:ordem_servico/app/data/provider/api/os_equipamento_api_provider.dart';
import 'package:ordem_servico/app/data/provider/drift/os_equipamento_drift_provider.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsEquipamentoRepository {
  final OsEquipamentoApiProvider osEquipamentoApiProvider;
  final OsEquipamentoDriftProvider osEquipamentoDriftProvider;

  OsEquipamentoRepository({required this.osEquipamentoApiProvider, required this.osEquipamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await osEquipamentoDriftProvider.getList(filter: filter);
    } else {
      return await osEquipamentoApiProvider.getList(filter: filter);
    }
  }

  Future<OsEquipamentoModel?>? save({required OsEquipamentoModel osEquipamentoModel}) async {
    if (osEquipamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await osEquipamentoDriftProvider.update(osEquipamentoModel);
      } else {
        return await osEquipamentoApiProvider.update(osEquipamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await osEquipamentoDriftProvider.insert(osEquipamentoModel);
      } else {
        return await osEquipamentoApiProvider.insert(osEquipamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await osEquipamentoDriftProvider.delete(id) ?? false;
    } else {
      return await osEquipamentoApiProvider.delete(id) ?? false;
    }
  }
}