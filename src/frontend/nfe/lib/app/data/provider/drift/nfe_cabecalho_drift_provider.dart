import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeCabecalhoDriftProvider extends ProviderBase {

	Future<List<NfeCabecalhoModel>?> getList({Filter? filter}) async {
		List<NfeCabecalhoGrouped> nfeCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeCabecalhoDriftList = await Session.database.nfeCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeCabecalhoDriftList = await Session.database.nfeCabecalhoDao.getGroupedList(); 
			}
			if (nfeCabecalhoDriftList.isNotEmpty) {
				return toListModel(nfeCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCabecalhoModel?>? insert(NfeCabecalhoModel nfeCabecalhoModel) async {
		try {
			final lastPk = await Session.database.nfeCabecalhoDao.insertObject(toDrift(nfeCabecalhoModel));
			nfeCabecalhoModel.id = lastPk;
			return nfeCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCabecalhoModel?>? update(NfeCabecalhoModel nfeCabecalhoModel) async {
		try {
			await Session.database.nfeCabecalhoDao.updateObject(toDrift(nfeCabecalhoModel));
			return nfeCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeCabecalhoDao.deleteObject(toDrift(NfeCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeCabecalhoModel> toListModel(List<NfeCabecalhoGrouped> nfeCabecalhoDriftList) {
		List<NfeCabecalhoModel> listModel = [];
		for (var nfeCabecalhoDrift in nfeCabecalhoDriftList) {
			listModel.add(toModel(nfeCabecalhoDrift)!);
		}
		return listModel;
	}	

	NfeCabecalhoModel? toModel(NfeCabecalhoGrouped? nfeCabecalhoDrift) {
		if (nfeCabecalhoDrift != null) {
			return NfeCabecalhoModel(
				id: nfeCabecalhoDrift.nfeCabecalho?.id,
				idVendaCabecalho: nfeCabecalhoDrift.nfeCabecalho?.idVendaCabecalho,
				idTributOperacaoFiscal: nfeCabecalhoDrift.nfeCabecalho?.idTributOperacaoFiscal,
				idCliente: nfeCabecalhoDrift.nfeCabecalho?.idCliente,
				idColaborador: nfeCabecalhoDrift.nfeCabecalho?.idColaborador,
				idFornecedor: nfeCabecalhoDrift.nfeCabecalho?.idFornecedor,
				ufEmitente: NfeCabecalhoDomain.getUfEmitente(nfeCabecalhoDrift.nfeCabecalho?.ufEmitente),
				codigoNumerico: nfeCabecalhoDrift.nfeCabecalho?.codigoNumerico,
				naturezaOperacao: nfeCabecalhoDrift.nfeCabecalho?.naturezaOperacao,
				codigoModelo: NfeCabecalhoDomain.getCodigoModelo(nfeCabecalhoDrift.nfeCabecalho?.codigoModelo),
				serie: nfeCabecalhoDrift.nfeCabecalho?.serie,
				numero: nfeCabecalhoDrift.nfeCabecalho?.numero,
				dataHoraEmissao: nfeCabecalhoDrift.nfeCabecalho?.dataHoraEmissao,
				dataHoraEntradaSaida: nfeCabecalhoDrift.nfeCabecalho?.dataHoraEntradaSaida,
				tipoOperacao: NfeCabecalhoDomain.getTipoOperacao(nfeCabecalhoDrift.nfeCabecalho?.tipoOperacao),
				localDestino: NfeCabecalhoDomain.getLocalDestino(nfeCabecalhoDrift.nfeCabecalho?.localDestino),
				codigoMunicipio: nfeCabecalhoDrift.nfeCabecalho?.codigoMunicipio,
				formatoImpressaoDanfe: NfeCabecalhoDomain.getFormatoImpressaoDanfe(nfeCabecalhoDrift.nfeCabecalho?.formatoImpressaoDanfe),
				tipoEmissao: NfeCabecalhoDomain.getTipoEmissao(nfeCabecalhoDrift.nfeCabecalho?.tipoEmissao),
				chaveAcesso: nfeCabecalhoDrift.nfeCabecalho?.chaveAcesso,
				digitoChaveAcesso: nfeCabecalhoDrift.nfeCabecalho?.digitoChaveAcesso,
				ambiente: NfeCabecalhoDomain.getAmbiente(nfeCabecalhoDrift.nfeCabecalho?.ambiente),
				finalidadeEmissao: NfeCabecalhoDomain.getFinalidadeEmissao(nfeCabecalhoDrift.nfeCabecalho?.finalidadeEmissao),
				consumidorOperacao: NfeCabecalhoDomain.getConsumidorOperacao(nfeCabecalhoDrift.nfeCabecalho?.consumidorOperacao),
				consumidorPresenca: NfeCabecalhoDomain.getConsumidorPresenca(nfeCabecalhoDrift.nfeCabecalho?.consumidorPresenca),
				processoEmissao: NfeCabecalhoDomain.getProcessoEmissao(nfeCabecalhoDrift.nfeCabecalho?.processoEmissao),
				versaoProcessoEmissao: nfeCabecalhoDrift.nfeCabecalho?.versaoProcessoEmissao,
				dataEntradaContingencia: nfeCabecalhoDrift.nfeCabecalho?.dataEntradaContingencia,
				justificativaContingencia: nfeCabecalhoDrift.nfeCabecalho?.justificativaContingencia,
				baseCalculoIcms: nfeCabecalhoDrift.nfeCabecalho?.baseCalculoIcms,
				valorIcms: nfeCabecalhoDrift.nfeCabecalho?.valorIcms,
				valorIcmsDesonerado: nfeCabecalhoDrift.nfeCabecalho?.valorIcmsDesonerado,
				totalIcmsFcpUfDestino: nfeCabecalhoDrift.nfeCabecalho?.totalIcmsFcpUfDestino,
				totalIcmsInterestadualUfDestino: nfeCabecalhoDrift.nfeCabecalho?.totalIcmsInterestadualUfDestino,
				totalIcmsInterestadualUfRemetente: nfeCabecalhoDrift.nfeCabecalho?.totalIcmsInterestadualUfRemetente,
				valorTotalFcp: nfeCabecalhoDrift.nfeCabecalho?.valorTotalFcp,
				baseCalculoIcmsSt: nfeCabecalhoDrift.nfeCabecalho?.baseCalculoIcmsSt,
				valorIcmsSt: nfeCabecalhoDrift.nfeCabecalho?.valorIcmsSt,
				valorTotalFcpSt: nfeCabecalhoDrift.nfeCabecalho?.valorTotalFcpSt,
				valorTotalFcpStRetido: nfeCabecalhoDrift.nfeCabecalho?.valorTotalFcpStRetido,
				valorTotalProdutos: nfeCabecalhoDrift.nfeCabecalho?.valorTotalProdutos,
				valorFrete: nfeCabecalhoDrift.nfeCabecalho?.valorFrete,
				valorSeguro: nfeCabecalhoDrift.nfeCabecalho?.valorSeguro,
				valorDesconto: nfeCabecalhoDrift.nfeCabecalho?.valorDesconto,
				valorImpostoImportacao: nfeCabecalhoDrift.nfeCabecalho?.valorImpostoImportacao,
				valorIpi: nfeCabecalhoDrift.nfeCabecalho?.valorIpi,
				valorIpiDevolvido: nfeCabecalhoDrift.nfeCabecalho?.valorIpiDevolvido,
				valorPis: nfeCabecalhoDrift.nfeCabecalho?.valorPis,
				valorCofins: nfeCabecalhoDrift.nfeCabecalho?.valorCofins,
				valorDespesasAcessorias: nfeCabecalhoDrift.nfeCabecalho?.valorDespesasAcessorias,
				valorTotal: nfeCabecalhoDrift.nfeCabecalho?.valorTotal,
				valorTotalTributos: nfeCabecalhoDrift.nfeCabecalho?.valorTotalTributos,
				valorServicos: nfeCabecalhoDrift.nfeCabecalho?.valorServicos,
				baseCalculoIssqn: nfeCabecalhoDrift.nfeCabecalho?.baseCalculoIssqn,
				valorIssqn: nfeCabecalhoDrift.nfeCabecalho?.valorIssqn,
				valorPisIssqn: nfeCabecalhoDrift.nfeCabecalho?.valorPisIssqn,
				valorCofinsIssqn: nfeCabecalhoDrift.nfeCabecalho?.valorCofinsIssqn,
				dataPrestacaoServico: nfeCabecalhoDrift.nfeCabecalho?.dataPrestacaoServico,
				valorDeducaoIssqn: nfeCabecalhoDrift.nfeCabecalho?.valorDeducaoIssqn,
				outrasRetencoesIssqn: nfeCabecalhoDrift.nfeCabecalho?.outrasRetencoesIssqn,
				descontoIncondicionadoIssqn: nfeCabecalhoDrift.nfeCabecalho?.descontoIncondicionadoIssqn,
				descontoCondicionadoIssqn: nfeCabecalhoDrift.nfeCabecalho?.descontoCondicionadoIssqn,
				totalRetencaoIssqn: nfeCabecalhoDrift.nfeCabecalho?.totalRetencaoIssqn,
				regimeEspecialTributacao: NfeCabecalhoDomain.getRegimeEspecialTributacao(nfeCabecalhoDrift.nfeCabecalho?.regimeEspecialTributacao),
				valorRetidoPis: nfeCabecalhoDrift.nfeCabecalho?.valorRetidoPis,
				valorRetidoCofins: nfeCabecalhoDrift.nfeCabecalho?.valorRetidoCofins,
				valorRetidoCsll: nfeCabecalhoDrift.nfeCabecalho?.valorRetidoCsll,
				baseCalculoIrrf: nfeCabecalhoDrift.nfeCabecalho?.baseCalculoIrrf,
				valorRetidoIrrf: nfeCabecalhoDrift.nfeCabecalho?.valorRetidoIrrf,
				baseCalculoPrevidencia: nfeCabecalhoDrift.nfeCabecalho?.baseCalculoPrevidencia,
				valorRetidoPrevidencia: nfeCabecalhoDrift.nfeCabecalho?.valorRetidoPrevidencia,
				informacoesAddFisco: nfeCabecalhoDrift.nfeCabecalho?.informacoesAddFisco,
				informacoesAddContribuinte: nfeCabecalhoDrift.nfeCabecalho?.informacoesAddContribuinte,
				comexUfEmbarque: NfeCabecalhoDomain.getComexUfEmbarque(nfeCabecalhoDrift.nfeCabecalho?.comexUfEmbarque),
				comexLocalEmbarque: nfeCabecalhoDrift.nfeCabecalho?.comexLocalEmbarque,
				comexLocalDespacho: nfeCabecalhoDrift.nfeCabecalho?.comexLocalDespacho,
				compraNotaEmpenho: nfeCabecalhoDrift.nfeCabecalho?.compraNotaEmpenho,
				compraPedido: nfeCabecalhoDrift.nfeCabecalho?.compraPedido,
				compraContrato: nfeCabecalhoDrift.nfeCabecalho?.compraContrato,
				qrcode: nfeCabecalhoDrift.nfeCabecalho?.qrcode,
				urlChave: nfeCabecalhoDrift.nfeCabecalho?.urlChave,
				statusNota: NfeCabecalhoDomain.getStatusNota(nfeCabecalhoDrift.nfeCabecalho?.statusNota),
				nfeReferenciadaModelList: nfeReferenciadaDriftToModel(nfeCabecalhoDrift.nfeReferenciadaGroupedList),
				nfeEmitenteModelList: nfeEmitenteDriftToModel(nfeCabecalhoDrift.nfeEmitenteGroupedList),
				nfeDestinatarioModelList: nfeDestinatarioDriftToModel(nfeCabecalhoDrift.nfeDestinatarioGroupedList),
				nfeLocalRetiradaModelList: nfeLocalRetiradaDriftToModel(nfeCabecalhoDrift.nfeLocalRetiradaGroupedList),
				nfeLocalEntregaModelList: nfeLocalEntregaDriftToModel(nfeCabecalhoDrift.nfeLocalEntregaGroupedList),
				nfeTransporteModelList: nfeTransporteDriftToModel(nfeCabecalhoDrift.nfeTransporteGroupedList),
				nfeFaturaModelList: nfeFaturaDriftToModel(nfeCabecalhoDrift.nfeFaturaGroupedList),
				nfeCanaModelList: nfeCanaDriftToModel(nfeCabecalhoDrift.nfeCanaGroupedList),
				nfeProdRuralReferenciadaModelList: nfeProdRuralReferenciadaDriftToModel(nfeCabecalhoDrift.nfeProdRuralReferenciadaGroupedList),
				nfeNfReferenciadaModelList: nfeNfReferenciadaDriftToModel(nfeCabecalhoDrift.nfeNfReferenciadaGroupedList),
				nfeProcessoReferenciadoModelList: nfeProcessoReferenciadoDriftToModel(nfeCabecalhoDrift.nfeProcessoReferenciadoGroupedList),
				nfeAcessoXmlModelList: nfeAcessoXmlDriftToModel(nfeCabecalhoDrift.nfeAcessoXmlGroupedList),
				nfeInformacaoPagamentoModelList: nfeInformacaoPagamentoDriftToModel(nfeCabecalhoDrift.nfeInformacaoPagamentoGroupedList),
				nfeResponsavelTecnicoModelList: nfeResponsavelTecnicoDriftToModel(nfeCabecalhoDrift.nfeResponsavelTecnicoGroupedList),
				tributOperacaoFiscalModel: TributOperacaoFiscalModel(
					id: nfeCabecalhoDrift.tributOperacaoFiscal?.id,
					descricao: nfeCabecalhoDrift.tributOperacaoFiscal?.descricao,
					descricaoNaNf: nfeCabecalhoDrift.tributOperacaoFiscal?.descricaoNaNf,
					cfop: nfeCabecalhoDrift.tributOperacaoFiscal?.cfop,
					observacao: nfeCabecalhoDrift.tributOperacaoFiscal?.observacao,
				),
				vendaCabecalhoModel: VendaCabecalhoModel(
					id: nfeCabecalhoDrift.vendaCabecalho?.id,
					idVendaOrcamentoCabecalho: nfeCabecalhoDrift.vendaCabecalho?.idVendaOrcamentoCabecalho,
					idVendaCondicoesPagamento: nfeCabecalhoDrift.vendaCabecalho?.idVendaCondicoesPagamento,
					idNotaFiscalTipo: nfeCabecalhoDrift.vendaCabecalho?.idNotaFiscalTipo,
					idTransportadora: nfeCabecalhoDrift.vendaCabecalho?.idTransportadora,
					dataVenda: nfeCabecalhoDrift.vendaCabecalho?.dataVenda,
					dataSaida: nfeCabecalhoDrift.vendaCabecalho?.dataSaida,
					horaSaida: nfeCabecalhoDrift.vendaCabecalho?.horaSaida,
					numeroFatura: nfeCabecalhoDrift.vendaCabecalho?.numeroFatura,
					localEntrega: nfeCabecalhoDrift.vendaCabecalho?.localEntrega,
					localCobranca: nfeCabecalhoDrift.vendaCabecalho?.localCobranca,
					valorSubtotal: nfeCabecalhoDrift.vendaCabecalho?.valorSubtotal,
					taxaComissao: nfeCabecalhoDrift.vendaCabecalho?.taxaComissao,
					valorComissao: nfeCabecalhoDrift.vendaCabecalho?.valorComissao,
					taxaDesconto: nfeCabecalhoDrift.vendaCabecalho?.taxaDesconto,
					valorDesconto: nfeCabecalhoDrift.vendaCabecalho?.valorDesconto,
					valorTotal: nfeCabecalhoDrift.vendaCabecalho?.valorTotal,
					tipoFrete: nfeCabecalhoDrift.vendaCabecalho?.tipoFrete,
					formaPagamento: nfeCabecalhoDrift.vendaCabecalho?.formaPagamento,
					valorFrete: nfeCabecalhoDrift.vendaCabecalho?.valorFrete,
					valorSeguro: nfeCabecalhoDrift.vendaCabecalho?.valorSeguro,
					observacao: nfeCabecalhoDrift.vendaCabecalho?.observacao,
					situacao: nfeCabecalhoDrift.vendaCabecalho?.situacao,
					diaFixoParcela: nfeCabecalhoDrift.vendaCabecalho?.diaFixoParcela,
				),
				viewPessoaClienteModel: ViewPessoaClienteModel(
					id: nfeCabecalhoDrift.viewPessoaCliente?.id,
					nome: nfeCabecalhoDrift.viewPessoaCliente?.nome,
					tipo: nfeCabecalhoDrift.viewPessoaCliente?.tipo,
					email: nfeCabecalhoDrift.viewPessoaCliente?.email,
					site: nfeCabecalhoDrift.viewPessoaCliente?.site,
					cpfCnpj: nfeCabecalhoDrift.viewPessoaCliente?.cpfCnpj,
					rgIe: nfeCabecalhoDrift.viewPessoaCliente?.rgIe,
					desde: nfeCabecalhoDrift.viewPessoaCliente?.desde,
					taxaDesconto: nfeCabecalhoDrift.viewPessoaCliente?.taxaDesconto,
					limiteCredito: nfeCabecalhoDrift.viewPessoaCliente?.limiteCredito,
					dataCadastro: nfeCabecalhoDrift.viewPessoaCliente?.dataCadastro,
					observacao: nfeCabecalhoDrift.viewPessoaCliente?.observacao,
					idPessoa: nfeCabecalhoDrift.viewPessoaCliente?.idPessoa,
				),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: nfeCabecalhoDrift.viewPessoaColaborador?.id,
					nome: nfeCabecalhoDrift.viewPessoaColaborador?.nome,
					tipo: nfeCabecalhoDrift.viewPessoaColaborador?.tipo,
					email: nfeCabecalhoDrift.viewPessoaColaborador?.email,
					site: nfeCabecalhoDrift.viewPessoaColaborador?.site,
					cpfCnpj: nfeCabecalhoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: nfeCabecalhoDrift.viewPessoaColaborador?.rgIe,
					matricula: nfeCabecalhoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: nfeCabecalhoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: nfeCabecalhoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: nfeCabecalhoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: nfeCabecalhoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: nfeCabecalhoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: nfeCabecalhoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: nfeCabecalhoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: nfeCabecalhoDrift.viewPessoaColaborador?.observacao,
					logradouro: nfeCabecalhoDrift.viewPessoaColaborador?.logradouro,
					numero: nfeCabecalhoDrift.viewPessoaColaborador?.numero,
					complemento: nfeCabecalhoDrift.viewPessoaColaborador?.complemento,
					bairro: nfeCabecalhoDrift.viewPessoaColaborador?.bairro,
					cidade: nfeCabecalhoDrift.viewPessoaColaborador?.cidade,
					cep: nfeCabecalhoDrift.viewPessoaColaborador?.cep,
					municipioIbge: nfeCabecalhoDrift.viewPessoaColaborador?.municipioIbge,
					uf: nfeCabecalhoDrift.viewPessoaColaborador?.uf,
					idPessoa: nfeCabecalhoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: nfeCabecalhoDrift.viewPessoaColaborador?.idCargo,
					idSetor: nfeCabecalhoDrift.viewPessoaColaborador?.idSetor,
				),
				viewPessoaFornecedorModel: ViewPessoaFornecedorModel(
					id: nfeCabecalhoDrift.viewPessoaFornecedor?.id,
					nome: nfeCabecalhoDrift.viewPessoaFornecedor?.nome,
					tipo: nfeCabecalhoDrift.viewPessoaFornecedor?.tipo,
					email: nfeCabecalhoDrift.viewPessoaFornecedor?.email,
					site: nfeCabecalhoDrift.viewPessoaFornecedor?.site,
					cpfCnpj: nfeCabecalhoDrift.viewPessoaFornecedor?.cpfCnpj,
					rgIe: nfeCabecalhoDrift.viewPessoaFornecedor?.rgIe,
					desde: nfeCabecalhoDrift.viewPessoaFornecedor?.desde,
					dataCadastro: nfeCabecalhoDrift.viewPessoaFornecedor?.dataCadastro,
					observacao: nfeCabecalhoDrift.viewPessoaFornecedor?.observacao,
					idPessoa: nfeCabecalhoDrift.viewPessoaFornecedor?.idPessoa,
				),
				nfeCteReferenciadoModelList: nfeCteReferenciadoDriftToModel(nfeCabecalhoDrift.nfeCteReferenciadoGroupedList),
				nfeCupomFiscalReferenciadoModelList: nfeCupomFiscalReferenciadoDriftToModel(nfeCabecalhoDrift.nfeCupomFiscalReferenciadoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<NfeReferenciadaModel> nfeReferenciadaDriftToModel(List<NfeReferenciadaGrouped>? nfeReferenciadaDriftList) { 
		List<NfeReferenciadaModel> nfeReferenciadaModelList = [];
		if (nfeReferenciadaDriftList != null) {
			for (var nfeReferenciadaGrouped in nfeReferenciadaDriftList) {
				nfeReferenciadaModelList.add(
					NfeReferenciadaModel(
						id: nfeReferenciadaGrouped.nfeReferenciada?.id,
						idNfeCabecalho: nfeReferenciadaGrouped.nfeReferenciada?.idNfeCabecalho,
						chaveAcesso: nfeReferenciadaGrouped.nfeReferenciada?.chaveAcesso,
					)
				);
			}
			return nfeReferenciadaModelList;
		}
		return [];
	}

	List<NfeEmitenteModel> nfeEmitenteDriftToModel(List<NfeEmitenteGrouped>? nfeEmitenteDriftList) { 
		List<NfeEmitenteModel> nfeEmitenteModelList = [];
		if (nfeEmitenteDriftList != null) {
			for (var nfeEmitenteGrouped in nfeEmitenteDriftList) {
				nfeEmitenteModelList.add(
					NfeEmitenteModel(
						id: nfeEmitenteGrouped.nfeEmitente?.id,
						idNfeCabecalho: nfeEmitenteGrouped.nfeEmitente?.idNfeCabecalho,
						cnpj: nfeEmitenteGrouped.nfeEmitente?.cnpj,
						cpf: nfeEmitenteGrouped.nfeEmitente?.cpf,
						nome: nfeEmitenteGrouped.nfeEmitente?.nome,
						fantasia: nfeEmitenteGrouped.nfeEmitente?.fantasia,
						logradouro: nfeEmitenteGrouped.nfeEmitente?.logradouro,
						numero: nfeEmitenteGrouped.nfeEmitente?.numero,
						complemento: nfeEmitenteGrouped.nfeEmitente?.complemento,
						bairro: nfeEmitenteGrouped.nfeEmitente?.bairro,
						codigoMunicipio: nfeEmitenteGrouped.nfeEmitente?.codigoMunicipio,
						nomeMunicipio: nfeEmitenteGrouped.nfeEmitente?.nomeMunicipio,
						uf: NfeEmitenteDomain.getUf(nfeEmitenteGrouped.nfeEmitente?.uf),
						cep: nfeEmitenteGrouped.nfeEmitente?.cep,
						codigoPais: nfeEmitenteGrouped.nfeEmitente?.codigoPais,
						nomePais: nfeEmitenteGrouped.nfeEmitente?.nomePais,
						telefone: nfeEmitenteGrouped.nfeEmitente?.telefone,
						inscricaoEstadual: nfeEmitenteGrouped.nfeEmitente?.inscricaoEstadual,
						inscricaoEstadualSt: nfeEmitenteGrouped.nfeEmitente?.inscricaoEstadualSt,
						inscricaoMunicipal: nfeEmitenteGrouped.nfeEmitente?.inscricaoMunicipal,
						cnae: nfeEmitenteGrouped.nfeEmitente?.cnae,
						crt: NfeEmitenteDomain.getCrt(nfeEmitenteGrouped.nfeEmitente?.crt),
					)
				);
			}
			return nfeEmitenteModelList;
		}
		return [];
	}

	List<NfeDestinatarioModel> nfeDestinatarioDriftToModel(List<NfeDestinatarioGrouped>? nfeDestinatarioDriftList) { 
		List<NfeDestinatarioModel> nfeDestinatarioModelList = [];
		if (nfeDestinatarioDriftList != null) {
			for (var nfeDestinatarioGrouped in nfeDestinatarioDriftList) {
				nfeDestinatarioModelList.add(
					NfeDestinatarioModel(
						id: nfeDestinatarioGrouped.nfeDestinatario?.id,
						idNfeCabecalho: nfeDestinatarioGrouped.nfeDestinatario?.idNfeCabecalho,
						cnpj: nfeDestinatarioGrouped.nfeDestinatario?.cnpj,
						cpf: nfeDestinatarioGrouped.nfeDestinatario?.cpf,
						estrangeiroIdentificacao: nfeDestinatarioGrouped.nfeDestinatario?.estrangeiroIdentificacao,
						nome: nfeDestinatarioGrouped.nfeDestinatario?.nome,
						logradouro: nfeDestinatarioGrouped.nfeDestinatario?.logradouro,
						numero: nfeDestinatarioGrouped.nfeDestinatario?.numero,
						complemento: nfeDestinatarioGrouped.nfeDestinatario?.complemento,
						bairro: nfeDestinatarioGrouped.nfeDestinatario?.bairro,
						codigoMunicipio: nfeDestinatarioGrouped.nfeDestinatario?.codigoMunicipio,
						nomeMunicipio: nfeDestinatarioGrouped.nfeDestinatario?.nomeMunicipio,
						uf: NfeDestinatarioDomain.getUf(nfeDestinatarioGrouped.nfeDestinatario?.uf),
						cep: nfeDestinatarioGrouped.nfeDestinatario?.cep,
						codigoPais: nfeDestinatarioGrouped.nfeDestinatario?.codigoPais,
						nomePais: nfeDestinatarioGrouped.nfeDestinatario?.nomePais,
						telefone: nfeDestinatarioGrouped.nfeDestinatario?.telefone,
						indicadorIe: NfeDestinatarioDomain.getIndicadorIe(nfeDestinatarioGrouped.nfeDestinatario?.indicadorIe),
						inscricaoEstadual: nfeDestinatarioGrouped.nfeDestinatario?.inscricaoEstadual,
						suframa: nfeDestinatarioGrouped.nfeDestinatario?.suframa,
						inscricaoMunicipal: nfeDestinatarioGrouped.nfeDestinatario?.inscricaoMunicipal,
						email: nfeDestinatarioGrouped.nfeDestinatario?.email,
					)
				);
			}
			return nfeDestinatarioModelList;
		}
		return [];
	}

	List<NfeLocalRetiradaModel> nfeLocalRetiradaDriftToModel(List<NfeLocalRetiradaGrouped>? nfeLocalRetiradaDriftList) { 
		List<NfeLocalRetiradaModel> nfeLocalRetiradaModelList = [];
		if (nfeLocalRetiradaDriftList != null) {
			for (var nfeLocalRetiradaGrouped in nfeLocalRetiradaDriftList) {
				nfeLocalRetiradaModelList.add(
					NfeLocalRetiradaModel(
						id: nfeLocalRetiradaGrouped.nfeLocalRetirada?.id,
						idNfeCabecalho: nfeLocalRetiradaGrouped.nfeLocalRetirada?.idNfeCabecalho,
						cnpj: nfeLocalRetiradaGrouped.nfeLocalRetirada?.cnpj,
						cpf: nfeLocalRetiradaGrouped.nfeLocalRetirada?.cpf,
						nomeExpedidor: nfeLocalRetiradaGrouped.nfeLocalRetirada?.nomeExpedidor,
						logradouro: nfeLocalRetiradaGrouped.nfeLocalRetirada?.logradouro,
						numero: nfeLocalRetiradaGrouped.nfeLocalRetirada?.numero,
						complemento: nfeLocalRetiradaGrouped.nfeLocalRetirada?.complemento,
						bairro: nfeLocalRetiradaGrouped.nfeLocalRetirada?.bairro,
						codigoMunicipio: nfeLocalRetiradaGrouped.nfeLocalRetirada?.codigoMunicipio,
						nomeMunicipio: nfeLocalRetiradaGrouped.nfeLocalRetirada?.nomeMunicipio,
						uf: NfeLocalRetiradaDomain.getUf(nfeLocalRetiradaGrouped.nfeLocalRetirada?.uf),
						cep: nfeLocalRetiradaGrouped.nfeLocalRetirada?.cep,
						codigoPais: nfeLocalRetiradaGrouped.nfeLocalRetirada?.codigoPais,
						nomePais: nfeLocalRetiradaGrouped.nfeLocalRetirada?.nomePais,
						telefone: nfeLocalRetiradaGrouped.nfeLocalRetirada?.telefone,
						email: nfeLocalRetiradaGrouped.nfeLocalRetirada?.email,
						inscricaoEstadual: nfeLocalRetiradaGrouped.nfeLocalRetirada?.inscricaoEstadual,
					)
				);
			}
			return nfeLocalRetiradaModelList;
		}
		return [];
	}

	List<NfeLocalEntregaModel> nfeLocalEntregaDriftToModel(List<NfeLocalEntregaGrouped>? nfeLocalEntregaDriftList) { 
		List<NfeLocalEntregaModel> nfeLocalEntregaModelList = [];
		if (nfeLocalEntregaDriftList != null) {
			for (var nfeLocalEntregaGrouped in nfeLocalEntregaDriftList) {
				nfeLocalEntregaModelList.add(
					NfeLocalEntregaModel(
						id: nfeLocalEntregaGrouped.nfeLocalEntrega?.id,
						idNfeCabecalho: nfeLocalEntregaGrouped.nfeLocalEntrega?.idNfeCabecalho,
						cnpj: nfeLocalEntregaGrouped.nfeLocalEntrega?.cnpj,
						cpf: nfeLocalEntregaGrouped.nfeLocalEntrega?.cpf,
						nomeRecebedor: nfeLocalEntregaGrouped.nfeLocalEntrega?.nomeRecebedor,
						logradouro: nfeLocalEntregaGrouped.nfeLocalEntrega?.logradouro,
						numero: nfeLocalEntregaGrouped.nfeLocalEntrega?.numero,
						complemento: nfeLocalEntregaGrouped.nfeLocalEntrega?.complemento,
						bairro: nfeLocalEntregaGrouped.nfeLocalEntrega?.bairro,
						codigoMunicipio: nfeLocalEntregaGrouped.nfeLocalEntrega?.codigoMunicipio,
						nomeMunicipio: nfeLocalEntregaGrouped.nfeLocalEntrega?.nomeMunicipio,
						uf: NfeLocalEntregaDomain.getUf(nfeLocalEntregaGrouped.nfeLocalEntrega?.uf),
						cep: nfeLocalEntregaGrouped.nfeLocalEntrega?.cep,
						codigoPais: nfeLocalEntregaGrouped.nfeLocalEntrega?.codigoPais,
						nomePais: nfeLocalEntregaGrouped.nfeLocalEntrega?.nomePais,
						telefone: nfeLocalEntregaGrouped.nfeLocalEntrega?.telefone,
						email: nfeLocalEntregaGrouped.nfeLocalEntrega?.email,
						inscricaoEstadual: nfeLocalEntregaGrouped.nfeLocalEntrega?.inscricaoEstadual,
					)
				);
			}
			return nfeLocalEntregaModelList;
		}
		return [];
	}

	List<NfeTransporteModel> nfeTransporteDriftToModel(List<NfeTransporteGrouped>? nfeTransporteDriftList) { 
		List<NfeTransporteModel> nfeTransporteModelList = [];
		if (nfeTransporteDriftList != null) {
			for (var nfeTransporteGrouped in nfeTransporteDriftList) {
				nfeTransporteModelList.add(
					NfeTransporteModel(
						id: nfeTransporteGrouped.nfeTransporte?.id,
						idNfeCabecalho: nfeTransporteGrouped.nfeTransporte?.idNfeCabecalho,
						idTransportadora: nfeTransporteGrouped.nfeTransporte?.idTransportadora,
						modalidadeFrete: NfeTransporteDomain.getModalidadeFrete(nfeTransporteGrouped.nfeTransporte?.modalidadeFrete),
						cnpj: nfeTransporteGrouped.nfeTransporte?.cnpj,
						cpf: nfeTransporteGrouped.nfeTransporte?.cpf,
						nome: nfeTransporteGrouped.nfeTransporte?.nome,
						inscricaoEstadual: nfeTransporteGrouped.nfeTransporte?.inscricaoEstadual,
						endereco: nfeTransporteGrouped.nfeTransporte?.endereco,
						nomeMunicipio: nfeTransporteGrouped.nfeTransporte?.nomeMunicipio,
						uf: NfeTransporteDomain.getUf(nfeTransporteGrouped.nfeTransporte?.uf),
						valorServico: nfeTransporteGrouped.nfeTransporte?.valorServico,
						valorBcRetencaoIcms: nfeTransporteGrouped.nfeTransporte?.valorBcRetencaoIcms,
						aliquotaRetencaoIcms: nfeTransporteGrouped.nfeTransporte?.aliquotaRetencaoIcms,
						valorIcmsRetido: nfeTransporteGrouped.nfeTransporte?.valorIcmsRetido,
						cfop: nfeTransporteGrouped.nfeTransporte?.cfop,
						municipio: nfeTransporteGrouped.nfeTransporte?.municipio,
						placaVeiculo: nfeTransporteGrouped.nfeTransporte?.placaVeiculo,
						ufVeiculo: NfeTransporteDomain.getUfVeiculo(nfeTransporteGrouped.nfeTransporte?.ufVeiculo),
						rntcVeiculo: nfeTransporteGrouped.nfeTransporte?.rntcVeiculo,
					)
				);
			}
			return nfeTransporteModelList;
		}
		return [];
	}

	List<NfeFaturaModel> nfeFaturaDriftToModel(List<NfeFaturaGrouped>? nfeFaturaDriftList) { 
		List<NfeFaturaModel> nfeFaturaModelList = [];
		if (nfeFaturaDriftList != null) {
			for (var nfeFaturaGrouped in nfeFaturaDriftList) {
				nfeFaturaModelList.add(
					NfeFaturaModel(
						id: nfeFaturaGrouped.nfeFatura?.id,
						idNfeCabecalho: nfeFaturaGrouped.nfeFatura?.idNfeCabecalho,
						numero: nfeFaturaGrouped.nfeFatura?.numero,
						valorOriginal: nfeFaturaGrouped.nfeFatura?.valorOriginal,
						valorDesconto: nfeFaturaGrouped.nfeFatura?.valorDesconto,
						valorLiquido: nfeFaturaGrouped.nfeFatura?.valorLiquido,
					)
				);
			}
			return nfeFaturaModelList;
		}
		return [];
	}

	List<NfeCanaModel> nfeCanaDriftToModel(List<NfeCanaGrouped>? nfeCanaDriftList) { 
		List<NfeCanaModel> nfeCanaModelList = [];
		if (nfeCanaDriftList != null) {
			for (var nfeCanaGrouped in nfeCanaDriftList) {
				nfeCanaModelList.add(
					NfeCanaModel(
						id: nfeCanaGrouped.nfeCana?.id,
						idNfeCabecalho: nfeCanaGrouped.nfeCana?.idNfeCabecalho,
						safra: nfeCanaGrouped.nfeCana?.safra,
						mesAnoReferencia: nfeCanaGrouped.nfeCana?.mesAnoReferencia,
					)
				);
			}
			return nfeCanaModelList;
		}
		return [];
	}

	List<NfeProdRuralReferenciadaModel> nfeProdRuralReferenciadaDriftToModel(List<NfeProdRuralReferenciadaGrouped>? nfeProdRuralReferenciadaDriftList) { 
		List<NfeProdRuralReferenciadaModel> nfeProdRuralReferenciadaModelList = [];
		if (nfeProdRuralReferenciadaDriftList != null) {
			for (var nfeProdRuralReferenciadaGrouped in nfeProdRuralReferenciadaDriftList) {
				nfeProdRuralReferenciadaModelList.add(
					NfeProdRuralReferenciadaModel(
						id: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.id,
						idNfeCabecalho: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.idNfeCabecalho,
						codigoUf: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.codigoUf,
						anoMes: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.anoMes,
						cnpj: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.cnpj,
						cpf: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.cpf,
						inscricaoEstadual: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.inscricaoEstadual,
						modelo: NfeProdRuralReferenciadaDomain.getModelo(nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.modelo),
						serie: NfeProdRuralReferenciadaDomain.getSerie(nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.serie),
						numeroNf: nfeProdRuralReferenciadaGrouped.nfeProdRuralReferenciada?.numeroNf,
					)
				);
			}
			return nfeProdRuralReferenciadaModelList;
		}
		return [];
	}

	List<NfeNfReferenciadaModel> nfeNfReferenciadaDriftToModel(List<NfeNfReferenciadaGrouped>? nfeNfReferenciadaDriftList) { 
		List<NfeNfReferenciadaModel> nfeNfReferenciadaModelList = [];
		if (nfeNfReferenciadaDriftList != null) {
			for (var nfeNfReferenciadaGrouped in nfeNfReferenciadaDriftList) {
				nfeNfReferenciadaModelList.add(
					NfeNfReferenciadaModel(
						id: nfeNfReferenciadaGrouped.nfeNfReferenciada?.id,
						idNfeCabecalho: nfeNfReferenciadaGrouped.nfeNfReferenciada?.idNfeCabecalho,
						codigoUf: nfeNfReferenciadaGrouped.nfeNfReferenciada?.codigoUf,
						anoMes: nfeNfReferenciadaGrouped.nfeNfReferenciada?.anoMes,
						cnpj: nfeNfReferenciadaGrouped.nfeNfReferenciada?.cnpj,
						modelo: NfeNfReferenciadaDomain.getModelo(nfeNfReferenciadaGrouped.nfeNfReferenciada?.modelo),
						serie: NfeNfReferenciadaDomain.getSerie(nfeNfReferenciadaGrouped.nfeNfReferenciada?.serie),
						numeroNf: nfeNfReferenciadaGrouped.nfeNfReferenciada?.numeroNf,
					)
				);
			}
			return nfeNfReferenciadaModelList;
		}
		return [];
	}

	List<NfeProcessoReferenciadoModel> nfeProcessoReferenciadoDriftToModel(List<NfeProcessoReferenciadoGrouped>? nfeProcessoReferenciadoDriftList) { 
		List<NfeProcessoReferenciadoModel> nfeProcessoReferenciadoModelList = [];
		if (nfeProcessoReferenciadoDriftList != null) {
			for (var nfeProcessoReferenciadoGrouped in nfeProcessoReferenciadoDriftList) {
				nfeProcessoReferenciadoModelList.add(
					NfeProcessoReferenciadoModel(
						id: nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado?.id,
						idNfeCabecalho: nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado?.idNfeCabecalho,
						identificador: nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado?.identificador,
						origem: NfeProcessoReferenciadoDomain.getOrigem(nfeProcessoReferenciadoGrouped.nfeProcessoReferenciado?.origem),
					)
				);
			}
			return nfeProcessoReferenciadoModelList;
		}
		return [];
	}

	List<NfeAcessoXmlModel> nfeAcessoXmlDriftToModel(List<NfeAcessoXmlGrouped>? nfeAcessoXmlDriftList) { 
		List<NfeAcessoXmlModel> nfeAcessoXmlModelList = [];
		if (nfeAcessoXmlDriftList != null) {
			for (var nfeAcessoXmlGrouped in nfeAcessoXmlDriftList) {
				nfeAcessoXmlModelList.add(
					NfeAcessoXmlModel(
						id: nfeAcessoXmlGrouped.nfeAcessoXml?.id,
						idNfeCabecalho: nfeAcessoXmlGrouped.nfeAcessoXml?.idNfeCabecalho,
						cnpj: nfeAcessoXmlGrouped.nfeAcessoXml?.cnpj,
						cpf: nfeAcessoXmlGrouped.nfeAcessoXml?.cpf,
					)
				);
			}
			return nfeAcessoXmlModelList;
		}
		return [];
	}

	List<NfeInformacaoPagamentoModel> nfeInformacaoPagamentoDriftToModel(List<NfeInformacaoPagamentoGrouped>? nfeInformacaoPagamentoDriftList) { 
		List<NfeInformacaoPagamentoModel> nfeInformacaoPagamentoModelList = [];
		if (nfeInformacaoPagamentoDriftList != null) {
			for (var nfeInformacaoPagamentoGrouped in nfeInformacaoPagamentoDriftList) {
				nfeInformacaoPagamentoModelList.add(
					NfeInformacaoPagamentoModel(
						id: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.id,
						idNfeCabecalho: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.idNfeCabecalho,
						indicadorPagamento: NfeInformacaoPagamentoDomain.getIndicadorPagamento(nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.indicadorPagamento),
						meioPagamento: NfeInformacaoPagamentoDomain.getMeioPagamento(nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.meioPagamento),
						valor: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.valor,
						tipoIntegracao: NfeInformacaoPagamentoDomain.getTipoIntegracao(nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.tipoIntegracao),
						cnpjOperadoraCartao: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.cnpjOperadoraCartao,
						bandeira: NfeInformacaoPagamentoDomain.getBandeira(nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.bandeira),
						numeroAutorizacao: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.numeroAutorizacao,
						troco: nfeInformacaoPagamentoGrouped.nfeInformacaoPagamento?.troco,
					)
				);
			}
			return nfeInformacaoPagamentoModelList;
		}
		return [];
	}

	List<NfeResponsavelTecnicoModel> nfeResponsavelTecnicoDriftToModel(List<NfeResponsavelTecnicoGrouped>? nfeResponsavelTecnicoDriftList) { 
		List<NfeResponsavelTecnicoModel> nfeResponsavelTecnicoModelList = [];
		if (nfeResponsavelTecnicoDriftList != null) {
			for (var nfeResponsavelTecnicoGrouped in nfeResponsavelTecnicoDriftList) {
				nfeResponsavelTecnicoModelList.add(
					NfeResponsavelTecnicoModel(
						id: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.id,
						idNfeCabecalho: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.idNfeCabecalho,
						cnpj: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.cnpj,
						contato: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.contato,
						email: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.email,
						telefone: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.telefone,
						identificadorCsrt: NfeResponsavelTecnicoDomain.getIdentificadorCsrt(nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.identificadorCsrt),
						hashCsrt: nfeResponsavelTecnicoGrouped.nfeResponsavelTecnico?.hashCsrt,
					)
				);
			}
			return nfeResponsavelTecnicoModelList;
		}
		return [];
	}

	List<NfeCteReferenciadoModel> nfeCteReferenciadoDriftToModel(List<NfeCteReferenciadoGrouped>? nfeCteReferenciadoDriftList) { 
		List<NfeCteReferenciadoModel> nfeCteReferenciadoModelList = [];
		if (nfeCteReferenciadoDriftList != null) {
			for (var nfeCteReferenciadoGrouped in nfeCteReferenciadoDriftList) {
				nfeCteReferenciadoModelList.add(
					NfeCteReferenciadoModel(
						id: nfeCteReferenciadoGrouped.nfeCteReferenciado?.id,
						idNfeCabecalho: nfeCteReferenciadoGrouped.nfeCteReferenciado?.idNfeCabecalho,
						chaveAcesso: nfeCteReferenciadoGrouped.nfeCteReferenciado?.chaveAcesso,
					)
				);
			}
			return nfeCteReferenciadoModelList;
		}
		return [];
	}

	List<NfeCupomFiscalReferenciadoModel> nfeCupomFiscalReferenciadoDriftToModel(List<NfeCupomFiscalReferenciadoGrouped>? nfeCupomFiscalReferenciadoDriftList) { 
		List<NfeCupomFiscalReferenciadoModel> nfeCupomFiscalReferenciadoModelList = [];
		if (nfeCupomFiscalReferenciadoDriftList != null) {
			for (var nfeCupomFiscalReferenciadoGrouped in nfeCupomFiscalReferenciadoDriftList) {
				nfeCupomFiscalReferenciadoModelList.add(
					NfeCupomFiscalReferenciadoModel(
						id: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.id,
						idNfeCabecalho: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.idNfeCabecalho,
						modeloDocumentoFiscal: NfeCupomFiscalReferenciadoDomain.getModeloDocumentoFiscal(nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.modeloDocumentoFiscal),
						numeroOrdemEcf: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.numeroOrdemEcf,
						coo: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.coo,
						dataEmissaoCupom: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.dataEmissaoCupom,
						numeroCaixa: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.numeroCaixa,
						numeroSerieEcf: nfeCupomFiscalReferenciadoGrouped.nfeCupomFiscalReferenciado?.numeroSerieEcf,
					)
				);
			}
			return nfeCupomFiscalReferenciadoModelList;
		}
		return [];
	}


	NfeCabecalhoGrouped toDrift(NfeCabecalhoModel nfeCabecalhoModel) {
		return NfeCabecalhoGrouped(
			nfeCabecalho: NfeCabecalho(
				id: nfeCabecalhoModel.id,
				idVendaCabecalho: nfeCabecalhoModel.idVendaCabecalho,
				idTributOperacaoFiscal: nfeCabecalhoModel.idTributOperacaoFiscal,
				idCliente: nfeCabecalhoModel.idCliente,
				idColaborador: nfeCabecalhoModel.idColaborador,
				idFornecedor: nfeCabecalhoModel.idFornecedor,
				ufEmitente: NfeCabecalhoDomain.setUfEmitente(nfeCabecalhoModel.ufEmitente),
				codigoNumerico: nfeCabecalhoModel.codigoNumerico,
				naturezaOperacao: nfeCabecalhoModel.naturezaOperacao,
				codigoModelo: NfeCabecalhoDomain.setCodigoModelo(nfeCabecalhoModel.codigoModelo),
				serie: nfeCabecalhoModel.serie,
				numero: nfeCabecalhoModel.numero,
				dataHoraEmissao: nfeCabecalhoModel.dataHoraEmissao,
				dataHoraEntradaSaida: nfeCabecalhoModel.dataHoraEntradaSaida,
				tipoOperacao: NfeCabecalhoDomain.setTipoOperacao(nfeCabecalhoModel.tipoOperacao),
				localDestino: NfeCabecalhoDomain.setLocalDestino(nfeCabecalhoModel.localDestino),
				codigoMunicipio: nfeCabecalhoModel.codigoMunicipio,
				formatoImpressaoDanfe: NfeCabecalhoDomain.setFormatoImpressaoDanfe(nfeCabecalhoModel.formatoImpressaoDanfe),
				tipoEmissao: NfeCabecalhoDomain.setTipoEmissao(nfeCabecalhoModel.tipoEmissao),
				chaveAcesso: nfeCabecalhoModel.chaveAcesso,
				digitoChaveAcesso: nfeCabecalhoModel.digitoChaveAcesso,
				ambiente: NfeCabecalhoDomain.setAmbiente(nfeCabecalhoModel.ambiente),
				finalidadeEmissao: NfeCabecalhoDomain.setFinalidadeEmissao(nfeCabecalhoModel.finalidadeEmissao),
				consumidorOperacao: NfeCabecalhoDomain.setConsumidorOperacao(nfeCabecalhoModel.consumidorOperacao),
				consumidorPresenca: NfeCabecalhoDomain.setConsumidorPresenca(nfeCabecalhoModel.consumidorPresenca),
				processoEmissao: NfeCabecalhoDomain.setProcessoEmissao(nfeCabecalhoModel.processoEmissao),
				versaoProcessoEmissao: nfeCabecalhoModel.versaoProcessoEmissao,
				dataEntradaContingencia: nfeCabecalhoModel.dataEntradaContingencia,
				justificativaContingencia: nfeCabecalhoModel.justificativaContingencia,
				baseCalculoIcms: nfeCabecalhoModel.baseCalculoIcms,
				valorIcms: nfeCabecalhoModel.valorIcms,
				valorIcmsDesonerado: nfeCabecalhoModel.valorIcmsDesonerado,
				totalIcmsFcpUfDestino: nfeCabecalhoModel.totalIcmsFcpUfDestino,
				totalIcmsInterestadualUfDestino: nfeCabecalhoModel.totalIcmsInterestadualUfDestino,
				totalIcmsInterestadualUfRemetente: nfeCabecalhoModel.totalIcmsInterestadualUfRemetente,
				valorTotalFcp: nfeCabecalhoModel.valorTotalFcp,
				baseCalculoIcmsSt: nfeCabecalhoModel.baseCalculoIcmsSt,
				valorIcmsSt: nfeCabecalhoModel.valorIcmsSt,
				valorTotalFcpSt: nfeCabecalhoModel.valorTotalFcpSt,
				valorTotalFcpStRetido: nfeCabecalhoModel.valorTotalFcpStRetido,
				valorTotalProdutos: nfeCabecalhoModel.valorTotalProdutos,
				valorFrete: nfeCabecalhoModel.valorFrete,
				valorSeguro: nfeCabecalhoModel.valorSeguro,
				valorDesconto: nfeCabecalhoModel.valorDesconto,
				valorImpostoImportacao: nfeCabecalhoModel.valorImpostoImportacao,
				valorIpi: nfeCabecalhoModel.valorIpi,
				valorIpiDevolvido: nfeCabecalhoModel.valorIpiDevolvido,
				valorPis: nfeCabecalhoModel.valorPis,
				valorCofins: nfeCabecalhoModel.valorCofins,
				valorDespesasAcessorias: nfeCabecalhoModel.valorDespesasAcessorias,
				valorTotal: nfeCabecalhoModel.valorTotal,
				valorTotalTributos: nfeCabecalhoModel.valorTotalTributos,
				valorServicos: nfeCabecalhoModel.valorServicos,
				baseCalculoIssqn: nfeCabecalhoModel.baseCalculoIssqn,
				valorIssqn: nfeCabecalhoModel.valorIssqn,
				valorPisIssqn: nfeCabecalhoModel.valorPisIssqn,
				valorCofinsIssqn: nfeCabecalhoModel.valorCofinsIssqn,
				dataPrestacaoServico: nfeCabecalhoModel.dataPrestacaoServico,
				valorDeducaoIssqn: nfeCabecalhoModel.valorDeducaoIssqn,
				outrasRetencoesIssqn: nfeCabecalhoModel.outrasRetencoesIssqn,
				descontoIncondicionadoIssqn: nfeCabecalhoModel.descontoIncondicionadoIssqn,
				descontoCondicionadoIssqn: nfeCabecalhoModel.descontoCondicionadoIssqn,
				totalRetencaoIssqn: nfeCabecalhoModel.totalRetencaoIssqn,
				regimeEspecialTributacao: NfeCabecalhoDomain.setRegimeEspecialTributacao(nfeCabecalhoModel.regimeEspecialTributacao),
				valorRetidoPis: nfeCabecalhoModel.valorRetidoPis,
				valorRetidoCofins: nfeCabecalhoModel.valorRetidoCofins,
				valorRetidoCsll: nfeCabecalhoModel.valorRetidoCsll,
				baseCalculoIrrf: nfeCabecalhoModel.baseCalculoIrrf,
				valorRetidoIrrf: nfeCabecalhoModel.valorRetidoIrrf,
				baseCalculoPrevidencia: nfeCabecalhoModel.baseCalculoPrevidencia,
				valorRetidoPrevidencia: nfeCabecalhoModel.valorRetidoPrevidencia,
				informacoesAddFisco: nfeCabecalhoModel.informacoesAddFisco,
				informacoesAddContribuinte: nfeCabecalhoModel.informacoesAddContribuinte,
				comexUfEmbarque: NfeCabecalhoDomain.setComexUfEmbarque(nfeCabecalhoModel.comexUfEmbarque),
				comexLocalEmbarque: nfeCabecalhoModel.comexLocalEmbarque,
				comexLocalDespacho: nfeCabecalhoModel.comexLocalDespacho,
				compraNotaEmpenho: nfeCabecalhoModel.compraNotaEmpenho,
				compraPedido: nfeCabecalhoModel.compraPedido,
				compraContrato: nfeCabecalhoModel.compraContrato,
				qrcode: nfeCabecalhoModel.qrcode,
				urlChave: nfeCabecalhoModel.urlChave,
				statusNota: NfeCabecalhoDomain.setStatusNota(nfeCabecalhoModel.statusNota),
			),
			nfeReferenciadaGroupedList: nfeReferenciadaModelToDrift(nfeCabecalhoModel.nfeReferenciadaModelList),
			nfeEmitenteGroupedList: nfeEmitenteModelToDrift(nfeCabecalhoModel.nfeEmitenteModelList),
			nfeDestinatarioGroupedList: nfeDestinatarioModelToDrift(nfeCabecalhoModel.nfeDestinatarioModelList),
			nfeLocalRetiradaGroupedList: nfeLocalRetiradaModelToDrift(nfeCabecalhoModel.nfeLocalRetiradaModelList),
			nfeLocalEntregaGroupedList: nfeLocalEntregaModelToDrift(nfeCabecalhoModel.nfeLocalEntregaModelList),
			nfeTransporteGroupedList: nfeTransporteModelToDrift(nfeCabecalhoModel.nfeTransporteModelList),
			nfeFaturaGroupedList: nfeFaturaModelToDrift(nfeCabecalhoModel.nfeFaturaModelList),
			nfeCanaGroupedList: nfeCanaModelToDrift(nfeCabecalhoModel.nfeCanaModelList),
			nfeProdRuralReferenciadaGroupedList: nfeProdRuralReferenciadaModelToDrift(nfeCabecalhoModel.nfeProdRuralReferenciadaModelList),
			nfeNfReferenciadaGroupedList: nfeNfReferenciadaModelToDrift(nfeCabecalhoModel.nfeNfReferenciadaModelList),
			nfeProcessoReferenciadoGroupedList: nfeProcessoReferenciadoModelToDrift(nfeCabecalhoModel.nfeProcessoReferenciadoModelList),
			nfeAcessoXmlGroupedList: nfeAcessoXmlModelToDrift(nfeCabecalhoModel.nfeAcessoXmlModelList),
			nfeInformacaoPagamentoGroupedList: nfeInformacaoPagamentoModelToDrift(nfeCabecalhoModel.nfeInformacaoPagamentoModelList),
			nfeResponsavelTecnicoGroupedList: nfeResponsavelTecnicoModelToDrift(nfeCabecalhoModel.nfeResponsavelTecnicoModelList),
			nfeCteReferenciadoGroupedList: nfeCteReferenciadoModelToDrift(nfeCabecalhoModel.nfeCteReferenciadoModelList),
			nfeCupomFiscalReferenciadoGroupedList: nfeCupomFiscalReferenciadoModelToDrift(nfeCabecalhoModel.nfeCupomFiscalReferenciadoModelList),
		);
	}

	List<NfeReferenciadaGrouped> nfeReferenciadaModelToDrift(List<NfeReferenciadaModel>? nfeReferenciadaModelList) { 
		List<NfeReferenciadaGrouped> nfeReferenciadaGroupedList = [];
		if (nfeReferenciadaModelList != null) {
			for (var nfeReferenciadaModel in nfeReferenciadaModelList) {
				nfeReferenciadaGroupedList.add(
					NfeReferenciadaGrouped(
						nfeReferenciada: NfeReferenciada(
							id: nfeReferenciadaModel.id,
							idNfeCabecalho: nfeReferenciadaModel.idNfeCabecalho,
							chaveAcesso: nfeReferenciadaModel.chaveAcesso,
						),
					),
				);
			}
			return nfeReferenciadaGroupedList;
		}
		return [];
	}

	List<NfeEmitenteGrouped> nfeEmitenteModelToDrift(List<NfeEmitenteModel>? nfeEmitenteModelList) { 
		List<NfeEmitenteGrouped> nfeEmitenteGroupedList = [];
		if (nfeEmitenteModelList != null) {
			for (var nfeEmitenteModel in nfeEmitenteModelList) {
				nfeEmitenteGroupedList.add(
					NfeEmitenteGrouped(
						nfeEmitente: NfeEmitente(
							id: nfeEmitenteModel.id,
							idNfeCabecalho: nfeEmitenteModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeEmitenteModel.cnpj),
							cpf: Util.removeMask(nfeEmitenteModel.cpf),
							nome: nfeEmitenteModel.nome,
							fantasia: nfeEmitenteModel.fantasia,
							logradouro: nfeEmitenteModel.logradouro,
							numero: nfeEmitenteModel.numero,
							complemento: nfeEmitenteModel.complemento,
							bairro: nfeEmitenteModel.bairro,
							codigoMunicipio: nfeEmitenteModel.codigoMunicipio,
							nomeMunicipio: nfeEmitenteModel.nomeMunicipio,
							uf: NfeEmitenteDomain.setUf(nfeEmitenteModel.uf),
							cep: Util.removeMask(nfeEmitenteModel.cep),
							codigoPais: nfeEmitenteModel.codigoPais,
							nomePais: nfeEmitenteModel.nomePais,
							telefone: nfeEmitenteModel.telefone,
							inscricaoEstadual: nfeEmitenteModel.inscricaoEstadual,
							inscricaoEstadualSt: nfeEmitenteModel.inscricaoEstadualSt,
							inscricaoMunicipal: nfeEmitenteModel.inscricaoMunicipal,
							cnae: nfeEmitenteModel.cnae,
							crt: NfeEmitenteDomain.setCrt(nfeEmitenteModel.crt),
						),
					),
				);
			}
			return nfeEmitenteGroupedList;
		}
		return [];
	}

	List<NfeDestinatarioGrouped> nfeDestinatarioModelToDrift(List<NfeDestinatarioModel>? nfeDestinatarioModelList) { 
		List<NfeDestinatarioGrouped> nfeDestinatarioGroupedList = [];
		if (nfeDestinatarioModelList != null) {
			for (var nfeDestinatarioModel in nfeDestinatarioModelList) {
				nfeDestinatarioGroupedList.add(
					NfeDestinatarioGrouped(
						nfeDestinatario: NfeDestinatario(
							id: nfeDestinatarioModel.id,
							idNfeCabecalho: nfeDestinatarioModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeDestinatarioModel.cnpj),
							cpf: Util.removeMask(nfeDestinatarioModel.cpf),
							estrangeiroIdentificacao: nfeDestinatarioModel.estrangeiroIdentificacao,
							nome: nfeDestinatarioModel.nome,
							logradouro: nfeDestinatarioModel.logradouro,
							numero: nfeDestinatarioModel.numero,
							complemento: nfeDestinatarioModel.complemento,
							bairro: nfeDestinatarioModel.bairro,
							codigoMunicipio: nfeDestinatarioModel.codigoMunicipio,
							nomeMunicipio: nfeDestinatarioModel.nomeMunicipio,
							uf: NfeDestinatarioDomain.setUf(nfeDestinatarioModel.uf),
							cep: Util.removeMask(nfeDestinatarioModel.cep),
							codigoPais: nfeDestinatarioModel.codigoPais,
							nomePais: nfeDestinatarioModel.nomePais,
							telefone: nfeDestinatarioModel.telefone,
							indicadorIe: NfeDestinatarioDomain.setIndicadorIe(nfeDestinatarioModel.indicadorIe),
							inscricaoEstadual: nfeDestinatarioModel.inscricaoEstadual,
							suframa: nfeDestinatarioModel.suframa,
							inscricaoMunicipal: nfeDestinatarioModel.inscricaoMunicipal,
							email: nfeDestinatarioModel.email,
						),
					),
				);
			}
			return nfeDestinatarioGroupedList;
		}
		return [];
	}

	List<NfeLocalRetiradaGrouped> nfeLocalRetiradaModelToDrift(List<NfeLocalRetiradaModel>? nfeLocalRetiradaModelList) { 
		List<NfeLocalRetiradaGrouped> nfeLocalRetiradaGroupedList = [];
		if (nfeLocalRetiradaModelList != null) {
			for (var nfeLocalRetiradaModel in nfeLocalRetiradaModelList) {
				nfeLocalRetiradaGroupedList.add(
					NfeLocalRetiradaGrouped(
						nfeLocalRetirada: NfeLocalRetirada(
							id: nfeLocalRetiradaModel.id,
							idNfeCabecalho: nfeLocalRetiradaModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeLocalRetiradaModel.cnpj),
							cpf: Util.removeMask(nfeLocalRetiradaModel.cpf),
							nomeExpedidor: nfeLocalRetiradaModel.nomeExpedidor,
							logradouro: nfeLocalRetiradaModel.logradouro,
							numero: nfeLocalRetiradaModel.numero,
							complemento: nfeLocalRetiradaModel.complemento,
							bairro: nfeLocalRetiradaModel.bairro,
							codigoMunicipio: nfeLocalRetiradaModel.codigoMunicipio,
							nomeMunicipio: nfeLocalRetiradaModel.nomeMunicipio,
							uf: NfeLocalRetiradaDomain.setUf(nfeLocalRetiradaModel.uf),
							cep: Util.removeMask(nfeLocalRetiradaModel.cep),
							codigoPais: nfeLocalRetiradaModel.codigoPais,
							nomePais: nfeLocalRetiradaModel.nomePais,
							telefone: nfeLocalRetiradaModel.telefone,
							email: nfeLocalRetiradaModel.email,
							inscricaoEstadual: nfeLocalRetiradaModel.inscricaoEstadual,
						),
					),
				);
			}
			return nfeLocalRetiradaGroupedList;
		}
		return [];
	}

	List<NfeLocalEntregaGrouped> nfeLocalEntregaModelToDrift(List<NfeLocalEntregaModel>? nfeLocalEntregaModelList) { 
		List<NfeLocalEntregaGrouped> nfeLocalEntregaGroupedList = [];
		if (nfeLocalEntregaModelList != null) {
			for (var nfeLocalEntregaModel in nfeLocalEntregaModelList) {
				nfeLocalEntregaGroupedList.add(
					NfeLocalEntregaGrouped(
						nfeLocalEntrega: NfeLocalEntrega(
							id: nfeLocalEntregaModel.id,
							idNfeCabecalho: nfeLocalEntregaModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeLocalEntregaModel.cnpj),
							cpf: Util.removeMask(nfeLocalEntregaModel.cpf),
							nomeRecebedor: nfeLocalEntregaModel.nomeRecebedor,
							logradouro: nfeLocalEntregaModel.logradouro,
							numero: nfeLocalEntregaModel.numero,
							complemento: nfeLocalEntregaModel.complemento,
							bairro: nfeLocalEntregaModel.bairro,
							codigoMunicipio: nfeLocalEntregaModel.codigoMunicipio,
							nomeMunicipio: nfeLocalEntregaModel.nomeMunicipio,
							uf: NfeLocalEntregaDomain.setUf(nfeLocalEntregaModel.uf),
							cep: Util.removeMask(nfeLocalEntregaModel.cep),
							codigoPais: nfeLocalEntregaModel.codigoPais,
							nomePais: nfeLocalEntregaModel.nomePais,
							telefone: nfeLocalEntregaModel.telefone,
							email: nfeLocalEntregaModel.email,
							inscricaoEstadual: nfeLocalEntregaModel.inscricaoEstadual,
						),
					),
				);
			}
			return nfeLocalEntregaGroupedList;
		}
		return [];
	}

	List<NfeTransporteGrouped> nfeTransporteModelToDrift(List<NfeTransporteModel>? nfeTransporteModelList) { 
		List<NfeTransporteGrouped> nfeTransporteGroupedList = [];
		if (nfeTransporteModelList != null) {
			for (var nfeTransporteModel in nfeTransporteModelList) {
				nfeTransporteGroupedList.add(
					NfeTransporteGrouped(
						nfeTransporte: NfeTransporte(
							id: nfeTransporteModel.id,
							idNfeCabecalho: nfeTransporteModel.idNfeCabecalho,
							idTransportadora: nfeTransporteModel.idTransportadora,
							modalidadeFrete: NfeTransporteDomain.setModalidadeFrete(nfeTransporteModel.modalidadeFrete),
							cnpj: Util.removeMask(nfeTransporteModel.cnpj),
							cpf: Util.removeMask(nfeTransporteModel.cpf),
							nome: nfeTransporteModel.nome,
							inscricaoEstadual: nfeTransporteModel.inscricaoEstadual,
							endereco: nfeTransporteModel.endereco,
							nomeMunicipio: nfeTransporteModel.nomeMunicipio,
							uf: NfeTransporteDomain.setUf(nfeTransporteModel.uf),
							valorServico: nfeTransporteModel.valorServico,
							valorBcRetencaoIcms: nfeTransporteModel.valorBcRetencaoIcms,
							aliquotaRetencaoIcms: nfeTransporteModel.aliquotaRetencaoIcms,
							valorIcmsRetido: nfeTransporteModel.valorIcmsRetido,
							cfop: nfeTransporteModel.cfop,
							municipio: nfeTransporteModel.municipio,
							placaVeiculo: nfeTransporteModel.placaVeiculo,
							ufVeiculo: NfeTransporteDomain.setUfVeiculo(nfeTransporteModel.ufVeiculo),
							rntcVeiculo: nfeTransporteModel.rntcVeiculo,
						),
					),
				);
			}
			return nfeTransporteGroupedList;
		}
		return [];
	}

	List<NfeFaturaGrouped> nfeFaturaModelToDrift(List<NfeFaturaModel>? nfeFaturaModelList) { 
		List<NfeFaturaGrouped> nfeFaturaGroupedList = [];
		if (nfeFaturaModelList != null) {
			for (var nfeFaturaModel in nfeFaturaModelList) {
				nfeFaturaGroupedList.add(
					NfeFaturaGrouped(
						nfeFatura: NfeFatura(
							id: nfeFaturaModel.id,
							idNfeCabecalho: nfeFaturaModel.idNfeCabecalho,
							numero: nfeFaturaModel.numero,
							valorOriginal: nfeFaturaModel.valorOriginal,
							valorDesconto: nfeFaturaModel.valorDesconto,
							valorLiquido: nfeFaturaModel.valorLiquido,
						),
					),
				);
			}
			return nfeFaturaGroupedList;
		}
		return [];
	}

	List<NfeCanaGrouped> nfeCanaModelToDrift(List<NfeCanaModel>? nfeCanaModelList) { 
		List<NfeCanaGrouped> nfeCanaGroupedList = [];
		if (nfeCanaModelList != null) {
			for (var nfeCanaModel in nfeCanaModelList) {
				nfeCanaGroupedList.add(
					NfeCanaGrouped(
						nfeCana: NfeCana(
							id: nfeCanaModel.id,
							idNfeCabecalho: nfeCanaModel.idNfeCabecalho,
							safra: nfeCanaModel.safra,
							mesAnoReferencia: nfeCanaModel.mesAnoReferencia,
						),
					),
				);
			}
			return nfeCanaGroupedList;
		}
		return [];
	}

	List<NfeProdRuralReferenciadaGrouped> nfeProdRuralReferenciadaModelToDrift(List<NfeProdRuralReferenciadaModel>? nfeProdRuralReferenciadaModelList) { 
		List<NfeProdRuralReferenciadaGrouped> nfeProdRuralReferenciadaGroupedList = [];
		if (nfeProdRuralReferenciadaModelList != null) {
			for (var nfeProdRuralReferenciadaModel in nfeProdRuralReferenciadaModelList) {
				nfeProdRuralReferenciadaGroupedList.add(
					NfeProdRuralReferenciadaGrouped(
						nfeProdRuralReferenciada: NfeProdRuralReferenciada(
							id: nfeProdRuralReferenciadaModel.id,
							idNfeCabecalho: nfeProdRuralReferenciadaModel.idNfeCabecalho,
							codigoUf: nfeProdRuralReferenciadaModel.codigoUf,
							anoMes: nfeProdRuralReferenciadaModel.anoMes,
							cnpj: Util.removeMask(nfeProdRuralReferenciadaModel.cnpj),
							cpf: Util.removeMask(nfeProdRuralReferenciadaModel.cpf),
							inscricaoEstadual: nfeProdRuralReferenciadaModel.inscricaoEstadual,
							modelo: NfeProdRuralReferenciadaDomain.setModelo(nfeProdRuralReferenciadaModel.modelo),
							serie: NfeProdRuralReferenciadaDomain.setSerie(nfeProdRuralReferenciadaModel.serie),
							numeroNf: nfeProdRuralReferenciadaModel.numeroNf,
						),
					),
				);
			}
			return nfeProdRuralReferenciadaGroupedList;
		}
		return [];
	}

	List<NfeNfReferenciadaGrouped> nfeNfReferenciadaModelToDrift(List<NfeNfReferenciadaModel>? nfeNfReferenciadaModelList) { 
		List<NfeNfReferenciadaGrouped> nfeNfReferenciadaGroupedList = [];
		if (nfeNfReferenciadaModelList != null) {
			for (var nfeNfReferenciadaModel in nfeNfReferenciadaModelList) {
				nfeNfReferenciadaGroupedList.add(
					NfeNfReferenciadaGrouped(
						nfeNfReferenciada: NfeNfReferenciada(
							id: nfeNfReferenciadaModel.id,
							idNfeCabecalho: nfeNfReferenciadaModel.idNfeCabecalho,
							codigoUf: nfeNfReferenciadaModel.codigoUf,
							anoMes: nfeNfReferenciadaModel.anoMes,
							cnpj: Util.removeMask(nfeNfReferenciadaModel.cnpj),
							modelo: NfeNfReferenciadaDomain.setModelo(nfeNfReferenciadaModel.modelo),
							serie: NfeNfReferenciadaDomain.setSerie(nfeNfReferenciadaModel.serie),
							numeroNf: nfeNfReferenciadaModel.numeroNf,
						),
					),
				);
			}
			return nfeNfReferenciadaGroupedList;
		}
		return [];
	}

	List<NfeProcessoReferenciadoGrouped> nfeProcessoReferenciadoModelToDrift(List<NfeProcessoReferenciadoModel>? nfeProcessoReferenciadoModelList) { 
		List<NfeProcessoReferenciadoGrouped> nfeProcessoReferenciadoGroupedList = [];
		if (nfeProcessoReferenciadoModelList != null) {
			for (var nfeProcessoReferenciadoModel in nfeProcessoReferenciadoModelList) {
				nfeProcessoReferenciadoGroupedList.add(
					NfeProcessoReferenciadoGrouped(
						nfeProcessoReferenciado: NfeProcessoReferenciado(
							id: nfeProcessoReferenciadoModel.id,
							idNfeCabecalho: nfeProcessoReferenciadoModel.idNfeCabecalho,
							identificador: nfeProcessoReferenciadoModel.identificador,
							origem: NfeProcessoReferenciadoDomain.setOrigem(nfeProcessoReferenciadoModel.origem),
						),
					),
				);
			}
			return nfeProcessoReferenciadoGroupedList;
		}
		return [];
	}

	List<NfeAcessoXmlGrouped> nfeAcessoXmlModelToDrift(List<NfeAcessoXmlModel>? nfeAcessoXmlModelList) { 
		List<NfeAcessoXmlGrouped> nfeAcessoXmlGroupedList = [];
		if (nfeAcessoXmlModelList != null) {
			for (var nfeAcessoXmlModel in nfeAcessoXmlModelList) {
				nfeAcessoXmlGroupedList.add(
					NfeAcessoXmlGrouped(
						nfeAcessoXml: NfeAcessoXml(
							id: nfeAcessoXmlModel.id,
							idNfeCabecalho: nfeAcessoXmlModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeAcessoXmlModel.cnpj),
							cpf: Util.removeMask(nfeAcessoXmlModel.cpf),
						),
					),
				);
			}
			return nfeAcessoXmlGroupedList;
		}
		return [];
	}

	List<NfeInformacaoPagamentoGrouped> nfeInformacaoPagamentoModelToDrift(List<NfeInformacaoPagamentoModel>? nfeInformacaoPagamentoModelList) { 
		List<NfeInformacaoPagamentoGrouped> nfeInformacaoPagamentoGroupedList = [];
		if (nfeInformacaoPagamentoModelList != null) {
			for (var nfeInformacaoPagamentoModel in nfeInformacaoPagamentoModelList) {
				nfeInformacaoPagamentoGroupedList.add(
					NfeInformacaoPagamentoGrouped(
						nfeInformacaoPagamento: NfeInformacaoPagamento(
							id: nfeInformacaoPagamentoModel.id,
							idNfeCabecalho: nfeInformacaoPagamentoModel.idNfeCabecalho,
							indicadorPagamento: NfeInformacaoPagamentoDomain.setIndicadorPagamento(nfeInformacaoPagamentoModel.indicadorPagamento),
							meioPagamento: NfeInformacaoPagamentoDomain.setMeioPagamento(nfeInformacaoPagamentoModel.meioPagamento),
							valor: nfeInformacaoPagamentoModel.valor,
							tipoIntegracao: NfeInformacaoPagamentoDomain.setTipoIntegracao(nfeInformacaoPagamentoModel.tipoIntegracao),
							cnpjOperadoraCartao: Util.removeMask(nfeInformacaoPagamentoModel.cnpjOperadoraCartao),
							bandeira: NfeInformacaoPagamentoDomain.setBandeira(nfeInformacaoPagamentoModel.bandeira),
							numeroAutorizacao: nfeInformacaoPagamentoModel.numeroAutorizacao,
							troco: nfeInformacaoPagamentoModel.troco,
						),
					),
				);
			}
			return nfeInformacaoPagamentoGroupedList;
		}
		return [];
	}

	List<NfeResponsavelTecnicoGrouped> nfeResponsavelTecnicoModelToDrift(List<NfeResponsavelTecnicoModel>? nfeResponsavelTecnicoModelList) { 
		List<NfeResponsavelTecnicoGrouped> nfeResponsavelTecnicoGroupedList = [];
		if (nfeResponsavelTecnicoModelList != null) {
			for (var nfeResponsavelTecnicoModel in nfeResponsavelTecnicoModelList) {
				nfeResponsavelTecnicoGroupedList.add(
					NfeResponsavelTecnicoGrouped(
						nfeResponsavelTecnico: NfeResponsavelTecnico(
							id: nfeResponsavelTecnicoModel.id,
							idNfeCabecalho: nfeResponsavelTecnicoModel.idNfeCabecalho,
							cnpj: Util.removeMask(nfeResponsavelTecnicoModel.cnpj),
							contato: nfeResponsavelTecnicoModel.contato,
							email: nfeResponsavelTecnicoModel.email,
							telefone: nfeResponsavelTecnicoModel.telefone,
							identificadorCsrt: NfeResponsavelTecnicoDomain.setIdentificadorCsrt(nfeResponsavelTecnicoModel.identificadorCsrt),
							hashCsrt: nfeResponsavelTecnicoModel.hashCsrt,
						),
					),
				);
			}
			return nfeResponsavelTecnicoGroupedList;
		}
		return [];
	}

	List<NfeCteReferenciadoGrouped> nfeCteReferenciadoModelToDrift(List<NfeCteReferenciadoModel>? nfeCteReferenciadoModelList) { 
		List<NfeCteReferenciadoGrouped> nfeCteReferenciadoGroupedList = [];
		if (nfeCteReferenciadoModelList != null) {
			for (var nfeCteReferenciadoModel in nfeCteReferenciadoModelList) {
				nfeCteReferenciadoGroupedList.add(
					NfeCteReferenciadoGrouped(
						nfeCteReferenciado: NfeCteReferenciado(
							id: nfeCteReferenciadoModel.id,
							idNfeCabecalho: nfeCteReferenciadoModel.idNfeCabecalho,
							chaveAcesso: nfeCteReferenciadoModel.chaveAcesso,
						),
					),
				);
			}
			return nfeCteReferenciadoGroupedList;
		}
		return [];
	}

	List<NfeCupomFiscalReferenciadoGrouped> nfeCupomFiscalReferenciadoModelToDrift(List<NfeCupomFiscalReferenciadoModel>? nfeCupomFiscalReferenciadoModelList) { 
		List<NfeCupomFiscalReferenciadoGrouped> nfeCupomFiscalReferenciadoGroupedList = [];
		if (nfeCupomFiscalReferenciadoModelList != null) {
			for (var nfeCupomFiscalReferenciadoModel in nfeCupomFiscalReferenciadoModelList) {
				nfeCupomFiscalReferenciadoGroupedList.add(
					NfeCupomFiscalReferenciadoGrouped(
						nfeCupomFiscalReferenciado: NfeCupomFiscalReferenciado(
							id: nfeCupomFiscalReferenciadoModel.id,
							idNfeCabecalho: nfeCupomFiscalReferenciadoModel.idNfeCabecalho,
							modeloDocumentoFiscal: NfeCupomFiscalReferenciadoDomain.setModeloDocumentoFiscal(nfeCupomFiscalReferenciadoModel.modeloDocumentoFiscal),
							numeroOrdemEcf: nfeCupomFiscalReferenciadoModel.numeroOrdemEcf,
							coo: nfeCupomFiscalReferenciadoModel.coo,
							dataEmissaoCupom: nfeCupomFiscalReferenciadoModel.dataEmissaoCupom,
							numeroCaixa: nfeCupomFiscalReferenciadoModel.numeroCaixa,
							numeroSerieEcf: nfeCupomFiscalReferenciadoModel.numeroSerieEcf,
						),
					),
				);
			}
			return nfeCupomFiscalReferenciadoGroupedList;
		}
		return [];
	}

		
}
