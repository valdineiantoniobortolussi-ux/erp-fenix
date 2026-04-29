import 'package:frotas/app/data/provider/drift/database/database_imports.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/provider/provider_base.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/model/model_imports.dart';

class FrotaCombustivelTipoDriftProvider extends ProviderBase {

	Future<List<FrotaCombustivelTipoModel>?> getList({Filter? filter}) async {
		List<FrotaCombustivelTipoGrouped> frotaCombustivelTipoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				frotaCombustivelTipoDriftList = await Session.database.frotaCombustivelTipoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				frotaCombustivelTipoDriftList = await Session.database.frotaCombustivelTipoDao.getGroupedList(); 
			}
			if (frotaCombustivelTipoDriftList.isNotEmpty) {
				return toListModel(frotaCombustivelTipoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FrotaCombustivelTipoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.frotaCombustivelTipoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaCombustivelTipoModel?>? insert(FrotaCombustivelTipoModel frotaCombustivelTipoModel) async {
		try {
			final lastPk = await Session.database.frotaCombustivelTipoDao.insertObject(toDrift(frotaCombustivelTipoModel));
			frotaCombustivelTipoModel.id = lastPk;
			return frotaCombustivelTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaCombustivelTipoModel?>? update(FrotaCombustivelTipoModel frotaCombustivelTipoModel) async {
		try {
			await Session.database.frotaCombustivelTipoDao.updateObject(toDrift(frotaCombustivelTipoModel));
			return frotaCombustivelTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.frotaCombustivelTipoDao.deleteObject(toDrift(FrotaCombustivelTipoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FrotaCombustivelTipoModel> toListModel(List<FrotaCombustivelTipoGrouped> frotaCombustivelTipoDriftList) {
		List<FrotaCombustivelTipoModel> listModel = [];
		for (var frotaCombustivelTipoDrift in frotaCombustivelTipoDriftList) {
			listModel.add(toModel(frotaCombustivelTipoDrift)!);
		}
		return listModel;
	}	

	FrotaCombustivelTipoModel? toModel(FrotaCombustivelTipoGrouped? frotaCombustivelTipoDrift) {
		if (frotaCombustivelTipoDrift != null) {
			return FrotaCombustivelTipoModel(
				id: frotaCombustivelTipoDrift.frotaCombustivelTipo?.id,
				codigo: frotaCombustivelTipoDrift.frotaCombustivelTipo?.codigo,
				nome: frotaCombustivelTipoDrift.frotaCombustivelTipo?.nome,
			);
		} else {
			return null;
		}
	}


	FrotaCombustivelTipoGrouped toDrift(FrotaCombustivelTipoModel frotaCombustivelTipoModel) {
		return FrotaCombustivelTipoGrouped(
			frotaCombustivelTipo: FrotaCombustivelTipo(
				id: frotaCombustivelTipoModel.id,
				codigo: frotaCombustivelTipoModel.codigo,
				nome: frotaCombustivelTipoModel.nome,
			),
		);
	}

		
}
