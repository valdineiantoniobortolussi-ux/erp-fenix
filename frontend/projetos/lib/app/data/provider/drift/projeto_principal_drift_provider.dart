import 'package:projetos/app/data/provider/drift/database/database_imports.dart';
import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/data/provider/provider_base.dart';
import 'package:projetos/app/data/provider/drift/database/database.dart';
import 'package:projetos/app/data/model/model_imports.dart';

class ProjetoPrincipalDriftProvider extends ProviderBase {

	Future<List<ProjetoPrincipalModel>?> getList({Filter? filter}) async {
		List<ProjetoPrincipalGrouped> projetoPrincipalDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				projetoPrincipalDriftList = await Session.database.projetoPrincipalDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				projetoPrincipalDriftList = await Session.database.projetoPrincipalDao.getGroupedList(); 
			}
			if (projetoPrincipalDriftList.isNotEmpty) {
				return toListModel(projetoPrincipalDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ProjetoPrincipalModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.projetoPrincipalDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProjetoPrincipalModel?>? insert(ProjetoPrincipalModel projetoPrincipalModel) async {
		try {
			final lastPk = await Session.database.projetoPrincipalDao.insertObject(toDrift(projetoPrincipalModel));
			projetoPrincipalModel.id = lastPk;
			return projetoPrincipalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ProjetoPrincipalModel?>? update(ProjetoPrincipalModel projetoPrincipalModel) async {
		try {
			await Session.database.projetoPrincipalDao.updateObject(toDrift(projetoPrincipalModel));
			return projetoPrincipalModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.projetoPrincipalDao.deleteObject(toDrift(ProjetoPrincipalModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ProjetoPrincipalModel> toListModel(List<ProjetoPrincipalGrouped> projetoPrincipalDriftList) {
		List<ProjetoPrincipalModel> listModel = [];
		for (var projetoPrincipalDrift in projetoPrincipalDriftList) {
			listModel.add(toModel(projetoPrincipalDrift)!);
		}
		return listModel;
	}	

	ProjetoPrincipalModel? toModel(ProjetoPrincipalGrouped? projetoPrincipalDrift) {
		if (projetoPrincipalDrift != null) {
			return ProjetoPrincipalModel(
				id: projetoPrincipalDrift.projetoPrincipal?.id,
				nome: projetoPrincipalDrift.projetoPrincipal?.nome,
				dataInicio: projetoPrincipalDrift.projetoPrincipal?.dataInicio,
				dataPrevisaoFim: projetoPrincipalDrift.projetoPrincipal?.dataPrevisaoFim,
				dataFim: projetoPrincipalDrift.projetoPrincipal?.dataFim,
				valorOrcamento: projetoPrincipalDrift.projetoPrincipal?.valorOrcamento,
				linkQuadroKanban: projetoPrincipalDrift.projetoPrincipal?.linkQuadroKanban,
				observacao: projetoPrincipalDrift.projetoPrincipal?.observacao,
				projetoCronogramaModelList: projetoCronogramaDriftToModel(projetoPrincipalDrift.projetoCronogramaGroupedList),
				projetoRiscoModelList: projetoRiscoDriftToModel(projetoPrincipalDrift.projetoRiscoGroupedList),
				projetoCustoModelList: projetoCustoDriftToModel(projetoPrincipalDrift.projetoCustoGroupedList),
				projetoStakeholdersModelList: projetoStakeholdersDriftToModel(projetoPrincipalDrift.projetoStakeholdersGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ProjetoCronogramaModel> projetoCronogramaDriftToModel(List<ProjetoCronogramaGrouped>? projetoCronogramaDriftList) { 
		List<ProjetoCronogramaModel> projetoCronogramaModelList = [];
		if (projetoCronogramaDriftList != null) {
			for (var projetoCronogramaGrouped in projetoCronogramaDriftList) {
				projetoCronogramaModelList.add(
					ProjetoCronogramaModel(
						id: projetoCronogramaGrouped.projetoCronograma?.id,
						idProjetoPrincipal: projetoCronogramaGrouped.projetoCronograma?.idProjetoPrincipal,
						tarefa: projetoCronogramaGrouped.projetoCronograma?.tarefa,
						dataTarefa: projetoCronogramaGrouped.projetoCronograma?.dataTarefa,
						descricao: projetoCronogramaGrouped.projetoCronograma?.descricao,
					)
				);
			}
			return projetoCronogramaModelList;
		}
		return [];
	}

	List<ProjetoRiscoModel> projetoRiscoDriftToModel(List<ProjetoRiscoGrouped>? projetoRiscoDriftList) { 
		List<ProjetoRiscoModel> projetoRiscoModelList = [];
		if (projetoRiscoDriftList != null) {
			for (var projetoRiscoGrouped in projetoRiscoDriftList) {
				projetoRiscoModelList.add(
					ProjetoRiscoModel(
						id: projetoRiscoGrouped.projetoRisco?.id,
						idProjetoPrincipal: projetoRiscoGrouped.projetoRisco?.idProjetoPrincipal,
						nome: projetoRiscoGrouped.projetoRisco?.nome,
						probabilidade: projetoRiscoGrouped.projetoRisco?.probabilidade,
						impacto: projetoRiscoGrouped.projetoRisco?.impacto,
						descricao: projetoRiscoGrouped.projetoRisco?.descricao,
					)
				);
			}
			return projetoRiscoModelList;
		}
		return [];
	}

	List<ProjetoCustoModel> projetoCustoDriftToModel(List<ProjetoCustoGrouped>? projetoCustoDriftList) { 
		List<ProjetoCustoModel> projetoCustoModelList = [];
		if (projetoCustoDriftList != null) {
			for (var projetoCustoGrouped in projetoCustoDriftList) {
				projetoCustoModelList.add(
					ProjetoCustoModel(
						id: projetoCustoGrouped.projetoCusto?.id,
						idProjetoPrincipal: projetoCustoGrouped.projetoCusto?.idProjetoPrincipal,
						idFinNaturezaFinanceira: projetoCustoGrouped.projetoCusto?.idFinNaturezaFinanceira,
						finNaturezaFinanceiraModel: FinNaturezaFinanceiraModel(
							id: projetoCustoGrouped.finNaturezaFinanceira?.id,
							codigo: projetoCustoGrouped.finNaturezaFinanceira?.codigo,
							descricao: projetoCustoGrouped.finNaturezaFinanceira?.descricao,
							tipo: projetoCustoGrouped.finNaturezaFinanceira?.tipo,
							aplicacao: projetoCustoGrouped.finNaturezaFinanceira?.aplicacao,
						),
						nome: projetoCustoGrouped.projetoCusto?.nome,
						valorMensal: projetoCustoGrouped.projetoCusto?.valorMensal,
						valorTotal: projetoCustoGrouped.projetoCusto?.valorTotal,
						justificativa: projetoCustoGrouped.projetoCusto?.justificativa,
					)
				);
			}
			return projetoCustoModelList;
		}
		return [];
	}

	List<ProjetoStakeholdersModel> projetoStakeholdersDriftToModel(List<ProjetoStakeholdersGrouped>? projetoStakeholdersDriftList) { 
		List<ProjetoStakeholdersModel> projetoStakeholdersModelList = [];
		if (projetoStakeholdersDriftList != null) {
			for (var projetoStakeholdersGrouped in projetoStakeholdersDriftList) {
				projetoStakeholdersModelList.add(
					ProjetoStakeholdersModel(
						id: projetoStakeholdersGrouped.projetoStakeholders?.id,
						idProjetoPrincipal: projetoStakeholdersGrouped.projetoStakeholders?.idProjetoPrincipal,
						idColaborador: projetoStakeholdersGrouped.projetoStakeholders?.idColaborador,
						viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
							id: projetoStakeholdersGrouped.viewPessoaColaborador?.id,
							nome: projetoStakeholdersGrouped.viewPessoaColaborador?.nome,
							tipo: projetoStakeholdersGrouped.viewPessoaColaborador?.tipo,
							email: projetoStakeholdersGrouped.viewPessoaColaborador?.email,
							site: projetoStakeholdersGrouped.viewPessoaColaborador?.site,
							cpfCnpj: projetoStakeholdersGrouped.viewPessoaColaborador?.cpfCnpj,
							rgIe: projetoStakeholdersGrouped.viewPessoaColaborador?.rgIe,
							matricula: projetoStakeholdersGrouped.viewPessoaColaborador?.matricula,
							dataCadastro: projetoStakeholdersGrouped.viewPessoaColaborador?.dataCadastro,
							dataAdmissao: projetoStakeholdersGrouped.viewPessoaColaborador?.dataAdmissao,
							dataDemissao: projetoStakeholdersGrouped.viewPessoaColaborador?.dataDemissao,
							ctpsNumero: projetoStakeholdersGrouped.viewPessoaColaborador?.ctpsNumero,
							ctpsSerie: projetoStakeholdersGrouped.viewPessoaColaborador?.ctpsSerie,
							ctpsDataExpedicao: projetoStakeholdersGrouped.viewPessoaColaborador?.ctpsDataExpedicao,
							ctpsUf: projetoStakeholdersGrouped.viewPessoaColaborador?.ctpsUf,
							observacao: projetoStakeholdersGrouped.viewPessoaColaborador?.observacao,
							logradouro: projetoStakeholdersGrouped.viewPessoaColaborador?.logradouro,
							numero: projetoStakeholdersGrouped.viewPessoaColaborador?.numero,
							complemento: projetoStakeholdersGrouped.viewPessoaColaborador?.complemento,
							bairro: projetoStakeholdersGrouped.viewPessoaColaborador?.bairro,
							cidade: projetoStakeholdersGrouped.viewPessoaColaborador?.cidade,
							cep: projetoStakeholdersGrouped.viewPessoaColaborador?.cep,
							municipioIbge: projetoStakeholdersGrouped.viewPessoaColaborador?.municipioIbge,
							uf: projetoStakeholdersGrouped.viewPessoaColaborador?.uf,
							idPessoa: projetoStakeholdersGrouped.viewPessoaColaborador?.idPessoa,
							idCargo: projetoStakeholdersGrouped.viewPessoaColaborador?.idCargo,
							idSetor: projetoStakeholdersGrouped.viewPessoaColaborador?.idSetor,
						),
					)
				);
			}
			return projetoStakeholdersModelList;
		}
		return [];
	}


	ProjetoPrincipalGrouped toDrift(ProjetoPrincipalModel projetoPrincipalModel) {
		return ProjetoPrincipalGrouped(
			projetoPrincipal: ProjetoPrincipal(
				id: projetoPrincipalModel.id,
				nome: projetoPrincipalModel.nome,
				dataInicio: projetoPrincipalModel.dataInicio,
				dataPrevisaoFim: projetoPrincipalModel.dataPrevisaoFim,
				dataFim: projetoPrincipalModel.dataFim,
				valorOrcamento: projetoPrincipalModel.valorOrcamento,
				linkQuadroKanban: projetoPrincipalModel.linkQuadroKanban,
				observacao: projetoPrincipalModel.observacao,
			),
			projetoCronogramaGroupedList: projetoCronogramaModelToDrift(projetoPrincipalModel.projetoCronogramaModelList),
			projetoRiscoGroupedList: projetoRiscoModelToDrift(projetoPrincipalModel.projetoRiscoModelList),
			projetoCustoGroupedList: projetoCustoModelToDrift(projetoPrincipalModel.projetoCustoModelList),
			projetoStakeholdersGroupedList: projetoStakeholdersModelToDrift(projetoPrincipalModel.projetoStakeholdersModelList),
		);
	}

	List<ProjetoCronogramaGrouped> projetoCronogramaModelToDrift(List<ProjetoCronogramaModel>? projetoCronogramaModelList) { 
		List<ProjetoCronogramaGrouped> projetoCronogramaGroupedList = [];
		if (projetoCronogramaModelList != null) {
			for (var projetoCronogramaModel in projetoCronogramaModelList) {
				projetoCronogramaGroupedList.add(
					ProjetoCronogramaGrouped(
						projetoCronograma: ProjetoCronograma(
							id: projetoCronogramaModel.id,
							idProjetoPrincipal: projetoCronogramaModel.idProjetoPrincipal,
							tarefa: projetoCronogramaModel.tarefa,
							dataTarefa: projetoCronogramaModel.dataTarefa,
							descricao: projetoCronogramaModel.descricao,
						),
					),
				);
			}
			return projetoCronogramaGroupedList;
		}
		return [];
	}

	List<ProjetoRiscoGrouped> projetoRiscoModelToDrift(List<ProjetoRiscoModel>? projetoRiscoModelList) { 
		List<ProjetoRiscoGrouped> projetoRiscoGroupedList = [];
		if (projetoRiscoModelList != null) {
			for (var projetoRiscoModel in projetoRiscoModelList) {
				projetoRiscoGroupedList.add(
					ProjetoRiscoGrouped(
						projetoRisco: ProjetoRisco(
							id: projetoRiscoModel.id,
							idProjetoPrincipal: projetoRiscoModel.idProjetoPrincipal,
							nome: projetoRiscoModel.nome,
							probabilidade: projetoRiscoModel.probabilidade,
							impacto: projetoRiscoModel.impacto,
							descricao: projetoRiscoModel.descricao,
						),
					),
				);
			}
			return projetoRiscoGroupedList;
		}
		return [];
	}

	List<ProjetoCustoGrouped> projetoCustoModelToDrift(List<ProjetoCustoModel>? projetoCustoModelList) { 
		List<ProjetoCustoGrouped> projetoCustoGroupedList = [];
		if (projetoCustoModelList != null) {
			for (var projetoCustoModel in projetoCustoModelList) {
				projetoCustoGroupedList.add(
					ProjetoCustoGrouped(
						projetoCusto: ProjetoCusto(
							id: projetoCustoModel.id,
							idProjetoPrincipal: projetoCustoModel.idProjetoPrincipal,
							idFinNaturezaFinanceira: projetoCustoModel.idFinNaturezaFinanceira,
							nome: projetoCustoModel.nome,
							valorMensal: projetoCustoModel.valorMensal,
							valorTotal: projetoCustoModel.valorTotal,
							justificativa: projetoCustoModel.justificativa,
						),
					),
				);
			}
			return projetoCustoGroupedList;
		}
		return [];
	}

	List<ProjetoStakeholdersGrouped> projetoStakeholdersModelToDrift(List<ProjetoStakeholdersModel>? projetoStakeholdersModelList) { 
		List<ProjetoStakeholdersGrouped> projetoStakeholdersGroupedList = [];
		if (projetoStakeholdersModelList != null) {
			for (var projetoStakeholdersModel in projetoStakeholdersModelList) {
				projetoStakeholdersGroupedList.add(
					ProjetoStakeholdersGrouped(
						projetoStakeholders: ProjetoStakeholders(
							id: projetoStakeholdersModel.id,
							idProjetoPrincipal: projetoStakeholdersModel.idProjetoPrincipal,
							idColaborador: projetoStakeholdersModel.idColaborador,
						),
					),
				);
			}
			return projetoStakeholdersGroupedList;
		}
		return [];
	}

		
}
