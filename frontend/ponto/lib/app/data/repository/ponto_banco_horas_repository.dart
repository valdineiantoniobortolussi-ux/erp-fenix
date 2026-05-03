import 'package:ponto/app/infra/constants.dart';
import 'package:ponto/app/data/provider/api/ponto_banco_horas_api_provider.dart';
import 'package:ponto/app/data/provider/drift/ponto_banco_horas_drift_provider.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoBancoHorasRepository {
  final PontoBancoHorasApiProvider pontoBancoHorasApiProvider;
  final PontoBancoHorasDriftProvider pontoBancoHorasDriftProvider;

  PontoBancoHorasRepository({required this.pontoBancoHorasApiProvider, required this.pontoBancoHorasDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoBancoHorasDriftProvider.getList(filter: filter);
    } else {
      return await pontoBancoHorasApiProvider.getList(filter: filter);
    }
  }

  Future<PontoBancoHorasModel?>? save({required PontoBancoHorasModel pontoBancoHorasModel}) async {
    if (pontoBancoHorasModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await pontoBancoHorasDriftProvider.update(pontoBancoHorasModel);
      } else {
        return await pontoBancoHorasApiProvider.update(pontoBancoHorasModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await pontoBancoHorasDriftProvider.insert(pontoBancoHorasModel);
      } else {
        return await pontoBancoHorasApiProvider.insert(pontoBancoHorasModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await pontoBancoHorasDriftProvider.delete(id) ?? false;
    } else {
      return await pontoBancoHorasApiProvider.delete(id) ?? false;
    }
  }
}