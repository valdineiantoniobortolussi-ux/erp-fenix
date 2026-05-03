import 'package:pcp/app/infra/constants.dart';
import 'package:pcp/app/data/provider/api/pcp_op_cabecalho_api_provider.dart';
import 'package:pcp/app/data/provider/drift/pcp_op_cabecalho_drift_provider.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpOpCabecalhoRepository {
  final PcpOpCabecalhoApiProvider pcpOpCabecalhoApiProvider;
  final PcpOpCabecalhoDriftProvider pcpOpCabecalhoDriftProvider;

  PcpOpCabecalhoRepository({required this.pcpOpCabecalhoApiProvider, required this.pcpOpCabecalhoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpOpCabecalhoDriftProvider.getList(filter: filter);
    } else {
      return await pcpOpCabecalhoApiProvider.getList(filter: filter);
    }
  }

  Future<PcpOpCabecalhoModel?>? save({required PcpOpCabecalhoModel pcpOpCabecalhoModel}) async {
    if (pcpOpCabecalhoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pcpOpCabecalhoDriftProvider.update(pcpOpCabecalhoModel);
      } else {
        return await pcpOpCabecalhoApiProvider.update(pcpOpCabecalhoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pcpOpCabecalhoDriftProvider.insert(pcpOpCabecalhoModel);
      } else {
        return await pcpOpCabecalhoApiProvider.insert(pcpOpCabecalhoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pcpOpCabecalhoDriftProvider.delete(id) ?? false;
    } else {
      return await pcpOpCabecalhoApiProvider.delete(id) ?? false;
    }
  }
}