import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/tribut_operacao_fiscal_api_provider.dart';
import 'package:nfe/app/data/provider/drift/tribut_operacao_fiscal_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class TributOperacaoFiscalRepository {
  final TributOperacaoFiscalApiProvider tributOperacaoFiscalApiProvider;
  final TributOperacaoFiscalDriftProvider tributOperacaoFiscalDriftProvider;

  TributOperacaoFiscalRepository({required this.tributOperacaoFiscalApiProvider, required this.tributOperacaoFiscalDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tributOperacaoFiscalDriftProvider.getList(filter: filter);
    } else {
      return await tributOperacaoFiscalApiProvider.getList(filter: filter);
    }
  }

  Future<TributOperacaoFiscalModel?>? save({required TributOperacaoFiscalModel tributOperacaoFiscalModel}) async {
    if (tributOperacaoFiscalModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tributOperacaoFiscalDriftProvider.update(tributOperacaoFiscalModel);
      } else {
        return await tributOperacaoFiscalApiProvider.update(tributOperacaoFiscalModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tributOperacaoFiscalDriftProvider.insert(tributOperacaoFiscalModel);
      } else {
        return await tributOperacaoFiscalApiProvider.insert(tributOperacaoFiscalModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tributOperacaoFiscalDriftProvider.delete(id) ?? false;
    } else {
      return await tributOperacaoFiscalApiProvider.delete(id) ?? false;
    }
  }
}