import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/provider/provider_base.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/data/domain/domain_imports.dart';

class OrcamentoPeriodoDriftProvider extends ProviderBase {

	Future<List<OrcamentoPeriodoModel>?> getList({Filter? filter}) async {
		List<OrcamentoPeriodoGrouped> orcamentoPeriodoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				orcamentoPeriodoDriftList = await Session.database.orcamentoPeriodoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				orcamentoPeriodoDriftList = await Session.database.orcamentoPeriodoDao.getGroupedList(); 
			}
			if (orcamentoPeriodoDriftList.isNotEmpty) {
				return toListModel(orcamentoPeriodoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OrcamentoPeriodoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.orcamentoPeriodoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoPeriodoModel?>? insert(OrcamentoPeriodoModel orcamentoPeriodoModel) async {
		try {
			final lastPk = await Session.database.orcamentoPeriodoDao.insertObject(toDrift(orcamentoPeriodoModel));
			orcamentoPeriodoModel.id = lastPk;
			return orcamentoPeriodoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoPeriodoModel?>? update(OrcamentoPeriodoModel orcamentoPeriodoModel) async {
		try {
			await Session.database.orcamentoPeriodoDao.updateObject(toDrift(orcamentoPeriodoModel));
			return orcamentoPeriodoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.orcamentoPeriodoDao.deleteObject(toDrift(OrcamentoPeriodoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OrcamentoPeriodoModel> toListModel(List<OrcamentoPeriodoGrouped> orcamentoPeriodoDriftList) {
		List<OrcamentoPeriodoModel> listModel = [];
		for (var orcamentoPeriodoDrift in orcamentoPeriodoDriftList) {
			listModel.add(toModel(orcamentoPeriodoDrift)!);
		}
		return listModel;
	}	

	OrcamentoPeriodoModel? toModel(OrcamentoPeriodoGrouped? orcamentoPeriodoDrift) {
		if (orcamentoPeriodoDrift != null) {
			return OrcamentoPeriodoModel(
				id: orcamentoPeriodoDrift.orcamentoPeriodo?.id,
				periodo: OrcamentoPeriodoDomain.getPeriodo(orcamentoPeriodoDrift.orcamentoPeriodo?.periodo),
				nome: orcamentoPeriodoDrift.orcamentoPeriodo?.nome,
			);
		} else {
			return null;
		}
	}


	OrcamentoPeriodoGrouped toDrift(OrcamentoPeriodoModel orcamentoPeriodoModel) {
		return OrcamentoPeriodoGrouped(
			orcamentoPeriodo: OrcamentoPeriodo(
				id: orcamentoPeriodoModel.id,
				periodo: OrcamentoPeriodoDomain.setPeriodo(orcamentoPeriodoModel.periodo),
				nome: orcamentoPeriodoModel.nome,
			),
		);
	}

		
}
