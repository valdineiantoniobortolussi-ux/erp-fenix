import 'package:sped/app/data/provider/drift/database/database_imports.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/data/provider/provider_base.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/model/model_imports.dart';

class EfdReinfDriftProvider extends ProviderBase {

	Future<List<EfdReinfModel>?> getList({Filter? filter}) async {
		List<EfdReinfGrouped> efdReinfDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				efdReinfDriftList = await Session.database.efdReinfDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				efdReinfDriftList = await Session.database.efdReinfDao.getGroupedList(); 
			}
			if (efdReinfDriftList.isNotEmpty) {
				return toListModel(efdReinfDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EfdReinfModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.efdReinfDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EfdReinfModel?>? insert(EfdReinfModel efdReinfModel) async {
		try {
			final lastPk = await Session.database.efdReinfDao.insertObject(toDrift(efdReinfModel));
			efdReinfModel.id = lastPk;
			return efdReinfModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EfdReinfModel?>? update(EfdReinfModel efdReinfModel) async {
		try {
			await Session.database.efdReinfDao.updateObject(toDrift(efdReinfModel));
			return efdReinfModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.efdReinfDao.deleteObject(toDrift(EfdReinfModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EfdReinfModel> toListModel(List<EfdReinfGrouped> efdReinfDriftList) {
		List<EfdReinfModel> listModel = [];
		for (var efdReinfDrift in efdReinfDriftList) {
			listModel.add(toModel(efdReinfDrift)!);
		}
		return listModel;
	}	

	EfdReinfModel? toModel(EfdReinfGrouped? efdReinfDrift) {
		if (efdReinfDrift != null) {
			return EfdReinfModel(
				id: efdReinfDrift.efdReinf?.id,
				dataEmissao: efdReinfDrift.efdReinf?.dataEmissao,
				periodoInicial: efdReinfDrift.efdReinf?.periodoInicial,
				periodoFinal: efdReinfDrift.efdReinf?.periodoFinal,
				finalidadeArquivo: efdReinfDrift.efdReinf?.finalidadeArquivo,
			);
		} else {
			return null;
		}
	}


	EfdReinfGrouped toDrift(EfdReinfModel efdReinfModel) {
		return EfdReinfGrouped(
			efdReinf: EfdReinf(
				id: efdReinfModel.id,
				dataEmissao: efdReinfModel.dataEmissao,
				periodoInicial: efdReinfModel.periodoInicial,
				periodoFinal: efdReinfModel.periodoFinal,
				finalidadeArquivo: efdReinfModel.finalidadeArquivo,
			),
		);
	}

		
}
