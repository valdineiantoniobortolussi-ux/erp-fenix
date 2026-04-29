import 'package:esocial/app/data/provider/drift/database/database_imports.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/data/provider/provider_base.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialClassificacaoTributDriftProvider extends ProviderBase {

	Future<List<EsocialClassificacaoTributModel>?> getList({Filter? filter}) async {
		List<EsocialClassificacaoTributGrouped> esocialClassificacaoTributDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				esocialClassificacaoTributDriftList = await Session.database.esocialClassificacaoTributDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				esocialClassificacaoTributDriftList = await Session.database.esocialClassificacaoTributDao.getGroupedList(); 
			}
			if (esocialClassificacaoTributDriftList.isNotEmpty) {
				return toListModel(esocialClassificacaoTributDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EsocialClassificacaoTributModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.esocialClassificacaoTributDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialClassificacaoTributModel?>? insert(EsocialClassificacaoTributModel esocialClassificacaoTributModel) async {
		try {
			final lastPk = await Session.database.esocialClassificacaoTributDao.insertObject(toDrift(esocialClassificacaoTributModel));
			esocialClassificacaoTributModel.id = lastPk;
			return esocialClassificacaoTributModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialClassificacaoTributModel?>? update(EsocialClassificacaoTributModel esocialClassificacaoTributModel) async {
		try {
			await Session.database.esocialClassificacaoTributDao.updateObject(toDrift(esocialClassificacaoTributModel));
			return esocialClassificacaoTributModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.esocialClassificacaoTributDao.deleteObject(toDrift(EsocialClassificacaoTributModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EsocialClassificacaoTributModel> toListModel(List<EsocialClassificacaoTributGrouped> esocialClassificacaoTributDriftList) {
		List<EsocialClassificacaoTributModel> listModel = [];
		for (var esocialClassificacaoTributDrift in esocialClassificacaoTributDriftList) {
			listModel.add(toModel(esocialClassificacaoTributDrift)!);
		}
		return listModel;
	}	

	EsocialClassificacaoTributModel? toModel(EsocialClassificacaoTributGrouped? esocialClassificacaoTributDrift) {
		if (esocialClassificacaoTributDrift != null) {
			return EsocialClassificacaoTributModel(
				id: esocialClassificacaoTributDrift.esocialClassificacaoTribut?.id,
				codigo: esocialClassificacaoTributDrift.esocialClassificacaoTribut?.codigo,
				descricao: esocialClassificacaoTributDrift.esocialClassificacaoTribut?.descricao,
			);
		} else {
			return null;
		}
	}


	EsocialClassificacaoTributGrouped toDrift(EsocialClassificacaoTributModel esocialClassificacaoTributModel) {
		return EsocialClassificacaoTributGrouped(
			esocialClassificacaoTribut: EsocialClassificacaoTribut(
				id: esocialClassificacaoTributModel.id,
				codigo: esocialClassificacaoTributModel.codigo,
				descricao: esocialClassificacaoTributModel.descricao,
			),
		);
	}

		
}
