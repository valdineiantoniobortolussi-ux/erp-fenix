import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/provider/provider_base.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/data/domain/domain_imports.dart';

class OrcamentoFluxoCaixaPeriodoDriftProvider extends ProviderBase {

	Future<List<OrcamentoFluxoCaixaPeriodoModel>?> getList({Filter? filter}) async {
		List<OrcamentoFluxoCaixaPeriodoGrouped> orcamentoFluxoCaixaPeriodoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				orcamentoFluxoCaixaPeriodoDriftList = await Session.database.orcamentoFluxoCaixaPeriodoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				orcamentoFluxoCaixaPeriodoDriftList = await Session.database.orcamentoFluxoCaixaPeriodoDao.getGroupedList(); 
			}
			if (orcamentoFluxoCaixaPeriodoDriftList.isNotEmpty) {
				return toListModel(orcamentoFluxoCaixaPeriodoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OrcamentoFluxoCaixaPeriodoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.orcamentoFluxoCaixaPeriodoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoFluxoCaixaPeriodoModel?>? insert(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) async {
		try {
			final lastPk = await Session.database.orcamentoFluxoCaixaPeriodoDao.insertObject(toDrift(orcamentoFluxoCaixaPeriodoModel));
			orcamentoFluxoCaixaPeriodoModel.id = lastPk;
			return orcamentoFluxoCaixaPeriodoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoFluxoCaixaPeriodoModel?>? update(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) async {
		try {
			await Session.database.orcamentoFluxoCaixaPeriodoDao.updateObject(toDrift(orcamentoFluxoCaixaPeriodoModel));
			return orcamentoFluxoCaixaPeriodoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.orcamentoFluxoCaixaPeriodoDao.deleteObject(toDrift(OrcamentoFluxoCaixaPeriodoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OrcamentoFluxoCaixaPeriodoModel> toListModel(List<OrcamentoFluxoCaixaPeriodoGrouped> orcamentoFluxoCaixaPeriodoDriftList) {
		List<OrcamentoFluxoCaixaPeriodoModel> listModel = [];
		for (var orcamentoFluxoCaixaPeriodoDrift in orcamentoFluxoCaixaPeriodoDriftList) {
			listModel.add(toModel(orcamentoFluxoCaixaPeriodoDrift)!);
		}
		return listModel;
	}	

	OrcamentoFluxoCaixaPeriodoModel? toModel(OrcamentoFluxoCaixaPeriodoGrouped? orcamentoFluxoCaixaPeriodoDrift) {
		if (orcamentoFluxoCaixaPeriodoDrift != null) {
			return OrcamentoFluxoCaixaPeriodoModel(
				id: orcamentoFluxoCaixaPeriodoDrift.orcamentoFluxoCaixaPeriodo?.id,
				idBancoContaCaixa: orcamentoFluxoCaixaPeriodoDrift.orcamentoFluxoCaixaPeriodo?.idBancoContaCaixa,
				periodo: OrcamentoFluxoCaixaPeriodoDomain.getPeriodo(orcamentoFluxoCaixaPeriodoDrift.orcamentoFluxoCaixaPeriodo?.periodo),
				nome: orcamentoFluxoCaixaPeriodoDrift.orcamentoFluxoCaixaPeriodo?.nome,
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.id,
					numero: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.numero,
					digito: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.digito,
					nome: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.nome,
					tipo: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.tipo,
					descricao: orcamentoFluxoCaixaPeriodoDrift.bancoContaCaixa?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	OrcamentoFluxoCaixaPeriodoGrouped toDrift(OrcamentoFluxoCaixaPeriodoModel orcamentoFluxoCaixaPeriodoModel) {
		return OrcamentoFluxoCaixaPeriodoGrouped(
			orcamentoFluxoCaixaPeriodo: OrcamentoFluxoCaixaPeriodo(
				id: orcamentoFluxoCaixaPeriodoModel.id,
				idBancoContaCaixa: orcamentoFluxoCaixaPeriodoModel.idBancoContaCaixa,
				periodo: OrcamentoFluxoCaixaPeriodoDomain.setPeriodo(orcamentoFluxoCaixaPeriodoModel.periodo),
				nome: orcamentoFluxoCaixaPeriodoModel.nome,
			),
		);
	}

		
}
