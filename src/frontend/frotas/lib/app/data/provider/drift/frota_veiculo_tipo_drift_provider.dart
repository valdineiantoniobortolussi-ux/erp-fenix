import 'package:frotas/app/data/provider/drift/database/database_imports.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/provider/provider_base.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaVeiculoTipoDriftProvider extends ProviderBase {

	Future<List<FrotaVeiculoTipoModel>?> getList({Filter? filter}) async {
		List<FrotaVeiculoTipoGrouped> frotaVeiculoTipoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				frotaVeiculoTipoDriftList = await Session.database.frotaVeiculoTipoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				frotaVeiculoTipoDriftList = await Session.database.frotaVeiculoTipoDao.getGroupedList(); 
			}
			if (frotaVeiculoTipoDriftList.isNotEmpty) {
				return toListModel(frotaVeiculoTipoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FrotaVeiculoTipoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.frotaVeiculoTipoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaVeiculoTipoModel?>? insert(FrotaVeiculoTipoModel frotaVeiculoTipoModel) async {
		try {
			final lastPk = await Session.database.frotaVeiculoTipoDao.insertObject(toDrift(frotaVeiculoTipoModel));
			frotaVeiculoTipoModel.id = lastPk;
			return frotaVeiculoTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaVeiculoTipoModel?>? update(FrotaVeiculoTipoModel frotaVeiculoTipoModel) async {
		try {
			await Session.database.frotaVeiculoTipoDao.updateObject(toDrift(frotaVeiculoTipoModel));
			return frotaVeiculoTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.frotaVeiculoTipoDao.deleteObject(toDrift(FrotaVeiculoTipoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FrotaVeiculoTipoModel> toListModel(List<FrotaVeiculoTipoGrouped> frotaVeiculoTipoDriftList) {
		List<FrotaVeiculoTipoModel> listModel = [];
		for (var frotaVeiculoTipoDrift in frotaVeiculoTipoDriftList) {
			listModel.add(toModel(frotaVeiculoTipoDrift)!);
		}
		return listModel;
	}	

	FrotaVeiculoTipoModel? toModel(FrotaVeiculoTipoGrouped? frotaVeiculoTipoDrift) {
		if (frotaVeiculoTipoDrift != null) {
			return FrotaVeiculoTipoModel(
				id: frotaVeiculoTipoDrift.frotaVeiculoTipo?.id,
				codigo: frotaVeiculoTipoDrift.frotaVeiculoTipo?.codigo,
				nome: frotaVeiculoTipoDrift.frotaVeiculoTipo?.nome,
			);
		} else {
			return null;
		}
	}


	FrotaVeiculoTipoGrouped toDrift(FrotaVeiculoTipoModel frotaVeiculoTipoModel) {
		return FrotaVeiculoTipoGrouped(
			frotaVeiculoTipo: FrotaVeiculoTipo(
				id: frotaVeiculoTipoModel.id,
				codigo: frotaVeiculoTipoModel.codigo,
				nome: frotaVeiculoTipoModel.nome,
			),
		);
	}

		
}
