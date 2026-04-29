import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/provider/provider_base.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoFluxoCaixaDriftProvider extends ProviderBase {

	Future<List<OrcamentoFluxoCaixaModel>?> getList({Filter? filter}) async {
		List<OrcamentoFluxoCaixaGrouped> orcamentoFluxoCaixaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				orcamentoFluxoCaixaDriftList = await Session.database.orcamentoFluxoCaixaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				orcamentoFluxoCaixaDriftList = await Session.database.orcamentoFluxoCaixaDao.getGroupedList(); 
			}
			if (orcamentoFluxoCaixaDriftList.isNotEmpty) {
				return toListModel(orcamentoFluxoCaixaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OrcamentoFluxoCaixaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.orcamentoFluxoCaixaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoFluxoCaixaModel?>? insert(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) async {
		try {
			final lastPk = await Session.database.orcamentoFluxoCaixaDao.insertObject(toDrift(orcamentoFluxoCaixaModel));
			orcamentoFluxoCaixaModel.id = lastPk;
			return orcamentoFluxoCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoFluxoCaixaModel?>? update(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) async {
		try {
			await Session.database.orcamentoFluxoCaixaDao.updateObject(toDrift(orcamentoFluxoCaixaModel));
			return orcamentoFluxoCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.orcamentoFluxoCaixaDao.deleteObject(toDrift(OrcamentoFluxoCaixaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OrcamentoFluxoCaixaModel> toListModel(List<OrcamentoFluxoCaixaGrouped> orcamentoFluxoCaixaDriftList) {
		List<OrcamentoFluxoCaixaModel> listModel = [];
		for (var orcamentoFluxoCaixaDrift in orcamentoFluxoCaixaDriftList) {
			listModel.add(toModel(orcamentoFluxoCaixaDrift)!);
		}
		return listModel;
	}	

	OrcamentoFluxoCaixaModel? toModel(OrcamentoFluxoCaixaGrouped? orcamentoFluxoCaixaDrift) {
		if (orcamentoFluxoCaixaDrift != null) {
			return OrcamentoFluxoCaixaModel(
				id: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.id,
				idOrcFluxoCaixaPeriodo: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.idOrcFluxoCaixaPeriodo,
				nome: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.nome,
				dataInicial: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.dataInicial,
				numeroPeriodos: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.numeroPeriodos,
				dataBase: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.dataBase,
				descricao: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixa?.descricao,
				orcamentoFluxoCaixaDetalheModelList: orcamentoFluxoCaixaDetalheDriftToModel(orcamentoFluxoCaixaDrift.orcamentoFluxoCaixaDetalheGroupedList),
				orcamentoFluxoCaixaPeriodoModel: OrcamentoFluxoCaixaPeriodoModel(
					id: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixaPeriodo?.id,
					idBancoContaCaixa: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixaPeriodo?.idBancoContaCaixa,
					periodo: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixaPeriodo?.periodo,
					nome: orcamentoFluxoCaixaDrift.orcamentoFluxoCaixaPeriodo?.nome,
				),
			);
		} else {
			return null;
		}
	}

	List<OrcamentoFluxoCaixaDetalheModel> orcamentoFluxoCaixaDetalheDriftToModel(List<OrcamentoFluxoCaixaDetalheGrouped>? orcamentoFluxoCaixaDetalheDriftList) { 
		List<OrcamentoFluxoCaixaDetalheModel> orcamentoFluxoCaixaDetalheModelList = [];
		if (orcamentoFluxoCaixaDetalheDriftList != null) {
			for (var orcamentoFluxoCaixaDetalheGrouped in orcamentoFluxoCaixaDetalheDriftList) {
				orcamentoFluxoCaixaDetalheModelList.add(
					OrcamentoFluxoCaixaDetalheModel(
						id: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.id,
						idOrcamentoFluxoCaixa: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.idOrcamentoFluxoCaixa,
						idFinNaturezaFinanceira: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.idFinNaturezaFinanceira,
						finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
							id: orcamentoFluxoCaixaDetalheGrouped.finNaturezaFinanceira?.id,
							codigo: orcamentoFluxoCaixaDetalheGrouped.finNaturezaFinanceira?.codigo,
							descricao: orcamentoFluxoCaixaDetalheGrouped.finNaturezaFinanceira?.descricao,
							tipo: orcamentoFluxoCaixaDetalheGrouped.finNaturezaFinanceira?.tipo,
							aplicacao: orcamentoFluxoCaixaDetalheGrouped.finNaturezaFinanceira?.aplicacao,
						),
						periodo: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.periodo,
						valorOrcado: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.valorOrcado,
						valorRealizado: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.valorRealizado,
						taxaVariacao: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.taxaVariacao,
						valorVariacao: orcamentoFluxoCaixaDetalheGrouped.orcamentoFluxoCaixaDetalhe?.valorVariacao,
					)
				);
			}
			return orcamentoFluxoCaixaDetalheModelList;
		}
		return [];
	}


	OrcamentoFluxoCaixaGrouped toDrift(OrcamentoFluxoCaixaModel orcamentoFluxoCaixaModel) {
		return OrcamentoFluxoCaixaGrouped(
			orcamentoFluxoCaixa: OrcamentoFluxoCaixa(
				id: orcamentoFluxoCaixaModel.id,
				idOrcFluxoCaixaPeriodo: orcamentoFluxoCaixaModel.idOrcFluxoCaixaPeriodo,
				nome: orcamentoFluxoCaixaModel.nome,
				dataInicial: orcamentoFluxoCaixaModel.dataInicial,
				numeroPeriodos: orcamentoFluxoCaixaModel.numeroPeriodos,
				dataBase: orcamentoFluxoCaixaModel.dataBase,
				descricao: orcamentoFluxoCaixaModel.descricao,
			),
			orcamentoFluxoCaixaDetalheGroupedList: orcamentoFluxoCaixaDetalheModelToDrift(orcamentoFluxoCaixaModel.orcamentoFluxoCaixaDetalheModelList),
		);
	}

	List<OrcamentoFluxoCaixaDetalheGrouped> orcamentoFluxoCaixaDetalheModelToDrift(List<OrcamentoFluxoCaixaDetalheModel>? orcamentoFluxoCaixaDetalheModelList) { 
		List<OrcamentoFluxoCaixaDetalheGrouped> orcamentoFluxoCaixaDetalheGroupedList = [];
		if (orcamentoFluxoCaixaDetalheModelList != null) {
			for (var orcamentoFluxoCaixaDetalheModel in orcamentoFluxoCaixaDetalheModelList) {
				orcamentoFluxoCaixaDetalheGroupedList.add(
					OrcamentoFluxoCaixaDetalheGrouped(
						orcamentoFluxoCaixaDetalhe: OrcamentoFluxoCaixaDetalhe(
							id: orcamentoFluxoCaixaDetalheModel.id,
							idOrcamentoFluxoCaixa: orcamentoFluxoCaixaDetalheModel.idOrcamentoFluxoCaixa,
							idFinNaturezaFinanceira: orcamentoFluxoCaixaDetalheModel.idFinNaturezaFinanceira,
							periodo: orcamentoFluxoCaixaDetalheModel.periodo,
							valorOrcado: orcamentoFluxoCaixaDetalheModel.valorOrcado,
							valorRealizado: orcamentoFluxoCaixaDetalheModel.valorRealizado,
							taxaVariacao: orcamentoFluxoCaixaDetalheModel.taxaVariacao,
							valorVariacao: orcamentoFluxoCaixaDetalheModel.valorVariacao,
						),
					),
				);
			}
			return orcamentoFluxoCaixaDetalheGroupedList;
		}
		return [];
	}

		
}
