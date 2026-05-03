import 'package:patrimonio/app/data/provider/drift/database/database_imports.dart';
import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/provider/provider_base.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimBemDriftProvider extends ProviderBase {

	Future<List<PatrimBemModel>?> getList({Filter? filter}) async {
		List<PatrimBemGrouped> patrimBemDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				patrimBemDriftList = await Session.database.patrimBemDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				patrimBemDriftList = await Session.database.patrimBemDao.getGroupedList(); 
			}
			if (patrimBemDriftList.isNotEmpty) {
				return toListModel(patrimBemDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PatrimBemModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.patrimBemDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimBemModel?>? insert(PatrimBemModel patrimBemModel) async {
		try {
			final lastPk = await Session.database.patrimBemDao.insertObject(toDrift(patrimBemModel));
			patrimBemModel.id = lastPk;
			return patrimBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PatrimBemModel?>? update(PatrimBemModel patrimBemModel) async {
		try {
			await Session.database.patrimBemDao.updateObject(toDrift(patrimBemModel));
			return patrimBemModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.patrimBemDao.deleteObject(toDrift(PatrimBemModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PatrimBemModel> toListModel(List<PatrimBemGrouped> patrimBemDriftList) {
		List<PatrimBemModel> listModel = [];
		for (var patrimBemDrift in patrimBemDriftList) {
			listModel.add(toModel(patrimBemDrift)!);
		}
		return listModel;
	}	

	PatrimBemModel? toModel(PatrimBemGrouped? patrimBemDrift) {
		if (patrimBemDrift != null) {
			return PatrimBemModel(
				id: patrimBemDrift.patrimBem?.id,
				idCentroResultado: patrimBemDrift.patrimBem?.idCentroResultado,
				idFornecedor: patrimBemDrift.patrimBem?.idFornecedor,
				idColaborador: patrimBemDrift.patrimBem?.idColaborador,
				idPatrimTipoAquisicaoBem: patrimBemDrift.patrimBem?.idPatrimTipoAquisicaoBem,
				idPatrimEstadoConservacao: patrimBemDrift.patrimBem?.idPatrimEstadoConservacao,
				idPatrimGrupoBem: patrimBemDrift.patrimBem?.idPatrimGrupoBem,
				idSetor: patrimBemDrift.patrimBem?.idSetor,
				numeroNb: patrimBemDrift.patrimBem?.numeroNb,
				nome: patrimBemDrift.patrimBem?.nome,
				descricao: patrimBemDrift.patrimBem?.descricao,
				dataAquisicao: patrimBemDrift.patrimBem?.dataAquisicao,
				dataAceite: patrimBemDrift.patrimBem?.dataAceite,
				dataCadastro: patrimBemDrift.patrimBem?.dataCadastro,
				dataContabilizado: patrimBemDrift.patrimBem?.dataContabilizado,
				dataVistoria: patrimBemDrift.patrimBem?.dataVistoria,
				dataMarcacao: patrimBemDrift.patrimBem?.dataMarcacao,
				dataBaixa: patrimBemDrift.patrimBem?.dataBaixa,
				vencimentoGarantia: patrimBemDrift.patrimBem?.vencimentoGarantia,
				numeroNotaFiscal: patrimBemDrift.patrimBem?.numeroNotaFiscal,
				numeroSerie: patrimBemDrift.patrimBem?.numeroSerie,
				chaveNfe: patrimBemDrift.patrimBem?.chaveNfe,
				valorOriginal: patrimBemDrift.patrimBem?.valorOriginal,
				valorCompra: patrimBemDrift.patrimBem?.valorCompra,
				valorAtualizado: patrimBemDrift.patrimBem?.valorAtualizado,
				valorBaixa: patrimBemDrift.patrimBem?.valorBaixa,
				deprecia: PatrimBemDomain.getDeprecia(patrimBemDrift.patrimBem?.deprecia),
				metodoDepreciacao: PatrimBemDomain.getMetodoDepreciacao(patrimBemDrift.patrimBem?.metodoDepreciacao),
				inicioDepreciacao: patrimBemDrift.patrimBem?.inicioDepreciacao,
				ultimaDepreciacao: patrimBemDrift.patrimBem?.ultimaDepreciacao,
				tipoDepreciacao: PatrimBemDomain.getTipoDepreciacao(patrimBemDrift.patrimBem?.tipoDepreciacao),
				taxaAnualDepreciacao: patrimBemDrift.patrimBem?.taxaAnualDepreciacao,
				taxaMensalDepreciacao: patrimBemDrift.patrimBem?.taxaMensalDepreciacao,
				taxaDepreciacaoAcelerada: patrimBemDrift.patrimBem?.taxaDepreciacaoAcelerada,
				taxaDepreciacaoIncentivada: patrimBemDrift.patrimBem?.taxaDepreciacaoIncentivada,
				funcao: patrimBemDrift.patrimBem?.funcao,
				patrimDocumentoBemModelList: patrimDocumentoBemDriftToModel(patrimBemDrift.patrimDocumentoBemGroupedList),
				patrimDepreciacaoBemModelList: patrimDepreciacaoBemDriftToModel(patrimBemDrift.patrimDepreciacaoBemGroupedList),
				patrimMovimentacaoBemModelList: patrimMovimentacaoBemDriftToModel(patrimBemDrift.patrimMovimentacaoBemGroupedList),
				patrimApoliceSeguroModelList: patrimApoliceSeguroDriftToModel(patrimBemDrift.patrimApoliceSeguroGroupedList),
				centroResultadoModel: CentroResultadoModel(
					id: patrimBemDrift.centroResultado?.id,
					idPlanoCentroResultado: patrimBemDrift.centroResultado?.idPlanoCentroResultado,
					classificacao: patrimBemDrift.centroResultado?.classificacao,
					descricao: patrimBemDrift.centroResultado?.descricao,
					sofreRateiro: patrimBemDrift.centroResultado?.sofreRateiro,
				),
				patrimEstadoConservacaoModel: PatrimEstadoConservacaoModel(
					id: patrimBemDrift.patrimEstadoConservacao?.id,
					codigo: patrimBemDrift.patrimEstadoConservacao?.codigo,
					nome: patrimBemDrift.patrimEstadoConservacao?.nome,
					descricao: patrimBemDrift.patrimEstadoConservacao?.descricao,
				),
				setorModel: SetorModel(
					id: patrimBemDrift.setor?.id,
					nome: patrimBemDrift.setor?.nome,
					descricao: patrimBemDrift.setor?.descricao,
				),
				viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
					id: patrimBemDrift.viewPessoaFornecedor?.id,
					nome: patrimBemDrift.viewPessoaFornecedor?.nome,
					tipo: patrimBemDrift.viewPessoaFornecedor?.tipo,
					email: patrimBemDrift.viewPessoaFornecedor?.email,
					site: patrimBemDrift.viewPessoaFornecedor?.site,
					cpfCnpj: patrimBemDrift.viewPessoaFornecedor?.cpfCnpj,
					rgIe: patrimBemDrift.viewPessoaFornecedor?.rgIe,
					desde: patrimBemDrift.viewPessoaFornecedor?.desde,
					dataCadastro: patrimBemDrift.viewPessoaFornecedor?.dataCadastro,
					observacao: patrimBemDrift.viewPessoaFornecedor?.observacao,
					idPessoa: patrimBemDrift.viewPessoaFornecedor?.idPessoa,
				),
				patrimTipoAquisicaoBemModel: PatrimTipoAquisicaoBemModel(
					id: patrimBemDrift.patrimTipoAquisicaoBem?.id,
					tipo: patrimBemDrift.patrimTipoAquisicaoBem?.tipo,
					nome: patrimBemDrift.patrimTipoAquisicaoBem?.nome,
					descricao: patrimBemDrift.patrimTipoAquisicaoBem?.descricao,
				),
				patrimGrupoBemModel: PatrimGrupoBemModel(
					id: patrimBemDrift.patrimGrupoBem?.id,
					codigo: patrimBemDrift.patrimGrupoBem?.codigo,
					nome: patrimBemDrift.patrimGrupoBem?.nome,
					descricao: patrimBemDrift.patrimGrupoBem?.descricao,
					contaAtivoImobilizado: patrimBemDrift.patrimGrupoBem?.contaAtivoImobilizado,
					contaDepreciacaoAcumulada: patrimBemDrift.patrimGrupoBem?.contaDepreciacaoAcumulada,
					contaDespesaDepreciacao: patrimBemDrift.patrimGrupoBem?.contaDespesaDepreciacao,
					codigoHistorico: patrimBemDrift.patrimGrupoBem?.codigoHistorico,
				),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: patrimBemDrift.viewPessoaColaborador?.id,
					nome: patrimBemDrift.viewPessoaColaborador?.nome,
					tipo: patrimBemDrift.viewPessoaColaborador?.tipo,
					email: patrimBemDrift.viewPessoaColaborador?.email,
					site: patrimBemDrift.viewPessoaColaborador?.site,
					cpfCnpj: patrimBemDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: patrimBemDrift.viewPessoaColaborador?.rgIe,
					matricula: patrimBemDrift.viewPessoaColaborador?.matricula,
					dataCadastro: patrimBemDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: patrimBemDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: patrimBemDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: patrimBemDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: patrimBemDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: patrimBemDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: patrimBemDrift.viewPessoaColaborador?.ctpsUf,
					observacao: patrimBemDrift.viewPessoaColaborador?.observacao,
					logradouro: patrimBemDrift.viewPessoaColaborador?.logradouro,
					numero: patrimBemDrift.viewPessoaColaborador?.numero,
					complemento: patrimBemDrift.viewPessoaColaborador?.complemento,
					bairro: patrimBemDrift.viewPessoaColaborador?.bairro,
					cidade: patrimBemDrift.viewPessoaColaborador?.cidade,
					cep: patrimBemDrift.viewPessoaColaborador?.cep,
					municipioIbge: patrimBemDrift.viewPessoaColaborador?.municipioIbge,
					uf: patrimBemDrift.viewPessoaColaborador?.uf,
					idPessoa: patrimBemDrift.viewPessoaColaborador?.idPessoa,
					idCargo: patrimBemDrift.viewPessoaColaborador?.idCargo,
					idSetor: patrimBemDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<PatrimDocumentoBemModel> patrimDocumentoBemDriftToModel(List<PatrimDocumentoBemGrouped>? patrimDocumentoBemDriftList) { 
		List<PatrimDocumentoBemModel> patrimDocumentoBemModelList = [];
		if (patrimDocumentoBemDriftList != null) {
			for (var patrimDocumentoBemGrouped in patrimDocumentoBemDriftList) {
				patrimDocumentoBemModelList.add(
					PatrimDocumentoBemModel(
						id: patrimDocumentoBemGrouped.patrimDocumentoBem?.id,
						idPatrimBem: patrimDocumentoBemGrouped.patrimDocumentoBem?.idPatrimBem,
						nome: patrimDocumentoBemGrouped.patrimDocumentoBem?.nome,
						descricao: patrimDocumentoBemGrouped.patrimDocumentoBem?.descricao,
						imagem: patrimDocumentoBemGrouped.patrimDocumentoBem?.imagem,
					)
				);
			}
			return patrimDocumentoBemModelList;
		}
		return [];
	}

	List<PatrimDepreciacaoBemModel> patrimDepreciacaoBemDriftToModel(List<PatrimDepreciacaoBemGrouped>? patrimDepreciacaoBemDriftList) { 
		List<PatrimDepreciacaoBemModel> patrimDepreciacaoBemModelList = [];
		if (patrimDepreciacaoBemDriftList != null) {
			for (var patrimDepreciacaoBemGrouped in patrimDepreciacaoBemDriftList) {
				patrimDepreciacaoBemModelList.add(
					PatrimDepreciacaoBemModel(
						id: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.id,
						idPatrimBem: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.idPatrimBem,
						dataDepreciacao: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.dataDepreciacao,
						dias: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.dias,
						taxa: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.taxa,
						indice: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.indice,
						valor: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.valor,
						depreciacaoAcumulada: patrimDepreciacaoBemGrouped.patrimDepreciacaoBem?.depreciacaoAcumulada,
					)
				);
			}
			return patrimDepreciacaoBemModelList;
		}
		return [];
	}

	List<PatrimMovimentacaoBemModel> patrimMovimentacaoBemDriftToModel(List<PatrimMovimentacaoBemGrouped>? patrimMovimentacaoBemDriftList) { 
		List<PatrimMovimentacaoBemModel> patrimMovimentacaoBemModelList = [];
		if (patrimMovimentacaoBemDriftList != null) {
			for (var patrimMovimentacaoBemGrouped in patrimMovimentacaoBemDriftList) {
				patrimMovimentacaoBemModelList.add(
					PatrimMovimentacaoBemModel(
						id: patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.id,
						idPatrimBem: patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.idPatrimBem,
						idPatrimTipoMovimentacao: patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.idPatrimTipoMovimentacao,
						patrimTipoMovimentacaoModel: PatrimTipoMovimentacaoModel(
							id: patrimMovimentacaoBemGrouped.patrimTipoMovimentacao?.id,
							tipo: patrimMovimentacaoBemGrouped.patrimTipoMovimentacao?.tipo,
							nome: patrimMovimentacaoBemGrouped.patrimTipoMovimentacao?.nome,
							descricao: patrimMovimentacaoBemGrouped.patrimTipoMovimentacao?.descricao,
						),
						dataMovimentacao: patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.dataMovimentacao,
						responsavel: patrimMovimentacaoBemGrouped.patrimMovimentacaoBem?.responsavel,
					)
				);
			}
			return patrimMovimentacaoBemModelList;
		}
		return [];
	}

	List<PatrimApoliceSeguroModel> patrimApoliceSeguroDriftToModel(List<PatrimApoliceSeguroGrouped>? patrimApoliceSeguroDriftList) { 
		List<PatrimApoliceSeguroModel> patrimApoliceSeguroModelList = [];
		if (patrimApoliceSeguroDriftList != null) {
			for (var patrimApoliceSeguroGrouped in patrimApoliceSeguroDriftList) {
				patrimApoliceSeguroModelList.add(
					PatrimApoliceSeguroModel(
						id: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.id,
						idPatrimBem: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.idPatrimBem,
						idSeguradora: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.idSeguradora,
						seguradoraModel: SeguradoraModel(
							id: patrimApoliceSeguroGrouped.seguradora?.id,
							nome: patrimApoliceSeguroGrouped.seguradora?.nome,
							contato: patrimApoliceSeguroGrouped.seguradora?.contato,
							telefone: patrimApoliceSeguroGrouped.seguradora?.telefone,
						),
						numero: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.numero,
						dataContratacao: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.dataContratacao,
						dataVencimento: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.dataVencimento,
						valorPremio: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.valorPremio,
						valorSegurado: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.valorSegurado,
						observacao: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.observacao,
						imagem: patrimApoliceSeguroGrouped.patrimApoliceSeguro?.imagem,
					)
				);
			}
			return patrimApoliceSeguroModelList;
		}
		return [];
	}


	PatrimBemGrouped toDrift(PatrimBemModel patrimBemModel) {
		return PatrimBemGrouped(
			patrimBem: PatrimBem(
				id: patrimBemModel.id,
				idCentroResultado: patrimBemModel.idCentroResultado,
				idFornecedor: patrimBemModel.idFornecedor,
				idColaborador: patrimBemModel.idColaborador,
				idPatrimTipoAquisicaoBem: patrimBemModel.idPatrimTipoAquisicaoBem,
				idPatrimEstadoConservacao: patrimBemModel.idPatrimEstadoConservacao,
				idPatrimGrupoBem: patrimBemModel.idPatrimGrupoBem,
				idSetor: patrimBemModel.idSetor,
				numeroNb: patrimBemModel.numeroNb,
				nome: patrimBemModel.nome,
				descricao: patrimBemModel.descricao,
				dataAquisicao: patrimBemModel.dataAquisicao,
				dataAceite: patrimBemModel.dataAceite,
				dataCadastro: patrimBemModel.dataCadastro,
				dataContabilizado: patrimBemModel.dataContabilizado,
				dataVistoria: patrimBemModel.dataVistoria,
				dataMarcacao: patrimBemModel.dataMarcacao,
				dataBaixa: patrimBemModel.dataBaixa,
				vencimentoGarantia: patrimBemModel.vencimentoGarantia,
				numeroNotaFiscal: patrimBemModel.numeroNotaFiscal,
				numeroSerie: patrimBemModel.numeroSerie,
				chaveNfe: patrimBemModel.chaveNfe,
				valorOriginal: patrimBemModel.valorOriginal,
				valorCompra: patrimBemModel.valorCompra,
				valorAtualizado: patrimBemModel.valorAtualizado,
				valorBaixa: patrimBemModel.valorBaixa,
				deprecia: PatrimBemDomain.setDeprecia(patrimBemModel.deprecia),
				metodoDepreciacao: PatrimBemDomain.setMetodoDepreciacao(patrimBemModel.metodoDepreciacao),
				inicioDepreciacao: patrimBemModel.inicioDepreciacao,
				ultimaDepreciacao: patrimBemModel.ultimaDepreciacao,
				tipoDepreciacao: PatrimBemDomain.setTipoDepreciacao(patrimBemModel.tipoDepreciacao),
				taxaAnualDepreciacao: patrimBemModel.taxaAnualDepreciacao,
				taxaMensalDepreciacao: patrimBemModel.taxaMensalDepreciacao,
				taxaDepreciacaoAcelerada: patrimBemModel.taxaDepreciacaoAcelerada,
				taxaDepreciacaoIncentivada: patrimBemModel.taxaDepreciacaoIncentivada,
				funcao: patrimBemModel.funcao,
			),
			patrimDocumentoBemGroupedList: patrimDocumentoBemModelToDrift(patrimBemModel.patrimDocumentoBemModelList),
			patrimDepreciacaoBemGroupedList: patrimDepreciacaoBemModelToDrift(patrimBemModel.patrimDepreciacaoBemModelList),
			patrimMovimentacaoBemGroupedList: patrimMovimentacaoBemModelToDrift(patrimBemModel.patrimMovimentacaoBemModelList),
			patrimApoliceSeguroGroupedList: patrimApoliceSeguroModelToDrift(patrimBemModel.patrimApoliceSeguroModelList),
		);
	}

	List<PatrimDocumentoBemGrouped> patrimDocumentoBemModelToDrift(List<PatrimDocumentoBemModel>? patrimDocumentoBemModelList) { 
		List<PatrimDocumentoBemGrouped> patrimDocumentoBemGroupedList = [];
		if (patrimDocumentoBemModelList != null) {
			for (var patrimDocumentoBemModel in patrimDocumentoBemModelList) {
				patrimDocumentoBemGroupedList.add(
					PatrimDocumentoBemGrouped(
						patrimDocumentoBem: PatrimDocumentoBem(
							id: patrimDocumentoBemModel.id,
							idPatrimBem: patrimDocumentoBemModel.idPatrimBem,
							nome: patrimDocumentoBemModel.nome,
							descricao: patrimDocumentoBemModel.descricao,
							imagem: patrimDocumentoBemModel.imagem,
						),
					),
				);
			}
			return patrimDocumentoBemGroupedList;
		}
		return [];
	}

	List<PatrimDepreciacaoBemGrouped> patrimDepreciacaoBemModelToDrift(List<PatrimDepreciacaoBemModel>? patrimDepreciacaoBemModelList) { 
		List<PatrimDepreciacaoBemGrouped> patrimDepreciacaoBemGroupedList = [];
		if (patrimDepreciacaoBemModelList != null) {
			for (var patrimDepreciacaoBemModel in patrimDepreciacaoBemModelList) {
				patrimDepreciacaoBemGroupedList.add(
					PatrimDepreciacaoBemGrouped(
						patrimDepreciacaoBem: PatrimDepreciacaoBem(
							id: patrimDepreciacaoBemModel.id,
							idPatrimBem: patrimDepreciacaoBemModel.idPatrimBem,
							dataDepreciacao: patrimDepreciacaoBemModel.dataDepreciacao,
							dias: patrimDepreciacaoBemModel.dias,
							taxa: patrimDepreciacaoBemModel.taxa,
							indice: patrimDepreciacaoBemModel.indice,
							valor: patrimDepreciacaoBemModel.valor,
							depreciacaoAcumulada: patrimDepreciacaoBemModel.depreciacaoAcumulada,
						),
					),
				);
			}
			return patrimDepreciacaoBemGroupedList;
		}
		return [];
	}

	List<PatrimMovimentacaoBemGrouped> patrimMovimentacaoBemModelToDrift(List<PatrimMovimentacaoBemModel>? patrimMovimentacaoBemModelList) { 
		List<PatrimMovimentacaoBemGrouped> patrimMovimentacaoBemGroupedList = [];
		if (patrimMovimentacaoBemModelList != null) {
			for (var patrimMovimentacaoBemModel in patrimMovimentacaoBemModelList) {
				patrimMovimentacaoBemGroupedList.add(
					PatrimMovimentacaoBemGrouped(
						patrimMovimentacaoBem: PatrimMovimentacaoBem(
							id: patrimMovimentacaoBemModel.id,
							idPatrimBem: patrimMovimentacaoBemModel.idPatrimBem,
							idPatrimTipoMovimentacao: patrimMovimentacaoBemModel.idPatrimTipoMovimentacao,
							dataMovimentacao: patrimMovimentacaoBemModel.dataMovimentacao,
							responsavel: patrimMovimentacaoBemModel.responsavel,
						),
					),
				);
			}
			return patrimMovimentacaoBemGroupedList;
		}
		return [];
	}

	List<PatrimApoliceSeguroGrouped> patrimApoliceSeguroModelToDrift(List<PatrimApoliceSeguroModel>? patrimApoliceSeguroModelList) { 
		List<PatrimApoliceSeguroGrouped> patrimApoliceSeguroGroupedList = [];
		if (patrimApoliceSeguroModelList != null) {
			for (var patrimApoliceSeguroModel in patrimApoliceSeguroModelList) {
				patrimApoliceSeguroGroupedList.add(
					PatrimApoliceSeguroGrouped(
						patrimApoliceSeguro: PatrimApoliceSeguro(
							id: patrimApoliceSeguroModel.id,
							idPatrimBem: patrimApoliceSeguroModel.idPatrimBem,
							idSeguradora: patrimApoliceSeguroModel.idSeguradora,
							numero: patrimApoliceSeguroModel.numero,
							dataContratacao: patrimApoliceSeguroModel.dataContratacao,
							dataVencimento: patrimApoliceSeguroModel.dataVencimento,
							valorPremio: patrimApoliceSeguroModel.valorPremio,
							valorSegurado: patrimApoliceSeguroModel.valorSegurado,
							observacao: patrimApoliceSeguroModel.observacao,
							imagem: patrimApoliceSeguroModel.imagem,
						),
					),
				);
			}
			return patrimApoliceSeguroGroupedList;
		}
		return [];
	}

		
}
