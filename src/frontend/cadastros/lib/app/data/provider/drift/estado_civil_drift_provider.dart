import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class EstadoCivilDriftProvider extends ProviderBase {

	Future<List<EstadoCivilModel>?> getList({Filter? filter}) async {
		List<EstadoCivilGrouped> estadoCivilDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estadoCivilDriftList = await Session.database.estadoCivilDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estadoCivilDriftList = await Session.database.estadoCivilDao.getGroupedList(); 
			}
			if (estadoCivilDriftList.isNotEmpty) {
				return toListModel(estadoCivilDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstadoCivilModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estadoCivilDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstadoCivilModel?>? insert(EstadoCivilModel estadoCivilModel) async {
		try {
			final lastPk = await Session.database.estadoCivilDao.insertObject(toDrift(estadoCivilModel));
			estadoCivilModel.id = lastPk;
			return estadoCivilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstadoCivilModel?>? update(EstadoCivilModel estadoCivilModel) async {
		try {
			await Session.database.estadoCivilDao.updateObject(toDrift(estadoCivilModel));
			return estadoCivilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estadoCivilDao.deleteObject(toDrift(EstadoCivilModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstadoCivilModel> toListModel(List<EstadoCivilGrouped> estadoCivilDriftList) {
		List<EstadoCivilModel> listModel = [];
		for (var estadoCivilDrift in estadoCivilDriftList) {
			listModel.add(toModel(estadoCivilDrift)!);
		}
		return listModel;
	}	

	EstadoCivilModel? toModel(EstadoCivilGrouped? estadoCivilDrift) {
		if (estadoCivilDrift != null) {
			return EstadoCivilModel(
				id: estadoCivilDrift.estadoCivil?.id,
				nome: estadoCivilDrift.estadoCivil?.nome,
				descricao: estadoCivilDrift.estadoCivil?.descricao,
			);
		} else {
			return null;
		}
	}


	EstadoCivilGrouped toDrift(EstadoCivilModel estadoCivilModel) {
		return EstadoCivilGrouped(
			estadoCivil: EstadoCivil(
				id: estadoCivilModel.id,
				nome: estadoCivilModel.nome,
				descricao: estadoCivilModel.descricao,
			),
		);
	}

		
}
