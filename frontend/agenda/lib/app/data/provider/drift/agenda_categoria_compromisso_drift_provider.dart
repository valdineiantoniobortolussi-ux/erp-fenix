import 'package:agenda/app/data/provider/drift/database/database_imports.dart';
import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/provider/provider_base.dart';
import 'package:agenda/app/data/provider/drift/database/database.dart';
import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCategoriaCompromissoDriftProvider extends ProviderBase {

	Future<List<AgendaCategoriaCompromissoModel>?> getList({Filter? filter}) async {
		List<AgendaCategoriaCompromissoGrouped> agendaCategoriaCompromissoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				agendaCategoriaCompromissoDriftList = await Session.database.agendaCategoriaCompromissoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				agendaCategoriaCompromissoDriftList = await Session.database.agendaCategoriaCompromissoDao.getGroupedList(); 
			}
			if (agendaCategoriaCompromissoDriftList.isNotEmpty) {
				return toListModel(agendaCategoriaCompromissoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<AgendaCategoriaCompromissoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.agendaCategoriaCompromissoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AgendaCategoriaCompromissoModel?>? insert(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) async {
		try {
			final lastPk = await Session.database.agendaCategoriaCompromissoDao.insertObject(toDrift(agendaCategoriaCompromissoModel));
			agendaCategoriaCompromissoModel.id = lastPk;
			return agendaCategoriaCompromissoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<AgendaCategoriaCompromissoModel?>? update(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) async {
		try {
			await Session.database.agendaCategoriaCompromissoDao.updateObject(toDrift(agendaCategoriaCompromissoModel));
			return agendaCategoriaCompromissoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.agendaCategoriaCompromissoDao.deleteObject(toDrift(AgendaCategoriaCompromissoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<AgendaCategoriaCompromissoModel> toListModel(List<AgendaCategoriaCompromissoGrouped> agendaCategoriaCompromissoDriftList) {
		List<AgendaCategoriaCompromissoModel> listModel = [];
		for (var agendaCategoriaCompromissoDrift in agendaCategoriaCompromissoDriftList) {
			listModel.add(toModel(agendaCategoriaCompromissoDrift)!);
		}
		return listModel;
	}	

	AgendaCategoriaCompromissoModel? toModel(AgendaCategoriaCompromissoGrouped? agendaCategoriaCompromissoDrift) {
		if (agendaCategoriaCompromissoDrift != null) {
			return AgendaCategoriaCompromissoModel(
				id: agendaCategoriaCompromissoDrift.agendaCategoriaCompromisso?.id,
				nome: agendaCategoriaCompromissoDrift.agendaCategoriaCompromisso?.nome,
				cor: agendaCategoriaCompromissoDrift.agendaCategoriaCompromisso?.cor,
			);
		} else {
			return null;
		}
	}


	AgendaCategoriaCompromissoGrouped toDrift(AgendaCategoriaCompromissoModel agendaCategoriaCompromissoModel) {
		return AgendaCategoriaCompromissoGrouped(
			agendaCategoriaCompromisso: AgendaCategoriaCompromisso(
				id: agendaCategoriaCompromissoModel.id,
				nome: agendaCategoriaCompromissoModel.nome,
				cor: agendaCategoriaCompromissoModel.cor,
			),
		);
	}

		
}
