import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/provider/provider_base.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class UsuarioTokenDriftProvider extends ProviderBase {

	Future<List<UsuarioTokenModel>?> getList({Filter? filter}) async {
		List<UsuarioTokenGrouped> usuarioTokenDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				usuarioTokenDriftList = await Session.database.usuarioTokenDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				usuarioTokenDriftList = await Session.database.usuarioTokenDao.getGroupedList(); 
			}
			if (usuarioTokenDriftList.isNotEmpty) {
				return toListModel(usuarioTokenDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<UsuarioTokenModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.usuarioTokenDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UsuarioTokenModel?>? insert(UsuarioTokenModel usuarioTokenModel) async {
		try {
			final lastPk = await Session.database.usuarioTokenDao.insertObject(toDrift(usuarioTokenModel));
			usuarioTokenModel.id = lastPk;
			return usuarioTokenModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<UsuarioTokenModel?>? update(UsuarioTokenModel usuarioTokenModel) async {
		try {
			await Session.database.usuarioTokenDao.updateObject(toDrift(usuarioTokenModel));
			return usuarioTokenModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.usuarioTokenDao.deleteObject(toDrift(UsuarioTokenModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<UsuarioTokenModel> toListModel(List<UsuarioTokenGrouped> usuarioTokenDriftList) {
		List<UsuarioTokenModel> listModel = [];
		for (var usuarioTokenDrift in usuarioTokenDriftList) {
			listModel.add(toModel(usuarioTokenDrift)!);
		}
		return listModel;
	}	

	UsuarioTokenModel? toModel(UsuarioTokenGrouped? usuarioTokenDrift) {
		if (usuarioTokenDrift != null) {
			return UsuarioTokenModel(
				id: usuarioTokenDrift.usuarioToken?.id,
				login: usuarioTokenDrift.usuarioToken?.login,
				token: usuarioTokenDrift.usuarioToken?.token,
				dataCriacao: usuarioTokenDrift.usuarioToken?.dataCriacao,
				horaCriacao: usuarioTokenDrift.usuarioToken?.horaCriacao,
				dataExpiracao: usuarioTokenDrift.usuarioToken?.dataExpiracao,
				horaExpiracao: usuarioTokenDrift.usuarioToken?.horaExpiracao,
			);
		} else {
			return null;
		}
	}


	UsuarioTokenGrouped toDrift(UsuarioTokenModel usuarioTokenModel) {
		return UsuarioTokenGrouped(
			usuarioToken: UsuarioToken(
				id: usuarioTokenModel.id,
				login: usuarioTokenModel.login,
				token: usuarioTokenModel.token,
				dataCriacao: usuarioTokenModel.dataCriacao,
				horaCriacao: usuarioTokenModel.horaCriacao,
				dataExpiracao: usuarioTokenModel.dataExpiracao,
				horaExpiracao: usuarioTokenModel.horaExpiracao,
			),
		);
	}

		
}
