import 'package:sped/app/data/provider/drift/database/database_imports.dart';
import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/data/provider/provider_base.dart';
import 'package:sped/app/data/provider/drift/database/database.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/data/domain/domain_imports.dart';

class SpedFiscalDriftProvider extends ProviderBase {

	Future<List<SpedFiscalModel>?> getList({Filter? filter}) async {
		List<SpedFiscalGrouped> spedFiscalDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				spedFiscalDriftList = await Session.database.spedFiscalDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				spedFiscalDriftList = await Session.database.spedFiscalDao.getGroupedList(); 
			}
			if (spedFiscalDriftList.isNotEmpty) {
				return toListModel(spedFiscalDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SpedFiscalModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.spedFiscalDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SpedFiscalModel?>? insert(SpedFiscalModel spedFiscalModel) async {
		try {
			final lastPk = await Session.database.spedFiscalDao.insertObject(toDrift(spedFiscalModel));
			spedFiscalModel.id = lastPk;
			return spedFiscalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SpedFiscalModel?>? update(SpedFiscalModel spedFiscalModel) async {
		try {
			await Session.database.spedFiscalDao.updateObject(toDrift(spedFiscalModel));
			return spedFiscalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.spedFiscalDao.deleteObject(toDrift(SpedFiscalModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SpedFiscalModel> toListModel(List<SpedFiscalGrouped> spedFiscalDriftList) {
		List<SpedFiscalModel> listModel = [];
		for (var spedFiscalDrift in spedFiscalDriftList) {
			listModel.add(toModel(spedFiscalDrift)!);
		}
		return listModel;
	}	

	SpedFiscalModel? toModel(SpedFiscalGrouped? spedFiscalDrift) {
		if (spedFiscalDrift != null) {
			return SpedFiscalModel(
				id: spedFiscalDrift.spedFiscal?.id,
				dataEmissao: spedFiscalDrift.spedFiscal?.dataEmissao,
				periodoInicial: spedFiscalDrift.spedFiscal?.periodoInicial,
				periodoFinal: spedFiscalDrift.spedFiscal?.periodoFinal,
				perfilApresentacao: SpedFiscalDomain.getPerfilApresentacao(spedFiscalDrift.spedFiscal?.perfilApresentacao),
				finalidadeArquivo: spedFiscalDrift.spedFiscal?.finalidadeArquivo,
				versaoLayout: spedFiscalDrift.spedFiscal?.versaoLayout,
			);
		} else {
			return null;
		}
	}


	SpedFiscalGrouped toDrift(SpedFiscalModel spedFiscalModel) {
		return SpedFiscalGrouped(
			spedFiscal: SpedFiscal(
				id: spedFiscalModel.id,
				dataEmissao: spedFiscalModel.dataEmissao,
				periodoInicial: spedFiscalModel.periodoInicial,
				periodoFinal: spedFiscalModel.periodoFinal,
				perfilApresentacao: SpedFiscalDomain.setPerfilApresentacao(spedFiscalModel.perfilApresentacao),
				finalidadeArquivo: spedFiscalModel.finalidadeArquivo,
				versaoLayout: spedFiscalModel.versaoLayout,
			),
		);
	}

		
}
