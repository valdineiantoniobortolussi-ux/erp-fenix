import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TipoAdmissaoDriftProvider extends ProviderBase {

	Future<List<TipoAdmissaoModel>?> getList({Filter? filter}) async {
		List<TipoAdmissaoGrouped> tipoAdmissaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tipoAdmissaoDriftList = await Session.database.tipoAdmissaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tipoAdmissaoDriftList = await Session.database.tipoAdmissaoDao.getGroupedList(); 
			}
			if (tipoAdmissaoDriftList.isNotEmpty) {
				return toListModel(tipoAdmissaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TipoAdmissaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tipoAdmissaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoAdmissaoModel?>? insert(TipoAdmissaoModel tipoAdmissaoModel) async {
		try {
			final lastPk = await Session.database.tipoAdmissaoDao.insertObject(toDrift(tipoAdmissaoModel));
			tipoAdmissaoModel.id = lastPk;
			return tipoAdmissaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TipoAdmissaoModel?>? update(TipoAdmissaoModel tipoAdmissaoModel) async {
		try {
			await Session.database.tipoAdmissaoDao.updateObject(toDrift(tipoAdmissaoModel));
			return tipoAdmissaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tipoAdmissaoDao.deleteObject(toDrift(TipoAdmissaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TipoAdmissaoModel> toListModel(List<TipoAdmissaoGrouped> tipoAdmissaoDriftList) {
		List<TipoAdmissaoModel> listModel = [];
		for (var tipoAdmissaoDrift in tipoAdmissaoDriftList) {
			listModel.add(toModel(tipoAdmissaoDrift)!);
		}
		return listModel;
	}	

	TipoAdmissaoModel? toModel(TipoAdmissaoGrouped? tipoAdmissaoDrift) {
		if (tipoAdmissaoDrift != null) {
			return TipoAdmissaoModel(
				id: tipoAdmissaoDrift.tipoAdmissao?.id,
				codigo: tipoAdmissaoDrift.tipoAdmissao?.codigo,
				nome: tipoAdmissaoDrift.tipoAdmissao?.nome,
				descricao: tipoAdmissaoDrift.tipoAdmissao?.descricao,
			);
		} else {
			return null;
		}
	}


	TipoAdmissaoGrouped toDrift(TipoAdmissaoModel tipoAdmissaoModel) {
		return TipoAdmissaoGrouped(
			tipoAdmissao: TipoAdmissao(
				id: tipoAdmissaoModel.id,
				codigo: tipoAdmissaoModel.codigo,
				nome: tipoAdmissaoModel.nome,
				descricao: tipoAdmissaoModel.descricao,
			),
		);
	}

		
}
