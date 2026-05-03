import 'package:nfe/app/infra/constants.dart';
import 'package:nfe/app/data/provider/api/nfe_duplicata_api_provider.dart';
import 'package:nfe/app/data/provider/drift/nfe_duplicata_drift_provider.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeDuplicataRepository {
  final NfeDuplicataApiProvider nfeDuplicataApiProvider;
  final NfeDuplicataDriftProvider nfeDuplicataDriftProvider;

  NfeDuplicataRepository({required this.nfeDuplicataApiProvider, required this.nfeDuplicataDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeDuplicataDriftProvider.getList(filter: filter);
    } else {
      return await nfeDuplicataApiProvider.getList(filter: filter);
    }
  }

  Future<NfeDuplicataModel?>? save({required NfeDuplicataModel nfeDuplicataModel}) async {
    if (nfeDuplicataModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await nfeDuplicataDriftProvider.update(nfeDuplicataModel);
      } else {
        return await nfeDuplicataApiProvider.update(nfeDuplicataModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await nfeDuplicataDriftProvider.insert(nfeDuplicataModel);
      } else {
        return await nfeDuplicataApiProvider.insert(nfeDuplicataModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await nfeDuplicataDriftProvider.delete(id) ?? false;
    } else {
      return await nfeDuplicataApiProvider.delete(id) ?? false;
    }
  }
}