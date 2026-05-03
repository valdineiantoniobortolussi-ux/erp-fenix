import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class VendaCabecalhoModel {
	int? id;
	int? idVendaOrcamentoCabecalho;
	int? idVendaCondicoesPagamento;
	int? idNotaFiscalTipo;
	int? idTransportadora;
	DateTime? dataVenda;
	DateTime? dataSaida;
	String? horaSaida;
	int? numeroFatura;
	String? localEntrega;
	String? localCobranca;
	double? valorSubtotal;
	double? taxaComissao;
	double? valorComissao;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	String? tipoFrete;
	String? formaPagamento;
	double? valorFrete;
	double? valorSeguro;
	String? observacao;
	String? situacao;
	String? diaFixoParcela;

	VendaCabecalhoModel({
		this.id,
		this.idVendaOrcamentoCabecalho,
		this.idVendaCondicoesPagamento,
		this.idNotaFiscalTipo,
		this.idTransportadora,
		this.dataVenda,
		this.dataSaida,
		this.horaSaida,
		this.numeroFatura,
		this.localEntrega,
		this.localCobranca,
		this.valorSubtotal,
		this.taxaComissao,
		this.valorComissao,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.tipoFrete,
		this.formaPagamento,
		this.valorFrete,
		this.valorSeguro,
		this.observacao,
		this.situacao,
		this.diaFixoParcela,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_venda_orcamento_cabecalho',
		'id_venda_condicoes_pagamento',
		'id_nota_fiscal_tipo',
		'id_transportadora',
		'data_venda',
		'data_saida',
		'hora_saida',
		'numero_fatura',
		'local_entrega',
		'local_cobranca',
		'valor_subtotal',
		'taxa_comissao',
		'valor_comissao',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
		'tipo_frete',
		'forma_pagamento',
		'valor_frete',
		'valor_seguro',
		'observacao',
		'situacao',
		'dia_fixo_parcela',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Venda Orcamento Cabecalho',
		'Id Venda Condicoes Pagamento',
		'Id Nota Fiscal Tipo',
		'Id Transportadora',
		'Data Venda',
		'Data Saida',
		'Hora Saida',
		'Numero Fatura',
		'Local Entrega',
		'Local Cobranca',
		'Valor Subtotal',
		'Taxa Comissao',
		'Valor Comissao',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
		'Tipo Frete',
		'Forma Pagamento',
		'Valor Frete',
		'Valor Seguro',
		'Observacao',
		'Situacao',
		'Dia Fixo Parcela',
	];

	VendaCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaOrcamentoCabecalho = jsonData['idVendaOrcamentoCabecalho'];
		idVendaCondicoesPagamento = jsonData['idVendaCondicoesPagamento'];
		idNotaFiscalTipo = jsonData['idNotaFiscalTipo'];
		idTransportadora = jsonData['idTransportadora'];
		dataVenda = jsonData['dataVenda'] != null ? DateTime.tryParse(jsonData['dataVenda']) : null;
		dataSaida = jsonData['dataSaida'] != null ? DateTime.tryParse(jsonData['dataSaida']) : null;
		horaSaida = jsonData['horaSaida'];
		numeroFatura = jsonData['numeroFatura'];
		localEntrega = jsonData['localEntrega'];
		localCobranca = jsonData['localCobranca'];
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaComissao = jsonData['taxaComissao']?.toDouble();
		valorComissao = jsonData['valorComissao']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		tipoFrete = VendaCabecalhoDomain.getTipoFrete(jsonData['tipoFrete']);
		formaPagamento = VendaCabecalhoDomain.getFormaPagamento(jsonData['formaPagamento']);
		valorFrete = jsonData['valorFrete']?.toDouble();
		valorSeguro = jsonData['valorSeguro']?.toDouble();
		observacao = jsonData['observacao'];
		situacao = VendaCabecalhoDomain.getSituacao(jsonData['situacao']);
		diaFixoParcela = VendaCabecalhoDomain.getDiaFixoParcela(jsonData['diaFixoParcela']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaOrcamentoCabecalho'] = idVendaOrcamentoCabecalho;
		jsonData['idVendaCondicoesPagamento'] = idVendaCondicoesPagamento;
		jsonData['idNotaFiscalTipo'] = idNotaFiscalTipo;
		jsonData['idTransportadora'] = idTransportadora;
		jsonData['dataVenda'] = dataVenda != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVenda!) : null;
		jsonData['dataSaida'] = dataSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSaida!) : null;
		jsonData['horaSaida'] = horaSaida;
		jsonData['numeroFatura'] = numeroFatura;
		jsonData['localEntrega'] = localEntrega;
		jsonData['localCobranca'] = localCobranca;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaComissao'] = taxaComissao;
		jsonData['valorComissao'] = valorComissao;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['tipoFrete'] = VendaCabecalhoDomain.setTipoFrete(tipoFrete);
		jsonData['formaPagamento'] = VendaCabecalhoDomain.setFormaPagamento(formaPagamento);
		jsonData['valorFrete'] = valorFrete;
		jsonData['valorSeguro'] = valorSeguro;
		jsonData['observacao'] = observacao;
		jsonData['situacao'] = VendaCabecalhoDomain.setSituacao(situacao);
		jsonData['diaFixoParcela'] = VendaCabecalhoDomain.setDiaFixoParcela(diaFixoParcela);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaOrcamentoCabecalho = plutoRow.cells['idVendaOrcamentoCabecalho']?.value;
		idVendaCondicoesPagamento = plutoRow.cells['idVendaCondicoesPagamento']?.value;
		idNotaFiscalTipo = plutoRow.cells['idNotaFiscalTipo']?.value;
		idTransportadora = plutoRow.cells['idTransportadora']?.value;
		dataVenda = Util.stringToDate(plutoRow.cells['dataVenda']?.value);
		dataSaida = Util.stringToDate(plutoRow.cells['dataSaida']?.value);
		horaSaida = plutoRow.cells['horaSaida']?.value;
		numeroFatura = plutoRow.cells['numeroFatura']?.value;
		localEntrega = plutoRow.cells['localEntrega']?.value;
		localCobranca = plutoRow.cells['localCobranca']?.value;
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaComissao = plutoRow.cells['taxaComissao']?.value?.toDouble();
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		tipoFrete = plutoRow.cells['tipoFrete']?.value != '' ? plutoRow.cells['tipoFrete']?.value : 'AAA';
		formaPagamento = plutoRow.cells['formaPagamento']?.value != '' ? plutoRow.cells['formaPagamento']?.value : 'AAA';
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		valorSeguro = plutoRow.cells['valorSeguro']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'AAA';
		diaFixoParcela = plutoRow.cells['diaFixoParcela']?.value != '' ? plutoRow.cells['diaFixoParcela']?.value : 'AAA';
	}	

	VendaCabecalhoModel clone() {
		return VendaCabecalhoModel(
			id: id,
			idVendaOrcamentoCabecalho: idVendaOrcamentoCabecalho,
			idVendaCondicoesPagamento: idVendaCondicoesPagamento,
			idNotaFiscalTipo: idNotaFiscalTipo,
			idTransportadora: idTransportadora,
			dataVenda: dataVenda,
			dataSaida: dataSaida,
			horaSaida: horaSaida,
			numeroFatura: numeroFatura,
			localEntrega: localEntrega,
			localCobranca: localCobranca,
			valorSubtotal: valorSubtotal,
			taxaComissao: taxaComissao,
			valorComissao: valorComissao,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
			tipoFrete: tipoFrete,
			formaPagamento: formaPagamento,
			valorFrete: valorFrete,
			valorSeguro: valorSeguro,
			observacao: observacao,
			situacao: situacao,
			diaFixoParcela: diaFixoParcela,
		);			
	}

	
}