import 'package:ordem_servico/app/data/provider/drift/database/database_imports.dart';
import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/provider/provider_base.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';

class OsEquipamentoDriftProvider extends ProviderBase {

	Future<List<OsEquipamentoModel>?> getList({Filter? filter}) async {
		List<OsEquipamentoGrouped> osEquipamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				osEquipamentoDriftList = await Session.database.osEquipamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				osEquipamentoDriftList = await Session.database.osEquipamentoDao.getGroupedList(); 
			}
			if (osEquipamentoDriftList.isNotEmpty) {
				return toListModel(osEquipamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OsEquipamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.osEquipamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsEquipamentoModel?>? insert(OsEquipamentoModel osEquipamentoModel) async {
		try {
			final lastPk = await Session.database.osEquipamentoDao.insertObject(toDrift(osEquipamentoModel));
			osEquipamentoModel.id = lastPk;
			return osEquipamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OsEquipamentoModel?>? update(OsEquipamentoModel osEquipamentoModel) async {
		try {
			await Session.database.osEquipamentoDao.updateObject(toDrift(osEquipamentoModel));
			return osEquipamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.osEquipamentoDao.deleteObject(toDrift(OsEquipamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OsEquipamentoModel> toListModel(List<OsEquipamentoGrouped> osEquipamentoDriftList) {
		List<OsEquipamentoModel> listModel = [];
		for (var osEquipamentoDrift in osEquipamentoDriftList) {
			listModel.add(toModel(osEquipamentoDrift)!);
		}
		return listModel;
	}	

	OsEquipamentoModel? toModel(OsEquipamentoGrouped? osEquipamentoDrift) {
		if (osEquipamentoDrift != null) {
			return OsEquipamentoModel(
				id: osEquipamentoDrift.osEquipamento?.id,
				nome: osEquipamentoDrift.osEquipamento?.nome,
				descricao: osEquipamentoDrift.osEquipamento?.descricao,
			);
		} else {
			return null;
		}
	}


	OsEquipamentoGrouped toDrift(OsEquipamentoModel osEquipamentoModel) {
		return OsEquipamentoGrouped(
			osEquipamento: OsEquipamento(
				id: osEquipamentoModel.id,
				nome: osEquipamentoModel.nome,
				descricao: osEquipamentoModel.descricao,
			),
		);
	}

		
}
