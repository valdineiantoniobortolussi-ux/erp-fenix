import 'package:mdfe/app/infra/constants.dart';
import 'package:mdfe/app/data/provider/api/mdfe_rodoviario_veiculo_api_provider.dart';
import 'package:mdfe/app/data/provider/drift/mdfe_rodoviario_veiculo_drift_provider.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioVeiculoRepository {
  final MdfeRodoviarioVeiculoApiProvider mdfeRodoviarioVeiculoApiProvider;
  final MdfeRodoviarioVeiculoDriftProvider mdfeRodoviarioVeiculoDriftProvider;

  MdfeRodoviarioVeiculoRepository({required this.mdfeRodoviarioVeiculoApiProvider, required this.mdfeRodoviarioVeiculoDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioVeiculoDriftProvider.getList(filter: filter);
    } else {
      return await mdfeRodoviarioVeiculoApiProvider.getList(filter: filter);
    }
  }

  Future<MdfeRodoviarioVeiculoModel?>? save({required MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel}) async {
    if (mdfeRodoviarioVeiculoModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioVeiculoDriftProvider.update(mdfeRodoviarioVeiculoModel);
      } else {
        return await mdfeRodoviarioVeiculoApiProvider.update(mdfeRodoviarioVeiculoModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await mdfeRodoviarioVeiculoDriftProvider.insert(mdfeRodoviarioVeiculoModel);
      } else {
        return await mdfeRodoviarioVeiculoApiProvider.insert(mdfeRodoviarioVeiculoModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await mdfeRodoviarioVeiculoDriftProvider.delete(id) ?? false;
    } else {
      return await mdfeRodoviarioVeiculoApiProvider.delete(id) ?? false;
    }
  }
}