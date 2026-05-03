import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalMunicipalRegimeDriftProvider extends ProviderBase {

	Future<List<FiscalMunicipalRegimeModel>?> getList({Filter? filter}) async {
		List<FiscalMunicipalRegimeGrouped> fiscalMunicipalRegimeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalMunicipalRegimeDriftList = await Session.database.fiscalMunicipalRegimeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalMunicipalRegimeDriftList = await Session.database.fiscalMunicipalRegimeDao.getGroupedList(); 
			}
			if (fiscalMunicipalRegimeDriftList.isNotEmpty) {
				return toListModel(fiscalMunicipalRegimeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalMunicipalRegimeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalMunicipalRegimeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalMunicipalRegimeModel?>? insert(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) async {
		try {
			final lastPk = await Session.database.fiscalMunicipalRegimeDao.insertObject(toDrift(fiscalMunicipalRegimeModel));
			fiscalMunicipalRegimeModel.id = lastPk;
			return fiscalMunicipalRegimeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalMunicipalRegimeModel?>? update(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) async {
		try {
			await Session.database.fiscalMunicipalRegimeDao.updateObject(toDrift(fiscalMunicipalRegimeModel));
			return fiscalMunicipalRegimeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalMunicipalRegimeDao.deleteObject(toDrift(FiscalMunicipalRegimeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalMunicipalRegimeModel> toListModel(List<FiscalMunicipalRegimeGrouped> fiscalMunicipalRegimeDriftList) {
		List<FiscalMunicipalRegimeModel> listModel = [];
		for (var fiscalMunicipalRegimeDrift in fiscalMunicipalRegimeDriftList) {
			listModel.add(toModel(fiscalMunicipalRegimeDrift)!);
		}
		return listModel;
	}	

	FiscalMunicipalRegimeModel? toModel(FiscalMunicipalRegimeGrouped? fiscalMunicipalRegimeDrift) {
		if (fiscalMunicipalRegimeDrift != null) {
			return FiscalMunicipalRegimeModel(
				id: fiscalMunicipalRegimeDrift.fiscalMunicipalRegime?.id,
				uf: FiscalMunicipalRegimeDomain.getUf(fiscalMunicipalRegimeDrift.fiscalMunicipalRegime?.uf),
				codigo: fiscalMunicipalRegimeDrift.fiscalMunicipalRegime?.codigo,
				nome: fiscalMunicipalRegimeDrift.fiscalMunicipalRegime?.nome,
			);
		} else {
			return null;
		}
	}


	FiscalMunicipalRegimeGrouped toDrift(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) {
		return FiscalMunicipalRegimeGrouped(
			fiscalMunicipalRegime: FiscalMunicipalRegime(
				id: fiscalMunicipalRegimeModel.id,
				uf: FiscalMunicipalRegimeDomain.setUf(fiscalMunicipalRegimeModel.uf),
				codigo: fiscalMunicipalRegimeModel.codigo,
				nome: fiscalMunicipalRegimeModel.nome,
			),
		);
	}

		
}
