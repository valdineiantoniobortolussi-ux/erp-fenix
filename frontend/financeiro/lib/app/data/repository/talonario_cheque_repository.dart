import 'package:financeiro/app/infra/constants.dart';
import 'package:financeiro/app/data/provider/api/talonario_cheque_api_provider.dart';
import 'package:financeiro/app/data/provider/drift/talonario_cheque_drift_provider.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class TalonarioChequeRepository {
  final TalonarioChequeApiProvider talonarioChequeApiProvider;
  final TalonarioChequeDriftProvider talonarioChequeDriftProvider;

  TalonarioChequeRepository({required this.talonarioChequeApiProvider, required this.talonarioChequeDriftProvider});

  Future getList({Filter? filter}) async {
    if (Constants.usingLocalDatabase) {
      return await talonarioChequeDriftProvider.getList(filter: filter);
    } else {
      return await talonarioChequeApiProvider.getList(filter: filter);
    }
  }

  Future<TalonarioChequeModel?>? save({required TalonarioChequeModel talonarioChequeModel}) async {
    if (talonarioChequeModel.id! > 0) {
      if (Constants.usingLocalDatabase) {
        return await talonarioChequeDriftProvider.update(talonarioChequeModel);
      } else {
        return await talonarioChequeApiProvider.update(talonarioChequeModel);
      }
    } else {
      if (Constants.usingLocalDatabase) {
        return await talonarioChequeDriftProvider.insert(talonarioChequeModel);
      } else {
        return await talonarioChequeApiProvider.insert(talonarioChequeModel);
      }
    }   
  }

  Future<bool> delete({required int id}) async {
    if (Constants.usingLocalDatabase) {
      return await talonarioChequeDriftProvider.delete(id) ?? false;
    } else {
      return await talonarioChequeApiProvider.delete(id) ?? false;
    }
  }
}