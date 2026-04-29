import 'package:agenda/app/infra/constants.dart';
import 'package:agenda/app/data/provider/api/reuniao_sala_api_provider.dart';
import 'package:agenda/app/data/provider/drift/reuniao_sala_drift_provider.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class ReuniaoSalaRepository {
  final ReuniaoSalaApiProvider reuniaoSalaApiProvider;
  final ReuniaoSalaDriftProvider reuniaoSalaDriftProvider;

  ReuniaoSalaRepository({required this.reuniaoSalaApiProvider, required this.reuniaoSalaDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await reuniaoSalaDriftProvider.getList(filter: filter);
    } else {
      return await reuniaoSalaApiProvider.getList(filter: filter);
    }
  }

  Future<ReuniaoSalaModel?>? save({required ReuniaoSalaModel reuniaoSalaModel}) async {
    if (reuniaoSalaModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await reuniaoSalaDriftProvider.update(reuniaoSalaModel);
      } else {
        return await reuniaoSalaApiProvider.update(reuniaoSalaModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await reuniaoSalaDriftProvider.insert(reuniaoSalaModel);
      } else {
        return await reuniaoSalaApiProvider.insert(reuniaoSalaModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await reuniaoSalaDriftProvider.delete(id) ?? false;
    } else {
      return await reuniaoSalaApiProvider.delete(id) ?? false;
    }
  }
}