import 'package:esocial/app/data/provider/drift/database/database_imports.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/data/provider/provider_base.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialTipoAfastamentoDriftProvider extends ProviderBase {

	Future<List<EsocialTipoAfastamentoModel>?> getList({Filter? filter}) async {
		List<EsocialTipoAfastamentoGrouped> esocialTipoAfastamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				esocialTipoAfastamentoDriftList = await Session.database.esocialTipoAfastamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				esocialTipoAfastamentoDriftList = await Session.database.esocialTipoAfastamentoDao.getGroupedList(); 
			}
			if (esocialTipoAfastamentoDriftList.isNotEmpty) {
				return toListModel(esocialTipoAfastamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EsocialTipoAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.esocialTipoAfastamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialTipoAfastamentoModel?>? insert(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) async {
		try {
			final lastPk = await Session.database.esocialTipoAfastamentoDao.insertObject(toDrift(esocialTipoAfastamentoModel));
			esocialTipoAfastamentoModel.id = lastPk;
			return esocialTipoAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialTipoAfastamentoModel?>? update(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) async {
		try {
			await Session.database.esocialTipoAfastamentoDao.updateObject(toDrift(esocialTipoAfastamentoModel));
			return esocialTipoAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.esocialTipoAfastamentoDao.deleteObject(toDrift(EsocialTipoAfastamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EsocialTipoAfastamentoModel> toListModel(List<EsocialTipoAfastamentoGrouped> esocialTipoAfastamentoDriftList) {
		List<EsocialTipoAfastamentoModel> listModel = [];
		for (var esocialTipoAfastamentoDrift in esocialTipoAfastamentoDriftList) {
			listModel.add(toModel(esocialTipoAfastamentoDrift)!);
		}
		return listModel;
	}	

	EsocialTipoAfastamentoModel? toModel(EsocialTipoAfastamentoGrouped? esocialTipoAfastamentoDrift) {
		if (esocialTipoAfastamentoDrift != null) {
			return EsocialTipoAfastamentoModel(
				id: esocialTipoAfastamentoDrift.esocialTipoAfastamento?.id,
				codigo: esocialTipoAfastamentoDrift.esocialTipoAfastamento?.codigo,
				descricao: esocialTipoAfastamentoDrift.esocialTipoAfastamento?.descricao,
			);
		} else {
			return null;
		}
	}


	EsocialTipoAfastamentoGrouped toDrift(EsocialTipoAfastamentoModel esocialTipoAfastamentoModel) {
		return EsocialTipoAfastamentoGrouped(
			esocialTipoAfastamento: EsocialTipoAfastamento(
				id: esocialTipoAfastamentoModel.id,
				codigo: esocialTipoAfastamentoModel.codigo,
				descricao: esocialTipoAfastamentoModel.descricao,
			),
		);
	}

		
}
