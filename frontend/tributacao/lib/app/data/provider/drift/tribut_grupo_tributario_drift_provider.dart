import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/provider/provider_base.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributGrupoTributarioDriftProvider extends ProviderBase {

	Future<List<TributGrupoTributarioModel>?> getList({Filter? filter}) async {
		List<TributGrupoTributarioGrouped> tributGrupoTributarioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tributGrupoTributarioDriftList = await Session.database.tributGrupoTributarioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tributGrupoTributarioDriftList = await Session.database.tributGrupoTributarioDao.getGroupedList(); 
			}
			if (tributGrupoTributarioDriftList.isNotEmpty) {
				return toListModel(tributGrupoTributarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TributGrupoTributarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tributGrupoTributarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributGrupoTributarioModel?>? insert(TributGrupoTributarioModel tributGrupoTributarioModel) async {
		try {
			final lastPk = await Session.database.tributGrupoTributarioDao.insertObject(toDrift(tributGrupoTributarioModel));
			tributGrupoTributarioModel.id = lastPk;
			return tributGrupoTributarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TributGrupoTributarioModel?>? update(TributGrupoTributarioModel tributGrupoTributarioModel) async {
		try {
			await Session.database.tributGrupoTributarioDao.updateObject(toDrift(tributGrupoTributarioModel));
			return tributGrupoTributarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tributGrupoTributarioDao.deleteObject(toDrift(TributGrupoTributarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TributGrupoTributarioModel> toListModel(List<TributGrupoTributarioGrouped> tributGrupoTributarioDriftList) {
		List<TributGrupoTributarioModel> listModel = [];
		for (var tributGrupoTributarioDrift in tributGrupoTributarioDriftList) {
			listModel.add(toModel(tributGrupoTributarioDrift)!);
		}
		return listModel;
	}	

	TributGrupoTributarioModel? toModel(TributGrupoTributarioGrouped? tributGrupoTributarioDrift) {
		if (tributGrupoTributarioDrift != null) {
			return TributGrupoTributarioModel(
				id: tributGrupoTributarioDrift.tributGrupoTributario?.id,
				descricao: tributGrupoTributarioDrift.tributGrupoTributario?.descricao,
				origemMercadoria: TributGrupoTributarioDomain.getOrigemMercadoria(tributGrupoTributarioDrift.tributGrupoTributario?.origemMercadoria),
				observacao: tributGrupoTributarioDrift.tributGrupoTributario?.observacao,
			);
		} else {
			return null;
		}
	}


	TributGrupoTributarioGrouped toDrift(TributGrupoTributarioModel tributGrupoTributarioModel) {
		return TributGrupoTributarioGrouped(
			tributGrupoTributario: TributGrupoTributario(
				id: tributGrupoTributarioModel.id,
				descricao: tributGrupoTributarioModel.descricao,
				origemMercadoria: TributGrupoTributarioDomain.setOrigemMercadoria(tributGrupoTributarioModel.origemMercadoria),
				observacao: tributGrupoTributarioModel.observacao,
			),
		);
	}

		
}
