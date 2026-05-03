import 'package:pcp/app/infra/constants.dart';
import 'package:pcp/app/data/provider/api/pcp_instrucao_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_instrucao_drift_provider.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpInstrucaoRepository {
  final PcpInstrucaoApiProvider pcpInstrucaoApiProvider;
  final PcpInstrucaoDriftProvider pcpInstrucaoDriftProvider;

  PcpInstrucaoRepository({required this.pcpInstrucaoApiProvider, required this.pcpInstrucaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpInstrucaoDriftProvider.getList(filter: filter);
    } else {
      return await pcpInstrucaoApiProvider.getList(filter: filter);
    }
  }

  Future<PcpInstrucaoModel?>? save({required PcpInstrucaoModel pcpInstrucaoModel}) async {
    if (pcpInstrucaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pcpInstrucaoDriftProvider.update(pcpInstrucaoModel);
      } else {
        return await pcpInstrucaoApiProvider.update(pcpInstrucaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pcpInstrucaoDriftProvider.insert(pcpInstrucaoModel);
      } else {
        return await pcpInstrucaoApiProvider.insert(pcpInstrucaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpInstrucaoDriftProvider.delete(id) ?? false;
    } else {
      return await pcpInstrucaoApiProvider.delete(id) ?? false;
    }
  }
}