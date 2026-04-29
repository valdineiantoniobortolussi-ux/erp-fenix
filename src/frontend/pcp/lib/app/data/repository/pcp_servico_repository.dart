import 'package:pcp/app/infra/constants.dart';
import 'package:pcp/app/data/provider/api/pcp_servico_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_servico_drift_provider.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpServicoRepository {
  final PcpServicoApiProvider pcpServicoApiProvider;
  final PcpServicoDriftProvider pcpServicoDriftProvider;

  PcpServicoRepository({required this.pcpServicoApiProvider, required this.pcpServicoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpServicoDriftProvider.getList(filter: filter);
    } else {
      return await pcpServicoApiProvider.getList(filter: filter);
    }
  }

  Future<PcpServicoModel?>? save({required PcpServicoModel pcpServicoModel}) async {
    if (pcpServicoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pcpServicoDriftProvider.update(pcpServicoModel);
      } else {
        return await pcpServicoApiProvider.update(pcpServicoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pcpServicoDriftProvider.insert(pcpServicoModel);
      } else {
        return await pcpServicoApiProvider.insert(pcpServicoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpServicoDriftProvider.delete(id) ?? false;
    } else {
      return await pcpServicoApiProvider.delete(id) ?? false;
    }
  }
}