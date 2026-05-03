import 'package:compras/app/data/provider/drift/database/database_imports.dart';
import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/provider/provider_base.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/model/model_imports.dart';

class CompraTipoPedidoDriftProvider extends ProviderBase {

	Future<List<CompraTipoPedidoModel>?> getList({Filter? filter}) async {
		List<CompraTipoPedidoGrouped> compraTipoPedidoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				compraTipoPedidoDriftList = await Session.database.compraTipoPedidoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				compraTipoPedidoDriftList = await Session.database.compraTipoPedidoDao.getGroupedList(); 
			}
			if (compraTipoPedidoDriftList.isNotEmpty) {
				return toListModel(compraTipoPedidoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CompraTipoPedidoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.compraTipoPedidoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraTipoPedidoModel?>? insert(CompraTipoPedidoModel compraTipoPedidoModel) async {
		try {
			final lastPk = await Session.database.compraTipoPedidoDao.insertObject(toDrift(compraTipoPedidoModel));
			compraTipoPedidoModel.id = lastPk;
			return compraTipoPedidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CompraTipoPedidoModel?>? update(CompraTipoPedidoModel compraTipoPedidoModel) async {
		try {
			await Session.database.compraTipoPedidoDao.updateObject(toDrift(compraTipoPedidoModel));
			return compraTipoPedidoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.compraTipoPedidoDao.deleteObject(toDrift(CompraTipoPedidoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CompraTipoPedidoModel> toListModel(List<CompraTipoPedidoGrouped> compraTipoPedidoDriftList) {
		List<CompraTipoPedidoModel> listModel = [];
		for (var compraTipoPedidoDrift in compraTipoPedidoDriftList) {
			listModel.add(toModel(compraTipoPedidoDrift)!);
		}
		return listModel;
	}	

	CompraTipoPedidoModel? toModel(CompraTipoPedidoGrouped? compraTipoPedidoDrift) {
		if (compraTipoPedidoDrift != null) {
			return CompraTipoPedidoModel(
				id: compraTipoPedidoDrift.compraTipoPedido?.id,
				codigo: compraTipoPedidoDrift.compraTipoPedido?.codigo,
				nome: compraTipoPedidoDrift.compraTipoPedido?.nome,
				descricao: compraTipoPedidoDrift.compraTipoPedido?.descricao,
			);
		} else {
			return null;
		}
	}


	CompraTipoPedidoGrouped toDrift(CompraTipoPedidoModel compraTipoPedidoModel) {
		return CompraTipoPedidoGrouped(
			compraTipoPedido: CompraTipoPedido(
				id: compraTipoPedidoModel.id,
				codigo: compraTipoPedidoModel.codigo,
				nome: compraTipoPedidoModel.nome,
				descricao: compraTipoPedidoModel.descricao,
			),
		);
	}

		
}
