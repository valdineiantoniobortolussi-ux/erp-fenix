import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class ComissaoPerfilDriftProvider extends ProviderBase {

	Future<List<ComissaoPerfilModel>?> getList({Filter? filter}) async {
		List<ComissaoPerfilGrouped> comissaoPerfilDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				comissaoPerfilDriftList = await Session.database.comissaoPerfilDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				comissaoPerfilDriftList = await Session.database.comissaoPerfilDao.getGroupedList(); 
			}
			if (comissaoPerfilDriftList.isNotEmpty) {
				return toListModel(comissaoPerfilDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ComissaoPerfilModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.comissaoPerfilDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ComissaoPerfilModel?>? insert(ComissaoPerfilModel comissaoPerfilModel) async {
		try {
			final lastPk = await Session.database.comissaoPerfilDao.insertObject(toDrift(comissaoPerfilModel));
			comissaoPerfilModel.id = lastPk;
			return comissaoPerfilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ComissaoPerfilModel?>? update(ComissaoPerfilModel comissaoPerfilModel) async {
		try {
			await Session.database.comissaoPerfilDao.updateObject(toDrift(comissaoPerfilModel));
			return comissaoPerfilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.comissaoPerfilDao.deleteObject(toDrift(ComissaoPerfilModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ComissaoPerfilModel> toListModel(List<ComissaoPerfilGrouped> comissaoPerfilDriftList) {
		List<ComissaoPerfilModel> listModel = [];
		for (var comissaoPerfilDrift in comissaoPerfilDriftList) {
			listModel.add(toModel(comissaoPerfilDrift)!);
		}
		return listModel;
	}	

	ComissaoPerfilModel? toModel(ComissaoPerfilGrouped? comissaoPerfilDrift) {
		if (comissaoPerfilDrift != null) {
			return ComissaoPerfilModel(
				id: comissaoPerfilDrift.comissaoPerfil?.id,
				codigo: ComissaoPerfilDomain.getCodigo(comissaoPerfilDrift.comissaoPerfil?.codigo),
				nome: comissaoPerfilDrift.comissaoPerfil?.nome,
			);
		} else {
			return null;
		}
	}


	ComissaoPerfilGrouped toDrift(ComissaoPerfilModel comissaoPerfilModel) {
		return ComissaoPerfilGrouped(
			comissaoPerfil: ComissaoPerfil(
				id: comissaoPerfilModel.id,
				codigo: ComissaoPerfilDomain.setCodigo(comissaoPerfilModel.codigo),
				nome: comissaoPerfilModel.nome,
			),
		);
	}

		
}
