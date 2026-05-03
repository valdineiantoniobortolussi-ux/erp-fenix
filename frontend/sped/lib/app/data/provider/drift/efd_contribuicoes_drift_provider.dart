import 'package:sped/app/data/provider/drift/database/database_imports.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/data/provider/provider_base.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdContribuicoesDriftProvider extends ProviderBase {

	Future<List<EfdContribuicoesModel>?> getList({Filter? filter}) async {
		List<EfdContribuicoesGrouped> efdContribuicoesDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				efdContribuicoesDriftList = await Session.database.efdContribuicoesDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				efdContribuicoesDriftList = await Session.database.efdContribuicoesDao.getGroupedList(); 
			}
			if (efdContribuicoesDriftList.isNotEmpty) {
				return toListModel(efdContribuicoesDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EfdContribuicoesModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.efdContribuicoesDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EfdContribuicoesModel?>? insert(EfdContribuicoesModel efdContribuicoesModel) async {
		try {
			final lastPk = await Session.database.efdContribuicoesDao.insertObject(toDrift(efdContribuicoesModel));
			efdContribuicoesModel.id = lastPk;
			return efdContribuicoesModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EfdContribuicoesModel?>? update(EfdContribuicoesModel efdContribuicoesModel) async {
		try {
			await Session.database.efdContribuicoesDao.updateObject(toDrift(efdContribuicoesModel));
			return efdContribuicoesModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.efdContribuicoesDao.deleteObject(toDrift(EfdContribuicoesModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EfdContribuicoesModel> toListModel(List<EfdContribuicoesGrouped> efdContribuicoesDriftList) {
		List<EfdContribuicoesModel> listModel = [];
		for (var efdContribuicoesDrift in efdContribuicoesDriftList) {
			listModel.add(toModel(efdContribuicoesDrift)!);
		}
		return listModel;
	}	

	EfdContribuicoesModel? toModel(EfdContribuicoesGrouped? efdContribuicoesDrift) {
		if (efdContribuicoesDrift != null) {
			return EfdContribuicoesModel(
				id: efdContribuicoesDrift.efdContribuicoes?.id,
				dataEmissao: efdContribuicoesDrift.efdContribuicoes?.dataEmissao,
				periodoInicial: efdContribuicoesDrift.efdContribuicoes?.periodoInicial,
				periodoFinal: efdContribuicoesDrift.efdContribuicoes?.periodoFinal,
				finalidadeArquivo: efdContribuicoesDrift.efdContribuicoes?.finalidadeArquivo,
			);
		} else {
			return null;
		}
	}


	EfdContribuicoesGrouped toDrift(EfdContribuicoesModel efdContribuicoesModel) {
		return EfdContribuicoesGrouped(
			efdContribuicoes: EfdContribuicoes(
				id: efdContribuicoesModel.id,
				dataEmissao: efdContribuicoesModel.dataEmissao,
				periodoInicial: efdContribuicoesModel.periodoInicial,
				periodoFinal: efdContribuicoesModel.periodoFinal,
				finalidadeArquivo: efdContribuicoesModel.finalidadeArquivo,
			),
		);
	}

		
}
