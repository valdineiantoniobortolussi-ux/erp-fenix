import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheDriftProvider extends ProviderBase {

	Future<List<NfeDetalheModel>?> getList({Filter? filter}) async {
		List<NfeDetalheGrouped> nfeDetalheDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeDetalheDriftList = await Session.database.nfeDetalheDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeDetalheDriftList = await Session.database.nfeDetalheDao.getGroupedList(); 
			}
			if (nfeDetalheDriftList.isNotEmpty) {
				return toListModel(nfeDetalheDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeDetalheModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeDetalheDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeDetalheModel?>? insert(NfeDetalheModel nfeDetalheModel) async {
		try {
			final lastPk = await Session.database.nfeDetalheDao.insertObject(toDrift(nfeDetalheModel));
			nfeDetalheModel.id = lastPk;
			return nfeDetalheModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeDetalheModel?>? update(NfeDetalheModel nfeDetalheModel) async {
		try {
			await Session.database.nfeDetalheDao.updateObject(toDrift(nfeDetalheModel));
			return nfeDetalheModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeDetalheDao.deleteObject(toDrift(NfeDetalheModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeDetalheModel> toListModel(List<NfeDetalheGrouped> nfeDetalheDriftList) {
		List<NfeDetalheModel> listModel = [];
		for (var nfeDetalheDrift in nfeDetalheDriftList) {
			listModel.add(toModel(nfeDetalheDrift)!);
		}
		return listModel;
	}	

	NfeDetalheModel? toModel(NfeDetalheGrouped? nfeDetalheDrift) {
		if (nfeDetalheDrift != null) {
			return NfeDetalheModel(
				id: nfeDetalheDrift.nfeDetalhe?.id,
				idNfeCabecalho: nfeDetalheDrift.nfeDetalhe?.idNfeCabecalho,
				idProduto: nfeDetalheDrift.nfeDetalhe?.idProduto,
				numeroItem: nfeDetalheDrift.nfeDetalhe?.numeroItem,
				codigoProduto: nfeDetalheDrift.nfeDetalhe?.codigoProduto,
				gtin: nfeDetalheDrift.nfeDetalhe?.gtin,
				nomeProduto: nfeDetalheDrift.nfeDetalhe?.nomeProduto,
				ncm: nfeDetalheDrift.nfeDetalhe?.ncm,
				nve: nfeDetalheDrift.nfeDetalhe?.nve,
				cest: nfeDetalheDrift.nfeDetalhe?.cest,
				indicadorEscalaRelevante: NfeDetalheDomain.getIndicadorEscalaRelevante(nfeDetalheDrift.nfeDetalhe?.indicadorEscalaRelevante),
				cnpjFabricante: nfeDetalheDrift.nfeDetalhe?.cnpjFabricante,
				codigoBeneficioFiscal: nfeDetalheDrift.nfeDetalhe?.codigoBeneficioFiscal,
				exTipi: nfeDetalheDrift.nfeDetalhe?.exTipi,
				cfop: nfeDetalheDrift.nfeDetalhe?.cfop,
				unidadeComercial: nfeDetalheDrift.nfeDetalhe?.unidadeComercial,
				quantidadeComercial: nfeDetalheDrift.nfeDetalhe?.quantidadeComercial,
				numeroPedidoCompra: nfeDetalheDrift.nfeDetalhe?.numeroPedidoCompra,
				itemPedidoCompra: nfeDetalheDrift.nfeDetalhe?.itemPedidoCompra,
				numeroFci: nfeDetalheDrift.nfeDetalhe?.numeroFci,
				numeroRecopi: nfeDetalheDrift.nfeDetalhe?.numeroRecopi,
				valorUnitarioComercial: nfeDetalheDrift.nfeDetalhe?.valorUnitarioComercial,
				valorBrutoProduto: nfeDetalheDrift.nfeDetalhe?.valorBrutoProduto,
				gtinUnidadeTributavel: nfeDetalheDrift.nfeDetalhe?.gtinUnidadeTributavel,
				unidadeTributavel: nfeDetalheDrift.nfeDetalhe?.unidadeTributavel,
				quantidadeTributavel: nfeDetalheDrift.nfeDetalhe?.quantidadeTributavel,
				valorUnitarioTributavel: nfeDetalheDrift.nfeDetalhe?.valorUnitarioTributavel,
				valorFrete: nfeDetalheDrift.nfeDetalhe?.valorFrete,
				valorSeguro: nfeDetalheDrift.nfeDetalhe?.valorSeguro,
				valorDesconto: nfeDetalheDrift.nfeDetalhe?.valorDesconto,
				valorOutrasDespesas: nfeDetalheDrift.nfeDetalhe?.valorOutrasDespesas,
				entraTotal: NfeDetalheDomain.getEntraTotal(nfeDetalheDrift.nfeDetalhe?.entraTotal),
				valorTotalTributos: nfeDetalheDrift.nfeDetalhe?.valorTotalTributos,
				percentualDevolvido: nfeDetalheDrift.nfeDetalhe?.percentualDevolvido,
				valorIpiDevolvido: nfeDetalheDrift.nfeDetalhe?.valorIpiDevolvido,
				informacoesAdicionais: nfeDetalheDrift.nfeDetalhe?.informacoesAdicionais,
				valorSubtotal: nfeDetalheDrift.nfeDetalhe?.valorSubtotal,
				valorTotal: nfeDetalheDrift.nfeDetalhe?.valorTotal,
				nfeDetEspecificoVeiculoModelList: nfeDetEspecificoVeiculoDriftToModel(nfeDetalheDrift.nfeDetEspecificoVeiculoGroupedList),
				nfeDetEspecificoMedicamentoModelList: nfeDetEspecificoMedicamentoDriftToModel(nfeDetalheDrift.nfeDetEspecificoMedicamentoGroupedList),
				nfeDetEspecificoArmamentoModelList: nfeDetEspecificoArmamentoDriftToModel(nfeDetalheDrift.nfeDetEspecificoArmamentoGroupedList),
				nfeDetEspecificoCombustivelModelList: nfeDetEspecificoCombustivelDriftToModel(nfeDetalheDrift.nfeDetEspecificoCombustivelGroupedList),
				nfeDeclaracaoImportacaoModelList: nfeDeclaracaoImportacaoDriftToModel(nfeDetalheDrift.nfeDeclaracaoImportacaoGroupedList),
				nfeDetalheImpostoIcmsModelList: nfeDetalheImpostoIcmsDriftToModel(nfeDetalheDrift.nfeDetalheImpostoIcmsGroupedList),
				nfeDetalheImpostoIpiModelList: nfeDetalheImpostoIpiDriftToModel(nfeDetalheDrift.nfeDetalheImpostoIpiGroupedList),
				nfeDetalheImpostoIiModelList: nfeDetalheImpostoIiDriftToModel(nfeDetalheDrift.nfeDetalheImpostoIiGroupedList),
				nfeDetalheImpostoPisModelList: nfeDetalheImpostoPisDriftToModel(nfeDetalheDrift.nfeDetalheImpostoPisGroupedList),
				nfeDetalheImpostoCofinsModelList: nfeDetalheImpostoCofinsDriftToModel(nfeDetalheDrift.nfeDetalheImpostoCofinsGroupedList),
				nfeDetalheImpostoIssqnModelList: nfeDetalheImpostoIssqnDriftToModel(nfeDetalheDrift.nfeDetalheImpostoIssqnGroupedList),
				nfeExportacaoModelList: nfeExportacaoDriftToModel(nfeDetalheDrift.nfeExportacaoGroupedList),
				nfeItemRastreadoModelList: nfeItemRastreadoDriftToModel(nfeDetalheDrift.nfeItemRastreadoGroupedList),
				nfeDetalheImpostoPisStModelList: nfeDetalheImpostoPisStDriftToModel(nfeDetalheDrift.nfeDetalheImpostoPisStGroupedList),
				nfeDetalheImpostoIcmsUfdestModelList: nfeDetalheImpostoIcmsUfdestDriftToModel(nfeDetalheDrift.nfeDetalheImpostoIcmsUfdestGroupedList),
				nfeDetalheImpostoCofinsStModelList: nfeDetalheImpostoCofinsStDriftToModel(nfeDetalheDrift.nfeDetalheImpostoCofinsStGroupedList),
				nfeCabecalhoModel: NfeCabecalhoModel(
					id: nfeDetalheDrift.nfeCabecalho?.id,
					idVendaCabecalho: nfeDetalheDrift.nfeCabecalho?.idVendaCabecalho,
					idTributOperacaoFiscal: nfeDetalheDrift.nfeCabecalho?.idTributOperacaoFiscal,
					idCliente: nfeDetalheDrift.nfeCabecalho?.idCliente,
					idColaborador: nfeDetalheDrift.nfeCabecalho?.idColaborador,
					idFornecedor: nfeDetalheDrift.nfeCabecalho?.idFornecedor,
					ufEmitente: nfeDetalheDrift.nfeCabecalho?.ufEmitente,
					codigoNumerico: nfeDetalheDrift.nfeCabecalho?.codigoNumerico,
					naturezaOperacao: nfeDetalheDrift.nfeCabecalho?.naturezaOperacao,
					codigoModelo: nfeDetalheDrift.nfeCabecalho?.codigoModelo,
					serie: nfeDetalheDrift.nfeCabecalho?.serie,
					numero: nfeDetalheDrift.nfeCabecalho?.numero,
					dataHoraEmissao: nfeDetalheDrift.nfeCabecalho?.dataHoraEmissao,
					dataHoraEntradaSaida: nfeDetalheDrift.nfeCabecalho?.dataHoraEntradaSaida,
					tipoOperacao: nfeDetalheDrift.nfeCabecalho?.tipoOperacao,
					localDestino: nfeDetalheDrift.nfeCabecalho?.localDestino,
					codigoMunicipio: nfeDetalheDrift.nfeCabecalho?.codigoMunicipio,
					formatoImpressaoDanfe: nfeDetalheDrift.nfeCabecalho?.formatoImpressaoDanfe,
					tipoEmissao: nfeDetalheDrift.nfeCabecalho?.tipoEmissao,
					chaveAcesso: nfeDetalheDrift.nfeCabecalho?.chaveAcesso,
					digitoChaveAcesso: nfeDetalheDrift.nfeCabecalho?.digitoChaveAcesso,
					ambiente: nfeDetalheDrift.nfeCabecalho?.ambiente,
					finalidadeEmissao: nfeDetalheDrift.nfeCabecalho?.finalidadeEmissao,
					consumidorOperacao: nfeDetalheDrift.nfeCabecalho?.consumidorOperacao,
					consumidorPresenca: nfeDetalheDrift.nfeCabecalho?.consumidorPresenca,
					processoEmissao: nfeDetalheDrift.nfeCabecalho?.processoEmissao,
					versaoProcessoEmissao: nfeDetalheDrift.nfeCabecalho?.versaoProcessoEmissao,
					dataEntradaContingencia: nfeDetalheDrift.nfeCabecalho?.dataEntradaContingencia,
					justificativaContingencia: nfeDetalheDrift.nfeCabecalho?.justificativaContingencia,
					baseCalculoIcms: nfeDetalheDrift.nfeCabecalho?.baseCalculoIcms,
					valorIcms: nfeDetalheDrift.nfeCabecalho?.valorIcms,
					valorIcmsDesonerado: nfeDetalheDrift.nfeCabecalho?.valorIcmsDesonerado,
					totalIcmsFcpUfDestino: nfeDetalheDrift.nfeCabecalho?.totalIcmsFcpUfDestino,
					totalIcmsInterestadualUfDestino: nfeDetalheDrift.nfeCabecalho?.totalIcmsInterestadualUfDestino,
					totalIcmsInterestadualUfRemetente: nfeDetalheDrift.nfeCabecalho?.totalIcmsInterestadualUfRemetente,
					valorTotalFcp: nfeDetalheDrift.nfeCabecalho?.valorTotalFcp,
					baseCalculoIcmsSt: nfeDetalheDrift.nfeCabecalho?.baseCalculoIcmsSt,
					valorIcmsSt: nfeDetalheDrift.nfeCabecalho?.valorIcmsSt,
					valorTotalFcpSt: nfeDetalheDrift.nfeCabecalho?.valorTotalFcpSt,
					valorTotalFcpStRetido: nfeDetalheDrift.nfeCabecalho?.valorTotalFcpStRetido,
					valorTotalProdutos: nfeDetalheDrift.nfeCabecalho?.valorTotalProdutos,
					valorFrete: nfeDetalheDrift.nfeCabecalho?.valorFrete,
					valorSeguro: nfeDetalheDrift.nfeCabecalho?.valorSeguro,
					valorDesconto: nfeDetalheDrift.nfeCabecalho?.valorDesconto,
					valorImpostoImportacao: nfeDetalheDrift.nfeCabecalho?.valorImpostoImportacao,
					valorIpi: nfeDetalheDrift.nfeCabecalho?.valorIpi,
					valorIpiDevolvido: nfeDetalheDrift.nfeCabecalho?.valorIpiDevolvido,
					valorPis: nfeDetalheDrift.nfeCabecalho?.valorPis,
					valorCofins: nfeDetalheDrift.nfeCabecalho?.valorCofins,
					valorDespesasAcessorias: nfeDetalheDrift.nfeCabecalho?.valorDespesasAcessorias,
					valorTotal: nfeDetalheDrift.nfeCabecalho?.valorTotal,
					valorTotalTributos: nfeDetalheDrift.nfeCabecalho?.valorTotalTributos,
					valorServicos: nfeDetalheDrift.nfeCabecalho?.valorServicos,
					baseCalculoIssqn: nfeDetalheDrift.nfeCabecalho?.baseCalculoIssqn,
					valorIssqn: nfeDetalheDrift.nfeCabecalho?.valorIssqn,
					valorPisIssqn: nfeDetalheDrift.nfeCabecalho?.valorPisIssqn,
					valorCofinsIssqn: nfeDetalheDrift.nfeCabecalho?.valorCofinsIssqn,
					dataPrestacaoServico: nfeDetalheDrift.nfeCabecalho?.dataPrestacaoServico,
					valorDeducaoIssqn: nfeDetalheDrift.nfeCabecalho?.valorDeducaoIssqn,
					outrasRetencoesIssqn: nfeDetalheDrift.nfeCabecalho?.outrasRetencoesIssqn,
					descontoIncondicionadoIssqn: nfeDetalheDrift.nfeCabecalho?.descontoIncondicionadoIssqn,
					descontoCondicionadoIssqn: nfeDetalheDrift.nfeCabecalho?.descontoCondicionadoIssqn,
					totalRetencaoIssqn: nfeDetalheDrift.nfeCabecalho?.totalRetencaoIssqn,
					regimeEspecialTributacao: nfeDetalheDrift.nfeCabecalho?.regimeEspecialTributacao,
					valorRetidoPis: nfeDetalheDrift.nfeCabecalho?.valorRetidoPis,
					valorRetidoCofins: nfeDetalheDrift.nfeCabecalho?.valorRetidoCofins,
					valorRetidoCsll: nfeDetalheDrift.nfeCabecalho?.valorRetidoCsll,
					baseCalculoIrrf: nfeDetalheDrift.nfeCabecalho?.baseCalculoIrrf,
					valorRetidoIrrf: nfeDetalheDrift.nfeCabecalho?.valorRetidoIrrf,
					baseCalculoPrevidencia: nfeDetalheDrift.nfeCabecalho?.baseCalculoPrevidencia,
					valorRetidoPrevidencia: nfeDetalheDrift.nfeCabecalho?.valorRetidoPrevidencia,
					informacoesAddFisco: nfeDetalheDrift.nfeCabecalho?.informacoesAddFisco,
					informacoesAddContribuinte: nfeDetalheDrift.nfeCabecalho?.informacoesAddContribuinte,
					comexUfEmbarque: nfeDetalheDrift.nfeCabecalho?.comexUfEmbarque,
					comexLocalEmbarque: nfeDetalheDrift.nfeCabecalho?.comexLocalEmbarque,
					comexLocalDespacho: nfeDetalheDrift.nfeCabecalho?.comexLocalDespacho,
					compraNotaEmpenho: nfeDetalheDrift.nfeCabecalho?.compraNotaEmpenho,
					compraPedido: nfeDetalheDrift.nfeCabecalho?.compraPedido,
					compraContrato: nfeDetalheDrift.nfeCabecalho?.compraContrato,
					qrcode: nfeDetalheDrift.nfeCabecalho?.qrcode,
					urlChave: nfeDetalheDrift.nfeCabecalho?.urlChave,
					statusNota: nfeDetalheDrift.nfeCabecalho?.statusNota,
				),
				produtoModel: ProdutoModel(
					id: nfeDetalheDrift.produto?.id,
					idProdutoSubgrupo: nfeDetalheDrift.produto?.idProdutoSubgrupo,
					idProdutoMarca: nfeDetalheDrift.produto?.idProdutoMarca,
					idProdutoUnidade: nfeDetalheDrift.produto?.idProdutoUnidade,
					idTributIcmsCustomCab: nfeDetalheDrift.produto?.idTributIcmsCustomCab,
					idTributGrupoTributario: nfeDetalheDrift.produto?.idTributGrupoTributario,
					nome: nfeDetalheDrift.produto?.nome,
					descricao: nfeDetalheDrift.produto?.descricao,
					gtin: nfeDetalheDrift.produto?.gtin,
					codigoInterno: nfeDetalheDrift.produto?.codigoInterno,
					valorCompra: nfeDetalheDrift.produto?.valorCompra,
					valorVenda: nfeDetalheDrift.produto?.valorVenda,
					codigoNcm: nfeDetalheDrift.produto?.codigoNcm,
					estoqueMinimo: nfeDetalheDrift.produto?.estoqueMinimo,
					estoqueMaximo: nfeDetalheDrift.produto?.estoqueMaximo,
					quantidadeEstoque: nfeDetalheDrift.produto?.quantidadeEstoque,
					dataCadastro: nfeDetalheDrift.produto?.dataCadastro,
				),
			);
		} else {
			return null;
		}
	}

	List<NfeDetEspecificoVeiculoModel> nfeDetEspecificoVeiculoDriftToModel(List<NfeDetEspecificoVeiculoGrouped>? nfeDetEspecificoVeiculoDriftList) { 
		List<NfeDetEspecificoVeiculoModel> nfeDetEspecificoVeiculoModelList = [];
		if (nfeDetEspecificoVeiculoDriftList != null) {
			for (var nfeDetEspecificoVeiculoGrouped in nfeDetEspecificoVeiculoDriftList) {
				nfeDetEspecificoVeiculoModelList.add(
					NfeDetEspecificoVeiculoModel(
						id: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.id,
						idNfeDetalhe: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.idNfeDetalhe,
						tipoOperacao: NfeDetEspecificoVeiculoDomain.getTipoOperacao(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.tipoOperacao),
						chassi: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.chassi,
						cor: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.cor,
						descricaoCor: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.descricaoCor,
						potenciaMotor: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.potenciaMotor,
						cilindradas: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.cilindradas,
						pesoLiquido: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.pesoLiquido,
						pesoBruto: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.pesoBruto,
						numeroSerie: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.numeroSerie,
						tipoCombustivel: NfeDetEspecificoVeiculoDomain.getTipoCombustivel(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.tipoCombustivel),
						numeroMotor: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.numeroMotor,
						capacidadeMaximaTracao: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.capacidadeMaximaTracao,
						distanciaEixos: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.distanciaEixos,
						anoModelo: NfeDetEspecificoVeiculoDomain.getAnoModelo(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.anoModelo),
						anoFabricacao: NfeDetEspecificoVeiculoDomain.getAnoFabricacao(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.anoFabricacao),
						tipoPintura: NfeDetEspecificoVeiculoDomain.getTipoPintura(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.tipoPintura),
						tipoVeiculo: NfeDetEspecificoVeiculoDomain.getTipoVeiculo(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.tipoVeiculo),
						especieVeiculo: NfeDetEspecificoVeiculoDomain.getEspecieVeiculo(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.especieVeiculo),
						condicaoVin: NfeDetEspecificoVeiculoDomain.getCondicaoVin(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.condicaoVin),
						condicaoVeiculo: NfeDetEspecificoVeiculoDomain.getCondicaoVeiculo(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.condicaoVeiculo),
						codigoMarcaModelo: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.codigoMarcaModelo,
						codigoCorDenatran: NfeDetEspecificoVeiculoDomain.getCodigoCorDenatran(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.codigoCorDenatran),
						lotacaoMaxima: nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.lotacaoMaxima,
						restricao: NfeDetEspecificoVeiculoDomain.getRestricao(nfeDetEspecificoVeiculoGrouped.nfeDetEspecificoVeiculo?.restricao),
					)
				);
			}
			return nfeDetEspecificoVeiculoModelList;
		}
		return [];
	}

	List<NfeDetEspecificoMedicamentoModel> nfeDetEspecificoMedicamentoDriftToModel(List<NfeDetEspecificoMedicamentoGrouped>? nfeDetEspecificoMedicamentoDriftList) { 
		List<NfeDetEspecificoMedicamentoModel> nfeDetEspecificoMedicamentoModelList = [];
		if (nfeDetEspecificoMedicamentoDriftList != null) {
			for (var nfeDetEspecificoMedicamentoGrouped in nfeDetEspecificoMedicamentoDriftList) {
				nfeDetEspecificoMedicamentoModelList.add(
					NfeDetEspecificoMedicamentoModel(
						id: nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.id,
						idNfeDetalhe: nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.idNfeDetalhe,
						codigoAnvisa: nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.codigoAnvisa,
						motivoIsencao: nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.motivoIsencao,
						precoMaximoConsumidor: nfeDetEspecificoMedicamentoGrouped.nfeDetEspecificoMedicamento?.precoMaximoConsumidor,
					)
				);
			}
			return nfeDetEspecificoMedicamentoModelList;
		}
		return [];
	}

	List<NfeDetEspecificoArmamentoModel> nfeDetEspecificoArmamentoDriftToModel(List<NfeDetEspecificoArmamentoGrouped>? nfeDetEspecificoArmamentoDriftList) { 
		List<NfeDetEspecificoArmamentoModel> nfeDetEspecificoArmamentoModelList = [];
		if (nfeDetEspecificoArmamentoDriftList != null) {
			for (var nfeDetEspecificoArmamentoGrouped in nfeDetEspecificoArmamentoDriftList) {
				nfeDetEspecificoArmamentoModelList.add(
					NfeDetEspecificoArmamentoModel(
						id: nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.id,
						idNfeDetalhe: nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.idNfeDetalhe,
						tipoArma: NfeDetEspecificoArmamentoDomain.getTipoArma(nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.tipoArma),
						numeroSerieArma: nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.numeroSerieArma,
						numeroSerieCano: nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.numeroSerieCano,
						descricao: nfeDetEspecificoArmamentoGrouped.nfeDetEspecificoArmamento?.descricao,
					)
				);
			}
			return nfeDetEspecificoArmamentoModelList;
		}
		return [];
	}

	List<NfeDetEspecificoCombustivelModel> nfeDetEspecificoCombustivelDriftToModel(List<NfeDetEspecificoCombustivelGrouped>? nfeDetEspecificoCombustivelDriftList) { 
		List<NfeDetEspecificoCombustivelModel> nfeDetEspecificoCombustivelModelList = [];
		if (nfeDetEspecificoCombustivelDriftList != null) {
			for (var nfeDetEspecificoCombustivelGrouped in nfeDetEspecificoCombustivelDriftList) {
				nfeDetEspecificoCombustivelModelList.add(
					NfeDetEspecificoCombustivelModel(
						id: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.id,
						idNfeDetalhe: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.idNfeDetalhe,
						codigoAnp: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.codigoAnp,
						descricaoAnp: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.descricaoAnp,
						percentualGlp: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.percentualGlp,
						percentualGasNacional: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.percentualGasNacional,
						percentualGasImportado: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.percentualGasImportado,
						valorPartida: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.valorPartida,
						codif: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.codif,
						quantidadeTempAmbiente: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.quantidadeTempAmbiente,
						ufConsumo: NfeDetEspecificoCombustivelDomain.getUfConsumo(nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.ufConsumo),
						cideBaseCalculo: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.cideBaseCalculo,
						cideAliquota: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.cideAliquota,
						cideValor: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.cideValor,
						encerranteBico: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.encerranteBico,
						encerranteBomba: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.encerranteBomba,
						encerranteTanque: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.encerranteTanque,
						encerranteValorInicio: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.encerranteValorInicio,
						encerranteValorFim: nfeDetEspecificoCombustivelGrouped.nfeDetEspecificoCombustivel?.encerranteValorFim,
					)
				);
			}
			return nfeDetEspecificoCombustivelModelList;
		}
		return [];
	}

	List<NfeDeclaracaoImportacaoModel> nfeDeclaracaoImportacaoDriftToModel(List<NfeDeclaracaoImportacaoGrouped>? nfeDeclaracaoImportacaoDriftList) { 
		List<NfeDeclaracaoImportacaoModel> nfeDeclaracaoImportacaoModelList = [];
		if (nfeDeclaracaoImportacaoDriftList != null) {
			for (var nfeDeclaracaoImportacaoGrouped in nfeDeclaracaoImportacaoDriftList) {
				nfeDeclaracaoImportacaoModelList.add(
					NfeDeclaracaoImportacaoModel(
						id: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.id,
						idNfeDetalhe: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.idNfeDetalhe,
						numeroDocumento: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.numeroDocumento,
						dataRegistro: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.dataRegistro,
						localDesembaraco: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.localDesembaraco,
						ufDesembaraco: NfeDeclaracaoImportacaoDomain.getUfDesembaraco(nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.ufDesembaraco),
						dataDesembaraco: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.dataDesembaraco,
						viaTransporte: NfeDeclaracaoImportacaoDomain.getViaTransporte(nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.viaTransporte),
						valorAfrmm: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.valorAfrmm,
						formaIntermediacao: NfeDeclaracaoImportacaoDomain.getFormaIntermediacao(nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.formaIntermediacao),
						cnpj: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.cnpj,
						ufTerceiro: NfeDeclaracaoImportacaoDomain.getUfTerceiro(nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.ufTerceiro),
						codigoExportador: nfeDeclaracaoImportacaoGrouped.nfeDeclaracaoImportacao?.codigoExportador,
					)
				);
			}
			return nfeDeclaracaoImportacaoModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoIcmsModel> nfeDetalheImpostoIcmsDriftToModel(List<NfeDetalheImpostoIcmsGrouped>? nfeDetalheImpostoIcmsDriftList) { 
		List<NfeDetalheImpostoIcmsModel> nfeDetalheImpostoIcmsModelList = [];
		if (nfeDetalheImpostoIcmsDriftList != null) {
			for (var nfeDetalheImpostoIcmsGrouped in nfeDetalheImpostoIcmsDriftList) {
				nfeDetalheImpostoIcmsModelList.add(
					NfeDetalheImpostoIcmsModel(
						id: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.id,
						idNfeDetalhe: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.idNfeDetalhe,
						origemMercadoria: NfeDetalheImpostoIcmsDomain.getOrigemMercadoria(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.origemMercadoria),
						cstIcms: NfeDetalheImpostoIcmsDomain.getCstIcms(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.cstIcms),
						csosn: NfeDetalheImpostoIcmsDomain.getCsosn(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.csosn),
						modalidadeBcIcms: NfeDetalheImpostoIcmsDomain.getModalidadeBcIcms(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.modalidadeBcIcms),
						percentualReducaoBcIcms: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualReducaoBcIcms,
						valorBcIcms: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorBcIcms,
						aliquotaIcms: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.aliquotaIcms,
						valorIcmsOperacao: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsOperacao,
						percentualDiferimento: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualDiferimento,
						valorIcmsDiferido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsDiferido,
						valorIcms: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcms,
						baseCalculoFcp: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.baseCalculoFcp,
						percentualFcp: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualFcp,
						valorFcp: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorFcp,
						modalidadeBcIcmsSt: NfeDetalheImpostoIcmsDomain.getModalidadeBcIcmsSt(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.modalidadeBcIcmsSt),
						percentualMvaIcmsSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualMvaIcmsSt,
						percentualReducaoBcIcmsSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualReducaoBcIcmsSt,
						valorBaseCalculoIcmsSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorBaseCalculoIcmsSt,
						aliquotaIcmsSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.aliquotaIcmsSt,
						valorIcmsSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsSt,
						baseCalculoFcpSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.baseCalculoFcpSt,
						percentualFcpSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualFcpSt,
						valorFcpSt: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorFcpSt,
						ufSt: NfeDetalheImpostoIcmsDomain.getUfSt(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.ufSt),
						percentualBcOperacaoPropria: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualBcOperacaoPropria,
						valorBcIcmsStRetido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorBcIcmsStRetido,
						aliquotaSuportadaConsumidor: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.aliquotaSuportadaConsumidor,
						valorIcmsSubstituto: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsSubstituto,
						valorIcmsStRetido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsStRetido,
						baseCalculoFcpStRetido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.baseCalculoFcpStRetido,
						percentualFcpStRetido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualFcpStRetido,
						valorFcpStRetido: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorFcpStRetido,
						motivoDesoneracaoIcms: NfeDetalheImpostoIcmsDomain.getMotivoDesoneracaoIcms(nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.motivoDesoneracaoIcms),
						valorIcmsDesonerado: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsDesonerado,
						aliquotaCreditoIcmsSn: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.aliquotaCreditoIcmsSn,
						valorCreditoIcmsSn: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorCreditoIcmsSn,
						valorBcIcmsStDestino: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorBcIcmsStDestino,
						valorIcmsStDestino: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsStDestino,
						percentualReducaoBcEfetivo: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.percentualReducaoBcEfetivo,
						valorBcEfetivo: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorBcEfetivo,
						aliquotaIcmsEfetivo: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.aliquotaIcmsEfetivo,
						valorIcmsEfetivo: nfeDetalheImpostoIcmsGrouped.nfeDetalheImpostoIcms?.valorIcmsEfetivo,
					)
				);
			}
			return nfeDetalheImpostoIcmsModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoIpiModel> nfeDetalheImpostoIpiDriftToModel(List<NfeDetalheImpostoIpiGrouped>? nfeDetalheImpostoIpiDriftList) { 
		List<NfeDetalheImpostoIpiModel> nfeDetalheImpostoIpiModelList = [];
		if (nfeDetalheImpostoIpiDriftList != null) {
			for (var nfeDetalheImpostoIpiGrouped in nfeDetalheImpostoIpiDriftList) {
				nfeDetalheImpostoIpiModelList.add(
					NfeDetalheImpostoIpiModel(
						id: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.id,
						idNfeDetalhe: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.idNfeDetalhe,
						cnpjProdutor: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.cnpjProdutor,
						codigoSeloIpi: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.codigoSeloIpi,
						quantidadeSeloIpi: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.quantidadeSeloIpi,
						enquadramentoLegalIpi: NfeDetalheImpostoIpiDomain.getEnquadramentoLegalIpi(nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.enquadramentoLegalIpi),
						cstIpi: NfeDetalheImpostoIpiDomain.getCstIpi(nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.cstIpi),
						valorBaseCalculoIpi: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.valorBaseCalculoIpi,
						quantidadeUnidadeTributavel: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.quantidadeUnidadeTributavel,
						valorUnidadeTributavel: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.valorUnidadeTributavel,
						aliquotaIpi: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.aliquotaIpi,
						valorIpi: nfeDetalheImpostoIpiGrouped.nfeDetalheImpostoIpi?.valorIpi,
					)
				);
			}
			return nfeDetalheImpostoIpiModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoIiModel> nfeDetalheImpostoIiDriftToModel(List<NfeDetalheImpostoIiGrouped>? nfeDetalheImpostoIiDriftList) { 
		List<NfeDetalheImpostoIiModel> nfeDetalheImpostoIiModelList = [];
		if (nfeDetalheImpostoIiDriftList != null) {
			for (var nfeDetalheImpostoIiGrouped in nfeDetalheImpostoIiDriftList) {
				nfeDetalheImpostoIiModelList.add(
					NfeDetalheImpostoIiModel(
						id: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.id,
						idNfeDetalhe: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.idNfeDetalhe,
						valorBcIi: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.valorBcIi,
						valorDespesasAduaneiras: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.valorDespesasAduaneiras,
						valorImpostoImportacao: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.valorImpostoImportacao,
						valorIof: nfeDetalheImpostoIiGrouped.nfeDetalheImpostoIi?.valorIof,
					)
				);
			}
			return nfeDetalheImpostoIiModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoPisModel> nfeDetalheImpostoPisDriftToModel(List<NfeDetalheImpostoPisGrouped>? nfeDetalheImpostoPisDriftList) { 
		List<NfeDetalheImpostoPisModel> nfeDetalheImpostoPisModelList = [];
		if (nfeDetalheImpostoPisDriftList != null) {
			for (var nfeDetalheImpostoPisGrouped in nfeDetalheImpostoPisDriftList) {
				nfeDetalheImpostoPisModelList.add(
					NfeDetalheImpostoPisModel(
						id: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.id,
						idNfeDetalhe: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.idNfeDetalhe,
						cstPis: NfeDetalheImpostoPisDomain.getCstPis(nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.cstPis),
						valorBaseCalculoPis: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.valorBaseCalculoPis,
						aliquotaPisPercentual: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.aliquotaPisPercentual,
						valorPis: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.valorPis,
						quantidadeVendida: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.quantidadeVendida,
						aliquotaPisReais: nfeDetalheImpostoPisGrouped.nfeDetalheImpostoPis?.aliquotaPisReais,
					)
				);
			}
			return nfeDetalheImpostoPisModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoCofinsModel> nfeDetalheImpostoCofinsDriftToModel(List<NfeDetalheImpostoCofinsGrouped>? nfeDetalheImpostoCofinsDriftList) { 
		List<NfeDetalheImpostoCofinsModel> nfeDetalheImpostoCofinsModelList = [];
		if (nfeDetalheImpostoCofinsDriftList != null) {
			for (var nfeDetalheImpostoCofinsGrouped in nfeDetalheImpostoCofinsDriftList) {
				nfeDetalheImpostoCofinsModelList.add(
					NfeDetalheImpostoCofinsModel(
						id: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.id,
						idNfeDetalhe: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.idNfeDetalhe,
						cstCofins: NfeDetalheImpostoCofinsDomain.getCstCofins(nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.cstCofins),
						baseCalculoCofins: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.baseCalculoCofins,
						aliquotaCofinsPercentual: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.aliquotaCofinsPercentual,
						quantidadeVendida: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.quantidadeVendida,
						aliquotaCofinsReais: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.aliquotaCofinsReais,
						valorCofins: nfeDetalheImpostoCofinsGrouped.nfeDetalheImpostoCofins?.valorCofins,
					)
				);
			}
			return nfeDetalheImpostoCofinsModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoIssqnModel> nfeDetalheImpostoIssqnDriftToModel(List<NfeDetalheImpostoIssqnGrouped>? nfeDetalheImpostoIssqnDriftList) { 
		List<NfeDetalheImpostoIssqnModel> nfeDetalheImpostoIssqnModelList = [];
		if (nfeDetalheImpostoIssqnDriftList != null) {
			for (var nfeDetalheImpostoIssqnGrouped in nfeDetalheImpostoIssqnDriftList) {
				nfeDetalheImpostoIssqnModelList.add(
					NfeDetalheImpostoIssqnModel(
						id: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.id,
						idNfeDetalhe: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.idNfeDetalhe,
						baseCalculoIssqn: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.baseCalculoIssqn,
						aliquotaIssqn: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.aliquotaIssqn,
						valorIssqn: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorIssqn,
						municipioIssqn: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.municipioIssqn,
						itemListaServicos: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.itemListaServicos,
						valorDeducao: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorDeducao,
						valorOutrasRetencoes: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorOutrasRetencoes,
						valorDescontoIncondicionado: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorDescontoIncondicionado,
						valorDescontoCondicionado: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorDescontoCondicionado,
						valorRetencaoIss: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.valorRetencaoIss,
						indicadorExigibilidadeIss: NfeDetalheImpostoIssqnDomain.getIndicadorExigibilidadeIss(nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.indicadorExigibilidadeIss),
						codigoServico: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.codigoServico,
						municipioIncidencia: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.municipioIncidencia,
						paisSevicoPrestado: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.paisSevicoPrestado,
						numeroProcesso: nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.numeroProcesso,
						indicadorIncentivoFiscal: NfeDetalheImpostoIssqnDomain.getIndicadorIncentivoFiscal(nfeDetalheImpostoIssqnGrouped.nfeDetalheImpostoIssqn?.indicadorIncentivoFiscal),
					)
				);
			}
			return nfeDetalheImpostoIssqnModelList;
		}
		return [];
	}

	List<NfeExportacaoModel> nfeExportacaoDriftToModel(List<NfeExportacaoGrouped>? nfeExportacaoDriftList) { 
		List<NfeExportacaoModel> nfeExportacaoModelList = [];
		if (nfeExportacaoDriftList != null) {
			for (var nfeExportacaoGrouped in nfeExportacaoDriftList) {
				nfeExportacaoModelList.add(
					NfeExportacaoModel(
						id: nfeExportacaoGrouped.nfeExportacao?.id,
						idNfeDetalhe: nfeExportacaoGrouped.nfeExportacao?.idNfeDetalhe,
						drawback: nfeExportacaoGrouped.nfeExportacao?.drawback,
						numeroRegistro: nfeExportacaoGrouped.nfeExportacao?.numeroRegistro,
						chaveAcesso: nfeExportacaoGrouped.nfeExportacao?.chaveAcesso,
						quantidade: nfeExportacaoGrouped.nfeExportacao?.quantidade,
					)
				);
			}
			return nfeExportacaoModelList;
		}
		return [];
	}

	List<NfeItemRastreadoModel> nfeItemRastreadoDriftToModel(List<NfeItemRastreadoGrouped>? nfeItemRastreadoDriftList) { 
		List<NfeItemRastreadoModel> nfeItemRastreadoModelList = [];
		if (nfeItemRastreadoDriftList != null) {
			for (var nfeItemRastreadoGrouped in nfeItemRastreadoDriftList) {
				nfeItemRastreadoModelList.add(
					NfeItemRastreadoModel(
						id: nfeItemRastreadoGrouped.nfeItemRastreado?.id,
						idNfeDetalhe: nfeItemRastreadoGrouped.nfeItemRastreado?.idNfeDetalhe,
						numeroLote: nfeItemRastreadoGrouped.nfeItemRastreado?.numeroLote,
						quantidadeItens: nfeItemRastreadoGrouped.nfeItemRastreado?.quantidadeItens,
						dataFabricacao: nfeItemRastreadoGrouped.nfeItemRastreado?.dataFabricacao,
						dataValidade: nfeItemRastreadoGrouped.nfeItemRastreado?.dataValidade,
						codigoAgregacao: nfeItemRastreadoGrouped.nfeItemRastreado?.codigoAgregacao,
					)
				);
			}
			return nfeItemRastreadoModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoPisStModel> nfeDetalheImpostoPisStDriftToModel(List<NfeDetalheImpostoPisStGrouped>? nfeDetalheImpostoPisStDriftList) { 
		List<NfeDetalheImpostoPisStModel> nfeDetalheImpostoPisStModelList = [];
		if (nfeDetalheImpostoPisStDriftList != null) {
			for (var nfeDetalheImpostoPisStGrouped in nfeDetalheImpostoPisStDriftList) {
				nfeDetalheImpostoPisStModelList.add(
					NfeDetalheImpostoPisStModel(
						id: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.id,
						idNfeDetalhe: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.idNfeDetalhe,
						valorBaseCalculoPisSt: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.valorBaseCalculoPisSt,
						aliquotaPisStPercentual: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.aliquotaPisStPercentual,
						quantidadeVendidaPisSt: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.quantidadeVendidaPisSt,
						aliquotaPisStReais: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.aliquotaPisStReais,
						valorPisSt: nfeDetalheImpostoPisStGrouped.nfeDetalheImpostoPisSt?.valorPisSt,
					)
				);
			}
			return nfeDetalheImpostoPisStModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoIcmsUfdestModel> nfeDetalheImpostoIcmsUfdestDriftToModel(List<NfeDetalheImpostoIcmsUfdestGrouped>? nfeDetalheImpostoIcmsUfdestDriftList) { 
		List<NfeDetalheImpostoIcmsUfdestModel> nfeDetalheImpostoIcmsUfdestModelList = [];
		if (nfeDetalheImpostoIcmsUfdestDriftList != null) {
			for (var nfeDetalheImpostoIcmsUfdestGrouped in nfeDetalheImpostoIcmsUfdestDriftList) {
				nfeDetalheImpostoIcmsUfdestModelList.add(
					NfeDetalheImpostoIcmsUfdestModel(
						id: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.id,
						idNfeDetalhe: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.idNfeDetalhe,
						valorBcIcmsUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.valorBcIcmsUfDestino,
						valorBcFcpUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.valorBcFcpUfDestino,
						percentualFcpUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.percentualFcpUfDestino,
						aliquotaInternaUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.aliquotaInternaUfDestino,
						aliquotaInteresdatualUfEnvolvidas: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.aliquotaInteresdatualUfEnvolvidas,
						percentualProvisorioPartilhaIcms: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.percentualProvisorioPartilhaIcms,
						valorIcmsFcpUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.valorIcmsFcpUfDestino,
						valorInterestadualUfDestino: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.valorInterestadualUfDestino,
						valorInterestadualUfRemetente: nfeDetalheImpostoIcmsUfdestGrouped.nfeDetalheImpostoIcmsUfdest?.valorInterestadualUfRemetente,
					)
				);
			}
			return nfeDetalheImpostoIcmsUfdestModelList;
		}
		return [];
	}

	List<NfeDetalheImpostoCofinsStModel> nfeDetalheImpostoCofinsStDriftToModel(List<NfeDetalheImpostoCofinsStGrouped>? nfeDetalheImpostoCofinsStDriftList) { 
		List<NfeDetalheImpostoCofinsStModel> nfeDetalheImpostoCofinsStModelList = [];
		if (nfeDetalheImpostoCofinsStDriftList != null) {
			for (var nfeDetalheImpostoCofinsStGrouped in nfeDetalheImpostoCofinsStDriftList) {
				nfeDetalheImpostoCofinsStModelList.add(
					NfeDetalheImpostoCofinsStModel(
						id: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.id,
						idNfeDetalhe: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.idNfeDetalhe,
						baseCalculoCofinsSt: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.baseCalculoCofinsSt,
						aliquotaCofinsStPercentual: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.aliquotaCofinsStPercentual,
						quantidadeVendidaCofinsSt: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.quantidadeVendidaCofinsSt,
						aliquotaCofinsStReais: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.aliquotaCofinsStReais,
						valorCofinsSt: nfeDetalheImpostoCofinsStGrouped.nfeDetalheImpostoCofinsSt?.valorCofinsSt,
					)
				);
			}
			return nfeDetalheImpostoCofinsStModelList;
		}
		return [];
	}


	NfeDetalheGrouped toDrift(NfeDetalheModel nfeDetalheModel) {
		return NfeDetalheGrouped(
			nfeDetalhe: NfeDetalhe(
				id: nfeDetalheModel.id,
				idNfeCabecalho: nfeDetalheModel.idNfeCabecalho,
				idProduto: nfeDetalheModel.idProduto,
				numeroItem: nfeDetalheModel.numeroItem,
				codigoProduto: nfeDetalheModel.codigoProduto,
				gtin: nfeDetalheModel.gtin,
				nomeProduto: nfeDetalheModel.nomeProduto,
				ncm: nfeDetalheModel.ncm,
				nve: nfeDetalheModel.nve,
				cest: nfeDetalheModel.cest,
				indicadorEscalaRelevante: NfeDetalheDomain.setIndicadorEscalaRelevante(nfeDetalheModel.indicadorEscalaRelevante),
				cnpjFabricante: Util.removeMask(nfeDetalheModel.cnpjFabricante),
				codigoBeneficioFiscal: nfeDetalheModel.codigoBeneficioFiscal,
				exTipi: nfeDetalheModel.exTipi,
				cfop: nfeDetalheModel.cfop,
				unidadeComercial: nfeDetalheModel.unidadeComercial,
				quantidadeComercial: nfeDetalheModel.quantidadeComercial,
				numeroPedidoCompra: nfeDetalheModel.numeroPedidoCompra,
				itemPedidoCompra: nfeDetalheModel.itemPedidoCompra,
				numeroFci: nfeDetalheModel.numeroFci,
				numeroRecopi: nfeDetalheModel.numeroRecopi,
				valorUnitarioComercial: nfeDetalheModel.valorUnitarioComercial,
				valorBrutoProduto: nfeDetalheModel.valorBrutoProduto,
				gtinUnidadeTributavel: nfeDetalheModel.gtinUnidadeTributavel,
				unidadeTributavel: nfeDetalheModel.unidadeTributavel,
				quantidadeTributavel: nfeDetalheModel.quantidadeTributavel,
				valorUnitarioTributavel: nfeDetalheModel.valorUnitarioTributavel,
				valorFrete: nfeDetalheModel.valorFrete,
				valorSeguro: nfeDetalheModel.valorSeguro,
				valorDesconto: nfeDetalheModel.valorDesconto,
				valorOutrasDespesas: nfeDetalheModel.valorOutrasDespesas,
				entraTotal: NfeDetalheDomain.setEntraTotal(nfeDetalheModel.entraTotal),
				valorTotalTributos: nfeDetalheModel.valorTotalTributos,
				percentualDevolvido: nfeDetalheModel.percentualDevolvido,
				valorIpiDevolvido: nfeDetalheModel.valorIpiDevolvido,
				informacoesAdicionais: nfeDetalheModel.informacoesAdicionais,
				valorSubtotal: nfeDetalheModel.valorSubtotal,
				valorTotal: nfeDetalheModel.valorTotal,
			),
			nfeDetEspecificoVeiculoGroupedList: nfeDetEspecificoVeiculoModelToDrift(nfeDetalheModel.nfeDetEspecificoVeiculoModelList),
			nfeDetEspecificoMedicamentoGroupedList: nfeDetEspecificoMedicamentoModelToDrift(nfeDetalheModel.nfeDetEspecificoMedicamentoModelList),
			nfeDetEspecificoArmamentoGroupedList: nfeDetEspecificoArmamentoModelToDrift(nfeDetalheModel.nfeDetEspecificoArmamentoModelList),
			nfeDetEspecificoCombustivelGroupedList: nfeDetEspecificoCombustivelModelToDrift(nfeDetalheModel.nfeDetEspecificoCombustivelModelList),
			nfeDeclaracaoImportacaoGroupedList: nfeDeclaracaoImportacaoModelToDrift(nfeDetalheModel.nfeDeclaracaoImportacaoModelList),
			nfeDetalheImpostoIcmsGroupedList: nfeDetalheImpostoIcmsModelToDrift(nfeDetalheModel.nfeDetalheImpostoIcmsModelList),
			nfeDetalheImpostoIpiGroupedList: nfeDetalheImpostoIpiModelToDrift(nfeDetalheModel.nfeDetalheImpostoIpiModelList),
			nfeDetalheImpostoIiGroupedList: nfeDetalheImpostoIiModelToDrift(nfeDetalheModel.nfeDetalheImpostoIiModelList),
			nfeDetalheImpostoPisGroupedList: nfeDetalheImpostoPisModelToDrift(nfeDetalheModel.nfeDetalheImpostoPisModelList),
			nfeDetalheImpostoCofinsGroupedList: nfeDetalheImpostoCofinsModelToDrift(nfeDetalheModel.nfeDetalheImpostoCofinsModelList),
			nfeDetalheImpostoIssqnGroupedList: nfeDetalheImpostoIssqnModelToDrift(nfeDetalheModel.nfeDetalheImpostoIssqnModelList),
			nfeExportacaoGroupedList: nfeExportacaoModelToDrift(nfeDetalheModel.nfeExportacaoModelList),
			nfeItemRastreadoGroupedList: nfeItemRastreadoModelToDrift(nfeDetalheModel.nfeItemRastreadoModelList),
			nfeDetalheImpostoPisStGroupedList: nfeDetalheImpostoPisStModelToDrift(nfeDetalheModel.nfeDetalheImpostoPisStModelList),
			nfeDetalheImpostoIcmsUfdestGroupedList: nfeDetalheImpostoIcmsUfdestModelToDrift(nfeDetalheModel.nfeDetalheImpostoIcmsUfdestModelList),
			nfeDetalheImpostoCofinsStGroupedList: nfeDetalheImpostoCofinsStModelToDrift(nfeDetalheModel.nfeDetalheImpostoCofinsStModelList),
		);
	}

	List<NfeDetEspecificoVeiculoGrouped> nfeDetEspecificoVeiculoModelToDrift(List<NfeDetEspecificoVeiculoModel>? nfeDetEspecificoVeiculoModelList) { 
		List<NfeDetEspecificoVeiculoGrouped> nfeDetEspecificoVeiculoGroupedList = [];
		if (nfeDetEspecificoVeiculoModelList != null) {
			for (var nfeDetEspecificoVeiculoModel in nfeDetEspecificoVeiculoModelList) {
				nfeDetEspecificoVeiculoGroupedList.add(
					NfeDetEspecificoVeiculoGrouped(
						nfeDetEspecificoVeiculo: NfeDetEspecificoVeiculo(
							id: nfeDetEspecificoVeiculoModel.id,
							idNfeDetalhe: nfeDetEspecificoVeiculoModel.idNfeDetalhe,
							tipoOperacao: NfeDetEspecificoVeiculoDomain.setTipoOperacao(nfeDetEspecificoVeiculoModel.tipoOperacao),
							chassi: nfeDetEspecificoVeiculoModel.chassi,
							cor: nfeDetEspecificoVeiculoModel.cor,
							descricaoCor: nfeDetEspecificoVeiculoModel.descricaoCor,
							potenciaMotor: nfeDetEspecificoVeiculoModel.potenciaMotor,
							cilindradas: nfeDetEspecificoVeiculoModel.cilindradas,
							pesoLiquido: nfeDetEspecificoVeiculoModel.pesoLiquido,
							pesoBruto: nfeDetEspecificoVeiculoModel.pesoBruto,
							numeroSerie: nfeDetEspecificoVeiculoModel.numeroSerie,
							tipoCombustivel: NfeDetEspecificoVeiculoDomain.setTipoCombustivel(nfeDetEspecificoVeiculoModel.tipoCombustivel),
							numeroMotor: nfeDetEspecificoVeiculoModel.numeroMotor,
							capacidadeMaximaTracao: nfeDetEspecificoVeiculoModel.capacidadeMaximaTracao,
							distanciaEixos: nfeDetEspecificoVeiculoModel.distanciaEixos,
							anoModelo: NfeDetEspecificoVeiculoDomain.setAnoModelo(nfeDetEspecificoVeiculoModel.anoModelo),
							anoFabricacao: NfeDetEspecificoVeiculoDomain.setAnoFabricacao(nfeDetEspecificoVeiculoModel.anoFabricacao),
							tipoPintura: NfeDetEspecificoVeiculoDomain.setTipoPintura(nfeDetEspecificoVeiculoModel.tipoPintura),
							tipoVeiculo: NfeDetEspecificoVeiculoDomain.setTipoVeiculo(nfeDetEspecificoVeiculoModel.tipoVeiculo),
							especieVeiculo: NfeDetEspecificoVeiculoDomain.setEspecieVeiculo(nfeDetEspecificoVeiculoModel.especieVeiculo),
							condicaoVin: NfeDetEspecificoVeiculoDomain.setCondicaoVin(nfeDetEspecificoVeiculoModel.condicaoVin),
							condicaoVeiculo: NfeDetEspecificoVeiculoDomain.setCondicaoVeiculo(nfeDetEspecificoVeiculoModel.condicaoVeiculo),
							codigoMarcaModelo: nfeDetEspecificoVeiculoModel.codigoMarcaModelo,
							codigoCorDenatran: NfeDetEspecificoVeiculoDomain.setCodigoCorDenatran(nfeDetEspecificoVeiculoModel.codigoCorDenatran),
							lotacaoMaxima: nfeDetEspecificoVeiculoModel.lotacaoMaxima,
							restricao: NfeDetEspecificoVeiculoDomain.setRestricao(nfeDetEspecificoVeiculoModel.restricao),
						),
					),
				);
			}
			return nfeDetEspecificoVeiculoGroupedList;
		}
		return [];
	}

	List<NfeDetEspecificoMedicamentoGrouped> nfeDetEspecificoMedicamentoModelToDrift(List<NfeDetEspecificoMedicamentoModel>? nfeDetEspecificoMedicamentoModelList) { 
		List<NfeDetEspecificoMedicamentoGrouped> nfeDetEspecificoMedicamentoGroupedList = [];
		if (nfeDetEspecificoMedicamentoModelList != null) {
			for (var nfeDetEspecificoMedicamentoModel in nfeDetEspecificoMedicamentoModelList) {
				nfeDetEspecificoMedicamentoGroupedList.add(
					NfeDetEspecificoMedicamentoGrouped(
						nfeDetEspecificoMedicamento: NfeDetEspecificoMedicamento(
							id: nfeDetEspecificoMedicamentoModel.id,
							idNfeDetalhe: nfeDetEspecificoMedicamentoModel.idNfeDetalhe,
							codigoAnvisa: nfeDetEspecificoMedicamentoModel.codigoAnvisa,
							motivoIsencao: nfeDetEspecificoMedicamentoModel.motivoIsencao,
							precoMaximoConsumidor: nfeDetEspecificoMedicamentoModel.precoMaximoConsumidor,
						),
					),
				);
			}
			return nfeDetEspecificoMedicamentoGroupedList;
		}
		return [];
	}

	List<NfeDetEspecificoArmamentoGrouped> nfeDetEspecificoArmamentoModelToDrift(List<NfeDetEspecificoArmamentoModel>? nfeDetEspecificoArmamentoModelList) { 
		List<NfeDetEspecificoArmamentoGrouped> nfeDetEspecificoArmamentoGroupedList = [];
		if (nfeDetEspecificoArmamentoModelList != null) {
			for (var nfeDetEspecificoArmamentoModel in nfeDetEspecificoArmamentoModelList) {
				nfeDetEspecificoArmamentoGroupedList.add(
					NfeDetEspecificoArmamentoGrouped(
						nfeDetEspecificoArmamento: NfeDetEspecificoArmamento(
							id: nfeDetEspecificoArmamentoModel.id,
							idNfeDetalhe: nfeDetEspecificoArmamentoModel.idNfeDetalhe,
							tipoArma: NfeDetEspecificoArmamentoDomain.setTipoArma(nfeDetEspecificoArmamentoModel.tipoArma),
							numeroSerieArma: nfeDetEspecificoArmamentoModel.numeroSerieArma,
							numeroSerieCano: nfeDetEspecificoArmamentoModel.numeroSerieCano,
							descricao: nfeDetEspecificoArmamentoModel.descricao,
						),
					),
				);
			}
			return nfeDetEspecificoArmamentoGroupedList;
		}
		return [];
	}

	List<NfeDetEspecificoCombustivelGrouped> nfeDetEspecificoCombustivelModelToDrift(List<NfeDetEspecificoCombustivelModel>? nfeDetEspecificoCombustivelModelList) { 
		List<NfeDetEspecificoCombustivelGrouped> nfeDetEspecificoCombustivelGroupedList = [];
		if (nfeDetEspecificoCombustivelModelList != null) {
			for (var nfeDetEspecificoCombustivelModel in nfeDetEspecificoCombustivelModelList) {
				nfeDetEspecificoCombustivelGroupedList.add(
					NfeDetEspecificoCombustivelGrouped(
						nfeDetEspecificoCombustivel: NfeDetEspecificoCombustivel(
							id: nfeDetEspecificoCombustivelModel.id,
							idNfeDetalhe: nfeDetEspecificoCombustivelModel.idNfeDetalhe,
							codigoAnp: nfeDetEspecificoCombustivelModel.codigoAnp,
							descricaoAnp: nfeDetEspecificoCombustivelModel.descricaoAnp,
							percentualGlp: nfeDetEspecificoCombustivelModel.percentualGlp,
							percentualGasNacional: nfeDetEspecificoCombustivelModel.percentualGasNacional,
							percentualGasImportado: nfeDetEspecificoCombustivelModel.percentualGasImportado,
							valorPartida: nfeDetEspecificoCombustivelModel.valorPartida,
							codif: nfeDetEspecificoCombustivelModel.codif,
							quantidadeTempAmbiente: nfeDetEspecificoCombustivelModel.quantidadeTempAmbiente,
							ufConsumo: NfeDetEspecificoCombustivelDomain.setUfConsumo(nfeDetEspecificoCombustivelModel.ufConsumo),
							cideBaseCalculo: nfeDetEspecificoCombustivelModel.cideBaseCalculo,
							cideAliquota: nfeDetEspecificoCombustivelModel.cideAliquota,
							cideValor: nfeDetEspecificoCombustivelModel.cideValor,
							encerranteBico: nfeDetEspecificoCombustivelModel.encerranteBico,
							encerranteBomba: nfeDetEspecificoCombustivelModel.encerranteBomba,
							encerranteTanque: nfeDetEspecificoCombustivelModel.encerranteTanque,
							encerranteValorInicio: nfeDetEspecificoCombustivelModel.encerranteValorInicio,
							encerranteValorFim: nfeDetEspecificoCombustivelModel.encerranteValorFim,
						),
					),
				);
			}
			return nfeDetEspecificoCombustivelGroupedList;
		}
		return [];
	}

	List<NfeDeclaracaoImportacaoGrouped> nfeDeclaracaoImportacaoModelToDrift(List<NfeDeclaracaoImportacaoModel>? nfeDeclaracaoImportacaoModelList) { 
		List<NfeDeclaracaoImportacaoGrouped> nfeDeclaracaoImportacaoGroupedList = [];
		if (nfeDeclaracaoImportacaoModelList != null) {
			for (var nfeDeclaracaoImportacaoModel in nfeDeclaracaoImportacaoModelList) {
				nfeDeclaracaoImportacaoGroupedList.add(
					NfeDeclaracaoImportacaoGrouped(
						nfeDeclaracaoImportacao: NfeDeclaracaoImportacao(
							id: nfeDeclaracaoImportacaoModel.id,
							idNfeDetalhe: nfeDeclaracaoImportacaoModel.idNfeDetalhe,
							numeroDocumento: nfeDeclaracaoImportacaoModel.numeroDocumento,
							dataRegistro: nfeDeclaracaoImportacaoModel.dataRegistro,
							localDesembaraco: nfeDeclaracaoImportacaoModel.localDesembaraco,
							ufDesembaraco: NfeDeclaracaoImportacaoDomain.setUfDesembaraco(nfeDeclaracaoImportacaoModel.ufDesembaraco),
							dataDesembaraco: nfeDeclaracaoImportacaoModel.dataDesembaraco,
							viaTransporte: NfeDeclaracaoImportacaoDomain.setViaTransporte(nfeDeclaracaoImportacaoModel.viaTransporte),
							valorAfrmm: nfeDeclaracaoImportacaoModel.valorAfrmm,
							formaIntermediacao: NfeDeclaracaoImportacaoDomain.setFormaIntermediacao(nfeDeclaracaoImportacaoModel.formaIntermediacao),
							cnpj: Util.removeMask(nfeDeclaracaoImportacaoModel.cnpj),
							ufTerceiro: NfeDeclaracaoImportacaoDomain.setUfTerceiro(nfeDeclaracaoImportacaoModel.ufTerceiro),
							codigoExportador: nfeDeclaracaoImportacaoModel.codigoExportador,
						),
					),
				);
			}
			return nfeDeclaracaoImportacaoGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoIcmsGrouped> nfeDetalheImpostoIcmsModelToDrift(List<NfeDetalheImpostoIcmsModel>? nfeDetalheImpostoIcmsModelList) { 
		List<NfeDetalheImpostoIcmsGrouped> nfeDetalheImpostoIcmsGroupedList = [];
		if (nfeDetalheImpostoIcmsModelList != null) {
			for (var nfeDetalheImpostoIcmsModel in nfeDetalheImpostoIcmsModelList) {
				nfeDetalheImpostoIcmsGroupedList.add(
					NfeDetalheImpostoIcmsGrouped(
						nfeDetalheImpostoIcms: NfeDetalheImpostoIcms(
							id: nfeDetalheImpostoIcmsModel.id,
							idNfeDetalhe: nfeDetalheImpostoIcmsModel.idNfeDetalhe,
							origemMercadoria: NfeDetalheImpostoIcmsDomain.setOrigemMercadoria(nfeDetalheImpostoIcmsModel.origemMercadoria),
							cstIcms: NfeDetalheImpostoIcmsDomain.setCstIcms(nfeDetalheImpostoIcmsModel.cstIcms),
							csosn: NfeDetalheImpostoIcmsDomain.setCsosn(nfeDetalheImpostoIcmsModel.csosn),
							modalidadeBcIcms: NfeDetalheImpostoIcmsDomain.setModalidadeBcIcms(nfeDetalheImpostoIcmsModel.modalidadeBcIcms),
							percentualReducaoBcIcms: nfeDetalheImpostoIcmsModel.percentualReducaoBcIcms,
							valorBcIcms: nfeDetalheImpostoIcmsModel.valorBcIcms,
							aliquotaIcms: nfeDetalheImpostoIcmsModel.aliquotaIcms,
							valorIcmsOperacao: nfeDetalheImpostoIcmsModel.valorIcmsOperacao,
							percentualDiferimento: nfeDetalheImpostoIcmsModel.percentualDiferimento,
							valorIcmsDiferido: nfeDetalheImpostoIcmsModel.valorIcmsDiferido,
							valorIcms: nfeDetalheImpostoIcmsModel.valorIcms,
							baseCalculoFcp: nfeDetalheImpostoIcmsModel.baseCalculoFcp,
							percentualFcp: nfeDetalheImpostoIcmsModel.percentualFcp,
							valorFcp: nfeDetalheImpostoIcmsModel.valorFcp,
							modalidadeBcIcmsSt: NfeDetalheImpostoIcmsDomain.setModalidadeBcIcmsSt(nfeDetalheImpostoIcmsModel.modalidadeBcIcmsSt),
							percentualMvaIcmsSt: nfeDetalheImpostoIcmsModel.percentualMvaIcmsSt,
							percentualReducaoBcIcmsSt: nfeDetalheImpostoIcmsModel.percentualReducaoBcIcmsSt,
							valorBaseCalculoIcmsSt: nfeDetalheImpostoIcmsModel.valorBaseCalculoIcmsSt,
							aliquotaIcmsSt: nfeDetalheImpostoIcmsModel.aliquotaIcmsSt,
							valorIcmsSt: nfeDetalheImpostoIcmsModel.valorIcmsSt,
							baseCalculoFcpSt: nfeDetalheImpostoIcmsModel.baseCalculoFcpSt,
							percentualFcpSt: nfeDetalheImpostoIcmsModel.percentualFcpSt,
							valorFcpSt: nfeDetalheImpostoIcmsModel.valorFcpSt,
							ufSt: NfeDetalheImpostoIcmsDomain.setUfSt(nfeDetalheImpostoIcmsModel.ufSt),
							percentualBcOperacaoPropria: nfeDetalheImpostoIcmsModel.percentualBcOperacaoPropria,
							valorBcIcmsStRetido: nfeDetalheImpostoIcmsModel.valorBcIcmsStRetido,
							aliquotaSuportadaConsumidor: nfeDetalheImpostoIcmsModel.aliquotaSuportadaConsumidor,
							valorIcmsSubstituto: nfeDetalheImpostoIcmsModel.valorIcmsSubstituto,
							valorIcmsStRetido: nfeDetalheImpostoIcmsModel.valorIcmsStRetido,
							baseCalculoFcpStRetido: nfeDetalheImpostoIcmsModel.baseCalculoFcpStRetido,
							percentualFcpStRetido: nfeDetalheImpostoIcmsModel.percentualFcpStRetido,
							valorFcpStRetido: nfeDetalheImpostoIcmsModel.valorFcpStRetido,
							motivoDesoneracaoIcms: NfeDetalheImpostoIcmsDomain.setMotivoDesoneracaoIcms(nfeDetalheImpostoIcmsModel.motivoDesoneracaoIcms),
							valorIcmsDesonerado: nfeDetalheImpostoIcmsModel.valorIcmsDesonerado,
							aliquotaCreditoIcmsSn: nfeDetalheImpostoIcmsModel.aliquotaCreditoIcmsSn,
							valorCreditoIcmsSn: nfeDetalheImpostoIcmsModel.valorCreditoIcmsSn,
							valorBcIcmsStDestino: nfeDetalheImpostoIcmsModel.valorBcIcmsStDestino,
							valorIcmsStDestino: nfeDetalheImpostoIcmsModel.valorIcmsStDestino,
							percentualReducaoBcEfetivo: nfeDetalheImpostoIcmsModel.percentualReducaoBcEfetivo,
							valorBcEfetivo: nfeDetalheImpostoIcmsModel.valorBcEfetivo,
							aliquotaIcmsEfetivo: nfeDetalheImpostoIcmsModel.aliquotaIcmsEfetivo,
							valorIcmsEfetivo: nfeDetalheImpostoIcmsModel.valorIcmsEfetivo,
						),
					),
				);
			}
			return nfeDetalheImpostoIcmsGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoIpiGrouped> nfeDetalheImpostoIpiModelToDrift(List<NfeDetalheImpostoIpiModel>? nfeDetalheImpostoIpiModelList) { 
		List<NfeDetalheImpostoIpiGrouped> nfeDetalheImpostoIpiGroupedList = [];
		if (nfeDetalheImpostoIpiModelList != null) {
			for (var nfeDetalheImpostoIpiModel in nfeDetalheImpostoIpiModelList) {
				nfeDetalheImpostoIpiGroupedList.add(
					NfeDetalheImpostoIpiGrouped(
						nfeDetalheImpostoIpi: NfeDetalheImpostoIpi(
							id: nfeDetalheImpostoIpiModel.id,
							idNfeDetalhe: nfeDetalheImpostoIpiModel.idNfeDetalhe,
							cnpjProdutor: Util.removeMask(nfeDetalheImpostoIpiModel.cnpjProdutor),
							codigoSeloIpi: nfeDetalheImpostoIpiModel.codigoSeloIpi,
							quantidadeSeloIpi: nfeDetalheImpostoIpiModel.quantidadeSeloIpi,
							enquadramentoLegalIpi: NfeDetalheImpostoIpiDomain.setEnquadramentoLegalIpi(nfeDetalheImpostoIpiModel.enquadramentoLegalIpi),
							cstIpi: NfeDetalheImpostoIpiDomain.setCstIpi(nfeDetalheImpostoIpiModel.cstIpi),
							valorBaseCalculoIpi: nfeDetalheImpostoIpiModel.valorBaseCalculoIpi,
							quantidadeUnidadeTributavel: nfeDetalheImpostoIpiModel.quantidadeUnidadeTributavel,
							valorUnidadeTributavel: nfeDetalheImpostoIpiModel.valorUnidadeTributavel,
							aliquotaIpi: nfeDetalheImpostoIpiModel.aliquotaIpi,
							valorIpi: nfeDetalheImpostoIpiModel.valorIpi,
						),
					),
				);
			}
			return nfeDetalheImpostoIpiGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoIiGrouped> nfeDetalheImpostoIiModelToDrift(List<NfeDetalheImpostoIiModel>? nfeDetalheImpostoIiModelList) { 
		List<NfeDetalheImpostoIiGrouped> nfeDetalheImpostoIiGroupedList = [];
		if (nfeDetalheImpostoIiModelList != null) {
			for (var nfeDetalheImpostoIiModel in nfeDetalheImpostoIiModelList) {
				nfeDetalheImpostoIiGroupedList.add(
					NfeDetalheImpostoIiGrouped(
						nfeDetalheImpostoIi: NfeDetalheImpostoIi(
							id: nfeDetalheImpostoIiModel.id,
							idNfeDetalhe: nfeDetalheImpostoIiModel.idNfeDetalhe,
							valorBcIi: nfeDetalheImpostoIiModel.valorBcIi,
							valorDespesasAduaneiras: nfeDetalheImpostoIiModel.valorDespesasAduaneiras,
							valorImpostoImportacao: nfeDetalheImpostoIiModel.valorImpostoImportacao,
							valorIof: nfeDetalheImpostoIiModel.valorIof,
						),
					),
				);
			}
			return nfeDetalheImpostoIiGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoPisGrouped> nfeDetalheImpostoPisModelToDrift(List<NfeDetalheImpostoPisModel>? nfeDetalheImpostoPisModelList) { 
		List<NfeDetalheImpostoPisGrouped> nfeDetalheImpostoPisGroupedList = [];
		if (nfeDetalheImpostoPisModelList != null) {
			for (var nfeDetalheImpostoPisModel in nfeDetalheImpostoPisModelList) {
				nfeDetalheImpostoPisGroupedList.add(
					NfeDetalheImpostoPisGrouped(
						nfeDetalheImpostoPis: NfeDetalheImpostoPis(
							id: nfeDetalheImpostoPisModel.id,
							idNfeDetalhe: nfeDetalheImpostoPisModel.idNfeDetalhe,
							cstPis: NfeDetalheImpostoPisDomain.setCstPis(nfeDetalheImpostoPisModel.cstPis),
							valorBaseCalculoPis: nfeDetalheImpostoPisModel.valorBaseCalculoPis,
							aliquotaPisPercentual: nfeDetalheImpostoPisModel.aliquotaPisPercentual,
							valorPis: nfeDetalheImpostoPisModel.valorPis,
							quantidadeVendida: nfeDetalheImpostoPisModel.quantidadeVendida,
							aliquotaPisReais: nfeDetalheImpostoPisModel.aliquotaPisReais,
						),
					),
				);
			}
			return nfeDetalheImpostoPisGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoCofinsGrouped> nfeDetalheImpostoCofinsModelToDrift(List<NfeDetalheImpostoCofinsModel>? nfeDetalheImpostoCofinsModelList) { 
		List<NfeDetalheImpostoCofinsGrouped> nfeDetalheImpostoCofinsGroupedList = [];
		if (nfeDetalheImpostoCofinsModelList != null) {
			for (var nfeDetalheImpostoCofinsModel in nfeDetalheImpostoCofinsModelList) {
				nfeDetalheImpostoCofinsGroupedList.add(
					NfeDetalheImpostoCofinsGrouped(
						nfeDetalheImpostoCofins: NfeDetalheImpostoCofins(
							id: nfeDetalheImpostoCofinsModel.id,
							idNfeDetalhe: nfeDetalheImpostoCofinsModel.idNfeDetalhe,
							cstCofins: NfeDetalheImpostoCofinsDomain.setCstCofins(nfeDetalheImpostoCofinsModel.cstCofins),
							baseCalculoCofins: nfeDetalheImpostoCofinsModel.baseCalculoCofins,
							aliquotaCofinsPercentual: nfeDetalheImpostoCofinsModel.aliquotaCofinsPercentual,
							quantidadeVendida: nfeDetalheImpostoCofinsModel.quantidadeVendida,
							aliquotaCofinsReais: nfeDetalheImpostoCofinsModel.aliquotaCofinsReais,
							valorCofins: nfeDetalheImpostoCofinsModel.valorCofins,
						),
					),
				);
			}
			return nfeDetalheImpostoCofinsGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoIssqnGrouped> nfeDetalheImpostoIssqnModelToDrift(List<NfeDetalheImpostoIssqnModel>? nfeDetalheImpostoIssqnModelList) { 
		List<NfeDetalheImpostoIssqnGrouped> nfeDetalheImpostoIssqnGroupedList = [];
		if (nfeDetalheImpostoIssqnModelList != null) {
			for (var nfeDetalheImpostoIssqnModel in nfeDetalheImpostoIssqnModelList) {
				nfeDetalheImpostoIssqnGroupedList.add(
					NfeDetalheImpostoIssqnGrouped(
						nfeDetalheImpostoIssqn: NfeDetalheImpostoIssqn(
							id: nfeDetalheImpostoIssqnModel.id,
							idNfeDetalhe: nfeDetalheImpostoIssqnModel.idNfeDetalhe,
							baseCalculoIssqn: nfeDetalheImpostoIssqnModel.baseCalculoIssqn,
							aliquotaIssqn: nfeDetalheImpostoIssqnModel.aliquotaIssqn,
							valorIssqn: nfeDetalheImpostoIssqnModel.valorIssqn,
							municipioIssqn: nfeDetalheImpostoIssqnModel.municipioIssqn,
							itemListaServicos: nfeDetalheImpostoIssqnModel.itemListaServicos,
							valorDeducao: nfeDetalheImpostoIssqnModel.valorDeducao,
							valorOutrasRetencoes: nfeDetalheImpostoIssqnModel.valorOutrasRetencoes,
							valorDescontoIncondicionado: nfeDetalheImpostoIssqnModel.valorDescontoIncondicionado,
							valorDescontoCondicionado: nfeDetalheImpostoIssqnModel.valorDescontoCondicionado,
							valorRetencaoIss: nfeDetalheImpostoIssqnModel.valorRetencaoIss,
							indicadorExigibilidadeIss: NfeDetalheImpostoIssqnDomain.setIndicadorExigibilidadeIss(nfeDetalheImpostoIssqnModel.indicadorExigibilidadeIss),
							codigoServico: nfeDetalheImpostoIssqnModel.codigoServico,
							municipioIncidencia: nfeDetalheImpostoIssqnModel.municipioIncidencia,
							paisSevicoPrestado: nfeDetalheImpostoIssqnModel.paisSevicoPrestado,
							numeroProcesso: nfeDetalheImpostoIssqnModel.numeroProcesso,
							indicadorIncentivoFiscal: NfeDetalheImpostoIssqnDomain.setIndicadorIncentivoFiscal(nfeDetalheImpostoIssqnModel.indicadorIncentivoFiscal),
						),
					),
				);
			}
			return nfeDetalheImpostoIssqnGroupedList;
		}
		return [];
	}

	List<NfeExportacaoGrouped> nfeExportacaoModelToDrift(List<NfeExportacaoModel>? nfeExportacaoModelList) { 
		List<NfeExportacaoGrouped> nfeExportacaoGroupedList = [];
		if (nfeExportacaoModelList != null) {
			for (var nfeExportacaoModel in nfeExportacaoModelList) {
				nfeExportacaoGroupedList.add(
					NfeExportacaoGrouped(
						nfeExportacao: NfeExportacao(
							id: nfeExportacaoModel.id,
							idNfeDetalhe: nfeExportacaoModel.idNfeDetalhe,
							drawback: nfeExportacaoModel.drawback,
							numeroRegistro: nfeExportacaoModel.numeroRegistro,
							chaveAcesso: nfeExportacaoModel.chaveAcesso,
							quantidade: nfeExportacaoModel.quantidade,
						),
					),
				);
			}
			return nfeExportacaoGroupedList;
		}
		return [];
	}

	List<NfeItemRastreadoGrouped> nfeItemRastreadoModelToDrift(List<NfeItemRastreadoModel>? nfeItemRastreadoModelList) { 
		List<NfeItemRastreadoGrouped> nfeItemRastreadoGroupedList = [];
		if (nfeItemRastreadoModelList != null) {
			for (var nfeItemRastreadoModel in nfeItemRastreadoModelList) {
				nfeItemRastreadoGroupedList.add(
					NfeItemRastreadoGrouped(
						nfeItemRastreado: NfeItemRastreado(
							id: nfeItemRastreadoModel.id,
							idNfeDetalhe: nfeItemRastreadoModel.idNfeDetalhe,
							numeroLote: nfeItemRastreadoModel.numeroLote,
							quantidadeItens: nfeItemRastreadoModel.quantidadeItens,
							dataFabricacao: nfeItemRastreadoModel.dataFabricacao,
							dataValidade: nfeItemRastreadoModel.dataValidade,
							codigoAgregacao: nfeItemRastreadoModel.codigoAgregacao,
						),
					),
				);
			}
			return nfeItemRastreadoGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoPisStGrouped> nfeDetalheImpostoPisStModelToDrift(List<NfeDetalheImpostoPisStModel>? nfeDetalheImpostoPisStModelList) { 
		List<NfeDetalheImpostoPisStGrouped> nfeDetalheImpostoPisStGroupedList = [];
		if (nfeDetalheImpostoPisStModelList != null) {
			for (var nfeDetalheImpostoPisStModel in nfeDetalheImpostoPisStModelList) {
				nfeDetalheImpostoPisStGroupedList.add(
					NfeDetalheImpostoPisStGrouped(
						nfeDetalheImpostoPisSt: NfeDetalheImpostoPisSt(
							id: nfeDetalheImpostoPisStModel.id,
							idNfeDetalhe: nfeDetalheImpostoPisStModel.idNfeDetalhe,
							valorBaseCalculoPisSt: nfeDetalheImpostoPisStModel.valorBaseCalculoPisSt,
							aliquotaPisStPercentual: nfeDetalheImpostoPisStModel.aliquotaPisStPercentual,
							quantidadeVendidaPisSt: nfeDetalheImpostoPisStModel.quantidadeVendidaPisSt,
							aliquotaPisStReais: nfeDetalheImpostoPisStModel.aliquotaPisStReais,
							valorPisSt: nfeDetalheImpostoPisStModel.valorPisSt,
						),
					),
				);
			}
			return nfeDetalheImpostoPisStGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoIcmsUfdestGrouped> nfeDetalheImpostoIcmsUfdestModelToDrift(List<NfeDetalheImpostoIcmsUfdestModel>? nfeDetalheImpostoIcmsUfdestModelList) { 
		List<NfeDetalheImpostoIcmsUfdestGrouped> nfeDetalheImpostoIcmsUfdestGroupedList = [];
		if (nfeDetalheImpostoIcmsUfdestModelList != null) {
			for (var nfeDetalheImpostoIcmsUfdestModel in nfeDetalheImpostoIcmsUfdestModelList) {
				nfeDetalheImpostoIcmsUfdestGroupedList.add(
					NfeDetalheImpostoIcmsUfdestGrouped(
						nfeDetalheImpostoIcmsUfdest: NfeDetalheImpostoIcmsUfdest(
							id: nfeDetalheImpostoIcmsUfdestModel.id,
							idNfeDetalhe: nfeDetalheImpostoIcmsUfdestModel.idNfeDetalhe,
							valorBcIcmsUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorBcIcmsUfDestino,
							valorBcFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorBcFcpUfDestino,
							percentualFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.percentualFcpUfDestino,
							aliquotaInternaUfDestino: nfeDetalheImpostoIcmsUfdestModel.aliquotaInternaUfDestino,
							aliquotaInteresdatualUfEnvolvidas: nfeDetalheImpostoIcmsUfdestModel.aliquotaInteresdatualUfEnvolvidas,
							percentualProvisorioPartilhaIcms: nfeDetalheImpostoIcmsUfdestModel.percentualProvisorioPartilhaIcms,
							valorIcmsFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorIcmsFcpUfDestino,
							valorInterestadualUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfDestino,
							valorInterestadualUfRemetente: nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfRemetente,
						),
					),
				);
			}
			return nfeDetalheImpostoIcmsUfdestGroupedList;
		}
		return [];
	}

	List<NfeDetalheImpostoCofinsStGrouped> nfeDetalheImpostoCofinsStModelToDrift(List<NfeDetalheImpostoCofinsStModel>? nfeDetalheImpostoCofinsStModelList) { 
		List<NfeDetalheImpostoCofinsStGrouped> nfeDetalheImpostoCofinsStGroupedList = [];
		if (nfeDetalheImpostoCofinsStModelList != null) {
			for (var nfeDetalheImpostoCofinsStModel in nfeDetalheImpostoCofinsStModelList) {
				nfeDetalheImpostoCofinsStGroupedList.add(
					NfeDetalheImpostoCofinsStGrouped(
						nfeDetalheImpostoCofinsSt: NfeDetalheImpostoCofinsSt(
							id: nfeDetalheImpostoCofinsStModel.id,
							idNfeDetalhe: nfeDetalheImpostoCofinsStModel.idNfeDetalhe,
							baseCalculoCofinsSt: nfeDetalheImpostoCofinsStModel.baseCalculoCofinsSt,
							aliquotaCofinsStPercentual: nfeDetalheImpostoCofinsStModel.aliquotaCofinsStPercentual,
							quantidadeVendidaCofinsSt: nfeDetalheImpostoCofinsStModel.quantidadeVendidaCofinsSt,
							aliquotaCofinsStReais: nfeDetalheImpostoCofinsStModel.aliquotaCofinsStReais,
							valorCofinsSt: nfeDetalheImpostoCofinsStModel.valorCofinsSt,
						),
					),
				);
			}
			return nfeDetalheImpostoCofinsStGroupedList;
		}
		return [];
	}

		
}
