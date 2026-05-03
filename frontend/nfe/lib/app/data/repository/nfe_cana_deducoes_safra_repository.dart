import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_cana_deducoes_safra_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_cana_deducoes_safra_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaDeducoesSafraRepository {
  final NfeCanaDeducoesSafraApiProvider nfeCanaDeducoesSafraApiProvider;
  final NfeCanaDeducoesSafraDriftProvider nfeCanaDeducoesSafraDriftProvider;

  NfeCanaDeducoesSafraRepository({required this.nfeCanaDeducoesSafraApiProvider, required this.nfeCanaDeducoesSafraDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCanaDeducoesSafraDriftProvider.getList(filter: filter);
    } else {
      return await nfeCanaDeducoesSafraApiProvider.getList(filter: filter);
    }
  }

  Future<NfeCanaDeducoesSafraModel?>? save({required NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel}) async {
    if (nfeCanaDeducoesSafraModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeCanaDeducoesSafraDriftProvider.update(nfeCanaDeducoesSafraModel);
      } else {
        return await nfeCanaDeducoesSafraApiProvider.update(nfeCanaDeducoesSafraModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeCanaDeducoesSafraDriftProvider.insert(nfeCanaDeducoesSafraModel);
      } else {
        return await nfeCanaDeducoesSafraApiProvider.insert(nfeCanaDeducoesSafraModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeCanaDeducoesSafraDriftProvider.delete(id) ?? false;
    } else {
      return await nfeCanaDeducoesSafraApiProvider.delete(id) ?? false;
    }
  }
}