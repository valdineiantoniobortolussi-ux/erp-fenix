import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaPppDriftProvider extends ProviderBase {

	Future<List<FolhaPppModel>?> getList({Filter? filter}) async {
		List<FolhaPppGrouped> folhaPppDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaPppDriftList = await Session.database.folhaPppDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaPppDriftList = await Session.database.folhaPppDao.getGroupedList(); 
			}
			if (folhaPppDriftList.isNotEmpty) {
				return toListModel(folhaPppDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaPppModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaPppDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaPppModel?>? insert(FolhaPppModel folhaPppModel) async {
		try {
			final lastPk = await Session.database.folhaPppDao.insertObject(toDrift(folhaPppModel));
			folhaPppModel.id = lastPk;
			return folhaPppModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaPppModel?>? update(FolhaPppModel folhaPppModel) async {
		try {
			await Session.database.folhaPppDao.updateObject(toDrift(folhaPppModel));
			return folhaPppModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaPppDao.deleteObject(toDrift(FolhaPppModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaPppModel> toListModel(List<FolhaPppGrouped> folhaPppDriftList) {
		List<FolhaPppModel> listModel = [];
		for (var folhaPppDrift in folhaPppDriftList) {
			listModel.add(toModel(folhaPppDrift)!);
		}
		return listModel;
	}	

	FolhaPppModel? toModel(FolhaPppGrouped? folhaPppDrift) {
		if (folhaPppDrift != null) {
			return FolhaPppModel(
				id: folhaPppDrift.folhaPpp?.id,
				idColaborador: folhaPppDrift.folhaPpp?.idColaborador,
				observacao: folhaPppDrift.folhaPpp?.observacao,
				folhaPppCatModelList: folhaPppCatDriftToModel(folhaPppDrift.folhaPppCatGroupedList),
				folhaPppAtividadeModelList: folhaPppAtividadeDriftToModel(folhaPppDrift.folhaPppAtividadeGroupedList),
				folhaPppFatorRiscoModelList: folhaPppFatorRiscoDriftToModel(folhaPppDrift.folhaPppFatorRiscoGroupedList),
				folhaPppExameMedicoModelList: folhaPppExameMedicoDriftToModel(folhaPppDrift.folhaPppExameMedicoGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaPppDrift.viewPessoaColaborador?.id,
					nome: folhaPppDrift.viewPessoaColaborador?.nome,
					tipo: folhaPppDrift.viewPessoaColaborador?.tipo,
					email: folhaPppDrift.viewPessoaColaborador?.email,
					site: folhaPppDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaPppDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaPppDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaPppDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaPppDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaPppDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaPppDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaPppDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaPppDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaPppDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaPppDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaPppDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaPppDrift.viewPessoaColaborador?.logradouro,
					numero: folhaPppDrift.viewPessoaColaborador?.numero,
					complemento: folhaPppDrift.viewPessoaColaborador?.complemento,
					bairro: folhaPppDrift.viewPessoaColaborador?.bairro,
					cidade: folhaPppDrift.viewPessoaColaborador?.cidade,
					cep: folhaPppDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaPppDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaPppDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaPppDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaPppDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaPppDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<FolhaPppCatModel> folhaPppCatDriftToModel(List<FolhaPppCatGrouped>? folhaPppCatDriftList) { 
		List<FolhaPppCatModel> folhaPppCatModelList = [];
		if (folhaPppCatDriftList != null) {
			for (var folhaPppCatGrouped in folhaPppCatDriftList) {
				folhaPppCatModelList.add(
					FolhaPppCatModel(
						id: folhaPppCatGrouped.folhaPppCat?.id,
						idFolhaPpp: folhaPppCatGrouped.folhaPppCat?.idFolhaPpp,
						numeroCat: folhaPppCatGrouped.folhaPppCat?.numeroCat,
						dataAfastamento: folhaPppCatGrouped.folhaPppCat?.dataAfastamento,
						dataRegistro: folhaPppCatGrouped.folhaPppCat?.dataRegistro,
					)
				);
			}
			return folhaPppCatModelList;
		}
		return [];
	}

	List<FolhaPppAtividadeModel> folhaPppAtividadeDriftToModel(List<FolhaPppAtividadeGrouped>? folhaPppAtividadeDriftList) { 
		List<FolhaPppAtividadeModel> folhaPppAtividadeModelList = [];
		if (folhaPppAtividadeDriftList != null) {
			for (var folhaPppAtividadeGrouped in folhaPppAtividadeDriftList) {
				folhaPppAtividadeModelList.add(
					FolhaPppAtividadeModel(
						id: folhaPppAtividadeGrouped.folhaPppAtividade?.id,
						idFolhaPpp: folhaPppAtividadeGrouped.folhaPppAtividade?.idFolhaPpp,
						dataInicio: folhaPppAtividadeGrouped.folhaPppAtividade?.dataInicio,
						dataFim: folhaPppAtividadeGrouped.folhaPppAtividade?.dataFim,
						descricao: folhaPppAtividadeGrouped.folhaPppAtividade?.descricao,
					)
				);
			}
			return folhaPppAtividadeModelList;
		}
		return [];
	}

	List<FolhaPppFatorRiscoModel> folhaPppFatorRiscoDriftToModel(List<FolhaPppFatorRiscoGrouped>? folhaPppFatorRiscoDriftList) { 
		List<FolhaPppFatorRiscoModel> folhaPppFatorRiscoModelList = [];
		if (folhaPppFatorRiscoDriftList != null) {
			for (var folhaPppFatorRiscoGrouped in folhaPppFatorRiscoDriftList) {
				folhaPppFatorRiscoModelList.add(
					FolhaPppFatorRiscoModel(
						id: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.id,
						idFolhaPpp: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.idFolhaPpp,
						dataInicio: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.dataInicio,
						dataFim: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.dataFim,
						tipo: FolhaPppFatorRiscoDomain.getTipo(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.tipo),
						fatorRisco: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.fatorRisco,
						intensidade: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.intensidade,
						tecnicaUtilizada: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.tecnicaUtilizada,
						epcEficaz: FolhaPppFatorRiscoDomain.getEpcEficaz(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.epcEficaz),
						epiEficaz: FolhaPppFatorRiscoDomain.getEpiEficaz(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.epiEficaz),
						caEpi: folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.caEpi,
						atendimentoNr061: FolhaPppFatorRiscoDomain.getAtendimentoNr061(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.atendimentoNr061),
						atendimentoNr062: FolhaPppFatorRiscoDomain.getAtendimentoNr062(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.atendimentoNr062),
						atendimentoNr063: FolhaPppFatorRiscoDomain.getAtendimentoNr063(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.atendimentoNr063),
						atendimentoNr064: FolhaPppFatorRiscoDomain.getAtendimentoNr064(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.atendimentoNr064),
						atendimentoNr065: FolhaPppFatorRiscoDomain.getAtendimentoNr065(folhaPppFatorRiscoGrouped.folhaPppFatorRisco?.atendimentoNr065),
					)
				);
			}
			return folhaPppFatorRiscoModelList;
		}
		return [];
	}

	List<FolhaPppExameMedicoModel> folhaPppExameMedicoDriftToModel(List<FolhaPppExameMedicoGrouped>? folhaPppExameMedicoDriftList) { 
		List<FolhaPppExameMedicoModel> folhaPppExameMedicoModelList = [];
		if (folhaPppExameMedicoDriftList != null) {
			for (var folhaPppExameMedicoGrouped in folhaPppExameMedicoDriftList) {
				folhaPppExameMedicoModelList.add(
					FolhaPppExameMedicoModel(
						id: folhaPppExameMedicoGrouped.folhaPppExameMedico?.id,
						idFolhaPpp: folhaPppExameMedicoGrouped.folhaPppExameMedico?.idFolhaPpp,
						dataUltimo: folhaPppExameMedicoGrouped.folhaPppExameMedico?.dataUltimo,
						tipo: FolhaPppExameMedicoDomain.getTipo(folhaPppExameMedicoGrouped.folhaPppExameMedico?.tipo),
						exame: FolhaPppExameMedicoDomain.getExame(folhaPppExameMedicoGrouped.folhaPppExameMedico?.exame),
						natureza: folhaPppExameMedicoGrouped.folhaPppExameMedico?.natureza,
						indicacaoResultados: folhaPppExameMedicoGrouped.folhaPppExameMedico?.indicacaoResultados,
					)
				);
			}
			return folhaPppExameMedicoModelList;
		}
		return [];
	}


	FolhaPppGrouped toDrift(FolhaPppModel folhaPppModel) {
		return FolhaPppGrouped(
			folhaPpp: FolhaPpp(
				id: folhaPppModel.id,
				idColaborador: folhaPppModel.idColaborador,
				observacao: folhaPppModel.observacao,
			),
			folhaPppCatGroupedList: folhaPppCatModelToDrift(folhaPppModel.folhaPppCatModelList),
			folhaPppAtividadeGroupedList: folhaPppAtividadeModelToDrift(folhaPppModel.folhaPppAtividadeModelList),
			folhaPppFatorRiscoGroupedList: folhaPppFatorRiscoModelToDrift(folhaPppModel.folhaPppFatorRiscoModelList),
			folhaPppExameMedicoGroupedList: folhaPppExameMedicoModelToDrift(folhaPppModel.folhaPppExameMedicoModelList),
		);
	}

	List<FolhaPppCatGrouped> folhaPppCatModelToDrift(List<FolhaPppCatModel>? folhaPppCatModelList) { 
		List<FolhaPppCatGrouped> folhaPppCatGroupedList = [];
		if (folhaPppCatModelList != null) {
			for (var folhaPppCatModel in folhaPppCatModelList) {
				folhaPppCatGroupedList.add(
					FolhaPppCatGrouped(
						folhaPppCat: FolhaPppCat(
							id: folhaPppCatModel.id,
							idFolhaPpp: folhaPppCatModel.idFolhaPpp,
							numeroCat: folhaPppCatModel.numeroCat,
							dataAfastamento: folhaPppCatModel.dataAfastamento,
							dataRegistro: folhaPppCatModel.dataRegistro,
						),
					),
				);
			}
			return folhaPppCatGroupedList;
		}
		return [];
	}

	List<FolhaPppAtividadeGrouped> folhaPppAtividadeModelToDrift(List<FolhaPppAtividadeModel>? folhaPppAtividadeModelList) { 
		List<FolhaPppAtividadeGrouped> folhaPppAtividadeGroupedList = [];
		if (folhaPppAtividadeModelList != null) {
			for (var folhaPppAtividadeModel in folhaPppAtividadeModelList) {
				folhaPppAtividadeGroupedList.add(
					FolhaPppAtividadeGrouped(
						folhaPppAtividade: FolhaPppAtividade(
							id: folhaPppAtividadeModel.id,
							idFolhaPpp: folhaPppAtividadeModel.idFolhaPpp,
							dataInicio: folhaPppAtividadeModel.dataInicio,
							dataFim: folhaPppAtividadeModel.dataFim,
							descricao: folhaPppAtividadeModel.descricao,
						),
					),
				);
			}
			return folhaPppAtividadeGroupedList;
		}
		return [];
	}

	List<FolhaPppFatorRiscoGrouped> folhaPppFatorRiscoModelToDrift(List<FolhaPppFatorRiscoModel>? folhaPppFatorRiscoModelList) { 
		List<FolhaPppFatorRiscoGrouped> folhaPppFatorRiscoGroupedList = [];
		if (folhaPppFatorRiscoModelList != null) {
			for (var folhaPppFatorRiscoModel in folhaPppFatorRiscoModelList) {
				folhaPppFatorRiscoGroupedList.add(
					FolhaPppFatorRiscoGrouped(
						folhaPppFatorRisco: FolhaPppFatorRisco(
							id: folhaPppFatorRiscoModel.id,
							idFolhaPpp: folhaPppFatorRiscoModel.idFolhaPpp,
							dataInicio: folhaPppFatorRiscoModel.dataInicio,
							dataFim: folhaPppFatorRiscoModel.dataFim,
							tipo: FolhaPppFatorRiscoDomain.setTipo(folhaPppFatorRiscoModel.tipo),
							fatorRisco: folhaPppFatorRiscoModel.fatorRisco,
							intensidade: folhaPppFatorRiscoModel.intensidade,
							tecnicaUtilizada: folhaPppFatorRiscoModel.tecnicaUtilizada,
							epcEficaz: FolhaPppFatorRiscoDomain.setEpcEficaz(folhaPppFatorRiscoModel.epcEficaz),
							epiEficaz: FolhaPppFatorRiscoDomain.setEpiEficaz(folhaPppFatorRiscoModel.epiEficaz),
							caEpi: folhaPppFatorRiscoModel.caEpi,
							atendimentoNr061: FolhaPppFatorRiscoDomain.setAtendimentoNr061(folhaPppFatorRiscoModel.atendimentoNr061),
							atendimentoNr062: FolhaPppFatorRiscoDomain.setAtendimentoNr062(folhaPppFatorRiscoModel.atendimentoNr062),
							atendimentoNr063: FolhaPppFatorRiscoDomain.setAtendimentoNr063(folhaPppFatorRiscoModel.atendimentoNr063),
							atendimentoNr064: FolhaPppFatorRiscoDomain.setAtendimentoNr064(folhaPppFatorRiscoModel.atendimentoNr064),
							atendimentoNr065: FolhaPppFatorRiscoDomain.setAtendimentoNr065(folhaPppFatorRiscoModel.atendimentoNr065),
						),
					),
				);
			}
			return folhaPppFatorRiscoGroupedList;
		}
		return [];
	}

	List<FolhaPppExameMedicoGrouped> folhaPppExameMedicoModelToDrift(List<FolhaPppExameMedicoModel>? folhaPppExameMedicoModelList) { 
		List<FolhaPppExameMedicoGrouped> folhaPppExameMedicoGroupedList = [];
		if (folhaPppExameMedicoModelList != null) {
			for (var folhaPppExameMedicoModel in folhaPppExameMedicoModelList) {
				folhaPppExameMedicoGroupedList.add(
					FolhaPppExameMedicoGrouped(
						folhaPppExameMedico: FolhaPppExameMedico(
							id: folhaPppExameMedicoModel.id,
							idFolhaPpp: folhaPppExameMedicoModel.idFolhaPpp,
							dataUltimo: folhaPppExameMedicoModel.dataUltimo,
							tipo: FolhaPppExameMedicoDomain.setTipo(folhaPppExameMedicoModel.tipo),
							exame: FolhaPppExameMedicoDomain.setExame(folhaPppExameMedicoModel.exame),
							natureza: folhaPppExameMedicoModel.natureza,
							indicacaoResultados: folhaPppExameMedicoModel.indicacaoResultados,
						),
					),
				);
			}
			return folhaPppExameMedicoGroupedList;
		}
		return [];
	}

		
}
