import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

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
				idVendedor: nfeCabecalhoDrift.nfeCabecalho?.idVendedor,
				ufEmitente: nfeCabecalhoDrift.nfeCabecalho?.ufEmitente,
				codigoNumerico: nfeCabecalhoDrift.nfeCabecalho?.codigoNumerico,
				naturezaOperacao: nfeCabecalhoDrift.nfeCabecalho?.naturezaOperacao,
				codigoModelo: NfeCabecalhoDomain.getCodigoModelo(nfeCabecalhoDrift.nfeCabecalho?.codigoModelo),
				serie: NfeCabecalhoDomain.getSerie(nfeCabecalhoDrift.nfeCabecalho?.serie),
				numero: nfeCabecalhoDrift.nfeCabecalho?.numero,
				dataHoraEmissao: nfeCabecalhoDrift.nfeCabecalho?.dataHoraEmissao,
				dataHoraEntradaSaida: nfeCabecalhoDrift.nfeCabecalho?.dataHoraEntradaSaida,
				tipoOperacao: NfeCabecalhoDomain.getTipoOperacao(nfeCabecalhoDrift.nfeCabecalho?.tipoOperacao),
				localDestino: NfeCabecalhoDomain.getLocalDestino(nfeCabecalhoDrift.nfeCabecalho?.localDestino),
				codigoMunicipio: nfeCabecalhoDrift.nfeCabecalho?.codigoMunicipio,
				formatoImpressaoDanfe: NfeCabecalhoDomain.getFormatoImpressaoDanfe(nfeCabecalhoDrift.nfeCabecalho?.formatoImpressaoDanfe),
				tipoEmissao: NfeCabecalhoDomain.getTipoEmissao(nfeCabecalhoDrift.nfeCabecalho?.tipoEmissao),
				chaveAcesso: nfeCabecalhoDrift.nfeCabecalho?.chaveAcesso,
				digitoChaveAcesso: NfeCabecalhoDomain.getDigitoChaveAcesso(nfeCabecalhoDrift.nfeCabecalho?.digitoChaveAcesso),
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
				idFornecedor: nfeCabecalhoDrift.nfeCabecalho?.idFornecedor,
				idNfceMovimento: nfeCabecalhoDrift.nfeCabecalho?.idNfceMovimento,
				idVendaCabecalho: nfeCabecalhoDrift.nfeCabecalho?.idVendaCabecalho,
				idTributOperacaoFiscal: nfeCabecalhoDrift.nfeCabecalho?.idTributOperacaoFiscal,
				idCliente: nfeCabecalhoDrift.nfeCabecalho?.idCliente,
			);
		} else {
			return null;
		}
	}


	NfeCabecalhoGrouped toDrift(NfeCabecalhoModel nfeCabecalhoModel) {
		return NfeCabecalhoGrouped(
			nfeCabecalho: NfeCabecalho(
				id: nfeCabecalhoModel.id,
				idVendedor: nfeCabecalhoModel.idVendedor,
				ufEmitente: nfeCabecalhoModel.ufEmitente,
				codigoNumerico: nfeCabecalhoModel.codigoNumerico,
				naturezaOperacao: nfeCabecalhoModel.naturezaOperacao,
				codigoModelo: NfeCabecalhoDomain.setCodigoModelo(nfeCabecalhoModel.codigoModelo),
				serie: NfeCabecalhoDomain.setSerie(nfeCabecalhoModel.serie),
				numero: nfeCabecalhoModel.numero,
				dataHoraEmissao: nfeCabecalhoModel.dataHoraEmissao,
				dataHoraEntradaSaida: nfeCabecalhoModel.dataHoraEntradaSaida,
				tipoOperacao: NfeCabecalhoDomain.setTipoOperacao(nfeCabecalhoModel.tipoOperacao),
				localDestino: NfeCabecalhoDomain.setLocalDestino(nfeCabecalhoModel.localDestino),
				codigoMunicipio: nfeCabecalhoModel.codigoMunicipio,
				formatoImpressaoDanfe: NfeCabecalhoDomain.setFormatoImpressaoDanfe(nfeCabecalhoModel.formatoImpressaoDanfe),
				tipoEmissao: NfeCabecalhoDomain.setTipoEmissao(nfeCabecalhoModel.tipoEmissao),
				chaveAcesso: nfeCabecalhoModel.chaveAcesso,
				digitoChaveAcesso: NfeCabecalhoDomain.setDigitoChaveAcesso(nfeCabecalhoModel.digitoChaveAcesso),
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
				idFornecedor: nfeCabecalhoModel.idFornecedor,
				idNfceMovimento: nfeCabecalhoModel.idNfceMovimento,
				idVendaCabecalho: nfeCabecalhoModel.idVendaCabecalho,
				idTributOperacaoFiscal: nfeCabecalhoModel.idTributOperacaoFiscal,
				idCliente: nfeCabecalhoModel.idCliente,
			),
		);
	}

		
}
