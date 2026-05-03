import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class TipoContratoDriftProvider extends ProviderBase {

	Future<List<TipoContratoModel>?> getList({Filter? filter}) async {
		List<TipoContratoGrouped> tipoContratoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tipoContratoDriftList = await Session.database.tipoContratoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tipoContratoDriftList = await Session.database.tipoContratoDao.getGroupedList(); 
			}
			if (tipoContratoDriftList.isNotEmpty) {
				return toListModel(tipoContratoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TipoContratoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tipoContratoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoContratoModel?>? insert(TipoContratoModel tipoContratoModel) async {
		try {
			final lastPk = await Session.database.tipoContratoDao.insertObject(toDrift(tipoContratoModel));
			tipoContratoModel.id = lastPk;
			return tipoContratoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoContratoModel?>? update(TipoContratoModel tipoContratoModel) async {
		try {
			await Session.database.tipoContratoDao.updateObject(toDrift(tipoContratoModel));
			return tipoContratoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tipoContratoDao.deleteObject(toDrift(TipoContratoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TipoContratoModel> toListModel(List<TipoContratoGrouped> tipoContratoDriftList) {
		List<TipoContratoModel> listModel = [];
		for (var tipoContratoDrift in tipoContratoDriftList) {
			listModel.add(toModel(tipoContratoDrift)!);
		}
		return listModel;
	}	

	TipoContratoModel? toModel(TipoContratoGrouped? tipoContratoDrift) {
		if (tipoContratoDrift != null) {
			return TipoContratoModel(
				id: tipoContratoDrift.tipoContrato?.id,
				nome: tipoContratoDrift.tipoContrato?.nome,
				descricao: tipoContratoDrift.tipoContrato?.descricao,
			);
		} else {
			return null;
		}
	}


	TipoContratoGrouped toDrift(TipoContratoModel tipoContratoModel) {
		return TipoContratoGrouped(
			tipoContrato: TipoContrato(
				id: tipoContratoModel.id,
				nome: tipoContratoModel.nome,
				descricao: tipoContratoModel.descricao,
			),
		);
	}

		
}
