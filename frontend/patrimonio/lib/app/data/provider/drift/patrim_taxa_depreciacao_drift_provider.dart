import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimTaxaDepreciacaoDriftProvider extends ProviderBase {

	Future<List<PatrimTaxaDepreciacaoModel>?> getList({Filter? filter}) async {
		List<PatrimTaxaDepreciacaoGrouped> patrimTaxaDepreciacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimTaxaDepreciacaoDriftList = await Session.database.patrimTaxaDepreciacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimTaxaDepreciacaoDriftList = await Session.database.patrimTaxaDepreciacaoDao.getGroupedList(); 
			}
			if (patrimTaxaDepreciacaoDriftList.isNotEmpty) {
				return toListModel(patrimTaxaDepreciacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimTaxaDepreciacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimTaxaDepreciacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTaxaDepreciacaoModel?>? insert(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) async {
		try {
			final lastPk = await Session.database.patrimTaxaDepreciacaoDao.insertObject(toDrift(patrimTaxaDepreciacaoModel));
			patrimTaxaDepreciacaoModel.id = lastPk;
			return patrimTaxaDepreciacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimTaxaDepreciacaoModel?>? update(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) async {
		try {
			await Session.database.patrimTaxaDepreciacaoDao.updateObject(toDrift(patrimTaxaDepreciacaoModel));
			return patrimTaxaDepreciacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimTaxaDepreciacaoDao.deleteObject(toDrift(PatrimTaxaDepreciacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimTaxaDepreciacaoModel> toListModel(List<PatrimTaxaDepreciacaoGrouped> patrimTaxaDepreciacaoDriftList) {
		List<PatrimTaxaDepreciacaoModel> listModel = [];
		for (var patrimTaxaDepreciacaoDrift in patrimTaxaDepreciacaoDriftList) {
			listModel.add(toModel(patrimTaxaDepreciacaoDrift)!);
		}
		return listModel;
	}	

	PatrimTaxaDepreciacaoModel? toModel(PatrimTaxaDepreciacaoGrouped? patrimTaxaDepreciacaoDrift) {
		if (patrimTaxaDepreciacaoDrift != null) {
			return PatrimTaxaDepreciacaoModel(
				id: patrimTaxaDepreciacaoDrift.patrimTaxaDepreciacao?.id,
				ncm: patrimTaxaDepreciacaoDrift.patrimTaxaDepreciacao?.ncm,
				bem: patrimTaxaDepreciacaoDrift.patrimTaxaDepreciacao?.bem,
				vida: patrimTaxaDepreciacaoDrift.patrimTaxaDepreciacao?.vida,
				taxa: patrimTaxaDepreciacaoDrift.patrimTaxaDepreciacao?.taxa,
			);
		} else {
			return null;
		}
	}


	PatrimTaxaDepreciacaoGrouped toDrift(PatrimTaxaDepreciacaoModel patrimTaxaDepreciacaoModel) {
		return PatrimTaxaDepreciacaoGrouped(
			patrimTaxaDepreciacao: PatrimTaxaDepreciacao(
				id: patrimTaxaDepreciacaoModel.id,
				ncm: patrimTaxaDepreciacaoModel.ncm,
				bem: patrimTaxaDepreciacaoModel.bem,
				vida: patrimTaxaDepreciacaoModel.vida,
				taxa: patrimTaxaDepreciacaoModel.taxa,
			),
		);
	}

		
}
