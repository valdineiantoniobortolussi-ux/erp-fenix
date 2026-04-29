import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorSituacaoDriftProvider extends ProviderBase {

	Future<List<ColaboradorSituacaoModel>?> getList({Filter? filter}) async {
		List<ColaboradorSituacaoGrouped> colaboradorSituacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				colaboradorSituacaoDriftList = await Session.database.colaboradorSituacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				colaboradorSituacaoDriftList = await Session.database.colaboradorSituacaoDao.getGroupedList(); 
			}
			if (colaboradorSituacaoDriftList.isNotEmpty) {
				return toListModel(colaboradorSituacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ColaboradorSituacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.colaboradorSituacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorSituacaoModel?>? insert(ColaboradorSituacaoModel colaboradorSituacaoModel) async {
		try {
			final lastPk = await Session.database.colaboradorSituacaoDao.insertObject(toDrift(colaboradorSituacaoModel));
			colaboradorSituacaoModel.id = lastPk;
			return colaboradorSituacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorSituacaoModel?>? update(ColaboradorSituacaoModel colaboradorSituacaoModel) async {
		try {
			await Session.database.colaboradorSituacaoDao.updateObject(toDrift(colaboradorSituacaoModel));
			return colaboradorSituacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.colaboradorSituacaoDao.deleteObject(toDrift(ColaboradorSituacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ColaboradorSituacaoModel> toListModel(List<ColaboradorSituacaoGrouped> colaboradorSituacaoDriftList) {
		List<ColaboradorSituacaoModel> listModel = [];
		for (var colaboradorSituacaoDrift in colaboradorSituacaoDriftList) {
			listModel.add(toModel(colaboradorSituacaoDrift)!);
		}
		return listModel;
	}	

	ColaboradorSituacaoModel? toModel(ColaboradorSituacaoGrouped? colaboradorSituacaoDrift) {
		if (colaboradorSituacaoDrift != null) {
			return ColaboradorSituacaoModel(
				id: colaboradorSituacaoDrift.colaboradorSituacao?.id,
				codigo: colaboradorSituacaoDrift.colaboradorSituacao?.codigo,
				nome: colaboradorSituacaoDrift.colaboradorSituacao?.nome,
				descricao: colaboradorSituacaoDrift.colaboradorSituacao?.descricao,
			);
		} else {
			return null;
		}
	}


	ColaboradorSituacaoGrouped toDrift(ColaboradorSituacaoModel colaboradorSituacaoModel) {
		return ColaboradorSituacaoGrouped(
			colaboradorSituacao: ColaboradorSituacao(
				id: colaboradorSituacaoModel.id,
				codigo: colaboradorSituacaoModel.codigo,
				nome: colaboradorSituacaoModel.nome,
				descricao: colaboradorSituacaoModel.descricao,
			),
		);
	}

		
}
