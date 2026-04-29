import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';

class PatrimGrupoBemDriftProvider extends ProviderBase {

	Future<List<PatrimGrupoBemModel>?> getList({Filter? filter}) async {
		List<PatrimGrupoBemGrouped> patrimGrupoBemDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimGrupoBemDriftList = await Session.database.patrimGrupoBemDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimGrupoBemDriftList = await Session.database.patrimGrupoBemDao.getGroupedList(); 
			}
			if (patrimGrupoBemDriftList.isNotEmpty) {
				return toListModel(patrimGrupoBemDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimGrupoBemModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimGrupoBemDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimGrupoBemModel?>? insert(PatrimGrupoBemModel patrimGrupoBemModel) async {
		try {
			final lastPk = await Session.database.patrimGrupoBemDao.insertObject(toDrift(patrimGrupoBemModel));
			patrimGrupoBemModel.id = lastPk;
			return patrimGrupoBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimGrupoBemModel?>? update(PatrimGrupoBemModel patrimGrupoBemModel) async {
		try {
			await Session.database.patrimGrupoBemDao.updateObject(toDrift(patrimGrupoBemModel));
			return patrimGrupoBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimGrupoBemDao.deleteObject(toDrift(PatrimGrupoBemModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimGrupoBemModel> toListModel(List<PatrimGrupoBemGrouped> patrimGrupoBemDriftList) {
		List<PatrimGrupoBemModel> listModel = [];
		for (var patrimGrupoBemDrift in patrimGrupoBemDriftList) {
			listModel.add(toModel(patrimGrupoBemDrift)!);
		}
		return listModel;
	}	

	PatrimGrupoBemModel? toModel(PatrimGrupoBemGrouped? patrimGrupoBemDrift) {
		if (patrimGrupoBemDrift != null) {
			return PatrimGrupoBemModel(
				id: patrimGrupoBemDrift.patrimGrupoBem?.id,
				codigo: patrimGrupoBemDrift.patrimGrupoBem?.codigo,
				nome: patrimGrupoBemDrift.patrimGrupoBem?.nome,
				descricao: patrimGrupoBemDrift.patrimGrupoBem?.descricao,
				contaAtivoImobilizado: patrimGrupoBemDrift.patrimGrupoBem?.contaAtivoImobilizado,
				contaDepreciacaoAcumulada: patrimGrupoBemDrift.patrimGrupoBem?.contaDepreciacaoAcumulada,
				contaDespesaDepreciacao: patrimGrupoBemDrift.patrimGrupoBem?.contaDespesaDepreciacao,
				codigoHistorico: patrimGrupoBemDrift.patrimGrupoBem?.codigoHistorico,
			);
		} else {
			return null;
		}
	}


	PatrimGrupoBemGrouped toDrift(PatrimGrupoBemModel patrimGrupoBemModel) {
		return PatrimGrupoBemGrouped(
			patrimGrupoBem: PatrimGrupoBem(
				id: patrimGrupoBemModel.id,
				codigo: patrimGrupoBemModel.codigo,
				nome: patrimGrupoBemModel.nome,
				descricao: patrimGrupoBemModel.descricao,
				contaAtivoImobilizado: patrimGrupoBemModel.contaAtivoImobilizado,
				contaDepreciacaoAcumulada: patrimGrupoBemModel.contaDepreciacaoAcumulada,
				contaDespesaDepreciacao: patrimGrupoBemModel.contaDespesaDepreciacao,
				codigoHistorico: patrimGrupoBemModel.codigoHistorico,
			),
		);
	}

		
}
