import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoRelacionamentoDriftProvider extends ProviderBase {

	Future<List<TipoRelacionamentoModel>?> getList({Filter? filter}) async {
		List<TipoRelacionamentoGrouped> tipoRelacionamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tipoRelacionamentoDriftList = await Session.database.tipoRelacionamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tipoRelacionamentoDriftList = await Session.database.tipoRelacionamentoDao.getGroupedList(); 
			}
			if (tipoRelacionamentoDriftList.isNotEmpty) {
				return toListModel(tipoRelacionamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TipoRelacionamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tipoRelacionamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoRelacionamentoModel?>? insert(TipoRelacionamentoModel tipoRelacionamentoModel) async {
		try {
			final lastPk = await Session.database.tipoRelacionamentoDao.insertObject(toDrift(tipoRelacionamentoModel));
			tipoRelacionamentoModel.id = lastPk;
			return tipoRelacionamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoRelacionamentoModel?>? update(TipoRelacionamentoModel tipoRelacionamentoModel) async {
		try {
			await Session.database.tipoRelacionamentoDao.updateObject(toDrift(tipoRelacionamentoModel));
			return tipoRelacionamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tipoRelacionamentoDao.deleteObject(toDrift(TipoRelacionamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TipoRelacionamentoModel> toListModel(List<TipoRelacionamentoGrouped> tipoRelacionamentoDriftList) {
		List<TipoRelacionamentoModel> listModel = [];
		for (var tipoRelacionamentoDrift in tipoRelacionamentoDriftList) {
			listModel.add(toModel(tipoRelacionamentoDrift)!);
		}
		return listModel;
	}	

	TipoRelacionamentoModel? toModel(TipoRelacionamentoGrouped? tipoRelacionamentoDrift) {
		if (tipoRelacionamentoDrift != null) {
			return TipoRelacionamentoModel(
				id: tipoRelacionamentoDrift.tipoRelacionamento?.id,
				codigo: tipoRelacionamentoDrift.tipoRelacionamento?.codigo,
				nome: tipoRelacionamentoDrift.tipoRelacionamento?.nome,
				descricao: tipoRelacionamentoDrift.tipoRelacionamento?.descricao,
			);
		} else {
			return null;
		}
	}


	TipoRelacionamentoGrouped toDrift(TipoRelacionamentoModel tipoRelacionamentoModel) {
		return TipoRelacionamentoGrouped(
			tipoRelacionamento: TipoRelacionamento(
				id: tipoRelacionamentoModel.id,
				codigo: tipoRelacionamentoModel.codigo,
				nome: tipoRelacionamentoModel.nome,
				descricao: tipoRelacionamentoModel.descricao,
			),
		);
	}

		
}
