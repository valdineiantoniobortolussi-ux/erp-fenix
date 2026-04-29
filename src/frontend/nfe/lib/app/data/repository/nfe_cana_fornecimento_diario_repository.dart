import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_cana_fornecimento_diario_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_cana_fornecimento_diario_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaFornecimentoDiarioRepository {
  final NfeCanaFornecimentoDiarioApiProvider nfeCanaFornecimentoDiarioApiProvider;
  final NfeCanaFornecimentoDiarioDriftProvider nfeCanaFornecimentoDiarioDriftProvider;

  NfeCanaFornecimentoDiarioRepository({required this.nfeCanaFornecimentoDiarioApiProvider, required this.nfeCanaFornecimentoDiarioDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCanaFornecimentoDiarioDriftProvider.getList(filter: filter);
    } else {
      return await nfeCanaFornecimentoDiarioApiProvider.getList(filter: filter);
    }
  }

  Future<NfeCanaFornecimentoDiarioModel?>? save({required NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel}) async {
    if (nfeCanaFornecimentoDiarioModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeCanaFornecimentoDiarioDriftProvider.update(nfeCanaFornecimentoDiarioModel);
      } else {
        return await nfeCanaFornecimentoDiarioApiProvider.update(nfeCanaFornecimentoDiarioModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeCanaFornecimentoDiarioDriftProvider.insert(nfeCanaFornecimentoDiarioModel);
      } else {
        return await nfeCanaFornecimentoDiarioApiProvider.insert(nfeCanaFornecimentoDiarioModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCanaFornecimentoDiarioDriftProvider.delete(id) ?? false;
    } else {
      return await nfeCanaFornecimentoDiarioApiProvider.delete(id) ?? false;
    }
  }
}