import 'package:sped/app/data/provider/drift/database/database_imports.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/data/provider/provider_base.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SpedContabilDriftProvider extends ProviderBase {

	Future<List<SpedContabilModel>?> getList({Filter? filter}) async {
		List<SpedContabilGrouped> spedContabilDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				spedContabilDriftList = await Session.database.spedContabilDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				spedContabilDriftList = await Session.database.spedContabilDao.getGroupedList(); 
			}
			if (spedContabilDriftList.isNotEmpty) {
				return toListModel(spedContabilDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SpedContabilModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.spedContabilDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SpedContabilModel?>? insert(SpedContabilModel spedContabilModel) async {
		try {
			final lastPk = await Session.database.spedContabilDao.insertObject(toDrift(spedContabilModel));
			spedContabilModel.id = lastPk;
			return spedContabilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SpedContabilModel?>? update(SpedContabilModel spedContabilModel) async {
		try {
			await Session.database.spedContabilDao.updateObject(toDrift(spedContabilModel));
			return spedContabilModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.spedContabilDao.deleteObject(toDrift(SpedContabilModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SpedContabilModel> toListModel(List<SpedContabilGrouped> spedContabilDriftList) {
		List<SpedContabilModel> listModel = [];
		for (var spedContabilDrift in spedContabilDriftList) {
			listModel.add(toModel(spedContabilDrift)!);
		}
		return listModel;
	}	

	SpedContabilModel? toModel(SpedContabilGrouped? spedContabilDrift) {
		if (spedContabilDrift != null) {
			return SpedContabilModel(
				id: spedContabilDrift.spedContabil?.id,
				dataEmissao: spedContabilDrift.spedContabil?.dataEmissao,
				periodoInicial: spedContabilDrift.spedContabil?.periodoInicial,
				periodoFinal: spedContabilDrift.spedContabil?.periodoFinal,
				formaEscrituracao: SpedContabilDomain.getFormaEscrituracao(spedContabilDrift.spedContabil?.formaEscrituracao),
				versaoLayout: spedContabilDrift.spedContabil?.versaoLayout,
			);
		} else {
			return null;
		}
	}


	SpedContabilGrouped toDrift(SpedContabilModel spedContabilModel) {
		return SpedContabilGrouped(
			spedContabil: SpedContabil(
				id: spedContabilModel.id,
				dataEmissao: spedContabilModel.dataEmissao,
				periodoInicial: spedContabilModel.periodoInicial,
				periodoFinal: spedContabilModel.periodoFinal,
				formaEscrituracao: SpedContabilDomain.setFormaEscrituracao(spedContabilModel.formaEscrituracao),
				versaoLayout: spedContabilModel.versaoLayout,
			),
		);
	}

		
}
