import 'package:esocial/app/infra/constants.dart';
import 'package:esocial/app/data/provider/api/esocial_motivo_desligamento_api_provider.dart';
import 'package:esocial/app/data/provider/drift/esocial_motivo_desligamento_drift_provider.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialMotivoDesligamentoRepository {
  final EsocialMotivoDesligamentoApiProvider esocialMotivoDesligamentoApiProvider;
  final EsocialMotivoDesligamentoDriftProvider esocialMotivoDesligamentoDriftProvider;

  EsocialMotivoDesligamentoRepository({required this.esocialMotivoDesligamentoApiProvider, required this.esocialMotivoDesligamentoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialMotivoDesligamentoDriftProvider.getList(filter: filter);
    } else {
      return await esocialMotivoDesligamentoApiProvider.getList(filter: filter);
    }
  }

  Future<EsocialMotivoDesligamentoModel?>? save({required EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel}) async {
    if (esocialMotivoDesligamentoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await esocialMotivoDesligamentoDriftProvider.update(esocialMotivoDesligamentoModel);
      } else {
        return await esocialMotivoDesligamentoApiProvider.update(esocialMotivoDesligamentoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await esocialMotivoDesligamentoDriftProvider.insert(esocialMotivoDesligamentoModel);
      } else {
        return await esocialMotivoDesligamentoApiProvider.insert(esocialMotivoDesligamentoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await esocialMotivoDesligamentoDriftProvider.delete(id) ?? false;
    } else {
      return await esocialMotivoDesligamentoApiProvider.delete(id) ?? false;
    }
  }
}