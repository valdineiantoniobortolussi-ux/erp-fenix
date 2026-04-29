import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FinParcelaPagarModel {
	int? id;
	int? idFinLancamentoPagar;
	int? idFinChequeEmitido;
	int? idFinStatusParcela;
	int? idFinTipoPagamento;
	int? numeroParcela;
	DateTime? dataEmissao;
	DateTime? dataVencimento;
	DateTime? dataPagamento;
	DateTime? descontoAte;
	double? valor;
	double? taxaJuro;
	double? taxaMulta;
	double? taxaDesconto;
	double? valorJuro;
	double? valorMulta;
	double? valorDesconto;
	double? valorPago;
	String? historico;
	FinStatusParcelaModel? finStatusParcelaModel;
	FinTipoPagamentoModel? finTipoPagamentoModel;

	FinParcelaPagarModel({
		this.id,
		this.idFinLancamentoPagar,
		this.idFinChequeEmitido,
		this.idFinStatusParcela,
		this.idFinTipoPagamento,
		this.numeroParcela,
		this.dataEmissao,
		this.dataVencimento,
		this.dataPagamento,
		this.descontoAte,
		this.valor,
		this.taxaJuro,
		this.taxaMulta,
		this.taxaDesconto,
		this.valorJuro,
		this.valorMulta,
		this.valorDesconto,
		this.valorPago,
		this.historico,
		this.finStatusParcelaModel,
		this.finTipoPagamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_parcela',
		'data_emissao',
		'data_vencimento',
		'data_pagamento',
		'desconto_ate',
		'valor',
		'taxa_juro',
		'taxa_multa',
		'taxa_desconto',
		'valor_juro',
		'valor_multa',
		'valor_desconto',
		'valor_pago',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Parcela',
		'Data Emissao',
		'Data Vencimento',
		'Data Pagamento',
		'Desconto Ate',
		'Valor',
		'Taxa Juro',
		'Taxa Multa',
		'Taxa Desconto',
		'Valor Juro',
		'Valor Multa',
		'Valor Desconto',
		'Valor Pago',
		'Historico',
	];

	FinParcelaPagarModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFinLancamentoPagar = jsonData['idFinLancamentoPagar'];
		idFinChequeEmitido = jsonData['idFinChequeEmitido'];
		idFinStatusParcela = jsonData['idFinStatusParcela'];
		idFinTipoPagamento = jsonData['idFinTipoPagamento'];
		numeroParcela = jsonData['numeroParcela'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		dataPagamento = jsonData['dataPagamento'] != null ? DateTime.tryParse(jsonData['dataPagamento']) : null;
		descontoAte = jsonData['descontoAte'] != null ? DateTime.tryParse(jsonData['descontoAte']) : null;
		valor = jsonData['valor']?.toDouble();
		taxaJuro = jsonData['taxaJuro']?.toDouble();
		taxaMulta = jsonData['taxaMulta']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorJuro = jsonData['valorJuro']?.toDouble();
		valorMulta = jsonData['valorMulta']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorPago = jsonData['valorPago']?.toDouble();
		historico = jsonData['historico'];
		finStatusParcelaModel = jsonData['finStatusParcelaModel'] == null ? FinStatusParcelaModel() : FinStatusParcelaModel.fromJson(jsonData['finStatusParcelaModel']);
		finTipoPagamentoModel = jsonData['finTipoPagamentoModel'] == null ? FinTipoPagamentoModel() : FinTipoPagamentoModel.fromJson(jsonData['finTipoPagamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFinLancamentoPagar'] = idFinLancamentoPagar != 0 ? idFinLancamentoPagar : null;
		jsonData['idFinChequeEmitido'] = idFinChequeEmitido != 0 ? idFinChequeEmitido : null;
		jsonData['idFinStatusParcela'] = idFinStatusParcela != 0 ? idFinStatusParcela : null;
		jsonData['idFinTipoPagamento'] = idFinTipoPagamento != 0 ? idFinTipoPagamento : null;
		jsonData['numeroParcela'] = numeroParcela;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['dataPagamento'] = dataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPagamento!) : null;
		jsonData['descontoAte'] = descontoAte != null ? DateFormat('yyyy-MM-ddT00:00:00').format(descontoAte!) : null;
		jsonData['valor'] = valor;
		jsonData['taxaJuro'] = taxaJuro;
		jsonData['taxaMulta'] = taxaMulta;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorJuro'] = valorJuro;
		jsonData['valorMulta'] = valorMulta;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorPago'] = valorPago;
		jsonData['historico'] = historico;
		jsonData['finStatusParcelaModel'] = finStatusParcelaModel?.toJson;
		jsonData['finTipoPagamentoModel'] = finTipoPagamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFinLancamentoPagar = plutoRow.cells['idFinLancamentoPagar']?.value;
		idFinChequeEmitido = plutoRow.cells['idFinChequeEmitido']?.value;
		idFinStatusParcela = plutoRow.cells['idFinStatusParcela']?.value;
		idFinTipoPagamento = plutoRow.cells['idFinTipoPagamento']?.value;
		numeroParcela = plutoRow.cells['numeroParcela']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		dataPagamento = Util.stringToDate(plutoRow.cells['dataPagamento']?.value);
		descontoAte = Util.stringToDate(plutoRow.cells['descontoAte']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		taxaJuro = plutoRow.cells['taxaJuro']?.value?.toDouble();
		taxaMulta = plutoRow.cells['taxaMulta']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorJuro = plutoRow.cells['valorJuro']?.value?.toDouble();
		valorMulta = plutoRow.cells['valorMulta']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorPago = plutoRow.cells['valorPago']?.value?.toDouble();
		historico = plutoRow.cells['historico']?.value;
		finStatusParcelaModel = FinStatusParcelaModel();
		finStatusParcelaModel?.descricao = plutoRow.cells['finStatusParcelaModel']?.value;
		finTipoPagamentoModel = FinTipoPagamentoModel();
		finTipoPagamentoModel?.descricao = plutoRow.cells['finTipoPagamentoModel']?.value;
	}	

	FinParcelaPagarModel clone() {
		return FinParcelaPagarModel(
			id: id,
			idFinLancamentoPagar: idFinLancamentoPagar,
			idFinChequeEmitido: idFinChequeEmitido,
			idFinStatusParcela: idFinStatusParcela,
			idFinTipoPagamento: idFinTipoPagamento,
			numeroParcela: numeroParcela,
			dataEmissao: dataEmissao,
			dataVencimento: dataVencimento,
			dataPagamento: dataPagamento,
			descontoAte: descontoAte,
			valor: valor,
			taxaJuro: taxaJuro,
			taxaMulta: taxaMulta,
			taxaDesconto: taxaDesconto,
			valorJuro: valorJuro,
			valorMulta: valorMulta,
			valorDesconto: valorDesconto,
			valorPago: valorPago,
			historico: historico,
		);			
	}

	
}