import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTemplateDriftProvider extends ProviderBase {

	Future<List<ContratoTemplateModel>?> getList({Filter? filter}) async {
		List<ContratoTemplateGrouped> contratoTemplateDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contratoTemplateDriftList = await Session.database.contratoTemplateDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contratoTemplateDriftList = await Session.database.contratoTemplateDao.getGroupedList(); 
			}
			if (contratoTemplateDriftList.isNotEmpty) {
				return toListModel(contratoTemplateDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContratoTemplateModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contratoTemplateDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoTemplateModel?>? insert(ContratoTemplateModel contratoTemplateModel) async {
		try {
			final lastPk = await Session.database.contratoTemplateDao.insertObject(toDrift(contratoTemplateModel));
			contratoTemplateModel.id = lastPk;
			return contratoTemplateModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoTemplateModel?>? update(ContratoTemplateModel contratoTemplateModel) async {
		try {
			await Session.database.contratoTemplateDao.updateObject(toDrift(contratoTemplateModel));
			return contratoTemplateModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contratoTemplateDao.deleteObject(toDrift(ContratoTemplateModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContratoTemplateModel> toListModel(List<ContratoTemplateGrouped> contratoTemplateDriftList) {
		List<ContratoTemplateModel> listModel = [];
		for (var contratoTemplateDrift in contratoTemplateDriftList) {
			listModel.add(toModel(contratoTemplateDrift)!);
		}
		return listModel;
	}	

	ContratoTemplateModel? toModel(ContratoTemplateGrouped? contratoTemplateDrift) {
		if (contratoTemplateDrift != null) {
			return ContratoTemplateModel(
				id: contratoTemplateDrift.contratoTemplate?.id,
				nome: contratoTemplateDrift.contratoTemplate?.nome,
				descricao: contratoTemplateDrift.contratoTemplate?.descricao,
			);
		} else {
			return null;
		}
	}


	ContratoTemplateGrouped toDrift(ContratoTemplateModel contratoTemplateModel) {
		return ContratoTemplateGrouped(
			contratoTemplate: ContratoTemplate(
				id: contratoTemplateModel.id,
				nome: contratoTemplateModel.nome,
				descricao: contratoTemplateModel.descricao,
			),
		);
	}

		
}
