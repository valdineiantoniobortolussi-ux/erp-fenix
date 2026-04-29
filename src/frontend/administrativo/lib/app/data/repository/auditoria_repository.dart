import 'package:administrativo/app/infra/constants.dart';
import 'package:administrativo/app/data/provider/api/auditoria_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/auditoria_drift_provider.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class AuditoriaRepository {
  final AuditoriaApiProvider auditoriaApiProvider;
  final AuditoriaDriftProvider auditoriaDriftProvider;

  AuditoriaRepository({required this.auditoriaApiProvider, required this.auditoriaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await auditoriaDriftProvider.getList(filter: filter);
    } else {
      return await auditoriaApiProvider.getList(filter: filter);
    }
  }

  Future<AuditoriaModel?>? save({required AuditoriaModel auditoriaModel}) async {
    if (auditoriaModel.id != null) {
      if (Constants.usingLocalDatabase) {
        return await auditoriaDriftProvider.update(auditoriaModel);
      } else {
        return await auditoriaApiProvider.update(auditoriaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await auditoriaDriftProvider.insert(auditoriaModel);
      } else {
        return await auditoriaApiProvider.insert(auditoriaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await auditoriaDriftProvider.delete(id) ?? false;
    } else {
      return await auditoriaApiProvider.delete(id) ?? false;
    }
  }
}