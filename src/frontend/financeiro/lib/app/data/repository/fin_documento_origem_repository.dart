import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_documento_origem_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_documento_origem_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinDocumentoOrigemRepository {
  final FinDocumentoOrigemApiProvider finDocumentoOrigemApiProvider;
  final FinDocumentoOrigemDriftProvider finDocumentoOrigemDriftProvider;

  FinDocumentoOrigemRepository({required this.finDocumentoOrigemApiProvider, required this.finDocumentoOrigemDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finDocumentoOrigemDriftProvider.getList(filter: filter);
    } else {
      return await finDocumentoOrigemApiProvider.getList(filter: filter);
    }
  }

  Future<FinDocumentoOrigemModel?>? save({required FinDocumentoOrigemModel finDocumentoOrigemModel}) async {
    if (finDocumentoOrigemModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finDocumentoOrigemDriftProvider.update(finDocumentoOrigemModel);
      } else {
        return await finDocumentoOrigemApiProvider.update(finDocumentoOrigemModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finDocumentoOrigemDriftProvider.insert(finDocumentoOrigemModel);
      } else {
        return await finDocumentoOrigemApiProvider.insert(finDocumentoOrigemModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finDocumentoOrigemDriftProvider.delete(id) ?? false;
    } else {
      return await finDocumentoOrigemApiProvider.delete(id) ?? false;
    }
  }
}