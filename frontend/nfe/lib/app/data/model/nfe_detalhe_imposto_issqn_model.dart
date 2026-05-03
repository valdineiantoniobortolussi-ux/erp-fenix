import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheImpostoIssqnModel {
	int? id;
	int? idNfeDetalhe;
	double? baseCalculoIssqn;
	double? aliquotaIssqn;
	double? valorIssqn;
	int? municipioIssqn;
	int? itemListaServicos;
	double? valorDeducao;
	double? valorOutrasRetencoes;
	double? valorDescontoIncondicionado;
	double? valorDescontoCondicionado;
	double? valorRetencaoIss;
	String? indicadorExigibilidadeIss;
	String? codigoServico;
	int? municipioIncidencia;
	int? paisSevicoPrestado;
	String? numeroProcesso;
	String? indicadorIncentivoFiscal;

	NfeDetalheImpostoIssqnModel({
		this.id,
		this.idNfeDetalhe,
		this.baseCalculoIssqn,
		this.aliquotaIssqn,
		this.valorIssqn,
		this.municipioIssqn,
		this.itemListaServicos,
		this.valorDeducao,
		this.valorOutrasRetencoes,
		this.valorDescontoIncondicionado,
		this.valorDescontoCondicionado,
		this.valorRetencaoIss,
		this.indicadorExigibilidadeIss,
		this.codigoServico,
		this.municipioIncidencia,
		this.paisSevicoPrestado,
		this.numeroProcesso,
		this.indicadorIncentivoFiscal,
	});

	static List<String> dbColumns = <String>[
		'id',
		'base_calculo_issqn',
		'aliquota_issqn',
		'valor_issqn',
		'municipio_issqn',
		'item_lista_servicos',
		'valor_deducao',
		'valor_outras_retencoes',
		'valor_desconto_incondicionado',
		'valor_desconto_condicionado',
		'valor_retencao_iss',
		'indicador_exigibilidade_iss',
		'codigo_servico',
		'municipio_incidencia',
		'pais_sevico_prestado',
		'numero_processo',
		'indicador_incentivo_fiscal',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Base Calculo Issqn',
		'Aliquota Issqn',
		'Valor Issqn',
		'Municipio Issqn',
		'Item Lista Servicos',
		'Valor Deducao',
		'Valor Outras Retencoes',
		'Valor Desconto Incondicionado',
		'Valor Desconto Condicionado',
		'Valor Retencao Iss',
		'Indicador Exigibilidade Iss',
		'Codigo Servico',
		'Municipio Incidencia',
		'Pais Sevico Prestado',
		'Numero Processo',
		'Indicador Incentivo Fiscal',
	];

	NfeDetalheImpostoIssqnModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		baseCalculoIssqn = jsonData['baseCalculoIssqn']?.toDouble();
		aliquotaIssqn = jsonData['aliquotaIssqn']?.toDouble();
		valorIssqn = jsonData['valorIssqn']?.toDouble();
		municipioIssqn = jsonData['municipioIssqn'];
		itemListaServicos = jsonData['itemListaServicos'];
		valorDeducao = jsonData['valorDeducao']?.toDouble();
		valorOutrasRetencoes = jsonData['valorOutrasRetencoes']?.toDouble();
		valorDescontoIncondicionado = jsonData['valorDescontoIncondicionado']?.toDouble();
		valorDescontoCondicionado = jsonData['valorDescontoCondicionado']?.toDouble();
		valorRetencaoIss = jsonData['valorRetencaoIss']?.toDouble();
		indicadorExigibilidadeIss = NfeDetalheImpostoIssqnDomain.getIndicadorExigibilidadeIss(jsonData['indicadorExigibilidadeIss']);
		codigoServico = jsonData['codigoServico'];
		municipioIncidencia = jsonData['municipioIncidencia'];
		paisSevicoPrestado = jsonData['paisSevicoPrestado'];
		numeroProcesso = jsonData['numeroProcesso'];
		indicadorIncentivoFiscal = NfeDetalheImpostoIssqnDomain.getIndicadorIncentivoFiscal(jsonData['indicadorIncentivoFiscal']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['baseCalculoIssqn'] = baseCalculoIssqn;
		jsonData['aliquotaIssqn'] = aliquotaIssqn;
		jsonData['valorIssqn'] = valorIssqn;
		jsonData['municipioIssqn'] = municipioIssqn;
		jsonData['itemListaServicos'] = itemListaServicos;
		jsonData['valorDeducao'] = valorDeducao;
		jsonData['valorOutrasRetencoes'] = valorOutrasRetencoes;
		jsonData['valorDescontoIncondicionado'] = valorDescontoIncondicionado;
		jsonData['valorDescontoCondicionado'] = valorDescontoCondicionado;
		jsonData['valorRetencaoIss'] = valorRetencaoIss;
		jsonData['indicadorExigibilidadeIss'] = NfeDetalheImpostoIssqnDomain.setIndicadorExigibilidadeIss(indicadorExigibilidadeIss);
		jsonData['codigoServico'] = codigoServico;
		jsonData['municipioIncidencia'] = municipioIncidencia;
		jsonData['paisSevicoPrestado'] = paisSevicoPrestado;
		jsonData['numeroProcesso'] = numeroProcesso;
		jsonData['indicadorIncentivoFiscal'] = NfeDetalheImpostoIssqnDomain.setIndicadorIncentivoFiscal(indicadorIncentivoFiscal);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		baseCalculoIssqn = plutoRow.cells['baseCalculoIssqn']?.value?.toDouble();
		aliquotaIssqn = plutoRow.cells['aliquotaIssqn']?.value?.toDouble();
		valorIssqn = plutoRow.cells['valorIssqn']?.value?.toDouble();
		municipioIssqn = plutoRow.cells['municipioIssqn']?.value;
		itemListaServicos = plutoRow.cells['itemListaServicos']?.value;
		valorDeducao = plutoRow.cells['valorDeducao']?.value?.toDouble();
		valorOutrasRetencoes = plutoRow.cells['valorOutrasRetencoes']?.value?.toDouble();
		valorDescontoIncondicionado = plutoRow.cells['valorDescontoIncondicionado']?.value?.toDouble();
		valorDescontoCondicionado = plutoRow.cells['valorDescontoCondicionado']?.value?.toDouble();
		valorRetencaoIss = plutoRow.cells['valorRetencaoIss']?.value?.toDouble();
		indicadorExigibilidadeIss = plutoRow.cells['indicadorExigibilidadeIss']?.value != '' ? plutoRow.cells['indicadorExigibilidadeIss']?.value : 'AAA';
		codigoServico = plutoRow.cells['codigoServico']?.value;
		municipioIncidencia = plutoRow.cells['municipioIncidencia']?.value;
		paisSevicoPrestado = plutoRow.cells['paisSevicoPrestado']?.value;
		numeroProcesso = plutoRow.cells['numeroProcesso']?.value;
		indicadorIncentivoFiscal = plutoRow.cells['indicadorIncentivoFiscal']?.value != '' ? plutoRow.cells['indicadorIncentivoFiscal']?.value : 'AAA';
	}	

	NfeDetalheImpostoIssqnModel clone() {
		return NfeDetalheImpostoIssqnModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			baseCalculoIssqn: baseCalculoIssqn,
			aliquotaIssqn: aliquotaIssqn,
			valorIssqn: valorIssqn,
			municipioIssqn: municipioIssqn,
			itemListaServicos: itemListaServicos,
			valorDeducao: valorDeducao,
			valorOutrasRetencoes: valorOutrasRetencoes,
			valorDescontoIncondicionado: valorDescontoIncondicionado,
			valorDescontoCondicionado: valorDescontoCondicionado,
			valorRetencaoIss: valorRetencaoIss,
			indicadorExigibilidadeIss: indicadorExigibilidadeIss,
			codigoServico: codigoServico,
			municipioIncidencia: municipioIncidencia,
			paisSevicoPrestado: paisSevicoPrestado,
			numeroProcesso: numeroProcesso,
			indicadorIncentivoFiscal: indicadorIncentivoFiscal,
		);			
	}

	
}