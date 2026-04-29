import 'package:wms/app/infra/constants.dart';
import 'package:wms/app/data/provider/api/wms_agendamento_api_provider.dart';
import 'package:wms/app/data/provider/drift/wms_agendamento_drift_provider.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsAgendamentoRepository {
  final WmsAgendamentoApiProvider wmsAgendamentoApiProvider;
  final WmsAgendamentoDriftProvider wmsAgendamentoDriftProvider;

  WmsAgendamentoRepository({required this.wmsAgendamentoApiProvider, required this.wmsAgendamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsAgendamentoDriftProvider.getList(filter: filter);
    } else {
      return await wmsAgendamentoApiProvider.getList(filter: filter);
    }
  }

  Future<WmsAgendamentoModel?>? save({required WmsAgendamentoModel wmsAgendamentoModel}) async {
    if (wmsAgendamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await wmsAgendamentoDriftProvider.update(wmsAgendamentoModel);
      } else {
        return await wmsAgendamentoApiProvider.update(wmsAgendamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await wmsAgendamentoDriftProvider.insert(wmsAgendamentoModel);
      } else {
        return await wmsAgendamentoApiProvider.insert(wmsAgendamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await wmsAgendamentoDriftProvider.delete(id) ?? false;
    } else {
      return await wmsAgendamentoApiProvider.delete(id) ?? false;
    }
  }
}