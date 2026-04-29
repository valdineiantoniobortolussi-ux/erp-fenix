import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class NfeCabecalhoModel {
	int? id;
	int? idVendedor;
	int? ufEmitente;
	String? codigoNumerico;
	String? naturezaOperacao;
	String? codigoModelo;
	String? serie;
	String? numero;
	DateTime? dataHoraEmissao;
	DateTime? dataHoraEntradaSaida;
	String? tipoOperacao;
	String? localDestino;
	int? codigoMunicipio;
	String? formatoImpressaoDanfe;
	String? tipoEmissao;
	String? chaveAcesso;
	String? digitoChaveAcesso;
	String? ambiente;
	String? finalidadeEmissao;
	String? consumidorOperacao;
	String? consumidorPresenca;
	String? processoEmissao;
	String? versaoProcessoEmissao;
	DateTime? dataEntradaContingencia;
	String? justificativaContingencia;
	double? baseCalculoIcms;
	double? valorIcms;
	double? valorIcmsDesonerado;
	double? totalIcmsFcpUfDestino;
	double? totalIcmsInterestadualUfDestino;
	double? totalIcmsInterestadualUfRemetente;
	double? valorTotalFcp;
	double? baseCalculoIcmsSt;
	double? valorIcmsSt;
	double? valorTotalFcpSt;
	double? valorTotalFcpStRetido;
	double? valorTotalProdutos;
	double? valorFrete;
	double? valorSeguro;
	double? valorDesconto;
	double? valorImpostoImportacao;
	double? valorIpi;
	double? valorIpiDevolvido;
	double? valorPis;
	double? valorCofins;
	double? valorDespesasAcessorias;
	double? valorTotal;
	double? valorTotalTributos;
	double? valorServicos;
	double? baseCalculoIssqn;
	double? valorIssqn;
	double? valorPisIssqn;
	double? valorCofinsIssqn;
	DateTime? dataPrestacaoServico;
	double? valorDeducaoIssqn;
	double? outrasRetencoesIssqn;
	double? descontoIncondicionadoIssqn;
	double? descontoCondicionadoIssqn;
	double? totalRetencaoIssqn;
	String? regimeEspecialTributacao;
	double? valorRetidoPis;
	double? valorRetidoCofins;
	double? valorRetidoCsll;
	double? baseCalculoIrrf;
	double? valorRetidoIrrf;
	double? baseCalculoPrevidencia;
	double? valorRetidoPrevidencia;
	String? informacoesAddFisco;
	String? informacoesAddContribuinte;
	String? comexUfEmbarque;
	String? comexLocalEmbarque;
	String? comexLocalDespacho;
	String? compraNotaEmpenho;
	String? compraPedido;
	String? compraContrato;
	String? qrcode;
	String? urlChave;
	String? statusNota;
	int? idFornecedor;
	int? idNfceMovimento;
	int? idVendaCabecalho;
	int? idTributOperacaoFiscal;
	int? idCliente;

	NfeCabecalhoModel({
		this.id,
		this.idVendedor,
		this.ufEmitente,
		this.codigoNumerico,
		this.naturezaOperacao,
		this.codigoModelo,
		this.serie,
		this.numero,
		this.dataHoraEmissao,
		this.dataHoraEntradaSaida,
		this.tipoOperacao,
		this.localDestino,
		this.codigoMunicipio,
		this.formatoImpressaoDanfe,
		this.tipoEmissao,
		this.chaveAcesso,
		this.digitoChaveAcesso,
		this.ambiente,
		this.finalidadeEmissao,
		this.consumidorOperacao,
		this.consumidorPresenca,
		this.processoEmissao,
		this.versaoProcessoEmissao,
		this.dataEntradaContingencia,
		this.justificativaContingencia,
		this.baseCalculoIcms,
		this.valorIcms,
		this.valorIcmsDesonerado,
		this.totalIcmsFcpUfDestino,
		this.totalIcmsInterestadualUfDestino,
		this.totalIcmsInterestadualUfRemetente,
		this.valorTotalFcp,
		this.baseCalculoIcmsSt,
		this.valorIcmsSt,
		this.valorTotalFcpSt,
		this.valorTotalFcpStRetido,
		this.valorTotalProdutos,
		this.valorFrete,
		this.valorSeguro,
		this.valorDesconto,
		this.valorImpostoImportacao,
		this.valorIpi,
		this.valorIpiDevolvido,
		this.valorPis,
		this.valorCofins,
		this.valorDespesasAcessorias,
		this.valorTotal,
		this.valorTotalTributos,
		this.valorServicos,
		this.baseCalculoIssqn,
		this.valorIssqn,
		this.valorPisIssqn,
		this.valorCofinsIssqn,
		this.dataPrestacaoServico,
		this.valorDeducaoIssqn,
		this.outrasRetencoesIssqn,
		this.descontoIncondicionadoIssqn,
		this.descontoCondicionadoIssqn,
		this.totalRetencaoIssqn,
		this.regimeEspecialTributacao,
		this.valorRetidoPis,
		this.valorRetidoCofins,
		this.valorRetidoCsll,
		this.baseCalculoIrrf,
		this.valorRetidoIrrf,
		this.baseCalculoPrevidencia,
		this.valorRetidoPrevidencia,
		this.informacoesAddFisco,
		this.informacoesAddContribuinte,
		this.comexUfEmbarque,
		this.comexLocalEmbarque,
		this.comexLocalDespacho,
		this.compraNotaEmpenho,
		this.compraPedido,
		this.compraContrato,
		this.qrcode,
		this.urlChave,
		this.statusNota,
		this.idFornecedor,
		this.idNfceMovimento,
		this.idVendaCabecalho,
		this.idTributOperacaoFiscal,
		this.idCliente,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_vendedor',
		'uf_emitente',
		'codigo_numerico',
		'natureza_operacao',
		'codigo_modelo',
		'serie',
		'numero',
		'data_hora_emissao',
		'data_hora_entrada_saida',
		'tipo_operacao',
		'local_destino',
		'codigo_municipio',
		'formato_impressao_danfe',
		'tipo_emissao',
		'chave_acesso',
		'digito_chave_acesso',
		'ambiente',
		'finalidade_emissao',
		'consumidor_operacao',
		'consumidor_presenca',
		'processo_emissao',
		'versao_processo_emissao',
		'data_entrada_contingencia',
		'justificativa_contingencia',
		'base_calculo_icms',
		'valor_icms',
		'valor_icms_desonerado',
		'total_icms_fcp_uf_destino',
		'total_icms_interestadual_uf_destino',
		'total_icms_interestadual_uf_remetente',
		'valor_total_fcp',
		'base_calculo_icms_st',
		'valor_icms_st',
		'valor_total_fcp_st',
		'valor_total_fcp_st_retido',
		'valor_total_produtos',
		'valor_frete',
		'valor_seguro',
		'valor_desconto',
		'valor_imposto_importacao',
		'valor_ipi',
		'valor_ipi_devolvido',
		'valor_pis',
		'valor_cofins',
		'valor_despesas_acessorias',
		'valor_total',
		'valor_total_tributos',
		'valor_servicos',
		'base_calculo_issqn',
		'valor_issqn',
		'valor_pis_issqn',
		'valor_cofins_issqn',
		'data_prestacao_servico',
		'valor_deducao_issqn',
		'outras_retencoes_issqn',
		'desconto_incondicionado_issqn',
		'desconto_condicionado_issqn',
		'total_retencao_issqn',
		'regime_especial_fiscal',
		'valor_retido_pis',
		'valor_retido_cofins',
		'valor_retido_csll',
		'base_calculo_irrf',
		'valor_retido_irrf',
		'base_calculo_previdencia',
		'valor_retido_previdencia',
		'informacoes_add_fisco',
		'informacoes_add_contribuinte',
		'comex_uf_embarque',
		'comex_local_embarque',
		'comex_local_despacho',
		'compra_nota_empenho',
		'compra_pedido',
		'compra_contrato',
		'qrcode',
		'url_chave',
		'status_nota',
		'id_fornecedor',
		'id_nfce_movimento',
		'id_venda_cabecalho',
		'id_tribut_operacao_fiscal',
		'id_cliente',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Vendedor',
		'Uf Emitente',
		'Codigo Numerico',
		'Natureza Operacao',
		'Codigo Modelo',
		'Serie',
		'Numero',
		'Data Hora Emissao',
		'Data Hora Entrada Saida',
		'Tipo Operacao',
		'Local Destino',
		'Codigo Municipio',
		'Formato Impressao Danfe',
		'Tipo Emissao',
		'Chave Acesso',
		'Digito Chave Acesso',
		'Ambiente',
		'Finalidade Emissao',
		'Consumidor Operacao',
		'Consumidor Presenca',
		'Processo Emissao',
		'Versao Processo Emissao',
		'Data Entrada Contingencia',
		'Justificativa Contingencia',
		'Base Calculo Icms',
		'Valor Icms',
		'Valor Icms Desonerado',
		'Total Icms Fcp Uf Destino',
		'Total Icms Interestadual Uf Destino',
		'Total Icms Interestadual Uf Remetente',
		'Valor Total Fcp',
		'Base Calculo Icms St',
		'Valor Icms St',
		'Valor Total Fcp St',
		'Valor Total Fcp St Retido',
		'Valor Total Produtos',
		'Valor Frete',
		'Valor Seguro',
		'Valor Desconto',
		'Valor Imposto Importacao',
		'Valor Ipi',
		'Valor Ipi Devolvido',
		'Valor Pis',
		'Valor Cofins',
		'Valor Despesas Acessorias',
		'Valor Total',
		'Valor Total Tributos',
		'Valor Servicos',
		'Base Calculo Issqn',
		'Valor Issqn',
		'Valor Pis Issqn',
		'Valor Cofins Issqn',
		'Data Prestacao Servico',
		'Valor Deducao Issqn',
		'Outras Retencoes Issqn',
		'Desconto Incondicionado Issqn',
		'Desconto Condicionado Issqn',
		'Total Retencao Issqn',
		'Regime Especial Tributacao',
		'Valor Retido Pis',
		'Valor Retido Cofins',
		'Valor Retido Csll',
		'Base Calculo Irrf',
		'Valor Retido Irrf',
		'Base Calculo Previdencia',
		'Valor Retido Previdencia',
		'Informacoes Add Fisco',
		'Informacoes Add Contribuinte',
		'Comex Uf Embarque',
		'Comex Local Embarque',
		'Comex Local Despacho',
		'Compra Nota Empenho',
		'Compra Pedido',
		'Compra Contrato',
		'Qrcode',
		'Url Chave',
		'Status Nota',
		'Id Fornecedor',
		'Id Nfce Movimento',
		'Id Venda Cabecalho',
		'Id Tribut Operacao Fiscal',
		'Id Cliente',
	];

	NfeCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendedor = jsonData['idVendedor'];
		ufEmitente = jsonData['ufEmitente'];
		codigoNumerico = jsonData['codigoNumerico'];
		naturezaOperacao = jsonData['naturezaOperacao'];
		codigoModelo = NfeCabecalhoDomain.getCodigoModelo(jsonData['codigoModelo']);
		serie = NfeCabecalhoDomain.getSerie(jsonData['serie']);
		numero = jsonData['numero'];
		dataHoraEmissao = jsonData['dataHoraEmissao'] != null ? DateTime.tryParse(jsonData['dataHoraEmissao']) : null;
		dataHoraEntradaSaida = jsonData['dataHoraEntradaSaida'] != null ? DateTime.tryParse(jsonData['dataHoraEntradaSaida']) : null;
		tipoOperacao = NfeCabecalhoDomain.getTipoOperacao(jsonData['tipoOperacao']);
		localDestino = NfeCabecalhoDomain.getLocalDestino(jsonData['localDestino']);
		codigoMunicipio = jsonData['codigoMunicipio'];
		formatoImpressaoDanfe = NfeCabecalhoDomain.getFormatoImpressaoDanfe(jsonData['formatoImpressaoDanfe']);
		tipoEmissao = NfeCabecalhoDomain.getTipoEmissao(jsonData['tipoEmissao']);
		chaveAcesso = jsonData['chaveAcesso'];
		digitoChaveAcesso = NfeCabecalhoDomain.getDigitoChaveAcesso(jsonData['digitoChaveAcesso']);
		ambiente = NfeCabecalhoDomain.getAmbiente(jsonData['ambiente']);
		finalidadeEmissao = NfeCabecalhoDomain.getFinalidadeEmissao(jsonData['finalidadeEmissao']);
		consumidorOperacao = NfeCabecalhoDomain.getConsumidorOperacao(jsonData['consumidorOperacao']);
		consumidorPresenca = NfeCabecalhoDomain.getConsumidorPresenca(jsonData['consumidorPresenca']);
		processoEmissao = NfeCabecalhoDomain.getProcessoEmissao(jsonData['processoEmissao']);
		versaoProcessoEmissao = jsonData['versaoProcessoEmissao'];
		dataEntradaContingencia = jsonData['dataEntradaContingencia'] != null ? DateTime.tryParse(jsonData['dataEntradaContingencia']) : null;
		justificativaContingencia = jsonData['justificativaContingencia'];
		baseCalculoIcms = jsonData['baseCalculoIcms']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		valorIcmsDesonerado = jsonData['valorIcmsDesonerado']?.toDouble();
		totalIcmsFcpUfDestino = jsonData['totalIcmsFcpUfDestino']?.toDouble();
		totalIcmsInterestadualUfDestino = jsonData['totalIcmsInterestadualUfDestino']?.toDouble();
		totalIcmsInterestadualUfRemetente = jsonData['totalIcmsInterestadualUfRemetente']?.toDouble();
		valorTotalFcp = jsonData['valorTotalFcp']?.toDouble();
		baseCalculoIcmsSt = jsonData['baseCalculoIcmsSt']?.toDouble();
		valorIcmsSt = jsonData['valorIcmsSt']?.toDouble();
		valorTotalFcpSt = jsonData['valorTotalFcpSt']?.toDouble();
		valorTotalFcpStRetido = jsonData['valorTotalFcpStRetido']?.toDouble();
		valorTotalProdutos = jsonData['valorTotalProdutos']?.toDouble();
		valorFrete = jsonData['valorFrete']?.toDouble();
		valorSeguro = jsonData['valorSeguro']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorImpostoImportacao = jsonData['valorImpostoImportacao']?.toDouble();
		valorIpi = jsonData['valorIpi']?.toDouble();
		valorIpiDevolvido = jsonData['valorIpiDevolvido']?.toDouble();
		valorPis = jsonData['valorPis']?.toDouble();
		valorCofins = jsonData['valorCofins']?.toDouble();
		valorDespesasAcessorias = jsonData['valorDespesasAcessorias']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		valorTotalTributos = jsonData['valorTotalTributos']?.toDouble();
		valorServicos = jsonData['valorServicos']?.toDouble();
		baseCalculoIssqn = jsonData['baseCalculoIssqn']?.toDouble();
		valorIssqn = jsonData['valorIssqn']?.toDouble();
		valorPisIssqn = jsonData['valorPisIssqn']?.toDouble();
		valorCofinsIssqn = jsonData['valorCofinsIssqn']?.toDouble();
		dataPrestacaoServico = jsonData['dataPrestacaoServico'] != null ? DateTime.tryParse(jsonData['dataPrestacaoServico']) : null;
		valorDeducaoIssqn = jsonData['valorDeducaoIssqn']?.toDouble();
		outrasRetencoesIssqn = jsonData['outrasRetencoesIssqn']?.toDouble();
		descontoIncondicionadoIssqn = jsonData['descontoIncondicionadoIssqn']?.toDouble();
		descontoCondicionadoIssqn = jsonData['descontoCondicionadoIssqn']?.toDouble();
		totalRetencaoIssqn = jsonData['totalRetencaoIssqn']?.toDouble();
		regimeEspecialTributacao = NfeCabecalhoDomain.getRegimeEspecialTributacao(jsonData['regimeEspecialTributacao']);
		valorRetidoPis = jsonData['valorRetidoPis']?.toDouble();
		valorRetidoCofins = jsonData['valorRetidoCofins']?.toDouble();
		valorRetidoCsll = jsonData['valorRetidoCsll']?.toDouble();
		baseCalculoIrrf = jsonData['baseCalculoIrrf']?.toDouble();
		valorRetidoIrrf = jsonData['valorRetidoIrrf']?.toDouble();
		baseCalculoPrevidencia = jsonData['baseCalculoPrevidencia']?.toDouble();
		valorRetidoPrevidencia = jsonData['valorRetidoPrevidencia']?.toDouble();
		informacoesAddFisco = jsonData['informacoesAddFisco'];
		informacoesAddContribuinte = jsonData['informacoesAddContribuinte'];
		comexUfEmbarque = NfeCabecalhoDomain.getComexUfEmbarque(jsonData['comexUfEmbarque']);
		comexLocalEmbarque = jsonData['comexLocalEmbarque'];
		comexLocalDespacho = jsonData['comexLocalDespacho'];
		compraNotaEmpenho = jsonData['compraNotaEmpenho'];
		compraPedido = jsonData['compraPedido'];
		compraContrato = jsonData['compraContrato'];
		qrcode = jsonData['qrcode'];
		urlChave = jsonData['urlChave'];
		statusNota = NfeCabecalhoDomain.getStatusNota(jsonData['statusNota']);
		idFornecedor = jsonData['idFornecedor'];
		idNfceMovimento = jsonData['idNfceMovimento'];
		idVendaCabecalho = jsonData['idVendaCabecalho'];
		idTributOperacaoFiscal = jsonData['idTributOperacaoFiscal'];
		idCliente = jsonData['idCliente'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendedor'] = idVendedor;
		jsonData['ufEmitente'] = ufEmitente;
		jsonData['codigoNumerico'] = codigoNumerico;
		jsonData['naturezaOperacao'] = naturezaOperacao;
		jsonData['codigoModelo'] = NfeCabecalhoDomain.setCodigoModelo(codigoModelo);
		jsonData['serie'] = NfeCabecalhoDomain.setSerie(serie);
		jsonData['numero'] = numero;
		jsonData['dataHoraEmissao'] = dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEmissao!) : null;
		jsonData['dataHoraEntradaSaida'] = dataHoraEntradaSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEntradaSaida!) : null;
		jsonData['tipoOperacao'] = NfeCabecalhoDomain.setTipoOperacao(tipoOperacao);
		jsonData['localDestino'] = NfeCabecalhoDomain.setLocalDestino(localDestino);
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['formatoImpressaoDanfe'] = NfeCabecalhoDomain.setFormatoImpressaoDanfe(formatoImpressaoDanfe);
		jsonData['tipoEmissao'] = NfeCabecalhoDomain.setTipoEmissao(tipoEmissao);
		jsonData['chaveAcesso'] = chaveAcesso;
		jsonData['digitoChaveAcesso'] = NfeCabecalhoDomain.setDigitoChaveAcesso(digitoChaveAcesso);
		jsonData['ambiente'] = NfeCabecalhoDomain.setAmbiente(ambiente);
		jsonData['finalidadeEmissao'] = NfeCabecalhoDomain.setFinalidadeEmissao(finalidadeEmissao);
		jsonData['consumidorOperacao'] = NfeCabecalhoDomain.setConsumidorOperacao(consumidorOperacao);
		jsonData['consumidorPresenca'] = NfeCabecalhoDomain.setConsumidorPresenca(consumidorPresenca);
		jsonData['processoEmissao'] = NfeCabecalhoDomain.setProcessoEmissao(processoEmissao);
		jsonData['versaoProcessoEmissao'] = versaoProcessoEmissao;
		jsonData['dataEntradaContingencia'] = dataEntradaContingencia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEntradaContingencia!) : null;
		jsonData['justificativaContingencia'] = justificativaContingencia;
		jsonData['baseCalculoIcms'] = baseCalculoIcms;
		jsonData['valorIcms'] = valorIcms;
		jsonData['valorIcmsDesonerado'] = valorIcmsDesonerado;
		jsonData['totalIcmsFcpUfDestino'] = totalIcmsFcpUfDestino;
		jsonData['totalIcmsInterestadualUfDestino'] = totalIcmsInterestadualUfDestino;
		jsonData['totalIcmsInterestadualUfRemetente'] = totalIcmsInterestadualUfRemetente;
		jsonData['valorTotalFcp'] = valorTotalFcp;
		jsonData['baseCalculoIcmsSt'] = baseCalculoIcmsSt;
		jsonData['valorIcmsSt'] = valorIcmsSt;
		jsonData['valorTotalFcpSt'] = valorTotalFcpSt;
		jsonData['valorTotalFcpStRetido'] = valorTotalFcpStRetido;
		jsonData['valorTotalProdutos'] = valorTotalProdutos;
		jsonData['valorFrete'] = valorFrete;
		jsonData['valorSeguro'] = valorSeguro;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorImpostoImportacao'] = valorImpostoImportacao;
		jsonData['valorIpi'] = valorIpi;
		jsonData['valorIpiDevolvido'] = valorIpiDevolvido;
		jsonData['valorPis'] = valorPis;
		jsonData['valorCofins'] = valorCofins;
		jsonData['valorDespesasAcessorias'] = valorDespesasAcessorias;
		jsonData['valorTotal'] = valorTotal;
		jsonData['valorTotalTributos'] = valorTotalTributos;
		jsonData['valorServicos'] = valorServicos;
		jsonData['baseCalculoIssqn'] = baseCalculoIssqn;
		jsonData['valorIssqn'] = valorIssqn;
		jsonData['valorPisIssqn'] = valorPisIssqn;
		jsonData['valorCofinsIssqn'] = valorCofinsIssqn;
		jsonData['dataPrestacaoServico'] = dataPrestacaoServico != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrestacaoServico!) : null;
		jsonData['valorDeducaoIssqn'] = valorDeducaoIssqn;
		jsonData['outrasRetencoesIssqn'] = outrasRetencoesIssqn;
		jsonData['descontoIncondicionadoIssqn'] = descontoIncondicionadoIssqn;
		jsonData['descontoCondicionadoIssqn'] = descontoCondicionadoIssqn;
		jsonData['totalRetencaoIssqn'] = totalRetencaoIssqn;
		jsonData['regimeEspecialTributacao'] = NfeCabecalhoDomain.setRegimeEspecialTributacao(regimeEspecialTributacao);
		jsonData['valorRetidoPis'] = valorRetidoPis;
		jsonData['valorRetidoCofins'] = valorRetidoCofins;
		jsonData['valorRetidoCsll'] = valorRetidoCsll;
		jsonData['baseCalculoIrrf'] = baseCalculoIrrf;
		jsonData['valorRetidoIrrf'] = valorRetidoIrrf;
		jsonData['baseCalculoPrevidencia'] = baseCalculoPrevidencia;
		jsonData['valorRetidoPrevidencia'] = valorRetidoPrevidencia;
		jsonData['informacoesAddFisco'] = informacoesAddFisco;
		jsonData['informacoesAddContribuinte'] = informacoesAddContribuinte;
		jsonData['comexUfEmbarque'] = NfeCabecalhoDomain.setComexUfEmbarque(comexUfEmbarque);
		jsonData['comexLocalEmbarque'] = comexLocalEmbarque;
		jsonData['comexLocalDespacho'] = comexLocalDespacho;
		jsonData['compraNotaEmpenho'] = compraNotaEmpenho;
		jsonData['compraPedido'] = compraPedido;
		jsonData['compraContrato'] = compraContrato;
		jsonData['qrcode'] = qrcode;
		jsonData['urlChave'] = urlChave;
		jsonData['statusNota'] = NfeCabecalhoDomain.setStatusNota(statusNota);
		jsonData['idFornecedor'] = idFornecedor;
		jsonData['idNfceMovimento'] = idNfceMovimento;
		jsonData['idVendaCabecalho'] = idVendaCabecalho;
		jsonData['idTributOperacaoFiscal'] = idTributOperacaoFiscal;
		jsonData['idCliente'] = idCliente;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendedor = plutoRow.cells['idVendedor']?.value;
		ufEmitente = plutoRow.cells['ufEmitente']?.value;
		codigoNumerico = plutoRow.cells['codigoNumerico']?.value;
		naturezaOperacao = plutoRow.cells['naturezaOperacao']?.value;
		codigoModelo = plutoRow.cells['codigoModelo']?.value != '' ? plutoRow.cells['codigoModelo']?.value : 'AAA';
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		numero = plutoRow.cells['numero']?.value;
		dataHoraEmissao = Util.stringToDate(plutoRow.cells['dataHoraEmissao']?.value);
		dataHoraEntradaSaida = Util.stringToDate(plutoRow.cells['dataHoraEntradaSaida']?.value);
		tipoOperacao = plutoRow.cells['tipoOperacao']?.value != '' ? plutoRow.cells['tipoOperacao']?.value : 'AAA';
		localDestino = plutoRow.cells['localDestino']?.value != '' ? plutoRow.cells['localDestino']?.value : 'AAA';
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		formatoImpressaoDanfe = plutoRow.cells['formatoImpressaoDanfe']?.value != '' ? plutoRow.cells['formatoImpressaoDanfe']?.value : 'AAA';
		tipoEmissao = plutoRow.cells['tipoEmissao']?.value != '' ? plutoRow.cells['tipoEmissao']?.value : 'AAA';
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
		digitoChaveAcesso = plutoRow.cells['digitoChaveAcesso']?.value != '' ? plutoRow.cells['digitoChaveAcesso']?.value : 'AAA';
		ambiente = plutoRow.cells['ambiente']?.value != '' ? plutoRow.cells['ambiente']?.value : 'AAA';
		finalidadeEmissao = plutoRow.cells['finalidadeEmissao']?.value != '' ? plutoRow.cells['finalidadeEmissao']?.value : 'AAA';
		consumidorOperacao = plutoRow.cells['consumidorOperacao']?.value != '' ? plutoRow.cells['consumidorOperacao']?.value : 'AAA';
		consumidorPresenca = plutoRow.cells['consumidorPresenca']?.value != '' ? plutoRow.cells['consumidorPresenca']?.value : 'AAA';
		processoEmissao = plutoRow.cells['processoEmissao']?.value != '' ? plutoRow.cells['processoEmissao']?.value : 'AAA';
		versaoProcessoEmissao = plutoRow.cells['versaoProcessoEmissao']?.value;
		dataEntradaContingencia = Util.stringToDate(plutoRow.cells['dataEntradaContingencia']?.value);
		justificativaContingencia = plutoRow.cells['justificativaContingencia']?.value;
		baseCalculoIcms = plutoRow.cells['baseCalculoIcms']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		valorIcmsDesonerado = plutoRow.cells['valorIcmsDesonerado']?.value?.toDouble();
		totalIcmsFcpUfDestino = plutoRow.cells['totalIcmsFcpUfDestino']?.value?.toDouble();
		totalIcmsInterestadualUfDestino = plutoRow.cells['totalIcmsInterestadualUfDestino']?.value?.toDouble();
		totalIcmsInterestadualUfRemetente = plutoRow.cells['totalIcmsInterestadualUfRemetente']?.value?.toDouble();
		valorTotalFcp = plutoRow.cells['valorTotalFcp']?.value?.toDouble();
		baseCalculoIcmsSt = plutoRow.cells['baseCalculoIcmsSt']?.value?.toDouble();
		valorIcmsSt = plutoRow.cells['valorIcmsSt']?.value?.toDouble();
		valorTotalFcpSt = plutoRow.cells['valorTotalFcpSt']?.value?.toDouble();
		valorTotalFcpStRetido = plutoRow.cells['valorTotalFcpStRetido']?.value?.toDouble();
		valorTotalProdutos = plutoRow.cells['valorTotalProdutos']?.value?.toDouble();
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		valorSeguro = plutoRow.cells['valorSeguro']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorImpostoImportacao = plutoRow.cells['valorImpostoImportacao']?.value?.toDouble();
		valorIpi = plutoRow.cells['valorIpi']?.value?.toDouble();
		valorIpiDevolvido = plutoRow.cells['valorIpiDevolvido']?.value?.toDouble();
		valorPis = plutoRow.cells['valorPis']?.value?.toDouble();
		valorCofins = plutoRow.cells['valorCofins']?.value?.toDouble();
		valorDespesasAcessorias = plutoRow.cells['valorDespesasAcessorias']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		valorTotalTributos = plutoRow.cells['valorTotalTributos']?.value?.toDouble();
		valorServicos = plutoRow.cells['valorServicos']?.value?.toDouble();
		baseCalculoIssqn = plutoRow.cells['baseCalculoIssqn']?.value?.toDouble();
		valorIssqn = plutoRow.cells['valorIssqn']?.value?.toDouble();
		valorPisIssqn = plutoRow.cells['valorPisIssqn']?.value?.toDouble();
		valorCofinsIssqn = plutoRow.cells['valorCofinsIssqn']?.value?.toDouble();
		dataPrestacaoServico = Util.stringToDate(plutoRow.cells['dataPrestacaoServico']?.value);
		valorDeducaoIssqn = plutoRow.cells['valorDeducaoIssqn']?.value?.toDouble();
		outrasRetencoesIssqn = plutoRow.cells['outrasRetencoesIssqn']?.value?.toDouble();
		descontoIncondicionadoIssqn = plutoRow.cells['descontoIncondicionadoIssqn']?.value?.toDouble();
		descontoCondicionadoIssqn = plutoRow.cells['descontoCondicionadoIssqn']?.value?.toDouble();
		totalRetencaoIssqn = plutoRow.cells['totalRetencaoIssqn']?.value?.toDouble();
		regimeEspecialTributacao = plutoRow.cells['regimeEspecialTributacao']?.value != '' ? plutoRow.cells['regimeEspecialTributacao']?.value : 'AAA';
		valorRetidoPis = plutoRow.cells['valorRetidoPis']?.value?.toDouble();
		valorRetidoCofins = plutoRow.cells['valorRetidoCofins']?.value?.toDouble();
		valorRetidoCsll = plutoRow.cells['valorRetidoCsll']?.value?.toDouble();
		baseCalculoIrrf = plutoRow.cells['baseCalculoIrrf']?.value?.toDouble();
		valorRetidoIrrf = plutoRow.cells['valorRetidoIrrf']?.value?.toDouble();
		baseCalculoPrevidencia = plutoRow.cells['baseCalculoPrevidencia']?.value?.toDouble();
		valorRetidoPrevidencia = plutoRow.cells['valorRetidoPrevidencia']?.value?.toDouble();
		informacoesAddFisco = plutoRow.cells['informacoesAddFisco']?.value;
		informacoesAddContribuinte = plutoRow.cells['informacoesAddContribuinte']?.value;
		comexUfEmbarque = plutoRow.cells['comexUfEmbarque']?.value != '' ? plutoRow.cells['comexUfEmbarque']?.value : 'AC';
		comexLocalEmbarque = plutoRow.cells['comexLocalEmbarque']?.value;
		comexLocalDespacho = plutoRow.cells['comexLocalDespacho']?.value;
		compraNotaEmpenho = plutoRow.cells['compraNotaEmpenho']?.value;
		compraPedido = plutoRow.cells['compraPedido']?.value;
		compraContrato = plutoRow.cells['compraContrato']?.value;
		qrcode = plutoRow.cells['qrcode']?.value;
		urlChave = plutoRow.cells['urlChave']?.value;
		statusNota = plutoRow.cells['statusNota']?.value != '' ? plutoRow.cells['statusNota']?.value : 'AAA';
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		idNfceMovimento = plutoRow.cells['idNfceMovimento']?.value;
		idVendaCabecalho = plutoRow.cells['idVendaCabecalho']?.value;
		idTributOperacaoFiscal = plutoRow.cells['idTributOperacaoFiscal']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
	}	

	NfeCabecalhoModel clone() {
		return NfeCabecalhoModel(
			id: id,
			idVendedor: idVendedor,
			ufEmitente: ufEmitente,
			codigoNumerico: codigoNumerico,
			naturezaOperacao: naturezaOperacao,
			codigoModelo: codigoModelo,
			serie: serie,
			numero: numero,
			dataHoraEmissao: dataHoraEmissao,
			dataHoraEntradaSaida: dataHoraEntradaSaida,
			tipoOperacao: tipoOperacao,
			localDestino: localDestino,
			codigoMunicipio: codigoMunicipio,
			formatoImpressaoDanfe: formatoImpressaoDanfe,
			tipoEmissao: tipoEmissao,
			chaveAcesso: chaveAcesso,
			digitoChaveAcesso: digitoChaveAcesso,
			ambiente: ambiente,
			finalidadeEmissao: finalidadeEmissao,
			consumidorOperacao: consumidorOperacao,
			consumidorPresenca: consumidorPresenca,
			processoEmissao: processoEmissao,
			versaoProcessoEmissao: versaoProcessoEmissao,
			dataEntradaContingencia: dataEntradaContingencia,
			justificativaContingencia: justificativaContingencia,
			baseCalculoIcms: baseCalculoIcms,
			valorIcms: valorIcms,
			valorIcmsDesonerado: valorIcmsDesonerado,
			totalIcmsFcpUfDestino: totalIcmsFcpUfDestino,
			totalIcmsInterestadualUfDestino: totalIcmsInterestadualUfDestino,
			totalIcmsInterestadualUfRemetente: totalIcmsInterestadualUfRemetente,
			valorTotalFcp: valorTotalFcp,
			baseCalculoIcmsSt: baseCalculoIcmsSt,
			valorIcmsSt: valorIcmsSt,
			valorTotalFcpSt: valorTotalFcpSt,
			valorTotalFcpStRetido: valorTotalFcpStRetido,
			valorTotalProdutos: valorTotalProdutos,
			valorFrete: valorFrete,
			valorSeguro: valorSeguro,
			valorDesconto: valorDesconto,
			valorImpostoImportacao: valorImpostoImportacao,
			valorIpi: valorIpi,
			valorIpiDevolvido: valorIpiDevolvido,
			valorPis: valorPis,
			valorCofins: valorCofins,
			valorDespesasAcessorias: valorDespesasAcessorias,
			valorTotal: valorTotal,
			valorTotalTributos: valorTotalTributos,
			valorServicos: valorServicos,
			baseCalculoIssqn: baseCalculoIssqn,
			valorIssqn: valorIssqn,
			valorPisIssqn: valorPisIssqn,
			valorCofinsIssqn: valorCofinsIssqn,
			dataPrestacaoServico: dataPrestacaoServico,
			valorDeducaoIssqn: valorDeducaoIssqn,
			outrasRetencoesIssqn: outrasRetencoesIssqn,
			descontoIncondicionadoIssqn: descontoIncondicionadoIssqn,
			descontoCondicionadoIssqn: descontoCondicionadoIssqn,
			totalRetencaoIssqn: totalRetencaoIssqn,
			regimeEspecialTributacao: regimeEspecialTributacao,
			valorRetidoPis: valorRetidoPis,
			valorRetidoCofins: valorRetidoCofins,
			valorRetidoCsll: valorRetidoCsll,
			baseCalculoIrrf: baseCalculoIrrf,
			valorRetidoIrrf: valorRetidoIrrf,
			baseCalculoPrevidencia: baseCalculoPrevidencia,
			valorRetidoPrevidencia: valorRetidoPrevidencia,
			informacoesAddFisco: informacoesAddFisco,
			informacoesAddContribuinte: informacoesAddContribuinte,
			comexUfEmbarque: comexUfEmbarque,
			comexLocalEmbarque: comexLocalEmbarque,
			comexLocalDespacho: comexLocalDespacho,
			compraNotaEmpenho: compraNotaEmpenho,
			compraPedido: compraPedido,
			compraContrato: compraContrato,
			qrcode: qrcode,
			urlChave: urlChave,
			statusNota: statusNota,
			idFornecedor: idFornecedor,
			idNfceMovimento: idNfceMovimento,
			idVendaCabecalho: idVendaCabecalho,
			idTributOperacaoFiscal: idTributOperacaoFiscal,
			idCliente: idCliente,
		);			
	}

	
}