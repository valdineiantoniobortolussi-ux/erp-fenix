import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoRequisicaoDriftProvider extends ProviderBase {

	Future<List<CompraTipoRequisicaoModel>?> getList({Filter? filter}) async {
		List<CompraTipoRequisicaoGrouped> compraTipoRequisicaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				compraTipoRequisicaoDriftList = await Session.database.compraTipoRequisicaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				compraTipoRequisicaoDriftList = await Session.database.compraTipoRequisicaoDao.getGroupedList(); 
			}
			if (compraTipoRequisicaoDriftList.isNotEmpty) {
				return toListModel(compraTipoRequisicaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CompraTipoRequisicaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.compraTipoRequisicaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraTipoRequisicaoModel?>? insert(CompraTipoRequisicaoModel compraTipoRequisicaoModel) async {
		try {
			final lastPk = await Session.database.compraTipoRequisicaoDao.insertObject(toDrift(compraTipoRequisicaoModel));
			compraTipoRequisicaoModel.id = lastPk;
			return compraTipoRequisicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraTipoRequisicaoModel?>? update(CompraTipoRequisicaoModel compraTipoRequisicaoModel) async {
		try {
			await Session.database.compraTipoRequisicaoDao.updateObject(toDrift(compraTipoRequisicaoModel));
			return compraTipoRequisicaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.compraTipoRequisicaoDao.deleteObject(toDrift(CompraTipoRequisicaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CompraTipoRequisicaoModel> toListModel(List<CompraTipoRequisicaoGrouped> compraTipoRequisicaoDriftList) {
		List<CompraTipoRequisicaoModel> listModel = [];
		for (var compraTipoRequisicaoDrift in compraTipoRequisicaoDriftList) {
			listModel.add(toModel(compraTipoRequisicaoDrift)!);
		}
		return listModel;
	}	

	CompraTipoRequisicaoModel? toModel(CompraTipoRequisicaoGrouped? compraTipoRequisicaoDrift) {
		if (compraTipoRequisicaoDrift != null) {
			return CompraTipoRequisicaoModel(
				id: compraTipoRequisicaoDrift.compraTipoRequisicao?.id,
				codigo: compraTipoRequisicaoDrift.compraTipoRequisicao?.codigo,
				nome: compraTipoRequisicaoDrift.compraTipoRequisicao?.nome,
				descricao: compraTipoRequisicaoDrift.compraTipoRequisicao?.descricao,
			);
		} else {
			return null;
		}
	}


	CompraTipoRequisicaoGrouped toDrift(CompraTipoRequisicaoModel compraTipoRequisicaoModel) {
		return CompraTipoRequisicaoGrouped(
			compraTipoRequisicao: CompraTipoRequisicao(
				id: compraTipoRequisicaoModel.id,
				codigo: compraTipoRequisicaoModel.codigo,
				nome: compraTipoRequisicaoModel.nome,
				descricao: compraTipoRequisicaoModel.descricao,
			),
		);
	}

		
}
