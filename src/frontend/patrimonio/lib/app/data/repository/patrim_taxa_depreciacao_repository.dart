import 'package:patrimonio/app/infra/constants.dart';
import 'package:patrimonio/app/data/provider/api/patrim_taxa_depreciacao_api_provider.dart';
import 'package:patrimonio/app/data/provider/drift/patrim_taxa_depreciacao_drift_provider.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTaxaDepreciacaoRepository {
  final PatrimTaxaDepreciacaoApiProvider patrimTaxaDepreciacaoApiProvider;
  final PatrimTaxaDepreciacaoDriftProvider patrimTaxaDepreciacaoDriftProvider;

  PatrimTaxaDepreciacaoRepository({required this.patrimTaxaDepreciacaoApiProvider, required this.patrimTaxaDepreciacaoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTaxaDepreciacaoDriftProvider.getList(filter: filter);
    } else {
      return await patrimTaxaDepreciacaoApiProvider.getList(filter: filter);
    }
  }

  Future<PatrimTaxaDepreciacaoModel?>? save({required PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel}) async {
    if (patrimTaxaDepreciacaoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await patrimTaxaDepreciacaoDriftProvider.update(patrimTaxaDepreciacaoModel);
      } else {
        return await patrimTaxaDepreciacaoApiProvider.update(patrimTaxaDepreciacaoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await patrimTaxaDepreciacaoDriftProvider.insert(patrimTaxaDepreciacaoModel);
      } else {
        return await patrimTaxaDepreciacaoApiProvider.insert(patrimTaxaDepreciacaoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await patrimTaxaDepreciacaoDriftProvider.delete(id) ?? false;
    } else {
      return await patrimTaxaDepreciacaoApiProvider.delete(id) ?? false;
    }
  }
}