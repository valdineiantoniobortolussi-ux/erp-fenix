import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeCabecalhoModel {
	int? id;
	String? ufEmitente;
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
	int? idVendaCabecalho;
	int? idTributOperacaoFiscal;
	int? idCliente;
	int? idColaborador;
	int? idFornecedor;
	List<NfeReferenciadaModel>? nfeReferenciadaModelList;
	List<NfeEmitenteModel>? nfeEmitenteModelList;
	List<NfeDestinatarioModel>? nfeDestinatarioModelList;
	List<NfeLocalRetiradaModel>? nfeLocalRetiradaModelList;
	List<NfeLocalEntregaModel>? nfeLocalEntregaModelList;
	List<NfeTransporteModel>? nfeTransporteModelList;
	List<NfeFaturaModel>? nfeFaturaModelList;
	List<NfeCanaModel>? nfeCanaModelList;
	List<NfeProdRuralReferenciadaModel>? nfeProdRuralReferenciadaModelList;
	List<NfeNfReferenciadaModel>? nfeNfReferenciadaModelList;
	List<NfeProcessoReferenciadoModel>? nfeProcessoReferenciadoModelList;
	List<NfeAcessoXmlModel>? nfeAcessoXmlModelList;
	List<NfeInformacaoPagamentoModel>? nfeInformacaoPagamentoModelList;
	List<NfeResponsavelTecnicoModel>? nfeResponsavelTecnicoModelList;
	TributOperacaoFiscalModel? tributOperacaoFiscalModel;
	VendaCabecalhoModel? vendaCabecalhoModel;
	ViewPessoaClienteModel? viewPessoaClienteModel;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;
	List<NfeCteReferenciadoModel>? nfeCteReferenciadoModelList;
	List<NfeCupomFiscalReferenciadoModel>? nfeCupomFiscalReferenciadoModelList;

	NfeCabecalhoModel({
		this.id,
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
		this.idVendaCabecalho,
		this.idTributOperacaoFiscal,
		this.idCliente,
		this.idColaborador,
		this.idFornecedor,
		this.nfeReferenciadaModelList,
		this.nfeEmitenteModelList,
		this.nfeDestinatarioModelList,
		this.nfeLocalRetiradaModelList,
		this.nfeLocalEntregaModelList,
		this.nfeTransporteModelList,
		this.nfeFaturaModelList,
		this.nfeCanaModelList,
		this.nfeProdRuralReferenciadaModelList,
		this.nfeNfReferenciadaModelList,
		this.nfeProcessoReferenciadoModelList,
		this.nfeAcessoXmlModelList,
		this.nfeInformacaoPagamentoModelList,
		this.nfeResponsavelTecnicoModelList,
		this.tributOperacaoFiscalModel,
		this.vendaCabecalhoModel,
		this.viewPessoaClienteModel,
		this.viewPessoaColaboradorModel,
		this.viewPessoaFornecedorModel,
		this.nfeCteReferenciadoModelList,
		this.nfeCupomFiscalReferenciadoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
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
		'regime_especial_nfe',
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
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
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
	];

	NfeCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		ufEmitente = NfeCabecalhoDomain.getUfEmitente(jsonData['ufEmitente']);
		codigoNumerico = jsonData['codigoNumerico'];
		naturezaOperacao = jsonData['naturezaOperacao'];
		codigoModelo = NfeCabecalhoDomain.getCodigoModelo(jsonData['codigoModelo']);
		serie = jsonData['serie'];
		numero = jsonData['numero'];
		dataHoraEmissao = jsonData['dataHoraEmissao'] != null ? DateTime.tryParse(jsonData['dataHoraEmissao']) : null;
		dataHoraEntradaSaida = jsonData['dataHoraEntradaSaida'] != null ? DateTime.tryParse(jsonData['dataHoraEntradaSaida']) : null;
		tipoOperacao = NfeCabecalhoDomain.getTipoOperacao(jsonData['tipoOperacao']);
		localDestino = NfeCabecalhoDomain.getLocalDestino(jsonData['localDestino']);
		codigoMunicipio = jsonData['codigoMunicipio'];
		formatoImpressaoDanfe = NfeCabecalhoDomain.getFormatoImpressaoDanfe(jsonData['formatoImpressaoDanfe']);
		tipoEmissao = NfeCabecalhoDomain.getTipoEmissao(jsonData['tipoEmissao']);
		chaveAcesso = jsonData['chaveAcesso'];
		digitoChaveAcesso = jsonData['digitoChaveAcesso'];
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
		idVendaCabecalho = jsonData['idVendaCabecalho'];
		idTributOperacaoFiscal = jsonData['idTributOperacaoFiscal'];
		idCliente = jsonData['idCliente'];
		idColaborador = jsonData['idColaborador'];
		idFornecedor = jsonData['idFornecedor'];
		nfeReferenciadaModelList = (jsonData['nfeReferenciadaModelList'] as Iterable?)?.map((m) => NfeReferenciadaModel.fromJson(m)).toList() ?? [];
		nfeEmitenteModelList = (jsonData['nfeEmitenteModelList'] as Iterable?)?.map((m) => NfeEmitenteModel.fromJson(m)).toList() ?? [];
		nfeDestinatarioModelList = (jsonData['nfeDestinatarioModelList'] as Iterable?)?.map((m) => NfeDestinatarioModel.fromJson(m)).toList() ?? [];
		nfeLocalRetiradaModelList = (jsonData['nfeLocalRetiradaModelList'] as Iterable?)?.map((m) => NfeLocalRetiradaModel.fromJson(m)).toList() ?? [];
		nfeLocalEntregaModelList = (jsonData['nfeLocalEntregaModelList'] as Iterable?)?.map((m) => NfeLocalEntregaModel.fromJson(m)).toList() ?? [];
		nfeTransporteModelList = (jsonData['nfeTransporteModelList'] as Iterable?)?.map((m) => NfeTransporteModel.fromJson(m)).toList() ?? [];
		nfeFaturaModelList = (jsonData['nfeFaturaModelList'] as Iterable?)?.map((m) => NfeFaturaModel.fromJson(m)).toList() ?? [];
		nfeCanaModelList = (jsonData['nfeCanaModelList'] as Iterable?)?.map((m) => NfeCanaModel.fromJson(m)).toList() ?? [];
		nfeProdRuralReferenciadaModelList = (jsonData['nfeProdRuralReferenciadaModelList'] as Iterable?)?.map((m) => NfeProdRuralReferenciadaModel.fromJson(m)).toList() ?? [];
		nfeNfReferenciadaModelList = (jsonData['nfeNfReferenciadaModelList'] as Iterable?)?.map((m) => NfeNfReferenciadaModel.fromJson(m)).toList() ?? [];
		nfeProcessoReferenciadoModelList = (jsonData['nfeProcessoReferenciadoModelList'] as Iterable?)?.map((m) => NfeProcessoReferenciadoModel.fromJson(m)).toList() ?? [];
		nfeAcessoXmlModelList = (jsonData['nfeAcessoXmlModelList'] as Iterable?)?.map((m) => NfeAcessoXmlModel.fromJson(m)).toList() ?? [];
		nfeInformacaoPagamentoModelList = (jsonData['nfeInformacaoPagamentoModelList'] as Iterable?)?.map((m) => NfeInformacaoPagamentoModel.fromJson(m)).toList() ?? [];
		nfeResponsavelTecnicoModelList = (jsonData['nfeResponsavelTecnicoModelList'] as Iterable?)?.map((m) => NfeResponsavelTecnicoModel.fromJson(m)).toList() ?? [];
		tributOperacaoFiscalModel = jsonData['tributOperacaoFiscalModel'] == null ? TributOperacaoFiscalModel() : TributOperacaoFiscalModel.fromJson(jsonData['tributOperacaoFiscalModel']);
		vendaCabecalhoModel = jsonData['vendaCabecalhoModel'] == null ? VendaCabecalhoModel() : VendaCabecalhoModel.fromJson(jsonData['vendaCabecalhoModel']);
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
		nfeCteReferenciadoModelList = (jsonData['nfeCteReferenciadoModelList'] as Iterable?)?.map((m) => NfeCteReferenciadoModel.fromJson(m)).toList() ?? [];
		nfeCupomFiscalReferenciadoModelList = (jsonData['nfeCupomFiscalReferenciadoModelList'] as Iterable?)?.map((m) => NfeCupomFiscalReferenciadoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['ufEmitente'] = NfeCabecalhoDomain.setUfEmitente(ufEmitente);
		jsonData['codigoNumerico'] = codigoNumerico;
		jsonData['naturezaOperacao'] = naturezaOperacao;
		jsonData['codigoModelo'] = NfeCabecalhoDomain.setCodigoModelo(codigoModelo);
		jsonData['serie'] = serie;
		jsonData['numero'] = numero;
		jsonData['dataHoraEmissao'] = dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEmissao!) : null;
		jsonData['dataHoraEntradaSaida'] = dataHoraEntradaSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEntradaSaida!) : null;
		jsonData['tipoOperacao'] = NfeCabecalhoDomain.setTipoOperacao(tipoOperacao);
		jsonData['localDestino'] = NfeCabecalhoDomain.setLocalDestino(localDestino);
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['formatoImpressaoDanfe'] = NfeCabecalhoDomain.setFormatoImpressaoDanfe(formatoImpressaoDanfe);
		jsonData['tipoEmissao'] = NfeCabecalhoDomain.setTipoEmissao(tipoEmissao);
		jsonData['chaveAcesso'] = chaveAcesso;
		jsonData['digitoChaveAcesso'] = digitoChaveAcesso;
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
		jsonData['idVendaCabecalho'] = idVendaCabecalho != 0 ? idVendaCabecalho : null;
		jsonData['idTributOperacaoFiscal'] = idTributOperacaoFiscal != 0 ? idTributOperacaoFiscal : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		
		var nfeReferenciadaModelLocalList = []; 
		for (NfeReferenciadaModel object in nfeReferenciadaModelList ?? []) { 
			nfeReferenciadaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeReferenciadaModelList'] = nfeReferenciadaModelLocalList;
		
		var nfeEmitenteModelLocalList = []; 
		for (NfeEmitenteModel object in nfeEmitenteModelList ?? []) { 
			nfeEmitenteModelLocalList.add(object.toJson); 
		}
		jsonData['nfeEmitenteModelList'] = nfeEmitenteModelLocalList;
		
		var nfeDestinatarioModelLocalList = []; 
		for (NfeDestinatarioModel object in nfeDestinatarioModelList ?? []) { 
			nfeDestinatarioModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDestinatarioModelList'] = nfeDestinatarioModelLocalList;
		
		var nfeLocalRetiradaModelLocalList = []; 
		for (NfeLocalRetiradaModel object in nfeLocalRetiradaModelList ?? []) { 
			nfeLocalRetiradaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeLocalRetiradaModelList'] = nfeLocalRetiradaModelLocalList;
		
		var nfeLocalEntregaModelLocalList = []; 
		for (NfeLocalEntregaModel object in nfeLocalEntregaModelList ?? []) { 
			nfeLocalEntregaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeLocalEntregaModelList'] = nfeLocalEntregaModelLocalList;
		
		var nfeTransporteModelLocalList = []; 
		for (NfeTransporteModel object in nfeTransporteModelList ?? []) { 
			nfeTransporteModelLocalList.add(object.toJson); 
		}
		jsonData['nfeTransporteModelList'] = nfeTransporteModelLocalList;
		
		var nfeFaturaModelLocalList = []; 
		for (NfeFaturaModel object in nfeFaturaModelList ?? []) { 
			nfeFaturaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeFaturaModelList'] = nfeFaturaModelLocalList;
		
		var nfeCanaModelLocalList = []; 
		for (NfeCanaModel object in nfeCanaModelList ?? []) { 
			nfeCanaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeCanaModelList'] = nfeCanaModelLocalList;
		
		var nfeProdRuralReferenciadaModelLocalList = []; 
		for (NfeProdRuralReferenciadaModel object in nfeProdRuralReferenciadaModelList ?? []) { 
			nfeProdRuralReferenciadaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeProdRuralReferenciadaModelList'] = nfeProdRuralReferenciadaModelLocalList;
		
		var nfeNfReferenciadaModelLocalList = []; 
		for (NfeNfReferenciadaModel object in nfeNfReferenciadaModelList ?? []) { 
			nfeNfReferenciadaModelLocalList.add(object.toJson); 
		}
		jsonData['nfeNfReferenciadaModelList'] = nfeNfReferenciadaModelLocalList;
		
		var nfeProcessoReferenciadoModelLocalList = []; 
		for (NfeProcessoReferenciadoModel object in nfeProcessoReferenciadoModelList ?? []) { 
			nfeProcessoReferenciadoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeProcessoReferenciadoModelList'] = nfeProcessoReferenciadoModelLocalList;
		
		var nfeAcessoXmlModelLocalList = []; 
		for (NfeAcessoXmlModel object in nfeAcessoXmlModelList ?? []) { 
			nfeAcessoXmlModelLocalList.add(object.toJson); 
		}
		jsonData['nfeAcessoXmlModelList'] = nfeAcessoXmlModelLocalList;
		
		var nfeInformacaoPagamentoModelLocalList = []; 
		for (NfeInformacaoPagamentoModel object in nfeInformacaoPagamentoModelList ?? []) { 
			nfeInformacaoPagamentoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeInformacaoPagamentoModelList'] = nfeInformacaoPagamentoModelLocalList;
		
		var nfeResponsavelTecnicoModelLocalList = []; 
		for (NfeResponsavelTecnicoModel object in nfeResponsavelTecnicoModelList ?? []) { 
			nfeResponsavelTecnicoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeResponsavelTecnicoModelList'] = nfeResponsavelTecnicoModelLocalList;
		jsonData['tributOperacaoFiscalModel'] = tributOperacaoFiscalModel?.toJson;
		jsonData['vendaCabecalhoModel'] = vendaCabecalhoModel?.toJson;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
		
		var nfeCteReferenciadoModelLocalList = []; 
		for (NfeCteReferenciadoModel object in nfeCteReferenciadoModelList ?? []) { 
			nfeCteReferenciadoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeCteReferenciadoModelList'] = nfeCteReferenciadoModelLocalList;
		
		var nfeCupomFiscalReferenciadoModelLocalList = []; 
		for (NfeCupomFiscalReferenciadoModel object in nfeCupomFiscalReferenciadoModelList ?? []) { 
			nfeCupomFiscalReferenciadoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeCupomFiscalReferenciadoModelList'] = nfeCupomFiscalReferenciadoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		ufEmitente = plutoRow.cells['ufEmitente']?.value != '' ? plutoRow.cells['ufEmitente']?.value : 'AC';
		codigoNumerico = plutoRow.cells['codigoNumerico']?.value;
		naturezaOperacao = plutoRow.cells['naturezaOperacao']?.value;
		codigoModelo = plutoRow.cells['codigoModelo']?.value != '' ? plutoRow.cells['codigoModelo']?.value : '55';
		serie = plutoRow.cells['serie']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataHoraEmissao = Util.stringToDate(plutoRow.cells['dataHoraEmissao']?.value);
		dataHoraEntradaSaida = Util.stringToDate(plutoRow.cells['dataHoraEntradaSaida']?.value);
		tipoOperacao = plutoRow.cells['tipoOperacao']?.value != '' ? plutoRow.cells['tipoOperacao']?.value : '0=Entrada';
		localDestino = plutoRow.cells['localDestino']?.value != '' ? plutoRow.cells['localDestino']?.value : '1=Operação interna';
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		formatoImpressaoDanfe = plutoRow.cells['formatoImpressaoDanfe']?.value != '' ? plutoRow.cells['formatoImpressaoDanfe']?.value : '0=Sem geração de DANFE';
		tipoEmissao = plutoRow.cells['tipoEmissao']?.value != '' ? plutoRow.cells['tipoEmissao']?.value : '1=Emissão normal';
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
		digitoChaveAcesso = plutoRow.cells['digitoChaveAcesso']?.value;
		ambiente = plutoRow.cells['ambiente']?.value != '' ? plutoRow.cells['ambiente']?.value : '1=Produção';
		finalidadeEmissao = plutoRow.cells['finalidadeEmissao']?.value != '' ? plutoRow.cells['finalidadeEmissao']?.value : '1=NF-e normal';
		consumidorOperacao = plutoRow.cells['consumidorOperacao']?.value != '' ? plutoRow.cells['consumidorOperacao']?.value : '0=Normal';
		consumidorPresenca = plutoRow.cells['consumidorPresenca']?.value != '' ? plutoRow.cells['consumidorPresenca']?.value : '0=Não se aplica';
		processoEmissao = plutoRow.cells['processoEmissao']?.value != '' ? plutoRow.cells['processoEmissao']?.value : '0=Emissão de NF-e com aplicativo do contribuinte';
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
		regimeEspecialTributacao = plutoRow.cells['regimeEspecialTributacao']?.value != '' ? plutoRow.cells['regimeEspecialTributacao']?.value : '0=Emissão de NF-e com aplicativo do contribuinte';
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
		statusNota = plutoRow.cells['statusNota']?.value != '' ? plutoRow.cells['statusNota']?.value : '1-Salva';
		idVendaCabecalho = plutoRow.cells['idVendaCabecalho']?.value;
		idTributOperacaoFiscal = plutoRow.cells['idTributOperacaoFiscal']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		nfeReferenciadaModelList = [];
		nfeEmitenteModelList = [];
		nfeDestinatarioModelList = [];
		nfeLocalRetiradaModelList = [];
		nfeLocalEntregaModelList = [];
		nfeTransporteModelList = [];
		nfeFaturaModelList = [];
		nfeCanaModelList = [];
		nfeProdRuralReferenciadaModelList = [];
		nfeNfReferenciadaModelList = [];
		nfeProcessoReferenciadoModelList = [];
		nfeAcessoXmlModelList = [];
		nfeInformacaoPagamentoModelList = [];
		nfeResponsavelTecnicoModelList = [];
		tributOperacaoFiscalModel = TributOperacaoFiscalModel();
		tributOperacaoFiscalModel?.descricao = plutoRow.cells['tributOperacaoFiscalModel']?.value;
		vendaCabecalhoModel = VendaCabecalhoModel();
		vendaCabecalhoModel?.id = plutoRow.cells['vendaCabecalhoModel']?.value;
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
		nfeCteReferenciadoModelList = [];
		nfeCupomFiscalReferenciadoModelList = [];
	}	

	NfeCabecalhoModel clone() {
		return NfeCabecalhoModel(
			id: id,
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
			idVendaCabecalho: idVendaCabecalho,
			idTributOperacaoFiscal: idTributOperacaoFiscal,
			idCliente: idCliente,
			idColaborador: idColaborador,
			idFornecedor: idFornecedor,
			nfeReferenciadaModelList: nfeReferenciadaModelListClone(nfeReferenciadaModelList!),
			nfeEmitenteModelList: nfeEmitenteModelListClone(nfeEmitenteModelList!),
			nfeDestinatarioModelList: nfeDestinatarioModelListClone(nfeDestinatarioModelList!),
			nfeLocalRetiradaModelList: nfeLocalRetiradaModelListClone(nfeLocalRetiradaModelList!),
			nfeLocalEntregaModelList: nfeLocalEntregaModelListClone(nfeLocalEntregaModelList!),
			nfeTransporteModelList: nfeTransporteModelListClone(nfeTransporteModelList!),
			nfeFaturaModelList: nfeFaturaModelListClone(nfeFaturaModelList!),
			nfeCanaModelList: nfeCanaModelListClone(nfeCanaModelList!),
			nfeProdRuralReferenciadaModelList: nfeProdRuralReferenciadaModelListClone(nfeProdRuralReferenciadaModelList!),
			nfeNfReferenciadaModelList: nfeNfReferenciadaModelListClone(nfeNfReferenciadaModelList!),
			nfeProcessoReferenciadoModelList: nfeProcessoReferenciadoModelListClone(nfeProcessoReferenciadoModelList!),
			nfeAcessoXmlModelList: nfeAcessoXmlModelListClone(nfeAcessoXmlModelList!),
			nfeInformacaoPagamentoModelList: nfeInformacaoPagamentoModelListClone(nfeInformacaoPagamentoModelList!),
			nfeResponsavelTecnicoModelList: nfeResponsavelTecnicoModelListClone(nfeResponsavelTecnicoModelList!),
			nfeCteReferenciadoModelList: nfeCteReferenciadoModelListClone(nfeCteReferenciadoModelList!),
			nfeCupomFiscalReferenciadoModelList: nfeCupomFiscalReferenciadoModelListClone(nfeCupomFiscalReferenciadoModelList!),
		);			
	}

	nfeReferenciadaModelListClone(List<NfeReferenciadaModel> nfeReferenciadaModelList) { 
		List<NfeReferenciadaModel> resultList = [];
		for (var nfeReferenciadaModel in nfeReferenciadaModelList) {
			resultList.add(
				NfeReferenciadaModel(
					id: nfeReferenciadaModel.id,
					idNfeCabecalho: nfeReferenciadaModel.idNfeCabecalho,
					chaveAcesso: nfeReferenciadaModel.chaveAcesso,
				)
			);
		}
		return resultList;
	}

	nfeEmitenteModelListClone(List<NfeEmitenteModel> nfeEmitenteModelList) { 
		List<NfeEmitenteModel> resultList = [];
		for (var nfeEmitenteModel in nfeEmitenteModelList) {
			resultList.add(
				NfeEmitenteModel(
					id: nfeEmitenteModel.id,
					idNfeCabecalho: nfeEmitenteModel.idNfeCabecalho,
					cnpj: nfeEmitenteModel.cnpj,
					cpf: nfeEmitenteModel.cpf,
					nome: nfeEmitenteModel.nome,
					fantasia: nfeEmitenteModel.fantasia,
					logradouro: nfeEmitenteModel.logradouro,
					numero: nfeEmitenteModel.numero,
					complemento: nfeEmitenteModel.complemento,
					bairro: nfeEmitenteModel.bairro,
					codigoMunicipio: nfeEmitenteModel.codigoMunicipio,
					nomeMunicipio: nfeEmitenteModel.nomeMunicipio,
					uf: nfeEmitenteModel.uf,
					cep: nfeEmitenteModel.cep,
					codigoPais: nfeEmitenteModel.codigoPais,
					nomePais: nfeEmitenteModel.nomePais,
					telefone: nfeEmitenteModel.telefone,
					inscricaoEstadual: nfeEmitenteModel.inscricaoEstadual,
					inscricaoEstadualSt: nfeEmitenteModel.inscricaoEstadualSt,
					inscricaoMunicipal: nfeEmitenteModel.inscricaoMunicipal,
					cnae: nfeEmitenteModel.cnae,
					crt: nfeEmitenteModel.crt,
				)
			);
		}
		return resultList;
	}

	nfeDestinatarioModelListClone(List<NfeDestinatarioModel> nfeDestinatarioModelList) { 
		List<NfeDestinatarioModel> resultList = [];
		for (var nfeDestinatarioModel in nfeDestinatarioModelList) {
			resultList.add(
				NfeDestinatarioModel(
					id: nfeDestinatarioModel.id,
					idNfeCabecalho: nfeDestinatarioModel.idNfeCabecalho,
					cnpj: nfeDestinatarioModel.cnpj,
					cpf: nfeDestinatarioModel.cpf,
					estrangeiroIdentificacao: nfeDestinatarioModel.estrangeiroIdentificacao,
					nome: nfeDestinatarioModel.nome,
					logradouro: nfeDestinatarioModel.logradouro,
					numero: nfeDestinatarioModel.numero,
					complemento: nfeDestinatarioModel.complemento,
					bairro: nfeDestinatarioModel.bairro,
					codigoMunicipio: nfeDestinatarioModel.codigoMunicipio,
					nomeMunicipio: nfeDestinatarioModel.nomeMunicipio,
					uf: nfeDestinatarioModel.uf,
					cep: nfeDestinatarioModel.cep,
					codigoPais: nfeDestinatarioModel.codigoPais,
					nomePais: nfeDestinatarioModel.nomePais,
					telefone: nfeDestinatarioModel.telefone,
					indicadorIe: nfeDestinatarioModel.indicadorIe,
					inscricaoEstadual: nfeDestinatarioModel.inscricaoEstadual,
					suframa: nfeDestinatarioModel.suframa,
					inscricaoMunicipal: nfeDestinatarioModel.inscricaoMunicipal,
					email: nfeDestinatarioModel.email,
				)
			);
		}
		return resultList;
	}

	nfeLocalRetiradaModelListClone(List<NfeLocalRetiradaModel> nfeLocalRetiradaModelList) { 
		List<NfeLocalRetiradaModel> resultList = [];
		for (var nfeLocalRetiradaModel in nfeLocalRetiradaModelList) {
			resultList.add(
				NfeLocalRetiradaModel(
					id: nfeLocalRetiradaModel.id,
					idNfeCabecalho: nfeLocalRetiradaModel.idNfeCabecalho,
					cnpj: nfeLocalRetiradaModel.cnpj,
					cpf: nfeLocalRetiradaModel.cpf,
					nomeExpedidor: nfeLocalRetiradaModel.nomeExpedidor,
					logradouro: nfeLocalRetiradaModel.logradouro,
					numero: nfeLocalRetiradaModel.numero,
					complemento: nfeLocalRetiradaModel.complemento,
					bairro: nfeLocalRetiradaModel.bairro,
					codigoMunicipio: nfeLocalRetiradaModel.codigoMunicipio,
					nomeMunicipio: nfeLocalRetiradaModel.nomeMunicipio,
					uf: nfeLocalRetiradaModel.uf,
					cep: nfeLocalRetiradaModel.cep,
					codigoPais: nfeLocalRetiradaModel.codigoPais,
					nomePais: nfeLocalRetiradaModel.nomePais,
					telefone: nfeLocalRetiradaModel.telefone,
					email: nfeLocalRetiradaModel.email,
					inscricaoEstadual: nfeLocalRetiradaModel.inscricaoEstadual,
				)
			);
		}
		return resultList;
	}

	nfeLocalEntregaModelListClone(List<NfeLocalEntregaModel> nfeLocalEntregaModelList) { 
		List<NfeLocalEntregaModel> resultList = [];
		for (var nfeLocalEntregaModel in nfeLocalEntregaModelList) {
			resultList.add(
				NfeLocalEntregaModel(
					id: nfeLocalEntregaModel.id,
					idNfeCabecalho: nfeLocalEntregaModel.idNfeCabecalho,
					cnpj: nfeLocalEntregaModel.cnpj,
					cpf: nfeLocalEntregaModel.cpf,
					nomeRecebedor: nfeLocalEntregaModel.nomeRecebedor,
					logradouro: nfeLocalEntregaModel.logradouro,
					numero: nfeLocalEntregaModel.numero,
					complemento: nfeLocalEntregaModel.complemento,
					bairro: nfeLocalEntregaModel.bairro,
					codigoMunicipio: nfeLocalEntregaModel.codigoMunicipio,
					nomeMunicipio: nfeLocalEntregaModel.nomeMunicipio,
					uf: nfeLocalEntregaModel.uf,
					cep: nfeLocalEntregaModel.cep,
					codigoPais: nfeLocalEntregaModel.codigoPais,
					nomePais: nfeLocalEntregaModel.nomePais,
					telefone: nfeLocalEntregaModel.telefone,
					email: nfeLocalEntregaModel.email,
					inscricaoEstadual: nfeLocalEntregaModel.inscricaoEstadual,
				)
			);
		}
		return resultList;
	}

	nfeTransporteModelListClone(List<NfeTransporteModel> nfeTransporteModelList) { 
		List<NfeTransporteModel> resultList = [];
		for (var nfeTransporteModel in nfeTransporteModelList) {
			resultList.add(
				NfeTransporteModel(
					id: nfeTransporteModel.id,
					idNfeCabecalho: nfeTransporteModel.idNfeCabecalho,
					idTransportadora: nfeTransporteModel.idTransportadora,
					modalidadeFrete: nfeTransporteModel.modalidadeFrete,
					cnpj: nfeTransporteModel.cnpj,
					cpf: nfeTransporteModel.cpf,
					nome: nfeTransporteModel.nome,
					inscricaoEstadual: nfeTransporteModel.inscricaoEstadual,
					endereco: nfeTransporteModel.endereco,
					nomeMunicipio: nfeTransporteModel.nomeMunicipio,
					uf: nfeTransporteModel.uf,
					valorServico: nfeTransporteModel.valorServico,
					valorBcRetencaoIcms: nfeTransporteModel.valorBcRetencaoIcms,
					aliquotaRetencaoIcms: nfeTransporteModel.aliquotaRetencaoIcms,
					valorIcmsRetido: nfeTransporteModel.valorIcmsRetido,
					cfop: nfeTransporteModel.cfop,
					municipio: nfeTransporteModel.municipio,
					placaVeiculo: nfeTransporteModel.placaVeiculo,
					ufVeiculo: nfeTransporteModel.ufVeiculo,
					rntcVeiculo: nfeTransporteModel.rntcVeiculo,
				)
			);
		}
		return resultList;
	}

	nfeFaturaModelListClone(List<NfeFaturaModel> nfeFaturaModelList) { 
		List<NfeFaturaModel> resultList = [];
		for (var nfeFaturaModel in nfeFaturaModelList) {
			resultList.add(
				NfeFaturaModel(
					id: nfeFaturaModel.id,
					idNfeCabecalho: nfeFaturaModel.idNfeCabecalho,
					numero: nfeFaturaModel.numero,
					valorOriginal: nfeFaturaModel.valorOriginal,
					valorDesconto: nfeFaturaModel.valorDesconto,
					valorLiquido: nfeFaturaModel.valorLiquido,
				)
			);
		}
		return resultList;
	}

	nfeCanaModelListClone(List<NfeCanaModel> nfeCanaModelList) { 
		List<NfeCanaModel> resultList = [];
		for (var nfeCanaModel in nfeCanaModelList) {
			resultList.add(
				NfeCanaModel(
					id: nfeCanaModel.id,
					idNfeCabecalho: nfeCanaModel.idNfeCabecalho,
					safra: nfeCanaModel.safra,
					mesAnoReferencia: nfeCanaModel.mesAnoReferencia,
				)
			);
		}
		return resultList;
	}

	nfeProdRuralReferenciadaModelListClone(List<NfeProdRuralReferenciadaModel> nfeProdRuralReferenciadaModelList) { 
		List<NfeProdRuralReferenciadaModel> resultList = [];
		for (var nfeProdRuralReferenciadaModel in nfeProdRuralReferenciadaModelList) {
			resultList.add(
				NfeProdRuralReferenciadaModel(
					id: nfeProdRuralReferenciadaModel.id,
					idNfeCabecalho: nfeProdRuralReferenciadaModel.idNfeCabecalho,
					codigoUf: nfeProdRuralReferenciadaModel.codigoUf,
					anoMes: nfeProdRuralReferenciadaModel.anoMes,
					cnpj: nfeProdRuralReferenciadaModel.cnpj,
					cpf: nfeProdRuralReferenciadaModel.cpf,
					inscricaoEstadual: nfeProdRuralReferenciadaModel.inscricaoEstadual,
					modelo: nfeProdRuralReferenciadaModel.modelo,
					serie: nfeProdRuralReferenciadaModel.serie,
					numeroNf: nfeProdRuralReferenciadaModel.numeroNf,
				)
			);
		}
		return resultList;
	}

	nfeNfReferenciadaModelListClone(List<NfeNfReferenciadaModel> nfeNfReferenciadaModelList) { 
		List<NfeNfReferenciadaModel> resultList = [];
		for (var nfeNfReferenciadaModel in nfeNfReferenciadaModelList) {
			resultList.add(
				NfeNfReferenciadaModel(
					id: nfeNfReferenciadaModel.id,
					idNfeCabecalho: nfeNfReferenciadaModel.idNfeCabecalho,
					codigoUf: nfeNfReferenciadaModel.codigoUf,
					anoMes: nfeNfReferenciadaModel.anoMes,
					cnpj: nfeNfReferenciadaModel.cnpj,
					modelo: nfeNfReferenciadaModel.modelo,
					serie: nfeNfReferenciadaModel.serie,
					numeroNf: nfeNfReferenciadaModel.numeroNf,
				)
			);
		}
		return resultList;
	}

	nfeProcessoReferenciadoModelListClone(List<NfeProcessoReferenciadoModel> nfeProcessoReferenciadoModelList) { 
		List<NfeProcessoReferenciadoModel> resultList = [];
		for (var nfeProcessoReferenciadoModel in nfeProcessoReferenciadoModelList) {
			resultList.add(
				NfeProcessoReferenciadoModel(
					id: nfeProcessoReferenciadoModel.id,
					idNfeCabecalho: nfeProcessoReferenciadoModel.idNfeCabecalho,
					identificador: nfeProcessoReferenciadoModel.identificador,
					origem: nfeProcessoReferenciadoModel.origem,
				)
			);
		}
		return resultList;
	}

	nfeAcessoXmlModelListClone(List<NfeAcessoXmlModel> nfeAcessoXmlModelList) { 
		List<NfeAcessoXmlModel> resultList = [];
		for (var nfeAcessoXmlModel in nfeAcessoXmlModelList) {
			resultList.add(
				NfeAcessoXmlModel(
					id: nfeAcessoXmlModel.id,
					idNfeCabecalho: nfeAcessoXmlModel.idNfeCabecalho,
					cnpj: nfeAcessoXmlModel.cnpj,
					cpf: nfeAcessoXmlModel.cpf,
				)
			);
		}
		return resultList;
	}

	nfeInformacaoPagamentoModelListClone(List<NfeInformacaoPagamentoModel> nfeInformacaoPagamentoModelList) { 
		List<NfeInformacaoPagamentoModel> resultList = [];
		for (var nfeInformacaoPagamentoModel in nfeInformacaoPagamentoModelList) {
			resultList.add(
				NfeInformacaoPagamentoModel(
					id: nfeInformacaoPagamentoModel.id,
					idNfeCabecalho: nfeInformacaoPagamentoModel.idNfeCabecalho,
					indicadorPagamento: nfeInformacaoPagamentoModel.indicadorPagamento,
					meioPagamento: nfeInformacaoPagamentoModel.meioPagamento,
					valor: nfeInformacaoPagamentoModel.valor,
					tipoIntegracao: nfeInformacaoPagamentoModel.tipoIntegracao,
					cnpjOperadoraCartao: nfeInformacaoPagamentoModel.cnpjOperadoraCartao,
					bandeira: nfeInformacaoPagamentoModel.bandeira,
					numeroAutorizacao: nfeInformacaoPagamentoModel.numeroAutorizacao,
					troco: nfeInformacaoPagamentoModel.troco,
				)
			);
		}
		return resultList;
	}

	nfeResponsavelTecnicoModelListClone(List<NfeResponsavelTecnicoModel> nfeResponsavelTecnicoModelList) { 
		List<NfeResponsavelTecnicoModel> resultList = [];
		for (var nfeResponsavelTecnicoModel in nfeResponsavelTecnicoModelList) {
			resultList.add(
				NfeResponsavelTecnicoModel(
					id: nfeResponsavelTecnicoModel.id,
					idNfeCabecalho: nfeResponsavelTecnicoModel.idNfeCabecalho,
					cnpj: nfeResponsavelTecnicoModel.cnpj,
					contato: nfeResponsavelTecnicoModel.contato,
					email: nfeResponsavelTecnicoModel.email,
					telefone: nfeResponsavelTecnicoModel.telefone,
					identificadorCsrt: nfeResponsavelTecnicoModel.identificadorCsrt,
					hashCsrt: nfeResponsavelTecnicoModel.hashCsrt,
				)
			);
		}
		return resultList;
	}

	nfeCteReferenciadoModelListClone(List<NfeCteReferenciadoModel> nfeCteReferenciadoModelList) { 
		List<NfeCteReferenciadoModel> resultList = [];
		for (var nfeCteReferenciadoModel in nfeCteReferenciadoModelList) {
			resultList.add(
				NfeCteReferenciadoModel(
					id: nfeCteReferenciadoModel.id,
					idNfeCabecalho: nfeCteReferenciadoModel.idNfeCabecalho,
					chaveAcesso: nfeCteReferenciadoModel.chaveAcesso,
				)
			);
		}
		return resultList;
	}

	nfeCupomFiscalReferenciadoModelListClone(List<NfeCupomFiscalReferenciadoModel> nfeCupomFiscalReferenciadoModelList) { 
		List<NfeCupomFiscalReferenciadoModel> resultList = [];
		for (var nfeCupomFiscalReferenciadoModel in nfeCupomFiscalReferenciadoModelList) {
			resultList.add(
				NfeCupomFiscalReferenciadoModel(
					id: nfeCupomFiscalReferenciadoModel.id,
					idNfeCabecalho: nfeCupomFiscalReferenciadoModel.idNfeCabecalho,
					modeloDocumentoFiscal: nfeCupomFiscalReferenciadoModel.modeloDocumentoFiscal,
					numeroOrdemEcf: nfeCupomFiscalReferenciadoModel.numeroOrdemEcf,
					coo: nfeCupomFiscalReferenciadoModel.coo,
					dataEmissaoCupom: nfeCupomFiscalReferenciadoModel.dataEmissaoCupom,
					numeroCaixa: nfeCupomFiscalReferenciadoModel.numeroCaixa,
					numeroSerieEcf: nfeCupomFiscalReferenciadoModel.numeroSerieEcf,
				)
			);
		}
		return resultList;
	}

	
}