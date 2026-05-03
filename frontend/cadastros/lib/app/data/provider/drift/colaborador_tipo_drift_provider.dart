import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ColaboradorTipoDriftProvider extends ProviderBase {

	Future<List<ColaboradorTipoModel>?> getList({Filter? filter}) async {
		List<ColaboradorTipoGrouped> colaboradorTipoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				colaboradorTipoDriftList = await Session.database.colaboradorTipoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				colaboradorTipoDriftList = await Session.database.colaboradorTipoDao.getGroupedList(); 
			}
			if (colaboradorTipoDriftList.isNotEmpty) {
				return toListModel(colaboradorTipoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ColaboradorTipoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.colaboradorTipoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorTipoModel?>? insert(ColaboradorTipoModel colaboradorTipoModel) async {
		try {
			final lastPk = await Session.database.colaboradorTipoDao.insertObject(toDrift(colaboradorTipoModel));
			colaboradorTipoModel.id = lastPk;
			return colaboradorTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ColaboradorTipoModel?>? update(ColaboradorTipoModel colaboradorTipoModel) async {
		try {
			await Session.database.colaboradorTipoDao.updateObject(toDrift(colaboradorTipoModel));
			return colaboradorTipoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.colaboradorTipoDao.deleteObject(toDrift(ColaboradorTipoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ColaboradorTipoModel> toListModel(List<ColaboradorTipoGrouped> colaboradorTipoDriftList) {
		List<ColaboradorTipoModel> listModel = [];
		for (var colaboradorTipoDrift in colaboradorTipoDriftList) {
			listModel.add(toModel(colaboradorTipoDrift)!);
		}
		return listModel;
	}	

	ColaboradorTipoModel? toModel(ColaboradorTipoGrouped? colaboradorTipoDrift) {
		if (colaboradorTipoDrift != null) {
			return ColaboradorTipoModel(
				id: colaboradorTipoDrift.colaboradorTipo?.id,
				nome: colaboradorTipoDrift.colaboradorTipo?.nome,
				descricao: colaboradorTipoDrift.colaboradorTipo?.descricao,
			);
		} else {
			return null;
		}
	}


	ColaboradorTipoGrouped toDrift(ColaboradorTipoModel colaboradorTipoModel) {
		return ColaboradorTipoGrouped(
			colaboradorTipo: ColaboradorTipo(
				id: colaboradorTipoModel.id,
				nome: colaboradorTipoModel.nome,
				descricao: colaboradorTipoModel.descricao,
			),
		);
	}

		
}
