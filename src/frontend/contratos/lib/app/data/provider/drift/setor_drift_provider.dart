import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class SetorDriftProvider extends ProviderBase {

	Future<List<SetorModel>?> getList({Filter? filter}) async {
		List<SetorGrouped> setorDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				setorDriftList = await Session.database.setorDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				setorDriftList = await Session.database.setorDao.getGroupedList(); 
			}
			if (setorDriftList.isNotEmpty) {
				return toListModel(setorDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SetorModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.setorDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SetorModel?>? insert(SetorModel setorModel) async {
		try {
			final lastPk = await Session.database.setorDao.insertObject(toDrift(setorModel));
			setorModel.id = lastPk;
			return setorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SetorModel?>? update(SetorModel setorModel) async {
		try {
			await Session.database.setorDao.updateObject(toDrift(setorModel));
			return setorModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.setorDao.deleteObject(toDrift(SetorModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SetorModel> toListModel(List<SetorGrouped> setorDriftList) {
		List<SetorModel> listModel = [];
		for (var setorDrift in setorDriftList) {
			listModel.add(toModel(setorDrift)!);
		}
		return listModel;
	}	

	SetorModel? toModel(SetorGrouped? setorDrift) {
		if (setorDrift != null) {
			return SetorModel(
				id: setorDrift.setor?.id,
				nome: setorDrift.setor?.nome,
				descricao: setorDrift.setor?.descricao,
			);
		} else {
			return null;
		}
	}


	SetorGrouped toDrift(SetorModel setorModel) {
		return SetorGrouped(
			setor: Setor(
				id: setorModel.id,
				nome: setorModel.nome,
				descricao: setorModel.descricao,
			),
		);
	}

		
}
