import 'package:folha/app/infra/constants.dart';
import 'package:folha/app/data/provider/api/empresa_transporte_api_provider.dart';
import 'package:folha/app/data/provider/drift/empresa_transporte_drift_provider.dart';
import 'package:folha/app/data/model/model_imports.dart';

class EmpresaTransporteRepository {
  final EmpresaTransporteApiProvider empresaTransporteApiProvider;
  final EmpresaTransporteDriftProvider empresaTransporteDriftProvider;

  EmpresaTransporteRepository({required this.empresaTransporteApiProvider, required this.empresaTransporteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await empresaTransporteDriftProvider.getList(filter: filter);
    } else {
      return await empresaTransporteApiProvider.getList(filter: filter);
    }
  }

  Future<EmpresaTransporteModel?>? save({required EmpresaTransporteModel empresaTransporteModel}) async {
    if (empresaTransporteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await empresaTransporteDriftProvider.update(empresaTransporteModel);
      } else {
        return await empresaTransporteApiProvider.update(empresaTransporteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await empresaTransporteDriftProvider.insert(empresaTransporteModel);
      } else {
        return await empresaTransporteApiProvider.insert(empresaTransporteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await empresaTransporteDriftProvider.delete(id) ?? false;
    } else {
      return await empresaTransporteApiProvider.delete(id) ?? false;
    }
  }
}