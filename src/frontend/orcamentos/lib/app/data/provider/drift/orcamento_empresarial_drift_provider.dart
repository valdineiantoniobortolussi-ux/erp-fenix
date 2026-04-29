import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';
import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/provider/provider_base.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';

class OrcamentoEmpresarialDriftProvider extends ProviderBase {

	Future<List<OrcamentoEmpresarialModel>?> getList({Filter? filter}) async {
		List<OrcamentoEmpresarialGrouped> orcamentoEmpresarialDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				orcamentoEmpresarialDriftList = await Session.database.orcamentoEmpresarialDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				orcamentoEmpresarialDriftList = await Session.database.orcamentoEmpresarialDao.getGroupedList(); 
			}
			if (orcamentoEmpresarialDriftList.isNotEmpty) {
				return toListModel(orcamentoEmpresarialDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<OrcamentoEmpresarialModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.orcamentoEmpresarialDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoEmpresarialModel?>? insert(OrcamentoEmpresarialModel orcamentoEmpresarialModel) async {
		try {
			final lastPk = await Session.database.orcamentoEmpresarialDao.insertObject(toDrift(orcamentoEmpresarialModel));
			orcamentoEmpresarialModel.id = lastPk;
			return orcamentoEmpresarialModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<OrcamentoEmpresarialModel?>? update(OrcamentoEmpresarialModel orcamentoEmpresarialModel) async {
		try {
			await Session.database.orcamentoEmpresarialDao.updateObject(toDrift(orcamentoEmpresarialModel));
			return orcamentoEmpresarialModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.orcamentoEmpresarialDao.deleteObject(toDrift(OrcamentoEmpresarialModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<OrcamentoEmpresarialModel> toListModel(List<OrcamentoEmpresarialGrouped> orcamentoEmpresarialDriftList) {
		List<OrcamentoEmpresarialModel> listModel = [];
		for (var orcamentoEmpresarialDrift in orcamentoEmpresarialDriftList) {
			listModel.add(toModel(orcamentoEmpresarialDrift)!);
		}
		return listModel;
	}	

	OrcamentoEmpresarialModel? toModel(OrcamentoEmpresarialGrouped? orcamentoEmpresarialDrift) {
		if (orcamentoEmpresarialDrift != null) {
			return OrcamentoEmpresarialModel(
				id: orcamentoEmpresarialDrift.orcamentoEmpresarial?.id,
				idOrcamentoPeriodo: orcamentoEmpresarialDrift.orcamentoEmpresarial?.idOrcamentoPeriodo,
				nome: orcamentoEmpresarialDrift.orcamentoEmpresarial?.nome,
				dataInicial: orcamentoEmpresarialDrift.orcamentoEmpresarial?.dataInicial,
				numeroPeriodos: orcamentoEmpresarialDrift.orcamentoEmpresarial?.numeroPeriodos,
				dataBase: orcamentoEmpresarialDrift.orcamentoEmpresarial?.dataBase,
				descricao: orcamentoEmpresarialDrift.orcamentoEmpresarial?.descricao,
				orcamentoDetalheModelList: orcamentoDetalheDriftToModel(orcamentoEmpresarialDrift.orcamentoDetalheGroupedList),
				orcamentoPeriodoModel: OrcamentoPeriodoModel(
					id: orcamentoEmpresarialDrift.orcamentoPeriodo?.id,
					periodo: orcamentoEmpresarialDrift.orcamentoPeriodo?.periodo,
					nome: orcamentoEmpresarialDrift.orcamentoPeriodo?.nome,
				),
			);
		} else {
			return null;
		}
	}

	List<OrcamentoDetalheModel> orcamentoDetalheDriftToModel(List<OrcamentoDetalheGrouped>? orcamentoDetalheDriftList) { 
		List<OrcamentoDetalheModel> orcamentoDetalheModelList = [];
		if (orcamentoDetalheDriftList != null) {
			for (var orcamentoDetalheGrouped in orcamentoDetalheDriftList) {
				orcamentoDetalheModelList.add(
					OrcamentoDetalheModel(
						id: orcamentoDetalheGrouped.orcamentoDetalhe?.id,
						idOrcamentoEmpresarial: orcamentoDetalheGrouped.orcamentoDetalhe?.idOrcamentoEmpresarial,
						idFinNaturezaFinanceira: orcamentoDetalheGrouped.orcamentoDetalhe?.idFinNaturezaFinanceira,
						finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
							id: orcamentoDetalheGrouped.finNaturezaFinanceira?.id,
							codigo: orcamentoDetalheGrouped.finNaturezaFinanceira?.codigo,
							descricao: orcamentoDetalheGrouped.finNaturezaFinanceira?.descricao,
							tipo: orcamentoDetalheGrouped.finNaturezaFinanceira?.tipo,
							aplicacao: orcamentoDetalheGrouped.finNaturezaFinanceira?.aplicacao,
						),
						periodo: orcamentoDetalheGrouped.orcamentoDetalhe?.periodo,
						valorOrcado: orcamentoDetalheGrouped.orcamentoDetalhe?.valorOrcado,
						valorRealizado: orcamentoDetalheGrouped.orcamentoDetalhe?.valorRealizado,
						taxaVariacao: orcamentoDetalheGrouped.orcamentoDetalhe?.taxaVariacao,
						valorVariacao: orcamentoDetalheGrouped.orcamentoDetalhe?.valorVariacao,
					)
				);
			}
			return orcamentoDetalheModelList;
		}
		return [];
	}


	OrcamentoEmpresarialGrouped toDrift(OrcamentoEmpresarialModel orcamentoEmpresarialModel) {
		return OrcamentoEmpresarialGrouped(
			orcamentoEmpresarial: OrcamentoEmpresarial(
				id: orcamentoEmpresarialModel.id,
				idOrcamentoPeriodo: orcamentoEmpresarialModel.idOrcamentoPeriodo,
				nome: orcamentoEmpresarialModel.nome,
				dataInicial: orcamentoEmpresarialModel.dataInicial,
				numeroPeriodos: orcamentoEmpresarialModel.numeroPeriodos,
				dataBase: orcamentoEmpresarialModel.dataBase,
				descricao: orcamentoEmpresarialModel.descricao,
			),
			orcamentoDetalheGroupedList: orcamentoDetalheModelToDrift(orcamentoEmpresarialModel.orcamentoDetalheModelList),
		);
	}

	List<OrcamentoDetalheGrouped> orcamentoDetalheModelToDrift(List<OrcamentoDetalheModel>? orcamentoDetalheModelList) { 
		List<OrcamentoDetalheGrouped> orcamentoDetalheGroupedList = [];
		if (orcamentoDetalheModelList != null) {
			for (var orcamentoDetalheModel in orcamentoDetalheModelList) {
				orcamentoDetalheGroupedList.add(
					OrcamentoDetalheGrouped(
						orcamentoDetalhe: OrcamentoDetalhe(
							id: orcamentoDetalheModel.id,
							idOrcamentoEmpresarial: orcamentoDetalheModel.idOrcamentoEmpresarial,
							idFinNaturezaFinanceira: orcamentoDetalheModel.idFinNaturezaFinanceira,
							periodo: orcamentoDetalheModel.periodo,
							valorOrcado: orcamentoDetalheModel.valorOrcado,
							valorRealizado: orcamentoDetalheModel.valorRealizado,
							taxaVariacao: orcamentoDetalheModel.taxaVariacao,
							valorVariacao: orcamentoDetalheModel.valorVariacao,
						),
					),
				);
			}
			return orcamentoDetalheGroupedList;
		}
		return [];
	}

		
}
