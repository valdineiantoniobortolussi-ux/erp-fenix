import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:compras/app/data/domain/domain_imports.dart';

class CompraPedidoModel {
	int? id;
	int? idCompraTipoPedido;
	int? idColaborador;
	int? idFornecedor;
	String? codigoCotacao;
	DateTime? dataPedido;
	DateTime? dataPrevistaEntrega;
	DateTime? dataPrevisaoPagamento;
	String? localEntrega;
	String? localCobranca;
	String? contato;
	double? valorSubtotal;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	String? tipoFrete;
	String? formaPagamento;
	double? baseCalculoIcms;
	double? valorIcms;
	double? baseCalculoIcmsSt;
	double? valorIcmsSt;
	double? valorTotalProdutos;
	double? valorFrete;
	double? valorSeguro;
	double? valorOutrasDespesas;
	double? valorIpi;
	double? valorTotalNf;
	int? quantidadeParcelas;
	String? diaPrimeiroVencimento;
	int? intervaloEntreParcelas;
	String? diaFixoParcela;
	List<CompraPedidoDetalheModel>? compraPedidoDetalheModelList;
	CompraTipoPedidoModel? compraTipoPedidoModel;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;

	CompraPedidoModel({
		this.id,
		this.idCompraTipoPedido,
		this.idColaborador,
		this.idFornecedor,
		this.codigoCotacao,
		this.dataPedido,
		this.dataPrevistaEntrega,
		this.dataPrevisaoPagamento,
		this.localEntrega,
		this.localCobranca,
		this.contato,
		this.valorSubtotal,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.tipoFrete,
		this.formaPagamento,
		this.baseCalculoIcms,
		this.valorIcms,
		this.baseCalculoIcmsSt,
		this.valorIcmsSt,
		this.valorTotalProdutos,
		this.valorFrete,
		this.valorSeguro,
		this.valorOutrasDespesas,
		this.valorIpi,
		this.valorTotalNf,
		this.quantidadeParcelas,
		this.diaPrimeiroVencimento,
		this.intervaloEntreParcelas,
		this.diaFixoParcela,
		this.compraPedidoDetalheModelList,
		this.compraTipoPedidoModel,
		this.viewPessoaColaboradorModel,
		this.viewPessoaFornecedorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_cotacao',
		'data_pedido',
		'data_prevista_entrega',
		'data_previsao_pagamento',
		'local_entrega',
		'local_cobranca',
		'contato',
		'valor_subtotal',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
		'tipo_frete',
		'forma_pagamento',
		'base_calculo_icms',
		'valor_icms',
		'base_calculo_icms_st',
		'valor_icms_st',
		'valor_total_produtos',
		'valor_frete',
		'valor_seguro',
		'valor_outras_despesas',
		'valor_ipi',
		'valor_total_nf',
		'quantidade_parcelas',
		'dia_primeiro_vencimento',
		'intervalo_entre_parcelas',
		'dia_fixo_parcela',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Cotacao',
		'Data Pedido',
		'Data Prevista Entrega',
		'Data Previsao Pagamento',
		'Local Entrega',
		'Local Cobranca',
		'Contato',
		'Valor Subtotal',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
		'Tipo Frete',
		'Forma Pagamento',
		'Base Calculo Icms',
		'Valor Icms',
		'Base Calculo Icms St',
		'Valor Icms St',
		'Valor Total Produtos',
		'Valor Frete',
		'Valor Seguro',
		'Valor Outras Despesas',
		'Valor Ipi',
		'Valor Total Nf',
		'Quantidade Parcelas',
		'Dia Primeiro Vencimento',
		'Intervalo Entre Parcelas',
		'Dia Fixo Parcela',
	];

	CompraPedidoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraTipoPedido = jsonData['idCompraTipoPedido'];
		idColaborador = jsonData['idColaborador'];
		idFornecedor = jsonData['idFornecedor'];
		codigoCotacao = jsonData['codigoCotacao'];
		dataPedido = jsonData['dataPedido'] != null ? DateTime.tryParse(jsonData['dataPedido']) : null;
		dataPrevistaEntrega = jsonData['dataPrevistaEntrega'] != null ? DateTime.tryParse(jsonData['dataPrevistaEntrega']) : null;
		dataPrevisaoPagamento = jsonData['dataPrevisaoPagamento'] != null ? DateTime.tryParse(jsonData['dataPrevisaoPagamento']) : null;
		localEntrega = jsonData['localEntrega'];
		localCobranca = jsonData['localCobranca'];
		contato = jsonData['contato'];
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		tipoFrete = CompraPedidoDomain.getTipoFrete(jsonData['tipoFrete']);
		formaPagamento = CompraPedidoDomain.getFormaPagamento(jsonData['formaPagamento']);
		baseCalculoIcms = jsonData['baseCalculoIcms']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		baseCalculoIcmsSt = jsonData['baseCalculoIcmsSt']?.toDouble();
		valorIcmsSt = jsonData['valorIcmsSt']?.toDouble();
		valorTotalProdutos = jsonData['valorTotalProdutos']?.toDouble();
		valorFrete = jsonData['valorFrete']?.toDouble();
		valorSeguro = jsonData['valorSeguro']?.toDouble();
		valorOutrasDespesas = jsonData['valorOutrasDespesas']?.toDouble();
		valorIpi = jsonData['valorIpi']?.toDouble();
		valorTotalNf = jsonData['valorTotalNf']?.toDouble();
		quantidadeParcelas = jsonData['quantidadeParcelas'];
		diaPrimeiroVencimento = jsonData['diaPrimeiroVencimento'];
		intervaloEntreParcelas = jsonData['intervaloEntreParcelas'];
		diaFixoParcela = jsonData['diaFixoParcela'];
		compraPedidoDetalheModelList = (jsonData['compraPedidoDetalheModelList'] as Iterable?)?.map((m) => CompraPedidoDetalheModel.fromJson(m)).toList() ?? [];
		compraTipoPedidoModel = jsonData['compraTipoPedidoModel'] == null ? CompraTipoPedidoModel() : CompraTipoPedidoModel.fromJson(jsonData['compraTipoPedidoModel']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraTipoPedido'] = idCompraTipoPedido != 0 ? idCompraTipoPedido : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		jsonData['codigoCotacao'] = codigoCotacao;
		jsonData['dataPedido'] = dataPedido != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPedido!) : null;
		jsonData['dataPrevistaEntrega'] = dataPrevistaEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevistaEntrega!) : null;
		jsonData['dataPrevisaoPagamento'] = dataPrevisaoPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevisaoPagamento!) : null;
		jsonData['localEntrega'] = localEntrega;
		jsonData['localCobranca'] = localCobranca;
		jsonData['contato'] = contato;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['tipoFrete'] = CompraPedidoDomain.setTipoFrete(tipoFrete);
		jsonData['formaPagamento'] = CompraPedidoDomain.setFormaPagamento(formaPagamento);
		jsonData['baseCalculoIcms'] = baseCalculoIcms;
		jsonData['valorIcms'] = valorIcms;
		jsonData['baseCalculoIcmsSt'] = baseCalculoIcmsSt;
		jsonData['valorIcmsSt'] = valorIcmsSt;
		jsonData['valorTotalProdutos'] = valorTotalProdutos;
		jsonData['valorFrete'] = valorFrete;
		jsonData['valorSeguro'] = valorSeguro;
		jsonData['valorOutrasDespesas'] = valorOutrasDespesas;
		jsonData['valorIpi'] = valorIpi;
		jsonData['valorTotalNf'] = valorTotalNf;
		jsonData['quantidadeParcelas'] = quantidadeParcelas;
		jsonData['diaPrimeiroVencimento'] = diaPrimeiroVencimento;
		jsonData['intervaloEntreParcelas'] = intervaloEntreParcelas;
		jsonData['diaFixoParcela'] = diaFixoParcela;
		
		var compraPedidoDetalheModelLocalList = []; 
		for (CompraPedidoDetalheModel object in compraPedidoDetalheModelList ?? []) { 
			compraPedidoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['compraPedidoDetalheModelList'] = compraPedidoDetalheModelLocalList;
		jsonData['compraTipoPedidoModel'] = compraTipoPedidoModel?.toJson;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraTipoPedido = plutoRow.cells['idCompraTipoPedido']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		codigoCotacao = plutoRow.cells['codigoCotacao']?.value;
		dataPedido = Util.stringToDate(plutoRow.cells['dataPedido']?.value);
		dataPrevistaEntrega = Util.stringToDate(plutoRow.cells['dataPrevistaEntrega']?.value);
		dataPrevisaoPagamento = Util.stringToDate(plutoRow.cells['dataPrevisaoPagamento']?.value);
		localEntrega = plutoRow.cells['localEntrega']?.value;
		localCobranca = plutoRow.cells['localCobranca']?.value;
		contato = plutoRow.cells['contato']?.value;
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		tipoFrete = plutoRow.cells['tipoFrete']?.value != '' ? plutoRow.cells['tipoFrete']?.value : 'CIF';
		formaPagamento = plutoRow.cells['formaPagamento']?.value != '' ? plutoRow.cells['formaPagamento']?.value : 'Vista';
		baseCalculoIcms = plutoRow.cells['baseCalculoIcms']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		baseCalculoIcmsSt = plutoRow.cells['baseCalculoIcmsSt']?.value?.toDouble();
		valorIcmsSt = plutoRow.cells['valorIcmsSt']?.value?.toDouble();
		valorTotalProdutos = plutoRow.cells['valorTotalProdutos']?.value?.toDouble();
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		valorSeguro = plutoRow.cells['valorSeguro']?.value?.toDouble();
		valorOutrasDespesas = plutoRow.cells['valorOutrasDespesas']?.value?.toDouble();
		valorIpi = plutoRow.cells['valorIpi']?.value?.toDouble();
		valorTotalNf = plutoRow.cells['valorTotalNf']?.value?.toDouble();
		quantidadeParcelas = plutoRow.cells['quantidadeParcelas']?.value;
		diaPrimeiroVencimento = plutoRow.cells['diaPrimeiroVencimento']?.value;
		intervaloEntreParcelas = plutoRow.cells['intervaloEntreParcelas']?.value;
		diaFixoParcela = plutoRow.cells['diaFixoParcela']?.value;
		compraPedidoDetalheModelList = [];
		compraTipoPedidoModel = CompraTipoPedidoModel();
		compraTipoPedidoModel?.nome = plutoRow.cells['compraTipoPedidoModel']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
	}	

	CompraPedidoModel clone() {
		return CompraPedidoModel(
			id: id,
			idCompraTipoPedido: idCompraTipoPedido,
			idColaborador: idColaborador,
			idFornecedor: idFornecedor,
			codigoCotacao: codigoCotacao,
			dataPedido: dataPedido,
			dataPrevistaEntrega: dataPrevistaEntrega,
			dataPrevisaoPagamento: dataPrevisaoPagamento,
			localEntrega: localEntrega,
			localCobranca: localCobranca,
			contato: contato,
			valorSubtotal: valorSubtotal,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
			tipoFrete: tipoFrete,
			formaPagamento: formaPagamento,
			baseCalculoIcms: baseCalculoIcms,
			valorIcms: valorIcms,
			baseCalculoIcmsSt: baseCalculoIcmsSt,
			valorIcmsSt: valorIcmsSt,
			valorTotalProdutos: valorTotalProdutos,
			valorFrete: valorFrete,
			valorSeguro: valorSeguro,
			valorOutrasDespesas: valorOutrasDespesas,
			valorIpi: valorIpi,
			valorTotalNf: valorTotalNf,
			quantidadeParcelas: quantidadeParcelas,
			diaPrimeiroVencimento: diaPrimeiroVencimento,
			intervaloEntreParcelas: intervaloEntreParcelas,
			diaFixoParcela: diaFixoParcela,
			compraPedidoDetalheModelList: compraPedidoDetalheModelListClone(compraPedidoDetalheModelList!),
		);			
	}

	compraPedidoDetalheModelListClone(List<CompraPedidoDetalheModel> compraPedidoDetalheModelList) { 
		List<CompraPedidoDetalheModel> resultList = [];
		for (var compraPedidoDetalheModel in compraPedidoDetalheModelList) {
			resultList.add(
				CompraPedidoDetalheModel(
					id: compraPedidoDetalheModel.id,
					idCompraPedido: compraPedidoDetalheModel.idCompraPedido,
					idProduto: compraPedidoDetalheModel.idProduto,
					quantidade: compraPedidoDetalheModel.quantidade,
					valorUnitario: compraPedidoDetalheModel.valorUnitario,
					valorSubtotal: compraPedidoDetalheModel.valorSubtotal,
					taxaDesconto: compraPedidoDetalheModel.taxaDesconto,
					valorDesconto: compraPedidoDetalheModel.valorDesconto,
					valorTotal: compraPedidoDetalheModel.valorTotal,
					cst: compraPedidoDetalheModel.cst,
					csosn: compraPedidoDetalheModel.csosn,
					cfop: compraPedidoDetalheModel.cfop,
					baseCalculoIcms: compraPedidoDetalheModel.baseCalculoIcms,
					valorIcms: compraPedidoDetalheModel.valorIcms,
					valorIpi: compraPedidoDetalheModel.valorIpi,
					aliquotaIcms: compraPedidoDetalheModel.aliquotaIcms,
					aliquotaIpi: compraPedidoDetalheModel.aliquotaIpi,
				)
			);
		}
		return resultList;
	}

	
}