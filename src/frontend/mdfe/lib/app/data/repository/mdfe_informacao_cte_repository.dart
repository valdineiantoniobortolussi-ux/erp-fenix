import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_informacao_cte_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_informacao_cte_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoCteRepository {
  final MdfeInformacaoCteApiProvider mdfeInformacaoCteApiProvider;
  final MdfeInformacaoCteDriftProvider mdfeInformacaoCteDriftProvider;

  MdfeInformacaoCteRepository({required this.mdfeInformacaoCteApiProvider, required this.mdfeInformacaoCteDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeInformacaoCteDriftProvider.getList(filter: filter);
    } else {
      return await mdfeInformacaoCteApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeInformacaoCteModel?>? save({required MdfeInformacaoCteModel mdfeInformacaoCteModel}) async {
    if (mdfeInformacaoCteModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeInformacaoCteDriftProvider.update(mdfeInformacaoCteModel);
      } else {
        return await mdfeInformacaoCteApiProvider.update(mdfeInformacaoCteModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeInformacaoCteDriftProvider.insert(mdfeInformacaoCteModel);
      } else {
        return await mdfeInformacaoCteApiProvider.insert(mdfeInformacaoCteModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeInformacaoCteDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeInformacaoCteApiProvider.delete(id) ?? false;
    }
  }
}