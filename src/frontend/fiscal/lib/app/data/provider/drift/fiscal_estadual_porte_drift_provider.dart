import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalEstadualPorteDriftProvider extends ProviderBase {

	Future<List<FiscalEstadualPorteModel>?> getList({Filter? filter}) async {
		List<FiscalEstadualPorteGrouped> fiscalEstadualPorteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalEstadualPorteDriftList = await Session.database.fiscalEstadualPorteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalEstadualPorteDriftList = await Session.database.fiscalEstadualPorteDao.getGroupedList(); 
			}
			if (fiscalEstadualPorteDriftList.isNotEmpty) {
				return toListModel(fiscalEstadualPorteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalEstadualPorteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalEstadualPorteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalEstadualPorteModel?>? insert(FiscalEstadualPorteModel fiscalEstadualPorteModel) async {
		try {
			final lastPk = await Session.database.fiscalEstadualPorteDao.insertObject(toDrift(fiscalEstadualPorteModel));
			fiscalEstadualPorteModel.id = lastPk;
			return fiscalEstadualPorteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalEstadualPorteModel?>? update(FiscalEstadualPorteModel fiscalEstadualPorteModel) async {
		try {
			await Session.database.fiscalEstadualPorteDao.updateObject(toDrift(fiscalEstadualPorteModel));
			return fiscalEstadualPorteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalEstadualPorteDao.deleteObject(toDrift(FiscalEstadualPorteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalEstadualPorteModel> toListModel(List<FiscalEstadualPorteGrouped> fiscalEstadualPorteDriftList) {
		List<FiscalEstadualPorteModel> listModel = [];
		for (var fiscalEstadualPorteDrift in fiscalEstadualPorteDriftList) {
			listModel.add(toModel(fiscalEstadualPorteDrift)!);
		}
		return listModel;
	}	

	FiscalEstadualPorteModel? toModel(FiscalEstadualPorteGrouped? fiscalEstadualPorteDrift) {
		if (fiscalEstadualPorteDrift != null) {
			return FiscalEstadualPorteModel(
				id: fiscalEstadualPorteDrift.fiscalEstadualPorte?.id,
				uf: FiscalEstadualPorteDomain.getUf(fiscalEstadualPorteDrift.fiscalEstadualPorte?.uf),
				codigo: fiscalEstadualPorteDrift.fiscalEstadualPorte?.codigo,
				nome: fiscalEstadualPorteDrift.fiscalEstadualPorte?.nome,
			);
		} else {
			return null;
		}
	}


	FiscalEstadualPorteGrouped toDrift(FiscalEstadualPorteModel fiscalEstadualPorteModel) {
		return FiscalEstadualPorteGrouped(
			fiscalEstadualPorte: FiscalEstadualPorte(
				id: fiscalEstadualPorteModel.id,
				uf: FiscalEstadualPorteDomain.setUf(fiscalEstadualPorteModel.uf),
				codigo: fiscalEstadualPorteModel.codigo,
				nome: fiscalEstadualPorteModel.nome,
			),
		);
	}

		
}
