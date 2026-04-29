import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteCabecalhoModel {
	int? id;
	String? naturezaOperacao;
	String? chaveAcesso;
	String? digitoChaveAcesso;
	String? codigoNumerico;
	String? serie;
	String? numero;
	DateTime? dataHoraEmissao;
	String? ufEmitente;
	int? cfop;
	String? formaPagamento;
	String? modelo;
	String? formatoImpressaoDacte;
	String? tipoEmissao;
	String? ambiente;
	String? tipoCte;
	String? processoEmissao;
	String? versaoProcessoEmissao;
	String? chaveReferenciado;
	int? codigoMunicipioEnvio;
	String? nomeMunicipioEnvio;
	String? ufEnvio;
	String? modal;
	String? tipoServico;
	int? codigoMunicipioIniPrestacao;
	String? nomeMunicipioIniPrestacao;
	String? ufIniPrestacao;
	int? codigoMunicipioFimPrestacao;
	String? nomeMunicipioFimPrestacao;
	String? ufFimPrestacao;
	String? retira;
	String? retiraDetalhe;
	String? tomador;
	DateTime? dataEntradaContingencia;
	String? justificativaContingencia;
	String? caracAdicionalTransporte;
	String? caracAdicionalServico;
	String? funcionarioEmissor;
	String? fluxoOrigem;
	String? entregaTipoPeriodo;
	DateTime? entregaDataProgramada;
	DateTime? entregaDataInicial;
	DateTime? entregaDataFinal;
	String? entregaTipoHora;
	String? entregaHoraProgramada;
	String? entregaHoraInicial;
	String? entregaHoraFinal;
	String? municipioOrigemCalculo;
	String? municipioDestinoCalculo;
	String? observacoesGerais;
	double? valorTotalServico;
	double? valorReceber;
	String? cst;
	double? baseCalculoIcms;
	double? aliquotaIcms;
	double? valorIcms;
	double? percentualReducaoBcIcms;
	double? valorBcIcmsStRetido;
	double? valorIcmsStRetido;
	double? aliquotaIcmsStRetido;
	double? valorCreditoPresumidoIcms;
	double? percentualBcIcmsOutraUf;
	double? valorBcIcmsOutraUf;
	double? aliquotaIcmsOutraUf;
	double? valorIcmsOutraUf;
	String? simplesNacionalIndicador;
	double? simplesNacionalTotal;
	String? informacoesAddFisco;
	double? valorTotalCarga;
	String? produtoPredominante;
	String? cargaOutrasCaracteristicas;
	int? modalVersaoLayout;
	String? chaveCteSubstituido;
	List<CteEmitenteModel>? cteEmitenteModelList;
	List<CteLocalColetaModel>? cteLocalColetaModelList;
	List<CteTomadorModel>? cteTomadorModelList;
	List<CtePassagemModel>? ctePassagemModelList;
	List<CteRemetenteModel>? cteRemetenteModelList;
	List<CteExpedidorModel>? cteExpedidorModelList;
	List<CteRecebedorModel>? cteRecebedorModelList;
	List<CteDestinatarioModel>? cteDestinatarioModelList;
	List<CteLocalEntregaModel>? cteLocalEntregaModelList;
	List<CteComponenteModel>? cteComponenteModelList;
	List<CteCargaModel>? cteCargaModelList;
	List<CteInformacaoNfOutrosModel>? cteInformacaoNfOutrosModelList;
	List<CteSeguroModel>? cteSeguroModelList;
	List<CtePerigosoModel>? ctePerigosoModelList;
	List<CteVeiculoNovoModel>? cteVeiculoNovoModelList;
	List<CteFaturaModel>? cteFaturaModelList;
	List<CteDuplicataModel>? cteDuplicataModelList;
	List<CteRodoviarioModel>? cteRodoviarioModelList;
	List<CteAereoModel>? cteAereoModelList;
	List<CteAquaviarioModel>? cteAquaviarioModelList;
	List<CteFerroviarioModel>? cteFerroviarioModelList;
	List<CteDutoviarioModel>? cteDutoviarioModelList;
	List<CteMultimodalModel>? cteMultimodalModelList;

	CteCabecalhoModel({
		this.id,
		this.naturezaOperacao,
		this.chaveAcesso,
		this.digitoChaveAcesso,
		this.codigoNumerico,
		this.serie,
		this.numero,
		this.dataHoraEmissao,
		this.ufEmitente,
		this.cfop,
		this.formaPagamento,
		this.modelo,
		this.formatoImpressaoDacte,
		this.tipoEmissao,
		this.ambiente,
		this.tipoCte,
		this.processoEmissao,
		this.versaoProcessoEmissao,
		this.chaveReferenciado,
		this.codigoMunicipioEnvio,
		this.nomeMunicipioEnvio,
		this.ufEnvio,
		this.modal,
		this.tipoServico,
		this.codigoMunicipioIniPrestacao,
		this.nomeMunicipioIniPrestacao,
		this.ufIniPrestacao,
		this.codigoMunicipioFimPrestacao,
		this.nomeMunicipioFimPrestacao,
		this.ufFimPrestacao,
		this.retira,
		this.retiraDetalhe,
		this.tomador,
		this.dataEntradaContingencia,
		this.justificativaContingencia,
		this.caracAdicionalTransporte,
		this.caracAdicionalServico,
		this.funcionarioEmissor,
		this.fluxoOrigem,
		this.entregaTipoPeriodo,
		this.entregaDataProgramada,
		this.entregaDataInicial,
		this.entregaDataFinal,
		this.entregaTipoHora,
		this.entregaHoraProgramada,
		this.entregaHoraInicial,
		this.entregaHoraFinal,
		this.municipioOrigemCalculo,
		this.municipioDestinoCalculo,
		this.observacoesGerais,
		this.valorTotalServico,
		this.valorReceber,
		this.cst,
		this.baseCalculoIcms,
		this.aliquotaIcms,
		this.valorIcms,
		this.percentualReducaoBcIcms,
		this.valorBcIcmsStRetido,
		this.valorIcmsStRetido,
		this.aliquotaIcmsStRetido,
		this.valorCreditoPresumidoIcms,
		this.percentualBcIcmsOutraUf,
		this.valorBcIcmsOutraUf,
		this.aliquotaIcmsOutraUf,
		this.valorIcmsOutraUf,
		this.simplesNacionalIndicador,
		this.simplesNacionalTotal,
		this.informacoesAddFisco,
		this.valorTotalCarga,
		this.produtoPredominante,
		this.cargaOutrasCaracteristicas,
		this.modalVersaoLayout,
		this.chaveCteSubstituido,
		this.cteEmitenteModelList,
		this.cteLocalColetaModelList,
		this.cteTomadorModelList,
		this.ctePassagemModelList,
		this.cteRemetenteModelList,
		this.cteExpedidorModelList,
		this.cteRecebedorModelList,
		this.cteDestinatarioModelList,
		this.cteLocalEntregaModelList,
		this.cteComponenteModelList,
		this.cteCargaModelList,
		this.cteInformacaoNfOutrosModelList,
		this.cteSeguroModelList,
		this.ctePerigosoModelList,
		this.cteVeiculoNovoModelList,
		this.cteFaturaModelList,
		this.cteDuplicataModelList,
		this.cteRodoviarioModelList,
		this.cteAereoModelList,
		this.cteAquaviarioModelList,
		this.cteFerroviarioModelList,
		this.cteDutoviarioModelList,
		this.cteMultimodalModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'natureza_operacao',
		'chave_acesso',
		'digito_chave_acesso',
		'codigo_numerico',
		'serie',
		'numero',
		'data_hora_emissao',
		'uf_emitente',
		'cfop',
		'forma_pagamento',
		'modelo',
		'formato_impressao_dacte',
		'tipo_emissao',
		'ambiente',
		'tipo_cte',
		'processo_emissao',
		'versao_processo_emissao',
		'chave_referenciado',
		'codigo_municipio_envio',
		'nome_municipio_envio',
		'uf_envio',
		'modal',
		'tipo_servico',
		'codigo_municipio_ini_prestacao',
		'nome_municipio_ini_prestacao',
		'uf_ini_prestacao',
		'codigo_municipio_fim_prestacao',
		'nome_municipio_fim_prestacao',
		'uf_fim_prestacao',
		'retira',
		'retira_detalhe',
		'tomador',
		'data_entrada_contingencia',
		'justificativa_contingencia',
		'carac_adicional_transporte',
		'carac_adicional_servico',
		'funcionario_emissor',
		'fluxo_origem',
		'entrega_tipo_periodo',
		'entrega_data_programada',
		'entrega_data_inicial',
		'entrega_data_final',
		'entrega_tipo_hora',
		'entrega_hora_programada',
		'entrega_hora_inicial',
		'entrega_hora_final',
		'municipio_origem_calculo',
		'municipio_destino_calculo',
		'observacoes_gerais',
		'valor_total_servico',
		'valor_receber',
		'cst',
		'base_calculo_icms',
		'aliquota_icms',
		'valor_icms',
		'percentual_reducao_bc_icms',
		'valor_bc_icms_st_retido',
		'valor_icms_st_retido',
		'aliquota_icms_st_retido',
		'valor_credito_presumido_icms',
		'percentual_bc_icms_outra_uf',
		'valor_bc_icms_outra_uf',
		'aliquota_icms_outra_uf',
		'valor_icms_outra_uf',
		'simples_nacional_indicador',
		'simples_nacional_total',
		'informacoes_add_fisco',
		'valor_total_carga',
		'produto_predominante',
		'carga_outras_caracteristicas',
		'modal_versao_layout',
		'chave_cte_substituido',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Natureza Operacao',
		'Chave Acesso',
		'Digito Chave Acesso',
		'Codigo Numerico',
		'Serie',
		'Numero',
		'Data Hora Emissao',
		'Uf Emitente',
		'Cfop',
		'Forma Pagamento',
		'Modelo',
		'Formato Impressao Dacte',
		'Tipo Emissao',
		'Ambiente',
		'Tipo Cte',
		'Processo Emissao',
		'Versao Processo Emissao',
		'Chave Referenciado',
		'Codigo Municipio Envio',
		'Nome Municipio Envio',
		'Uf Envio',
		'Modal',
		'Tipo Servico',
		'Codigo Municipio Ini Prestacao',
		'Nome Municipio Ini Prestacao',
		'Uf Ini Prestacao',
		'Codigo Municipio Fim Prestacao',
		'Nome Municipio Fim Prestacao',
		'Uf Fim Prestacao',
		'Retira',
		'Retira Detalhe',
		'Tomador',
		'Data Entrada Contingencia',
		'Justificativa Contingencia',
		'Carac Adicional Transporte',
		'Carac Adicional Servico',
		'Funcionario Emissor',
		'Fluxo Origem',
		'Entrega Tipo Periodo',
		'Entrega Data Programada',
		'Entrega Data Inicial',
		'Entrega Data Final',
		'Entrega Tipo Hora',
		'Entrega Hora Programada',
		'Entrega Hora Inicial',
		'Entrega Hora Final',
		'Municipio Origem Calculo',
		'Municipio Destino Calculo',
		'Observacoes Gerais',
		'Valor Total Servico',
		'Valor Receber',
		'Cst',
		'Base Calculo Icms',
		'Aliquota Icms',
		'Valor Icms',
		'Percentual Reducao Bc Icms',
		'Valor Bc Icms St Retido',
		'Valor Icms St Retido',
		'Aliquota Icms St Retido',
		'Valor Credito Presumido Icms',
		'Percentual Bc Icms Outra Uf',
		'Valor Bc Icms Outra Uf',
		'Aliquota Icms Outra Uf',
		'Valor Icms Outra Uf',
		'Simples Nacional Indicador',
		'Simples Nacional Total',
		'Informacoes Add Fisco',
		'Valor Total Carga',
		'Produto Predominante',
		'Carga Outras Caracteristicas',
		'Modal Versao Layout',
		'Chave Cte Substituido',
	];

	CteCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		naturezaOperacao = jsonData['naturezaOperacao'];
		chaveAcesso = jsonData['chaveAcesso'];
		digitoChaveAcesso = jsonData['digitoChaveAcesso'];
		codigoNumerico = jsonData['codigoNumerico'];
		serie = jsonData['serie'];
		numero = jsonData['numero'];
		dataHoraEmissao = jsonData['dataHoraEmissao'] != null ? DateTime.tryParse(jsonData['dataHoraEmissao']) : null;
		ufEmitente = CteCabecalhoDomain.getUfEmitente(jsonData['ufEmitente']);
		cfop = jsonData['cfop'];
		formaPagamento = CteCabecalhoDomain.getFormaPagamento(jsonData['formaPagamento']);
		modelo = CteCabecalhoDomain.getModelo(jsonData['modelo']);
		formatoImpressaoDacte = CteCabecalhoDomain.getFormatoImpressaoDacte(jsonData['formatoImpressaoDacte']);
		tipoEmissao = CteCabecalhoDomain.getTipoEmissao(jsonData['tipoEmissao']);
		ambiente = CteCabecalhoDomain.getAmbiente(jsonData['ambiente']);
		tipoCte = CteCabecalhoDomain.getTipoCte(jsonData['tipoCte']);
		processoEmissao = CteCabecalhoDomain.getProcessoEmissao(jsonData['processoEmissao']);
		versaoProcessoEmissao = jsonData['versaoProcessoEmissao'];
		chaveReferenciado = jsonData['chaveReferenciado'];
		codigoMunicipioEnvio = jsonData['codigoMunicipioEnvio'];
		nomeMunicipioEnvio = jsonData['nomeMunicipioEnvio'];
		ufEnvio = CteCabecalhoDomain.getUfEnvio(jsonData['ufEnvio']);
		modal = CteCabecalhoDomain.getModal(jsonData['modal']);
		tipoServico = CteCabecalhoDomain.getTipoServico(jsonData['tipoServico']);
		codigoMunicipioIniPrestacao = jsonData['codigoMunicipioIniPrestacao'];
		nomeMunicipioIniPrestacao = jsonData['nomeMunicipioIniPrestacao'];
		ufIniPrestacao = CteCabecalhoDomain.getUfIniPrestacao(jsonData['ufIniPrestacao']);
		codigoMunicipioFimPrestacao = jsonData['codigoMunicipioFimPrestacao'];
		nomeMunicipioFimPrestacao = jsonData['nomeMunicipioFimPrestacao'];
		ufFimPrestacao = CteCabecalhoDomain.getUfFimPrestacao(jsonData['ufFimPrestacao']);
		retira = CteCabecalhoDomain.getRetira(jsonData['retira']);
		retiraDetalhe = jsonData['retiraDetalhe'];
		tomador = CteCabecalhoDomain.getTomador(jsonData['tomador']);
		dataEntradaContingencia = jsonData['dataEntradaContingencia'] != null ? DateTime.tryParse(jsonData['dataEntradaContingencia']) : null;
		justificativaContingencia = jsonData['justificativaContingencia'];
		caracAdicionalTransporte = jsonData['caracAdicionalTransporte'];
		caracAdicionalServico = jsonData['caracAdicionalServico'];
		funcionarioEmissor = jsonData['funcionarioEmissor'];
		fluxoOrigem = jsonData['fluxoOrigem'];
		entregaTipoPeriodo = CteCabecalhoDomain.getEntregaTipoPeriodo(jsonData['entregaTipoPeriodo']);
		entregaDataProgramada = jsonData['entregaDataProgramada'] != null ? DateTime.tryParse(jsonData['entregaDataProgramada']) : null;
		entregaDataInicial = jsonData['entregaDataInicial'] != null ? DateTime.tryParse(jsonData['entregaDataInicial']) : null;
		entregaDataFinal = jsonData['entregaDataFinal'] != null ? DateTime.tryParse(jsonData['entregaDataFinal']) : null;
		entregaTipoHora = CteCabecalhoDomain.getEntregaTipoHora(jsonData['entregaTipoHora']);
		entregaHoraProgramada = jsonData['entregaHoraProgramada'];
		entregaHoraInicial = jsonData['entregaHoraInicial'];
		entregaHoraFinal = jsonData['entregaHoraFinal'];
		municipioOrigemCalculo = jsonData['municipioOrigemCalculo'];
		municipioDestinoCalculo = jsonData['municipioDestinoCalculo'];
		observacoesGerais = jsonData['observacoesGerais'];
		valorTotalServico = jsonData['valorTotalServico']?.toDouble();
		valorReceber = jsonData['valorReceber']?.toDouble();
		cst = jsonData['cst'];
		baseCalculoIcms = jsonData['baseCalculoIcms']?.toDouble();
		aliquotaIcms = jsonData['aliquotaIcms']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		percentualReducaoBcIcms = jsonData['percentualReducaoBcIcms']?.toDouble();
		valorBcIcmsStRetido = jsonData['valorBcIcmsStRetido']?.toDouble();
		valorIcmsStRetido = jsonData['valorIcmsStRetido']?.toDouble();
		aliquotaIcmsStRetido = jsonData['aliquotaIcmsStRetido']?.toDouble();
		valorCreditoPresumidoIcms = jsonData['valorCreditoPresumidoIcms']?.toDouble();
		percentualBcIcmsOutraUf = jsonData['percentualBcIcmsOutraUf']?.toDouble();
		valorBcIcmsOutraUf = jsonData['valorBcIcmsOutraUf']?.toDouble();
		aliquotaIcmsOutraUf = jsonData['aliquotaIcmsOutraUf']?.toDouble();
		valorIcmsOutraUf = jsonData['valorIcmsOutraUf']?.toDouble();
		simplesNacionalIndicador = CteCabecalhoDomain.getSimplesNacionalIndicador(jsonData['simplesNacionalIndicador']);
		simplesNacionalTotal = jsonData['simplesNacionalTotal']?.toDouble();
		informacoesAddFisco = jsonData['informacoesAddFisco'];
		valorTotalCarga = jsonData['valorTotalCarga']?.toDouble();
		produtoPredominante = jsonData['produtoPredominante'];
		cargaOutrasCaracteristicas = jsonData['cargaOutrasCaracteristicas'];
		modalVersaoLayout = jsonData['modalVersaoLayout'];
		chaveCteSubstituido = jsonData['chaveCteSubstituido'];
		cteEmitenteModelList = (jsonData['cteEmitenteModelList'] as Iterable?)?.map((m) => CteEmitenteModel.fromJson(m)).toList() ?? [];
		cteLocalColetaModelList = (jsonData['cteLocalColetaModelList'] as Iterable?)?.map((m) => CteLocalColetaModel.fromJson(m)).toList() ?? [];
		cteTomadorModelList = (jsonData['cteTomadorModelList'] as Iterable?)?.map((m) => CteTomadorModel.fromJson(m)).toList() ?? [];
		ctePassagemModelList = (jsonData['ctePassagemModelList'] as Iterable?)?.map((m) => CtePassagemModel.fromJson(m)).toList() ?? [];
		cteRemetenteModelList = (jsonData['cteRemetenteModelList'] as Iterable?)?.map((m) => CteRemetenteModel.fromJson(m)).toList() ?? [];
		cteExpedidorModelList = (jsonData['cteExpedidorModelList'] as Iterable?)?.map((m) => CteExpedidorModel.fromJson(m)).toList() ?? [];
		cteRecebedorModelList = (jsonData['cteRecebedorModelList'] as Iterable?)?.map((m) => CteRecebedorModel.fromJson(m)).toList() ?? [];
		cteDestinatarioModelList = (jsonData['cteDestinatarioModelList'] as Iterable?)?.map((m) => CteDestinatarioModel.fromJson(m)).toList() ?? [];
		cteLocalEntregaModelList = (jsonData['cteLocalEntregaModelList'] as Iterable?)?.map((m) => CteLocalEntregaModel.fromJson(m)).toList() ?? [];
		cteComponenteModelList = (jsonData['cteComponenteModelList'] as Iterable?)?.map((m) => CteComponenteModel.fromJson(m)).toList() ?? [];
		cteCargaModelList = (jsonData['cteCargaModelList'] as Iterable?)?.map((m) => CteCargaModel.fromJson(m)).toList() ?? [];
		cteInformacaoNfOutrosModelList = (jsonData['cteInformacaoNfOutrosModelList'] as Iterable?)?.map((m) => CteInformacaoNfOutrosModel.fromJson(m)).toList() ?? [];
		cteSeguroModelList = (jsonData['cteSeguroModelList'] as Iterable?)?.map((m) => CteSeguroModel.fromJson(m)).toList() ?? [];
		ctePerigosoModelList = (jsonData['ctePerigosoModelList'] as Iterable?)?.map((m) => CtePerigosoModel.fromJson(m)).toList() ?? [];
		cteVeiculoNovoModelList = (jsonData['cteVeiculoNovoModelList'] as Iterable?)?.map((m) => CteVeiculoNovoModel.fromJson(m)).toList() ?? [];
		cteFaturaModelList = (jsonData['cteFaturaModelList'] as Iterable?)?.map((m) => CteFaturaModel.fromJson(m)).toList() ?? [];
		cteDuplicataModelList = (jsonData['cteDuplicataModelList'] as Iterable?)?.map((m) => CteDuplicataModel.fromJson(m)).toList() ?? [];
		cteRodoviarioModelList = (jsonData['cteRodoviarioModelList'] as Iterable?)?.map((m) => CteRodoviarioModel.fromJson(m)).toList() ?? [];
		cteAereoModelList = (jsonData['cteAereoModelList'] as Iterable?)?.map((m) => CteAereoModel.fromJson(m)).toList() ?? [];
		cteAquaviarioModelList = (jsonData['cteAquaviarioModelList'] as Iterable?)?.map((m) => CteAquaviarioModel.fromJson(m)).toList() ?? [];
		cteFerroviarioModelList = (jsonData['cteFerroviarioModelList'] as Iterable?)?.map((m) => CteFerroviarioModel.fromJson(m)).toList() ?? [];
		cteDutoviarioModelList = (jsonData['cteDutoviarioModelList'] as Iterable?)?.map((m) => CteDutoviarioModel.fromJson(m)).toList() ?? [];
		cteMultimodalModelList = (jsonData['cteMultimodalModelList'] as Iterable?)?.map((m) => CteMultimodalModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['naturezaOperacao'] = naturezaOperacao;
		jsonData['chaveAcesso'] = chaveAcesso;
		jsonData['digitoChaveAcesso'] = digitoChaveAcesso;
		jsonData['codigoNumerico'] = codigoNumerico;
		jsonData['serie'] = serie;
		jsonData['numero'] = numero;
		jsonData['dataHoraEmissao'] = dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataHoraEmissao!) : null;
		jsonData['ufEmitente'] = CteCabecalhoDomain.setUfEmitente(ufEmitente);
		jsonData['cfop'] = cfop;
		jsonData['formaPagamento'] = CteCabecalhoDomain.setFormaPagamento(formaPagamento);
		jsonData['modelo'] = CteCabecalhoDomain.setModelo(modelo);
		jsonData['formatoImpressaoDacte'] = CteCabecalhoDomain.setFormatoImpressaoDacte(formatoImpressaoDacte);
		jsonData['tipoEmissao'] = CteCabecalhoDomain.setTipoEmissao(tipoEmissao);
		jsonData['ambiente'] = CteCabecalhoDomain.setAmbiente(ambiente);
		jsonData['tipoCte'] = CteCabecalhoDomain.setTipoCte(tipoCte);
		jsonData['processoEmissao'] = CteCabecalhoDomain.setProcessoEmissao(processoEmissao);
		jsonData['versaoProcessoEmissao'] = versaoProcessoEmissao;
		jsonData['chaveReferenciado'] = chaveReferenciado;
		jsonData['codigoMunicipioEnvio'] = codigoMunicipioEnvio;
		jsonData['nomeMunicipioEnvio'] = nomeMunicipioEnvio;
		jsonData['ufEnvio'] = CteCabecalhoDomain.setUfEnvio(ufEnvio);
		jsonData['modal'] = CteCabecalhoDomain.setModal(modal);
		jsonData['tipoServico'] = CteCabecalhoDomain.setTipoServico(tipoServico);
		jsonData['codigoMunicipioIniPrestacao'] = codigoMunicipioIniPrestacao;
		jsonData['nomeMunicipioIniPrestacao'] = nomeMunicipioIniPrestacao;
		jsonData['ufIniPrestacao'] = CteCabecalhoDomain.setUfIniPrestacao(ufIniPrestacao);
		jsonData['codigoMunicipioFimPrestacao'] = codigoMunicipioFimPrestacao;
		jsonData['nomeMunicipioFimPrestacao'] = nomeMunicipioFimPrestacao;
		jsonData['ufFimPrestacao'] = CteCabecalhoDomain.setUfFimPrestacao(ufFimPrestacao);
		jsonData['retira'] = CteCabecalhoDomain.setRetira(retira);
		jsonData['retiraDetalhe'] = retiraDetalhe;
		jsonData['tomador'] = CteCabecalhoDomain.setTomador(tomador);
		jsonData['dataEntradaContingencia'] = dataEntradaContingencia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEntradaContingencia!) : null;
		jsonData['justificativaContingencia'] = justificativaContingencia;
		jsonData['caracAdicionalTransporte'] = caracAdicionalTransporte;
		jsonData['caracAdicionalServico'] = caracAdicionalServico;
		jsonData['funcionarioEmissor'] = funcionarioEmissor;
		jsonData['fluxoOrigem'] = fluxoOrigem;
		jsonData['entregaTipoPeriodo'] = CteCabecalhoDomain.setEntregaTipoPeriodo(entregaTipoPeriodo);
		jsonData['entregaDataProgramada'] = entregaDataProgramada != null ? DateFormat('yyyy-MM-ddT00:00:00').format(entregaDataProgramada!) : null;
		jsonData['entregaDataInicial'] = entregaDataInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(entregaDataInicial!) : null;
		jsonData['entregaDataFinal'] = entregaDataFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(entregaDataFinal!) : null;
		jsonData['entregaTipoHora'] = CteCabecalhoDomain.setEntregaTipoHora(entregaTipoHora);
		jsonData['entregaHoraProgramada'] = entregaHoraProgramada;
		jsonData['entregaHoraInicial'] = entregaHoraInicial;
		jsonData['entregaHoraFinal'] = entregaHoraFinal;
		jsonData['municipioOrigemCalculo'] = municipioOrigemCalculo;
		jsonData['municipioDestinoCalculo'] = municipioDestinoCalculo;
		jsonData['observacoesGerais'] = observacoesGerais;
		jsonData['valorTotalServico'] = valorTotalServico;
		jsonData['valorReceber'] = valorReceber;
		jsonData['cst'] = cst;
		jsonData['baseCalculoIcms'] = baseCalculoIcms;
		jsonData['aliquotaIcms'] = aliquotaIcms;
		jsonData['valorIcms'] = valorIcms;
		jsonData['percentualReducaoBcIcms'] = percentualReducaoBcIcms;
		jsonData['valorBcIcmsStRetido'] = valorBcIcmsStRetido;
		jsonData['valorIcmsStRetido'] = valorIcmsStRetido;
		jsonData['aliquotaIcmsStRetido'] = aliquotaIcmsStRetido;
		jsonData['valorCreditoPresumidoIcms'] = valorCreditoPresumidoIcms;
		jsonData['percentualBcIcmsOutraUf'] = percentualBcIcmsOutraUf;
		jsonData['valorBcIcmsOutraUf'] = valorBcIcmsOutraUf;
		jsonData['aliquotaIcmsOutraUf'] = aliquotaIcmsOutraUf;
		jsonData['valorIcmsOutraUf'] = valorIcmsOutraUf;
		jsonData['simplesNacionalIndicador'] = CteCabecalhoDomain.setSimplesNacionalIndicador(simplesNacionalIndicador);
		jsonData['simplesNacionalTotal'] = simplesNacionalTotal;
		jsonData['informacoesAddFisco'] = informacoesAddFisco;
		jsonData['valorTotalCarga'] = valorTotalCarga;
		jsonData['produtoPredominante'] = produtoPredominante;
		jsonData['cargaOutrasCaracteristicas'] = cargaOutrasCaracteristicas;
		jsonData['modalVersaoLayout'] = modalVersaoLayout;
		jsonData['chaveCteSubstituido'] = chaveCteSubstituido;
		
		var cteEmitenteModelLocalList = []; 
		for (CteEmitenteModel object in cteEmitenteModelList ?? []) { 
			cteEmitenteModelLocalList.add(object.toJson); 
		}
		jsonData['cteEmitenteModelList'] = cteEmitenteModelLocalList;
		
		var cteLocalColetaModelLocalList = []; 
		for (CteLocalColetaModel object in cteLocalColetaModelList ?? []) { 
			cteLocalColetaModelLocalList.add(object.toJson); 
		}
		jsonData['cteLocalColetaModelList'] = cteLocalColetaModelLocalList;
		
		var cteTomadorModelLocalList = []; 
		for (CteTomadorModel object in cteTomadorModelList ?? []) { 
			cteTomadorModelLocalList.add(object.toJson); 
		}
		jsonData['cteTomadorModelList'] = cteTomadorModelLocalList;
		
		var ctePassagemModelLocalList = []; 
		for (CtePassagemModel object in ctePassagemModelList ?? []) { 
			ctePassagemModelLocalList.add(object.toJson); 
		}
		jsonData['ctePassagemModelList'] = ctePassagemModelLocalList;
		
		var cteRemetenteModelLocalList = []; 
		for (CteRemetenteModel object in cteRemetenteModelList ?? []) { 
			cteRemetenteModelLocalList.add(object.toJson); 
		}
		jsonData['cteRemetenteModelList'] = cteRemetenteModelLocalList;
		
		var cteExpedidorModelLocalList = []; 
		for (CteExpedidorModel object in cteExpedidorModelList ?? []) { 
			cteExpedidorModelLocalList.add(object.toJson); 
		}
		jsonData['cteExpedidorModelList'] = cteExpedidorModelLocalList;
		
		var cteRecebedorModelLocalList = []; 
		for (CteRecebedorModel object in cteRecebedorModelList ?? []) { 
			cteRecebedorModelLocalList.add(object.toJson); 
		}
		jsonData['cteRecebedorModelList'] = cteRecebedorModelLocalList;
		
		var cteDestinatarioModelLocalList = []; 
		for (CteDestinatarioModel object in cteDestinatarioModelList ?? []) { 
			cteDestinatarioModelLocalList.add(object.toJson); 
		}
		jsonData['cteDestinatarioModelList'] = cteDestinatarioModelLocalList;
		
		var cteLocalEntregaModelLocalList = []; 
		for (CteLocalEntregaModel object in cteLocalEntregaModelList ?? []) { 
			cteLocalEntregaModelLocalList.add(object.toJson); 
		}
		jsonData['cteLocalEntregaModelList'] = cteLocalEntregaModelLocalList;
		
		var cteComponenteModelLocalList = []; 
		for (CteComponenteModel object in cteComponenteModelList ?? []) { 
			cteComponenteModelLocalList.add(object.toJson); 
		}
		jsonData['cteComponenteModelList'] = cteComponenteModelLocalList;
		
		var cteCargaModelLocalList = []; 
		for (CteCargaModel object in cteCargaModelList ?? []) { 
			cteCargaModelLocalList.add(object.toJson); 
		}
		jsonData['cteCargaModelList'] = cteCargaModelLocalList;
		
		var cteInformacaoNfOutrosModelLocalList = []; 
		for (CteInformacaoNfOutrosModel object in cteInformacaoNfOutrosModelList ?? []) { 
			cteInformacaoNfOutrosModelLocalList.add(object.toJson); 
		}
		jsonData['cteInformacaoNfOutrosModelList'] = cteInformacaoNfOutrosModelLocalList;
		
		var cteSeguroModelLocalList = []; 
		for (CteSeguroModel object in cteSeguroModelList ?? []) { 
			cteSeguroModelLocalList.add(object.toJson); 
		}
		jsonData['cteSeguroModelList'] = cteSeguroModelLocalList;
		
		var ctePerigosoModelLocalList = []; 
		for (CtePerigosoModel object in ctePerigosoModelList ?? []) { 
			ctePerigosoModelLocalList.add(object.toJson); 
		}
		jsonData['ctePerigosoModelList'] = ctePerigosoModelLocalList;
		
		var cteVeiculoNovoModelLocalList = []; 
		for (CteVeiculoNovoModel object in cteVeiculoNovoModelList ?? []) { 
			cteVeiculoNovoModelLocalList.add(object.toJson); 
		}
		jsonData['cteVeiculoNovoModelList'] = cteVeiculoNovoModelLocalList;
		
		var cteFaturaModelLocalList = []; 
		for (CteFaturaModel object in cteFaturaModelList ?? []) { 
			cteFaturaModelLocalList.add(object.toJson); 
		}
		jsonData['cteFaturaModelList'] = cteFaturaModelLocalList;
		
		var cteDuplicataModelLocalList = []; 
		for (CteDuplicataModel object in cteDuplicataModelList ?? []) { 
			cteDuplicataModelLocalList.add(object.toJson); 
		}
		jsonData['cteDuplicataModelList'] = cteDuplicataModelLocalList;
		
		var cteRodoviarioModelLocalList = []; 
		for (CteRodoviarioModel object in cteRodoviarioModelList ?? []) { 
			cteRodoviarioModelLocalList.add(object.toJson); 
		}
		jsonData['cteRodoviarioModelList'] = cteRodoviarioModelLocalList;
		
		var cteAereoModelLocalList = []; 
		for (CteAereoModel object in cteAereoModelList ?? []) { 
			cteAereoModelLocalList.add(object.toJson); 
		}
		jsonData['cteAereoModelList'] = cteAereoModelLocalList;
		
		var cteAquaviarioModelLocalList = []; 
		for (CteAquaviarioModel object in cteAquaviarioModelList ?? []) { 
			cteAquaviarioModelLocalList.add(object.toJson); 
		}
		jsonData['cteAquaviarioModelList'] = cteAquaviarioModelLocalList;
		
		var cteFerroviarioModelLocalList = []; 
		for (CteFerroviarioModel object in cteFerroviarioModelList ?? []) { 
			cteFerroviarioModelLocalList.add(object.toJson); 
		}
		jsonData['cteFerroviarioModelList'] = cteFerroviarioModelLocalList;
		
		var cteDutoviarioModelLocalList = []; 
		for (CteDutoviarioModel object in cteDutoviarioModelList ?? []) { 
			cteDutoviarioModelLocalList.add(object.toJson); 
		}
		jsonData['cteDutoviarioModelList'] = cteDutoviarioModelLocalList;
		
		var cteMultimodalModelLocalList = []; 
		for (CteMultimodalModel object in cteMultimodalModelList ?? []) { 
			cteMultimodalModelLocalList.add(object.toJson); 
		}
		jsonData['cteMultimodalModelList'] = cteMultimodalModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		naturezaOperacao = plutoRow.cells['naturezaOperacao']?.value;
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
		digitoChaveAcesso = plutoRow.cells['digitoChaveAcesso']?.value;
		codigoNumerico = plutoRow.cells['codigoNumerico']?.value;
		serie = plutoRow.cells['serie']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataHoraEmissao = Util.stringToDate(plutoRow.cells['dataHoraEmissao']?.value);
		ufEmitente = plutoRow.cells['ufEmitente']?.value != '' ? plutoRow.cells['ufEmitente']?.value : 'AC';
		cfop = plutoRow.cells['cfop']?.value;
		formaPagamento = plutoRow.cells['formaPagamento']?.value != '' ? plutoRow.cells['formaPagamento']?.value : '0-Pago';
		modelo = plutoRow.cells['modelo']?.value != '' ? plutoRow.cells['modelo']?.value : '57';
		formatoImpressaoDacte = plutoRow.cells['formatoImpressaoDacte']?.value != '' ? plutoRow.cells['formatoImpressaoDacte']?.value : '1-Retrato';
		tipoEmissao = plutoRow.cells['tipoEmissao']?.value != '' ? plutoRow.cells['tipoEmissao']?.value : '1 - Normal';
		ambiente = plutoRow.cells['ambiente']?.value != '' ? plutoRow.cells['ambiente']?.value : '1-Produção';
		tipoCte = plutoRow.cells['tipoCte']?.value != '' ? plutoRow.cells['tipoCte']?.value : '0 - CT-e Normal';
		processoEmissao = plutoRow.cells['processoEmissao']?.value != '' ? plutoRow.cells['processoEmissao']?.value : '0 - emissão de CT-e com aplicativo do contribuinte; 1 - emissão de CT-e avulsa pelo Fisco; 2 - emissão de CT-e avulsa';
		versaoProcessoEmissao = plutoRow.cells['versaoProcessoEmissao']?.value;
		chaveReferenciado = plutoRow.cells['chaveReferenciado']?.value;
		codigoMunicipioEnvio = plutoRow.cells['codigoMunicipioEnvio']?.value;
		nomeMunicipioEnvio = plutoRow.cells['nomeMunicipioEnvio']?.value;
		ufEnvio = plutoRow.cells['ufEnvio']?.value != '' ? plutoRow.cells['ufEnvio']?.value : 'AC';
		modal = plutoRow.cells['modal']?.value != '' ? plutoRow.cells['modal']?.value : '01-Rodoviário';
		tipoServico = plutoRow.cells['tipoServico']?.value != '' ? plutoRow.cells['tipoServico']?.value : '0 - Normal';
		codigoMunicipioIniPrestacao = plutoRow.cells['codigoMunicipioIniPrestacao']?.value;
		nomeMunicipioIniPrestacao = plutoRow.cells['nomeMunicipioIniPrestacao']?.value;
		ufIniPrestacao = plutoRow.cells['ufIniPrestacao']?.value != '' ? plutoRow.cells['ufIniPrestacao']?.value : 'AC';
		codigoMunicipioFimPrestacao = plutoRow.cells['codigoMunicipioFimPrestacao']?.value;
		nomeMunicipioFimPrestacao = plutoRow.cells['nomeMunicipioFimPrestacao']?.value;
		ufFimPrestacao = plutoRow.cells['ufFimPrestacao']?.value != '' ? plutoRow.cells['ufFimPrestacao']?.value : 'AC';
		retira = plutoRow.cells['retira']?.value != '' ? plutoRow.cells['retira']?.value : 'Sim';
		retiraDetalhe = plutoRow.cells['retiraDetalhe']?.value;
		tomador = plutoRow.cells['tomador']?.value != '' ? plutoRow.cells['tomador']?.value : '0-Remetente';
		dataEntradaContingencia = Util.stringToDate(plutoRow.cells['dataEntradaContingencia']?.value);
		justificativaContingencia = plutoRow.cells['justificativaContingencia']?.value;
		caracAdicionalTransporte = plutoRow.cells['caracAdicionalTransporte']?.value;
		caracAdicionalServico = plutoRow.cells['caracAdicionalServico']?.value;
		funcionarioEmissor = plutoRow.cells['funcionarioEmissor']?.value;
		fluxoOrigem = plutoRow.cells['fluxoOrigem']?.value;
		entregaTipoPeriodo = plutoRow.cells['entregaTipoPeriodo']?.value != '' ? plutoRow.cells['entregaTipoPeriodo']?.value : '0-Sem data definida';
		entregaDataProgramada = Util.stringToDate(plutoRow.cells['entregaDataProgramada']?.value);
		entregaDataInicial = Util.stringToDate(plutoRow.cells['entregaDataInicial']?.value);
		entregaDataFinal = Util.stringToDate(plutoRow.cells['entregaDataFinal']?.value);
		entregaTipoHora = plutoRow.cells['entregaTipoHora']?.value != '' ? plutoRow.cells['entregaTipoHora']?.value : '0-Sem hora definida';
		entregaHoraProgramada = plutoRow.cells['entregaHoraProgramada']?.value;
		entregaHoraInicial = plutoRow.cells['entregaHoraInicial']?.value;
		entregaHoraFinal = plutoRow.cells['entregaHoraFinal']?.value;
		municipioOrigemCalculo = plutoRow.cells['municipioOrigemCalculo']?.value;
		municipioDestinoCalculo = plutoRow.cells['municipioDestinoCalculo']?.value;
		observacoesGerais = plutoRow.cells['observacoesGerais']?.value;
		valorTotalServico = plutoRow.cells['valorTotalServico']?.value?.toDouble();
		valorReceber = plutoRow.cells['valorReceber']?.value?.toDouble();
		cst = plutoRow.cells['cst']?.value;
		baseCalculoIcms = plutoRow.cells['baseCalculoIcms']?.value?.toDouble();
		aliquotaIcms = plutoRow.cells['aliquotaIcms']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		percentualReducaoBcIcms = plutoRow.cells['percentualReducaoBcIcms']?.value?.toDouble();
		valorBcIcmsStRetido = plutoRow.cells['valorBcIcmsStRetido']?.value?.toDouble();
		valorIcmsStRetido = plutoRow.cells['valorIcmsStRetido']?.value?.toDouble();
		aliquotaIcmsStRetido = plutoRow.cells['aliquotaIcmsStRetido']?.value?.toDouble();
		valorCreditoPresumidoIcms = plutoRow.cells['valorCreditoPresumidoIcms']?.value?.toDouble();
		percentualBcIcmsOutraUf = plutoRow.cells['percentualBcIcmsOutraUf']?.value?.toDouble();
		valorBcIcmsOutraUf = plutoRow.cells['valorBcIcmsOutraUf']?.value?.toDouble();
		aliquotaIcmsOutraUf = plutoRow.cells['aliquotaIcmsOutraUf']?.value?.toDouble();
		valorIcmsOutraUf = plutoRow.cells['valorIcmsOutraUf']?.value?.toDouble();
		simplesNacionalIndicador = plutoRow.cells['simplesNacionalIndicador']?.value != '' ? plutoRow.cells['simplesNacionalIndicador']?.value : 'Sim';
		simplesNacionalTotal = plutoRow.cells['simplesNacionalTotal']?.value?.toDouble();
		informacoesAddFisco = plutoRow.cells['informacoesAddFisco']?.value;
		valorTotalCarga = plutoRow.cells['valorTotalCarga']?.value?.toDouble();
		produtoPredominante = plutoRow.cells['produtoPredominante']?.value;
		cargaOutrasCaracteristicas = plutoRow.cells['cargaOutrasCaracteristicas']?.value;
		modalVersaoLayout = plutoRow.cells['modalVersaoLayout']?.value;
		chaveCteSubstituido = plutoRow.cells['chaveCteSubstituido']?.value;
		cteEmitenteModelList = [];
		cteLocalColetaModelList = [];
		cteTomadorModelList = [];
		ctePassagemModelList = [];
		cteRemetenteModelList = [];
		cteExpedidorModelList = [];
		cteRecebedorModelList = [];
		cteDestinatarioModelList = [];
		cteLocalEntregaModelList = [];
		cteComponenteModelList = [];
		cteCargaModelList = [];
		cteInformacaoNfOutrosModelList = [];
		cteSeguroModelList = [];
		ctePerigosoModelList = [];
		cteVeiculoNovoModelList = [];
		cteFaturaModelList = [];
		cteDuplicataModelList = [];
		cteRodoviarioModelList = [];
		cteAereoModelList = [];
		cteAquaviarioModelList = [];
		cteFerroviarioModelList = [];
		cteDutoviarioModelList = [];
		cteMultimodalModelList = [];
	}	

	CteCabecalhoModel clone() {
		return CteCabecalhoModel(
			id: id,
			naturezaOperacao: naturezaOperacao,
			chaveAcesso: chaveAcesso,
			digitoChaveAcesso: digitoChaveAcesso,
			codigoNumerico: codigoNumerico,
			serie: serie,
			numero: numero,
			dataHoraEmissao: dataHoraEmissao,
			ufEmitente: ufEmitente,
			cfop: cfop,
			formaPagamento: formaPagamento,
			modelo: modelo,
			formatoImpressaoDacte: formatoImpressaoDacte,
			tipoEmissao: tipoEmissao,
			ambiente: ambiente,
			tipoCte: tipoCte,
			processoEmissao: processoEmissao,
			versaoProcessoEmissao: versaoProcessoEmissao,
			chaveReferenciado: chaveReferenciado,
			codigoMunicipioEnvio: codigoMunicipioEnvio,
			nomeMunicipioEnvio: nomeMunicipioEnvio,
			ufEnvio: ufEnvio,
			modal: modal,
			tipoServico: tipoServico,
			codigoMunicipioIniPrestacao: codigoMunicipioIniPrestacao,
			nomeMunicipioIniPrestacao: nomeMunicipioIniPrestacao,
			ufIniPrestacao: ufIniPrestacao,
			codigoMunicipioFimPrestacao: codigoMunicipioFimPrestacao,
			nomeMunicipioFimPrestacao: nomeMunicipioFimPrestacao,
			ufFimPrestacao: ufFimPrestacao,
			retira: retira,
			retiraDetalhe: retiraDetalhe,
			tomador: tomador,
			dataEntradaContingencia: dataEntradaContingencia,
			justificativaContingencia: justificativaContingencia,
			caracAdicionalTransporte: caracAdicionalTransporte,
			caracAdicionalServico: caracAdicionalServico,
			funcionarioEmissor: funcionarioEmissor,
			fluxoOrigem: fluxoOrigem,
			entregaTipoPeriodo: entregaTipoPeriodo,
			entregaDataProgramada: entregaDataProgramada,
			entregaDataInicial: entregaDataInicial,
			entregaDataFinal: entregaDataFinal,
			entregaTipoHora: entregaTipoHora,
			entregaHoraProgramada: entregaHoraProgramada,
			entregaHoraInicial: entregaHoraInicial,
			entregaHoraFinal: entregaHoraFinal,
			municipioOrigemCalculo: municipioOrigemCalculo,
			municipioDestinoCalculo: municipioDestinoCalculo,
			observacoesGerais: observacoesGerais,
			valorTotalServico: valorTotalServico,
			valorReceber: valorReceber,
			cst: cst,
			baseCalculoIcms: baseCalculoIcms,
			aliquotaIcms: aliquotaIcms,
			valorIcms: valorIcms,
			percentualReducaoBcIcms: percentualReducaoBcIcms,
			valorBcIcmsStRetido: valorBcIcmsStRetido,
			valorIcmsStRetido: valorIcmsStRetido,
			aliquotaIcmsStRetido: aliquotaIcmsStRetido,
			valorCreditoPresumidoIcms: valorCreditoPresumidoIcms,
			percentualBcIcmsOutraUf: percentualBcIcmsOutraUf,
			valorBcIcmsOutraUf: valorBcIcmsOutraUf,
			aliquotaIcmsOutraUf: aliquotaIcmsOutraUf,
			valorIcmsOutraUf: valorIcmsOutraUf,
			simplesNacionalIndicador: simplesNacionalIndicador,
			simplesNacionalTotal: simplesNacionalTotal,
			informacoesAddFisco: informacoesAddFisco,
			valorTotalCarga: valorTotalCarga,
			produtoPredominante: produtoPredominante,
			cargaOutrasCaracteristicas: cargaOutrasCaracteristicas,
			modalVersaoLayout: modalVersaoLayout,
			chaveCteSubstituido: chaveCteSubstituido,
			cteEmitenteModelList: cteEmitenteModelListClone(cteEmitenteModelList!),
			cteLocalColetaModelList: cteLocalColetaModelListClone(cteLocalColetaModelList!),
			cteTomadorModelList: cteTomadorModelListClone(cteTomadorModelList!),
			ctePassagemModelList: ctePassagemModelListClone(ctePassagemModelList!),
			cteRemetenteModelList: cteRemetenteModelListClone(cteRemetenteModelList!),
			cteExpedidorModelList: cteExpedidorModelListClone(cteExpedidorModelList!),
			cteRecebedorModelList: cteRecebedorModelListClone(cteRecebedorModelList!),
			cteDestinatarioModelList: cteDestinatarioModelListClone(cteDestinatarioModelList!),
			cteLocalEntregaModelList: cteLocalEntregaModelListClone(cteLocalEntregaModelList!),
			cteComponenteModelList: cteComponenteModelListClone(cteComponenteModelList!),
			cteCargaModelList: cteCargaModelListClone(cteCargaModelList!),
			cteInformacaoNfOutrosModelList: cteInformacaoNfOutrosModelListClone(cteInformacaoNfOutrosModelList!),
			cteSeguroModelList: cteSeguroModelListClone(cteSeguroModelList!),
			ctePerigosoModelList: ctePerigosoModelListClone(ctePerigosoModelList!),
			cteVeiculoNovoModelList: cteVeiculoNovoModelListClone(cteVeiculoNovoModelList!),
			cteFaturaModelList: cteFaturaModelListClone(cteFaturaModelList!),
			cteDuplicataModelList: cteDuplicataModelListClone(cteDuplicataModelList!),
			cteRodoviarioModelList: cteRodoviarioModelListClone(cteRodoviarioModelList!),
			cteAereoModelList: cteAereoModelListClone(cteAereoModelList!),
			cteAquaviarioModelList: cteAquaviarioModelListClone(cteAquaviarioModelList!),
			cteFerroviarioModelList: cteFerroviarioModelListClone(cteFerroviarioModelList!),
			cteDutoviarioModelList: cteDutoviarioModelListClone(cteDutoviarioModelList!),
			cteMultimodalModelList: cteMultimodalModelListClone(cteMultimodalModelList!),
		);			
	}

	cteEmitenteModelListClone(List<CteEmitenteModel> cteEmitenteModelList) { 
		List<CteEmitenteModel> resultList = [];
		for (var cteEmitenteModel in cteEmitenteModelList) {
			resultList.add(
				CteEmitenteModel(
					id: cteEmitenteModel.id,
					idCteCabecalho: cteEmitenteModel.idCteCabecalho,
					cnpj: cteEmitenteModel.cnpj,
					ie: cteEmitenteModel.ie,
					nome: cteEmitenteModel.nome,
					fantasia: cteEmitenteModel.fantasia,
					logradouro: cteEmitenteModel.logradouro,
					numero: cteEmitenteModel.numero,
					complemento: cteEmitenteModel.complemento,
					bairro: cteEmitenteModel.bairro,
					codigoMunicipio: cteEmitenteModel.codigoMunicipio,
					nomeMunicipio: cteEmitenteModel.nomeMunicipio,
					uf: cteEmitenteModel.uf,
					cep: cteEmitenteModel.cep,
					telefone: cteEmitenteModel.telefone,
				)
			);
		}
		return resultList;
	}

	cteLocalColetaModelListClone(List<CteLocalColetaModel> cteLocalColetaModelList) { 
		List<CteLocalColetaModel> resultList = [];
		for (var cteLocalColetaModel in cteLocalColetaModelList) {
			resultList.add(
				CteLocalColetaModel(
					id: cteLocalColetaModel.id,
					idCteCabecalho: cteLocalColetaModel.idCteCabecalho,
					cnpj: cteLocalColetaModel.cnpj,
					cpf: cteLocalColetaModel.cpf,
					nome: cteLocalColetaModel.nome,
					logradouro: cteLocalColetaModel.logradouro,
					numero: cteLocalColetaModel.numero,
					complemento: cteLocalColetaModel.complemento,
					bairro: cteLocalColetaModel.bairro,
					codigoMunicipio: cteLocalColetaModel.codigoMunicipio,
					nomeMunicipio: cteLocalColetaModel.nomeMunicipio,
					uf: cteLocalColetaModel.uf,
				)
			);
		}
		return resultList;
	}

	cteTomadorModelListClone(List<CteTomadorModel> cteTomadorModelList) { 
		List<CteTomadorModel> resultList = [];
		for (var cteTomadorModel in cteTomadorModelList) {
			resultList.add(
				CteTomadorModel(
					id: cteTomadorModel.id,
					idCteCabecalho: cteTomadorModel.idCteCabecalho,
					cnpj: cteTomadorModel.cnpj,
					cpf: cteTomadorModel.cpf,
					ie: cteTomadorModel.ie,
					nome: cteTomadorModel.nome,
					fantasia: cteTomadorModel.fantasia,
					telefone: cteTomadorModel.telefone,
					logradouro: cteTomadorModel.logradouro,
					numero: cteTomadorModel.numero,
					complemento: cteTomadorModel.complemento,
					bairro: cteTomadorModel.bairro,
					codigoMunicipio: cteTomadorModel.codigoMunicipio,
					nomeMunicipio: cteTomadorModel.nomeMunicipio,
					uf: cteTomadorModel.uf,
					cep: cteTomadorModel.cep,
					codigoPais: cteTomadorModel.codigoPais,
					nomePais: cteTomadorModel.nomePais,
					email: cteTomadorModel.email,
				)
			);
		}
		return resultList;
	}

	ctePassagemModelListClone(List<CtePassagemModel> ctePassagemModelList) { 
		List<CtePassagemModel> resultList = [];
		for (var ctePassagemModel in ctePassagemModelList) {
			resultList.add(
				CtePassagemModel(
					id: ctePassagemModel.id,
					idCteCabecalho: ctePassagemModel.idCteCabecalho,
					siglaPassagem: ctePassagemModel.siglaPassagem,
					siglaDestino: ctePassagemModel.siglaDestino,
					rota: ctePassagemModel.rota,
				)
			);
		}
		return resultList;
	}

	cteRemetenteModelListClone(List<CteRemetenteModel> cteRemetenteModelList) { 
		List<CteRemetenteModel> resultList = [];
		for (var cteRemetenteModel in cteRemetenteModelList) {
			resultList.add(
				CteRemetenteModel(
					id: cteRemetenteModel.id,
					idCteCabecalho: cteRemetenteModel.idCteCabecalho,
					cnpj: cteRemetenteModel.cnpj,
					cpf: cteRemetenteModel.cpf,
					ie: cteRemetenteModel.ie,
					nome: cteRemetenteModel.nome,
					fantasia: cteRemetenteModel.fantasia,
					telefone: cteRemetenteModel.telefone,
					logradouro: cteRemetenteModel.logradouro,
					numero: cteRemetenteModel.numero,
					complemento: cteRemetenteModel.complemento,
					bairro: cteRemetenteModel.bairro,
					codigoMunicipio: cteRemetenteModel.codigoMunicipio,
					nomeMunicipio: cteRemetenteModel.nomeMunicipio,
					uf: cteRemetenteModel.uf,
					cep: cteRemetenteModel.cep,
					codigoPais: cteRemetenteModel.codigoPais,
					nomePais: cteRemetenteModel.nomePais,
					email: cteRemetenteModel.email,
				)
			);
		}
		return resultList;
	}

	cteExpedidorModelListClone(List<CteExpedidorModel> cteExpedidorModelList) { 
		List<CteExpedidorModel> resultList = [];
		for (var cteExpedidorModel in cteExpedidorModelList) {
			resultList.add(
				CteExpedidorModel(
					id: cteExpedidorModel.id,
					idCteCabecalho: cteExpedidorModel.idCteCabecalho,
					cnpj: cteExpedidorModel.cnpj,
					cpf: cteExpedidorModel.cpf,
					ie: cteExpedidorModel.ie,
					nome: cteExpedidorModel.nome,
					fantasia: cteExpedidorModel.fantasia,
					telefone: cteExpedidorModel.telefone,
					logradouro: cteExpedidorModel.logradouro,
					numero: cteExpedidorModel.numero,
					complemento: cteExpedidorModel.complemento,
					bairro: cteExpedidorModel.bairro,
					codigoMunicipio: cteExpedidorModel.codigoMunicipio,
					nomeMunicipio: cteExpedidorModel.nomeMunicipio,
					uf: cteExpedidorModel.uf,
					cep: cteExpedidorModel.cep,
					codigoPais: cteExpedidorModel.codigoPais,
					nomePais: cteExpedidorModel.nomePais,
					email: cteExpedidorModel.email,
				)
			);
		}
		return resultList;
	}

	cteRecebedorModelListClone(List<CteRecebedorModel> cteRecebedorModelList) { 
		List<CteRecebedorModel> resultList = [];
		for (var cteRecebedorModel in cteRecebedorModelList) {
			resultList.add(
				CteRecebedorModel(
					id: cteRecebedorModel.id,
					idCteCabecalho: cteRecebedorModel.idCteCabecalho,
					cnpj: cteRecebedorModel.cnpj,
					cpf: cteRecebedorModel.cpf,
					ie: cteRecebedorModel.ie,
					nome: cteRecebedorModel.nome,
					fantasia: cteRecebedorModel.fantasia,
					telefone: cteRecebedorModel.telefone,
					logradouro: cteRecebedorModel.logradouro,
					numero: cteRecebedorModel.numero,
					complemento: cteRecebedorModel.complemento,
					bairro: cteRecebedorModel.bairro,
					codigoMunicipio: cteRecebedorModel.codigoMunicipio,
					nomeMunicipio: cteRecebedorModel.nomeMunicipio,
					uf: cteRecebedorModel.uf,
					cep: cteRecebedorModel.cep,
					codigoPais: cteRecebedorModel.codigoPais,
					nomePais: cteRecebedorModel.nomePais,
					email: cteRecebedorModel.email,
				)
			);
		}
		return resultList;
	}

	cteDestinatarioModelListClone(List<CteDestinatarioModel> cteDestinatarioModelList) { 
		List<CteDestinatarioModel> resultList = [];
		for (var cteDestinatarioModel in cteDestinatarioModelList) {
			resultList.add(
				CteDestinatarioModel(
					id: cteDestinatarioModel.id,
					idCteCabecalho: cteDestinatarioModel.idCteCabecalho,
					cnpj: cteDestinatarioModel.cnpj,
					cpf: cteDestinatarioModel.cpf,
					ie: cteDestinatarioModel.ie,
					nome: cteDestinatarioModel.nome,
					fantasia: cteDestinatarioModel.fantasia,
					telefone: cteDestinatarioModel.telefone,
					logradouro: cteDestinatarioModel.logradouro,
					numero: cteDestinatarioModel.numero,
					complemento: cteDestinatarioModel.complemento,
					bairro: cteDestinatarioModel.bairro,
					codigoMunicipio: cteDestinatarioModel.codigoMunicipio,
					nomeMunicipio: cteDestinatarioModel.nomeMunicipio,
					uf: cteDestinatarioModel.uf,
					cep: cteDestinatarioModel.cep,
					codigoPais: cteDestinatarioModel.codigoPais,
					nomePais: cteDestinatarioModel.nomePais,
					email: cteDestinatarioModel.email,
				)
			);
		}
		return resultList;
	}

	cteLocalEntregaModelListClone(List<CteLocalEntregaModel> cteLocalEntregaModelList) { 
		List<CteLocalEntregaModel> resultList = [];
		for (var cteLocalEntregaModel in cteLocalEntregaModelList) {
			resultList.add(
				CteLocalEntregaModel(
					id: cteLocalEntregaModel.id,
					idCteCabecalho: cteLocalEntregaModel.idCteCabecalho,
					cnpj: cteLocalEntregaModel.cnpj,
					cpf: cteLocalEntregaModel.cpf,
					nome: cteLocalEntregaModel.nome,
					logradouro: cteLocalEntregaModel.logradouro,
					numero: cteLocalEntregaModel.numero,
					complemento: cteLocalEntregaModel.complemento,
					bairro: cteLocalEntregaModel.bairro,
					codigoMunicipio: cteLocalEntregaModel.codigoMunicipio,
					nomeMunicipio: cteLocalEntregaModel.nomeMunicipio,
					uf: cteLocalEntregaModel.uf,
				)
			);
		}
		return resultList;
	}

	cteComponenteModelListClone(List<CteComponenteModel> cteComponenteModelList) { 
		List<CteComponenteModel> resultList = [];
		for (var cteComponenteModel in cteComponenteModelList) {
			resultList.add(
				CteComponenteModel(
					id: cteComponenteModel.id,
					idCteCabecalho: cteComponenteModel.idCteCabecalho,
					nome: cteComponenteModel.nome,
					valor: cteComponenteModel.valor,
				)
			);
		}
		return resultList;
	}

	cteCargaModelListClone(List<CteCargaModel> cteCargaModelList) { 
		List<CteCargaModel> resultList = [];
		for (var cteCargaModel in cteCargaModelList) {
			resultList.add(
				CteCargaModel(
					id: cteCargaModel.id,
					idCteCabecalho: cteCargaModel.idCteCabecalho,
					codigoUnidadeMedida: cteCargaModel.codigoUnidadeMedida,
					tipoMedida: cteCargaModel.tipoMedida,
					quantidade: cteCargaModel.quantidade,
				)
			);
		}
		return resultList;
	}

	cteInformacaoNfOutrosModelListClone(List<CteInformacaoNfOutrosModel> cteInformacaoNfOutrosModelList) { 
		List<CteInformacaoNfOutrosModel> resultList = [];
		for (var cteInformacaoNfOutrosModel in cteInformacaoNfOutrosModelList) {
			resultList.add(
				CteInformacaoNfOutrosModel(
					id: cteInformacaoNfOutrosModel.id,
					idCteCabecalho: cteInformacaoNfOutrosModel.idCteCabecalho,
					numeroRomaneio: cteInformacaoNfOutrosModel.numeroRomaneio,
					numeroPedido: cteInformacaoNfOutrosModel.numeroPedido,
					chaveAcessoNfe: cteInformacaoNfOutrosModel.chaveAcessoNfe,
					codigoModelo: cteInformacaoNfOutrosModel.codigoModelo,
					serie: cteInformacaoNfOutrosModel.serie,
					numero: cteInformacaoNfOutrosModel.numero,
					dataEmissao: cteInformacaoNfOutrosModel.dataEmissao,
					ufEmitente: cteInformacaoNfOutrosModel.ufEmitente,
					baseCalculoIcms: cteInformacaoNfOutrosModel.baseCalculoIcms,
					valorIcms: cteInformacaoNfOutrosModel.valorIcms,
					baseCalculoIcmsSt: cteInformacaoNfOutrosModel.baseCalculoIcmsSt,
					valorIcmsSt: cteInformacaoNfOutrosModel.valorIcmsSt,
					valorTotalProdutos: cteInformacaoNfOutrosModel.valorTotalProdutos,
					valorTotal: cteInformacaoNfOutrosModel.valorTotal,
					cfopPredominante: cteInformacaoNfOutrosModel.cfopPredominante,
					pesoTotalKg: cteInformacaoNfOutrosModel.pesoTotalKg,
					pinSuframa: cteInformacaoNfOutrosModel.pinSuframa,
					dataPrevistaEntrega: cteInformacaoNfOutrosModel.dataPrevistaEntrega,
					outroTipoDocOrig: cteInformacaoNfOutrosModel.outroTipoDocOrig,
					outroDescricao: cteInformacaoNfOutrosModel.outroDescricao,
					outroValorDocumento: cteInformacaoNfOutrosModel.outroValorDocumento,
				)
			);
		}
		return resultList;
	}

	cteSeguroModelListClone(List<CteSeguroModel> cteSeguroModelList) { 
		List<CteSeguroModel> resultList = [];
		for (var cteSeguroModel in cteSeguroModelList) {
			resultList.add(
				CteSeguroModel(
					id: cteSeguroModel.id,
					idCteCabecalho: cteSeguroModel.idCteCabecalho,
					responsavel: cteSeguroModel.responsavel,
					seguradora: cteSeguroModel.seguradora,
					apolice: cteSeguroModel.apolice,
					averbacao: cteSeguroModel.averbacao,
					valorCarga: cteSeguroModel.valorCarga,
				)
			);
		}
		return resultList;
	}

	ctePerigosoModelListClone(List<CtePerigosoModel> ctePerigosoModelList) { 
		List<CtePerigosoModel> resultList = [];
		for (var ctePerigosoModel in ctePerigosoModelList) {
			resultList.add(
				CtePerigosoModel(
					id: ctePerigosoModel.id,
					idCteCabecalho: ctePerigosoModel.idCteCabecalho,
					numeroOnu: ctePerigosoModel.numeroOnu,
					nomeApropriado: ctePerigosoModel.nomeApropriado,
					classeRisco: ctePerigosoModel.classeRisco,
					grupoEmbalagem: ctePerigosoModel.grupoEmbalagem,
					quantidadeTotalProduto: ctePerigosoModel.quantidadeTotalProduto,
					quantidadeTipoVolume: ctePerigosoModel.quantidadeTipoVolume,
					pontoFulgor: ctePerigosoModel.pontoFulgor,
				)
			);
		}
		return resultList;
	}

	cteVeiculoNovoModelListClone(List<CteVeiculoNovoModel> cteVeiculoNovoModelList) { 
		List<CteVeiculoNovoModel> resultList = [];
		for (var cteVeiculoNovoModel in cteVeiculoNovoModelList) {
			resultList.add(
				CteVeiculoNovoModel(
					id: cteVeiculoNovoModel.id,
					idCteCabecalho: cteVeiculoNovoModel.idCteCabecalho,
					chassi: cteVeiculoNovoModel.chassi,
					cor: cteVeiculoNovoModel.cor,
					descricaoCor: cteVeiculoNovoModel.descricaoCor,
					codigoMarcaModelo: cteVeiculoNovoModel.codigoMarcaModelo,
					valorUnitario: cteVeiculoNovoModel.valorUnitario,
					valorFrete: cteVeiculoNovoModel.valorFrete,
				)
			);
		}
		return resultList;
	}

	cteFaturaModelListClone(List<CteFaturaModel> cteFaturaModelList) { 
		List<CteFaturaModel> resultList = [];
		for (var cteFaturaModel in cteFaturaModelList) {
			resultList.add(
				CteFaturaModel(
					id: cteFaturaModel.id,
					idCteCabecalho: cteFaturaModel.idCteCabecalho,
					numero: cteFaturaModel.numero,
					valorOriginal: cteFaturaModel.valorOriginal,
					valorDesconto: cteFaturaModel.valorDesconto,
					valorLiquido: cteFaturaModel.valorLiquido,
				)
			);
		}
		return resultList;
	}

	cteDuplicataModelListClone(List<CteDuplicataModel> cteDuplicataModelList) { 
		List<CteDuplicataModel> resultList = [];
		for (var cteDuplicataModel in cteDuplicataModelList) {
			resultList.add(
				CteDuplicataModel(
					id: cteDuplicataModel.id,
					idCteCabecalho: cteDuplicataModel.idCteCabecalho,
					numero: cteDuplicataModel.numero,
					dataVencimento: cteDuplicataModel.dataVencimento,
					valor: cteDuplicataModel.valor,
				)
			);
		}
		return resultList;
	}

	cteRodoviarioModelListClone(List<CteRodoviarioModel> cteRodoviarioModelList) { 
		List<CteRodoviarioModel> resultList = [];
		for (var cteRodoviarioModel in cteRodoviarioModelList) {
			resultList.add(
				CteRodoviarioModel(
					id: cteRodoviarioModel.id,
					idCteCabecalho: cteRodoviarioModel.idCteCabecalho,
					rntrc: cteRodoviarioModel.rntrc,
					dataPrevistaEntrega: cteRodoviarioModel.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioModel.indicadorLotacao,
					ciot: cteRodoviarioModel.ciot,
				)
			);
		}
		return resultList;
	}

	cteAereoModelListClone(List<CteAereoModel> cteAereoModelList) { 
		List<CteAereoModel> resultList = [];
		for (var cteAereoModel in cteAereoModelList) {
			resultList.add(
				CteAereoModel(
					id: cteAereoModel.id,
					idCteCabecalho: cteAereoModel.idCteCabecalho,
					numeroMinuta: cteAereoModel.numeroMinuta,
					numeroConhecimento: cteAereoModel.numeroConhecimento,
					dataPrevistaEntrega: cteAereoModel.dataPrevistaEntrega,
					idEmissor: cteAereoModel.idEmissor,
					idInternaTomador: cteAereoModel.idInternaTomador,
					tarifaClasse: cteAereoModel.tarifaClasse,
					tarifaCodigo: cteAereoModel.tarifaCodigo,
					tarifaValor: cteAereoModel.tarifaValor,
					cargaDimensao: cteAereoModel.cargaDimensao,
					cargaInformacaoManuseio: cteAereoModel.cargaInformacaoManuseio,
					cargaEspecial: cteAereoModel.cargaEspecial,
				)
			);
		}
		return resultList;
	}

	cteAquaviarioModelListClone(List<CteAquaviarioModel> cteAquaviarioModelList) { 
		List<CteAquaviarioModel> resultList = [];
		for (var cteAquaviarioModel in cteAquaviarioModelList) {
			resultList.add(
				CteAquaviarioModel(
					id: cteAquaviarioModel.id,
					idCteCabecalho: cteAquaviarioModel.idCteCabecalho,
					valorPrestacao: cteAquaviarioModel.valorPrestacao,
					afrmm: cteAquaviarioModel.afrmm,
					numeroBooking: cteAquaviarioModel.numeroBooking,
					numeroControle: cteAquaviarioModel.numeroControle,
					idNavio: cteAquaviarioModel.idNavio,
				)
			);
		}
		return resultList;
	}

	cteFerroviarioModelListClone(List<CteFerroviarioModel> cteFerroviarioModelList) { 
		List<CteFerroviarioModel> resultList = [];
		for (var cteFerroviarioModel in cteFerroviarioModelList) {
			resultList.add(
				CteFerroviarioModel(
					id: cteFerroviarioModel.id,
					idCteCabecalho: cteFerroviarioModel.idCteCabecalho,
					tipoTrafego: cteFerroviarioModel.tipoTrafego,
					responsavelFaturamento: cteFerroviarioModel.responsavelFaturamento,
					ferroviaEmitenteCte: cteFerroviarioModel.ferroviaEmitenteCte,
					fluxo: cteFerroviarioModel.fluxo,
					idTrem: cteFerroviarioModel.idTrem,
					valorFrete: cteFerroviarioModel.valorFrete,
				)
			);
		}
		return resultList;
	}

	cteDutoviarioModelListClone(List<CteDutoviarioModel> cteDutoviarioModelList) { 
		List<CteDutoviarioModel> resultList = [];
		for (var cteDutoviarioModel in cteDutoviarioModelList) {
			resultList.add(
				CteDutoviarioModel(
					id: cteDutoviarioModel.id,
					idCteCabecalho: cteDutoviarioModel.idCteCabecalho,
					valorTarifa: cteDutoviarioModel.valorTarifa,
					dataInicio: cteDutoviarioModel.dataInicio,
					dataFim: cteDutoviarioModel.dataFim,
				)
			);
		}
		return resultList;
	}

	cteMultimodalModelListClone(List<CteMultimodalModel> cteMultimodalModelList) { 
		List<CteMultimodalModel> resultList = [];
		for (var cteMultimodalModel in cteMultimodalModelList) {
			resultList.add(
				CteMultimodalModel(
					id: cteMultimodalModel.id,
					idCteCabecalho: cteMultimodalModel.idCteCabecalho,
					cotm: cteMultimodalModel.cotm,
					indicadorNegociavel: cteMultimodalModel.indicadorNegociavel,
				)
			);
		}
		return resultList;
	}

	
}