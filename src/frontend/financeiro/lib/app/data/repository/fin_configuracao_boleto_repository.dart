import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/fin_configuracao_boleto_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/fin_configuracao_boleto_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class FinConfiguracaoBoletoRepository {
  final FinConfiguracaoBoletoApiProvider finConfiguracaoBoletoApiProvider;
  final FinConfiguracaoBoletoDriftProvider finConfiguracaoBoletoDriftProvider;

  FinConfiguracaoBoletoRepository({required this.finConfiguracaoBoletoApiProvider, required this.finConfiguracaoBoletoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await finConfiguracaoBoletoDriftProvider.getList(filter: filter);
    } else {
      return await finConfiguracaoBoletoApiProvider.getList(filter: filter);
    }
  }

  Future<FinConfiguracaoBoletoModel?>? save({required FinConfiguracaoBoletoModel finConfiguracaoBoletoModel}) async {
    if (finConfiguracaoBoletoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await finConfiguracaoBoletoDriftProvider.update(finConfiguracaoBoletoModel);
      } else {
        return await finConfiguracaoBoletoApiProvider.update(finConfiguracaoBoletoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await finConfiguracaoBoletoDriftProvider.insert(finConfiguracaoBoletoModel);
      } else {
        return await finConfiguracaoBoletoApiProvider.insert(finConfiguracaoBoletoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await finConfiguracaoBoletoDriftProvider.delete(id) ?? false;
    } else {
      return await finConfiguracaoBoletoApiProvider.delete(id) ?? false;
    }
  }
}