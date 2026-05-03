import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_informacao_nfe_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_informacao_nfe_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoNfeRepository {
  final MdfeInformacaoNfeApiProvider mdfeInformacaoNfeApiProvider;
  final MdfeInformacaoNfeDriftProvider mdfeInformacaoNfeDriftProvider;

  MdfeInformacaoNfeRepository({required this.mdfeInformacaoNfeApiProvider, required this.mdfeInformacaoNfeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeInformacaoNfeDriftProvider.getList(filter: filter);
    } else {
      return await mdfeInformacaoNfeApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeInformacaoNfeModel?>? save({required MdfeInformacaoNfeModel mdfeInformacaoNfeModel}) async {
    if (mdfeInformacaoNfeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeInformacaoNfeDriftProvider.update(mdfeInformacaoNfeModel);
      } else {
        return await mdfeInformacaoNfeApiProvider.update(mdfeInformacaoNfeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeInformacaoNfeDriftProvider.insert(mdfeInformacaoNfeModel);
      } else {
        return await mdfeInformacaoNfeApiProvider.insert(mdfeInformacaoNfeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeInformacaoNfeDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeInformacaoNfeApiProvider.delete(id) ?? false;
    }
  }
}