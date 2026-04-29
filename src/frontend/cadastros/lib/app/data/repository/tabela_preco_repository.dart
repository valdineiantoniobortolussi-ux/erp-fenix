import 'package:cadastros/app/infra/constants.dart';
import 'package:cadastros/app/data/provider/api/tabela_preco_api_provider.dart';
import 'package:cadastros/app/data/provider/drift/tabela_preco_drift_provider.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TabelaPrecoRepository {
  final TabelaPrecoApiProvider tabelaPrecoApiProvider;
  final TabelaPrecoDriftProvider tabelaPrecoDriftProvider;

  TabelaPrecoRepository({required this.tabelaPrecoApiProvider, required this.tabelaPrecoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await tabelaPrecoDriftProvider.getList(filter: filter);
    } else {
      return await tabelaPrecoApiProvider.getList(filter: filter);
    }
  }

  Future<TabelaPrecoModel?>? save({required TabelaPrecoModel tabelaPrecoModel}) async {
    if (tabelaPrecoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await tabelaPrecoDriftProvider.update(tabelaPrecoModel);
      } else {
        return await tabelaPrecoApiProvider.update(tabelaPrecoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await tabelaPrecoDriftProvider.insert(tabelaPrecoModel);
      } else {
        return await tabelaPrecoApiProvider.insert(tabelaPrecoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await tabelaPrecoDriftProvider.delete(id) ?? false;
    } else {
      return await tabelaPrecoApiProvider.delete(id) ?? false;
    }
  }
}