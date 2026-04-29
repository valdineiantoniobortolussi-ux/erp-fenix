import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_natureza_financeira_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_natureza_financeira_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinNaturezaFinanceiraRepository {
  final FinNaturezaFinanceiraApiProvider finNaturezaFinanceiraApiProvider;
  final FinNaturezaFinanceiraDriftProvider finNaturezaFinanceiraDriftProvider;

  FinNaturezaFinanceiraRepository({required this.finNaturezaFinanceiraApiProvider, required this.finNaturezaFinanceiraDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finNaturezaFinanceiraDriftProvider.getList(filter: filter);
    } else {
      return await finNaturezaFinanceiraApiProvider.getList(filter: filter);
    }
  }

  Future<FinNaturezaFinanceiraModel?>? save({required FinNaturezaFinanceiraModel finNaturezaFinanceiraModel}) async {
    if (finNaturezaFinanceiraModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finNaturezaFinanceiraDriftProvider.update(finNaturezaFinanceiraModel);
      } else {
        return await finNaturezaFinanceiraApiProvider.update(finNaturezaFinanceiraModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finNaturezaFinanceiraDriftProvider.insert(finNaturezaFinanceiraModel);
      } else {
        return await finNaturezaFinanceiraApiProvider.insert(finNaturezaFinanceiraModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finNaturezaFinanceiraDriftProvider.delete(id) ?? false;
    } else {
      return await finNaturezaFinanceiraApiProvider.delete(id) ?? false;
    }
  }
}