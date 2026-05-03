import 'package:esocial/app/data/provider/drift/database/database_imports.dart';
import 'package:esocial/app/infra/infra_imports.dart';
import 'package:esocial/app/data/provider/provider_base.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/model/model_imports.dart';

class EsocialMotivoDesligamentoDriftProvider extends ProviderBase {

	Future<List<EsocialMotivoDesligamentoModel>?> getList({Filter? filter}) async {
		List<EsocialMotivoDesligamentoGrouped> esocialMotivoDesligamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				esocialMotivoDesligamentoDriftList = await Session.database.esocialMotivoDesligamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				esocialMotivoDesligamentoDriftList = await Session.database.esocialMotivoDesligamentoDao.getGroupedList(); 
			}
			if (esocialMotivoDesligamentoDriftList.isNotEmpty) {
				return toListModel(esocialMotivoDesligamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EsocialMotivoDesligamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.esocialMotivoDesligamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialMotivoDesligamentoModel?>? insert(EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel) async {
		try {
			final lastPk = await Session.database.esocialMotivoDesligamentoDao.insertObject(toDrift(esocialMotivoDesligamentoModel));
			esocialMotivoDesligamentoModel.id = lastPk;
			return esocialMotivoDesligamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EsocialMotivoDesligamentoModel?>? update(EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel) async {
		try {
			await Session.database.esocialMotivoDesligamentoDao.updateObject(toDrift(esocialMotivoDesligamentoModel));
			return esocialMotivoDesligamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.esocialMotivoDesligamentoDao.deleteObject(toDrift(EsocialMotivoDesligamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EsocialMotivoDesligamentoModel> toListModel(List<EsocialMotivoDesligamentoGrouped> esocialMotivoDesligamentoDriftList) {
		List<EsocialMotivoDesligamentoModel> listModel = [];
		for (var esocialMotivoDesligamentoDrift in esocialMotivoDesligamentoDriftList) {
			listModel.add(toModel(esocialMotivoDesligamentoDrift)!);
		}
		return listModel;
	}	

	EsocialMotivoDesligamentoModel? toModel(EsocialMotivoDesligamentoGrouped? esocialMotivoDesligamentoDrift) {
		if (esocialMotivoDesligamentoDrift != null) {
			return EsocialMotivoDesligamentoModel(
				id: esocialMotivoDesligamentoDrift.esocialMotivoDesligamento?.id,
				codigo: esocialMotivoDesligamentoDrift.esocialMotivoDesligamento?.codigo,
				descricao: esocialMotivoDesligamentoDrift.esocialMotivoDesligamento?.descricao,
			);
		} else {
			return null;
		}
	}


	EsocialMotivoDesligamentoGrouped toDrift(EsocialMotivoDesligamentoModel esocialMotivoDesligamentoModel) {
		return EsocialMotivoDesligamentoGrouped(
			esocialMotivoDesligamento: EsocialMotivoDesligamento(
				id: esocialMotivoDesligamentoModel.id,
				codigo: esocialMotivoDesligamentoModel.codigo,
				descricao: esocialMotivoDesligamentoModel.descricao,
			),
		);
	}

		
}
