import 'package:esocial/app/data/provider/drift/database/database_imports.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/data/provider/provider_base.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialNaturezaJuridicaDriftProvider extends ProviderBase {

	Future<List<EsocialNaturezaJuridicaModel>?> getList({Filter? filter}) async {
		List<EsocialNaturezaJuridicaGrouped> esocialNaturezaJuridicaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				esocialNaturezaJuridicaDriftList = await Session.database.esocialNaturezaJuridicaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				esocialNaturezaJuridicaDriftList = await Session.database.esocialNaturezaJuridicaDao.getGroupedList(); 
			}
			if (esocialNaturezaJuridicaDriftList.isNotEmpty) {
				return toListModel(esocialNaturezaJuridicaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EsocialNaturezaJuridicaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.esocialNaturezaJuridicaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialNaturezaJuridicaModel?>? insert(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) async {
		try {
			final lastPk = await Session.database.esocialNaturezaJuridicaDao.insertObject(toDrift(esocialNaturezaJuridicaModel));
			esocialNaturezaJuridicaModel.id = lastPk;
			return esocialNaturezaJuridicaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialNaturezaJuridicaModel?>? update(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) async {
		try {
			await Session.database.esocialNaturezaJuridicaDao.updateObject(toDrift(esocialNaturezaJuridicaModel));
			return esocialNaturezaJuridicaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.esocialNaturezaJuridicaDao.deleteObject(toDrift(EsocialNaturezaJuridicaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EsocialNaturezaJuridicaModel> toListModel(List<EsocialNaturezaJuridicaGrouped> esocialNaturezaJuridicaDriftList) {
		List<EsocialNaturezaJuridicaModel> listModel = [];
		for (var esocialNaturezaJuridicaDrift in esocialNaturezaJuridicaDriftList) {
			listModel.add(toModel(esocialNaturezaJuridicaDrift)!);
		}
		return listModel;
	}	

	EsocialNaturezaJuridicaModel? toModel(EsocialNaturezaJuridicaGrouped? esocialNaturezaJuridicaDrift) {
		if (esocialNaturezaJuridicaDrift != null) {
			return EsocialNaturezaJuridicaModel(
				id: esocialNaturezaJuridicaDrift.esocialNaturezaJuridica?.id,
				grupo: esocialNaturezaJuridicaDrift.esocialNaturezaJuridica?.grupo,
				codigo: esocialNaturezaJuridicaDrift.esocialNaturezaJuridica?.codigo,
				descricao: esocialNaturezaJuridicaDrift.esocialNaturezaJuridica?.descricao,
			);
		} else {
			return null;
		}
	}


	EsocialNaturezaJuridicaGrouped toDrift(EsocialNaturezaJuridicaModel esocialNaturezaJuridicaModel) {
		return EsocialNaturezaJuridicaGrouped(
			esocialNaturezaJuridica: EsocialNaturezaJuridica(
				id: esocialNaturezaJuridicaModel.id,
				grupo: esocialNaturezaJuridicaModel.grupo,
				codigo: esocialNaturezaJuridicaModel.codigo,
				descricao: esocialNaturezaJuridicaModel.descricao,
			),
		);
	}

		
}
