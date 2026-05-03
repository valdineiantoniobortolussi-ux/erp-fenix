import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinParcelaReceberModel {
	int? id;
	int? idFinLancamentoReceber;
	int? idFinChequeRecebido;
	int? idFinStatusParcela;
	int? idFinTipoRecebimento;
	int? numeroParcela;
	DateTime? dataEmissao;
	DateTime? dataVencimento;
	DateTime? dataRecebimento;
	DateTime? descontoAte;
	double? valor;
	double? taxaJuro;
	double? taxaMulta;
	double? taxaDesconto;
	double? valorJuro;
	double? valorMulta;
	double? valorDesconto;
	String? emitiuBoleto;
	String? boletoNossoNumero;
	double? valorRecebido;
	String? historico;
	FinStatusParcelaModel? finStatusParcelaModel;
	FinTipoRecebimentoModel? finTipoRecebimentoModel;

	FinParcelaReceberModel({
		this.id,
		this.idFinLancamentoReceber,
		this.idFinChequeRecebido,
		this.idFinStatusParcela,
		this.idFinTipoRecebimento,
		this.numeroParcela,
		this.dataEmissao,
		this.dataVencimento,
		this.dataRecebimento,
		this.descontoAte,
		this.valor,
		this.taxaJuro,
		this.taxaMulta,
		this.taxaDesconto,
		this.valorJuro,
		this.valorMulta,
		this.valorDesconto,
		this.emitiuBoleto,
		this.boletoNossoNumero,
		this.valorRecebido,
		this.historico,
		this.finStatusParcelaModel,
		this.finTipoRecebimentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_parcela',
		'data_emissao',
		'data_vencimento',
		'data_recebimento',
		'desconto_ate',
		'valor',
		'taxa_juro',
		'taxa_multa',
		'taxa_desconto',
		'valor_juro',
		'valor_multa',
		'valor_desconto',
		'emitiu_boleto',
		'boleto_nosso_numero',
		'valor_recebido',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Parcela',
		'Data Emissao',
		'Data Vencimento',
		'Data Recebimento',
		'Desconto Ate',
		'Valor',
		'Taxa Juro',
		'Taxa Multa',
		'Taxa Desconto',
		'Valor Juro',
		'Valor Multa',
		'Valor Desconto',
		'Emitiu Boleto',
		'Boleto Nosso Numero',
		'Valor Recebido',
		'Historico',
	];

	FinParcelaReceberModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFinLancamentoReceber = jsonData['idFinLancamentoReceber'];
		idFinChequeRecebido = jsonData['idFinChequeRecebido'];
		idFinStatusParcela = jsonData['idFinStatusParcela'];
		idFinTipoRecebimento = jsonData['idFinTipoRecebimento'];
		numeroParcela = jsonData['numeroParcela'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		dataRecebimento = jsonData['dataRecebimento'] != null ? DateTime.tryParse(jsonData['dataRecebimento']) : null;
		descontoAte = jsonData['descontoAte'] != null ? DateTime.tryParse(jsonData['descontoAte']) : null;
		valor = jsonData['valor']?.toDouble();
		taxaJuro = jsonData['taxaJuro']?.toDouble();
		taxaMulta = jsonData['taxaMulta']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorJuro = jsonData['valorJuro']?.toDouble();
		valorMulta = jsonData['valorMulta']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		emitiuBoleto = FinParcelaReceberDomain.getEmitiuBoleto(jsonData['emitiuBoleto']);
		boletoNossoNumero = jsonData['boletoNossoNumero'];
		valorRecebido = jsonData['valorRecebido']?.toDouble();
		historico = jsonData['historico'];
		finStatusParcelaModel = jsonData['finStatusParcelaModel'] == null ? FinStatusParcelaModel() : FinStatusParcelaModel.fromJson(jsonData['finStatusParcelaModel']);
		finTipoRecebimentoModel = jsonData['finTipoRecebimentoModel'] == null ? FinTipoRecebimentoModel() : FinTipoRecebimentoModel.fromJson(jsonData['finTipoRecebimentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFinLancamentoReceber'] = idFinLancamentoReceber != 0 ? idFinLancamentoReceber : null;
		jsonData['idFinChequeRecebido'] = idFinChequeRecebido != 0 ? idFinChequeRecebido : null;
		jsonData['idFinStatusParcela'] = idFinStatusParcela != 0 ? idFinStatusParcela : null;
		jsonData['idFinTipoRecebimento'] = idFinTipoRecebimento != 0 ? idFinTipoRecebimento : null;
		jsonData['numeroParcela'] = numeroParcela;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['dataRecebimento'] = dataRecebimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRecebimento!) : null;
		jsonData['descontoAte'] = descontoAte != null ? DateFormat('yyyy-MM-ddT00:00:00').format(descontoAte!) : null;
		jsonData['valor'] = valor;
		jsonData['taxaJuro'] = taxaJuro;
		jsonData['taxaMulta'] = taxaMulta;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorJuro'] = valorJuro;
		jsonData['valorMulta'] = valorMulta;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['emitiuBoleto'] = FinParcelaReceberDomain.setEmitiuBoleto(emitiuBoleto);
		jsonData['boletoNossoNumero'] = boletoNossoNumero;
		jsonData['valorRecebido'] = valorRecebido;
		jsonData['historico'] = historico;
		jsonData['finStatusParcelaModel'] = finStatusParcelaModel?.toJson;
		jsonData['finTipoRecebimentoModel'] = finTipoRecebimentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFinLancamentoReceber = plutoRow.cells['idFinLancamentoReceber']?.value;
		idFinChequeRecebido = plutoRow.cells['idFinChequeRecebido']?.value;
		idFinStatusParcela = plutoRow.cells['idFinStatusParcela']?.value;
		idFinTipoRecebimento = plutoRow.cells['idFinTipoRecebimento']?.value;
		numeroParcela = plutoRow.cells['numeroParcela']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		dataRecebimento = Util.stringToDate(plutoRow.cells['dataRecebimento']?.value);
		descontoAte = Util.stringToDate(plutoRow.cells['descontoAte']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		taxaJuro = plutoRow.cells['taxaJuro']?.value?.toDouble();
		taxaMulta = plutoRow.cells['taxaMulta']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorJuro = plutoRow.cells['valorJuro']?.value?.toDouble();
		valorMulta = plutoRow.cells['valorMulta']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		emitiuBoleto = plutoRow.cells['emitiuBoleto']?.value != '' ? plutoRow.cells['emitiuBoleto']?.value : 'S';
		boletoNossoNumero = plutoRow.cells['boletoNossoNumero']?.value;
		valorRecebido = plutoRow.cells['valorRecebido']?.value?.toDouble();
		historico = plutoRow.cells['historico']?.value;
		finStatusParcelaModel = FinStatusParcelaModel();
		finStatusParcelaModel?.descricao = plutoRow.cells['finStatusParcelaModel']?.value;
		finTipoRecebimentoModel = FinTipoRecebimentoModel();
		finTipoRecebimentoModel?.descricao = plutoRow.cells['finTipoRecebimentoModel']?.value;
	}	

	FinParcelaReceberModel clone() {
		return FinParcelaReceberModel(
			id: id,
			idFinLancamentoReceber: idFinLancamentoReceber,
			idFinChequeRecebido: idFinChequeRecebido,
			idFinStatusParcela: idFinStatusParcela,
			idFinTipoRecebimento: idFinTipoRecebimento,
			numeroParcela: numeroParcela,
			dataEmissao: dataEmissao,
			dataVencimento: dataVencimento,
			dataRecebimento: dataRecebimento,
			descontoAte: descontoAte,
			valor: valor,
			taxaJuro: taxaJuro,
			taxaMulta: taxaMulta,
			taxaDesconto: taxaDesconto,
			valorJuro: valorJuro,
			valorMulta: valorMulta,
			valorDesconto: valorDesconto,
			emitiuBoleto: emitiuBoleto,
			boletoNossoNumero: boletoNossoNumero,
			valorRecebido: valorRecebido,
			historico: historico,
		);			
	}

	
}