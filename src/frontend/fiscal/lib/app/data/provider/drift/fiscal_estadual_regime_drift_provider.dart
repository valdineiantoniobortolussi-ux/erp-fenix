import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalEstadualRegimeDriftProvider extends ProviderBase {

	Future<List<FiscalEstadualRegimeModel>?> getList({Filter? filter}) async {
		List<FiscalEstadualRegimeGrouped> fiscalEstadualRegimeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalEstadualRegimeDriftList = await Session.database.fiscalEstadualRegimeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalEstadualRegimeDriftList = await Session.database.fiscalEstadualRegimeDao.getGroupedList(); 
			}
			if (fiscalEstadualRegimeDriftList.isNotEmpty) {
				return toListModel(fiscalEstadualRegimeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalEstadualRegimeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalEstadualRegimeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalEstadualRegimeModel?>? insert(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) async {
		try {
			final lastPk = await Session.database.fiscalEstadualRegimeDao.insertObject(toDrift(fiscalEstadualRegimeModel));
			fiscalEstadualRegimeModel.id = lastPk;
			return fiscalEstadualRegimeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalEstadualRegimeModel?>? update(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) async {
		try {
			await Session.database.fiscalEstadualRegimeDao.updateObject(toDrift(fiscalEstadualRegimeModel));
			return fiscalEstadualRegimeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalEstadualRegimeDao.deleteObject(toDrift(FiscalEstadualRegimeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalEstadualRegimeModel> toListModel(List<FiscalEstadualRegimeGrouped> fiscalEstadualRegimeDriftList) {
		List<FiscalEstadualRegimeModel> listModel = [];
		for (var fiscalEstadualRegimeDrift in fiscalEstadualRegimeDriftList) {
			listModel.add(toModel(fiscalEstadualRegimeDrift)!);
		}
		return listModel;
	}	

	FiscalEstadualRegimeModel? toModel(FiscalEstadualRegimeGrouped? fiscalEstadualRegimeDrift) {
		if (fiscalEstadualRegimeDrift != null) {
			return FiscalEstadualRegimeModel(
				id: fiscalEstadualRegimeDrift.fiscalEstadualRegime?.id,
				uf: FiscalEstadualRegimeDomain.getUf(fiscalEstadualRegimeDrift.fiscalEstadualRegime?.uf),
				codigo: fiscalEstadualRegimeDrift.fiscalEstadualRegime?.codigo,
				nome: fiscalEstadualRegimeDrift.fiscalEstadualRegime?.nome,
			);
		} else {
			return null;
		}
	}


	FiscalEstadualRegimeGrouped toDrift(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) {
		return FiscalEstadualRegimeGrouped(
			fiscalEstadualRegime: FiscalEstadualRegime(
				id: fiscalEstadualRegimeModel.id,
				uf: FiscalEstadualRegimeDomain.setUf(fiscalEstadualRegimeModel.uf),
				codigo: fiscalEstadualRegimeModel.codigo,
				nome: fiscalEstadualRegimeModel.nome,
			),
		);
	}

		
}
