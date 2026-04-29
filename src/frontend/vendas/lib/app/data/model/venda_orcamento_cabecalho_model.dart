import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaOrcamentoCabecalhoModel {
	int? id;
	int? idVendedor;
	int? idCliente;
	int? idVendaCondicoesPagamento;
	int? idTransportadora;
	String? tipoFrete;
	String? codigo;
	DateTime? dataCadastro;
	DateTime? dataEntrega;
	DateTime? dataValidade;
	double? valorSubtotal;
	double? valorFrete;
	double? taxaComissao;
	double? valorComissao;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	String? observacao;
	List<VendaOrcamentoDetalheModel>? vendaOrcamentoDetalheModelList;
	VendaCondicoesPagamentoModel? vendaCondicoesPagamentoModel;
	ViewPessoaVendedorModel? viewPessoaVendedorModel;
	ViewPessoaTransportadoraModel? viewPessoaTransportadoraModel;
	ViewPessoaClienteModel? viewPessoaClienteModel;

	VendaOrcamentoCabecalhoModel({
		this.id,
		this.idVendedor,
		this.idCliente,
		this.idVendaCondicoesPagamento,
		this.idTransportadora,
		this.tipoFrete,
		this.codigo,
		this.dataCadastro,
		this.dataEntrega,
		this.dataValidade,
		this.valorSubtotal,
		this.valorFrete,
		this.taxaComissao,
		this.valorComissao,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.observacao,
		this.vendaOrcamentoDetalheModelList,
		this.vendaCondicoesPagamentoModel,
		this.viewPessoaVendedorModel,
		this.viewPessoaTransportadoraModel,
		this.viewPessoaClienteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_frete',
		'codigo',
		'data_cadastro',
		'data_entrega',
		'data_validade',
		'valor_subtotal',
		'valor_frete',
		'taxa_comissao',
		'valor_comissao',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Frete',
		'Codigo',
		'Data Cadastro',
		'Data Entrega',
		'Data Validade',
		'Valor Subtotal',
		'Valor Frete',
		'Taxa Comissao',
		'Valor Comissao',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
		'Observacao',
	];

	VendaOrcamentoCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendedor = jsonData['idVendedor'];
		idCliente = jsonData['idCliente'];
		idVendaCondicoesPagamento = jsonData['idVendaCondicoesPagamento'];
		idTransportadora = jsonData['idTransportadora'];
		tipoFrete = VendaOrcamentoCabecalhoDomain.getTipoFrete(jsonData['tipoFrete']);
		codigo = jsonData['codigo'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataEntrega = jsonData['dataEntrega'] != null ? DateTime.tryParse(jsonData['dataEntrega']) : null;
		dataValidade = jsonData['dataValidade'] != null ? DateTime.tryParse(jsonData['dataValidade']) : null;
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		valorFrete = jsonData['valorFrete']?.toDouble();
		taxaComissao = jsonData['taxaComissao']?.toDouble();
		valorComissao = jsonData['valorComissao']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		observacao = jsonData['observacao'];
		vendaOrcamentoDetalheModelList = (jsonData['vendaOrcamentoDetalheModelList'] as Iterable?)?.map((m) => VendaOrcamentoDetalheModel.fromJson(m)).toList() ?? [];
		vendaCondicoesPagamentoModel = jsonData['vendaCondicoesPagamentoModel'] == null ? VendaCondicoesPagamentoModel() : VendaCondicoesPagamentoModel.fromJson(jsonData['vendaCondicoesPagamentoModel']);
		viewPessoaVendedorModel = jsonData['viewPessoaVendedorModel'] == null ? ViewPessoaVendedorModel() : ViewPessoaVendedorModel.fromJson(jsonData['viewPessoaVendedorModel']);
		viewPessoaTransportadoraModel = jsonData['viewPessoaTransportadoraModel'] == null ? ViewPessoaTransportadoraModel() : ViewPessoaTransportadoraModel.fromJson(jsonData['viewPessoaTransportadoraModel']);
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendedor'] = idVendedor != 0 ? idVendedor : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['idVendaCondicoesPagamento'] = idVendaCondicoesPagamento != 0 ? idVendaCondicoesPagamento : null;
		jsonData['idTransportadora'] = idTransportadora != 0 ? idTransportadora : null;
		jsonData['tipoFrete'] = VendaOrcamentoCabecalhoDomain.setTipoFrete(tipoFrete);
		jsonData['codigo'] = codigo;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataEntrega'] = dataEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEntrega!) : null;
		jsonData['dataValidade'] = dataValidade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataValidade!) : null;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['valorFrete'] = valorFrete;
		jsonData['taxaComissao'] = taxaComissao;
		jsonData['valorComissao'] = valorComissao;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['observacao'] = observacao;
		
		var vendaOrcamentoDetalheModelLocalList = []; 
		for (VendaOrcamentoDetalheModel object in vendaOrcamentoDetalheModelList ?? []) { 
			vendaOrcamentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['vendaOrcamentoDetalheModelList'] = vendaOrcamentoDetalheModelLocalList;
		jsonData['vendaCondicoesPagamentoModel'] = vendaCondicoesPagamentoModel?.toJson;
		jsonData['viewPessoaVendedorModel'] = viewPessoaVendedorModel?.toJson;
		jsonData['viewPessoaTransportadoraModel'] = viewPessoaTransportadoraModel?.toJson;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendedor = plutoRow.cells['idVendedor']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		idVendaCondicoesPagamento = plutoRow.cells['idVendaCondicoesPagamento']?.value;
		idTransportadora = plutoRow.cells['idTransportadora']?.value;
		tipoFrete = plutoRow.cells['tipoFrete']?.value != '' ? plutoRow.cells['tipoFrete']?.value : 'CIF';
		codigo = plutoRow.cells['codigo']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataEntrega = Util.stringToDate(plutoRow.cells['dataEntrega']?.value);
		dataValidade = Util.stringToDate(plutoRow.cells['dataValidade']?.value);
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		taxaComissao = plutoRow.cells['taxaComissao']?.value?.toDouble();
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
		vendaOrcamentoDetalheModelList = [];
		vendaCondicoesPagamentoModel = VendaCondicoesPagamentoModel();
		vendaCondicoesPagamentoModel?.nome = plutoRow.cells['vendaCondicoesPagamentoModel']?.value;
		viewPessoaVendedorModel = ViewPessoaVendedorModel();
		viewPessoaVendedorModel?.nome = plutoRow.cells['viewPessoaVendedorModel']?.value;
		viewPessoaTransportadoraModel = ViewPessoaTransportadoraModel();
		viewPessoaTransportadoraModel?.nome = plutoRow.cells['viewPessoaTransportadoraModel']?.value;
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
	}	

	VendaOrcamentoCabecalhoModel clone() {
		return VendaOrcamentoCabecalhoModel(
			id: id,
			idVendedor: idVendedor,
			idCliente: idCliente,
			idVendaCondicoesPagamento: idVendaCondicoesPagamento,
			idTransportadora: idTransportadora,
			tipoFrete: tipoFrete,
			codigo: codigo,
			dataCadastro: dataCadastro,
			dataEntrega: dataEntrega,
			dataValidade: dataValidade,
			valorSubtotal: valorSubtotal,
			valorFrete: valorFrete,
			taxaComissao: taxaComissao,
			valorComissao: valorComissao,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
			observacao: observacao,
			vendaOrcamentoDetalheModelList: vendaOrcamentoDetalheModelListClone(vendaOrcamentoDetalheModelList!),
		);			
	}

	vendaOrcamentoDetalheModelListClone(List<VendaOrcamentoDetalheModel> vendaOrcamentoDetalheModelList) { 
		List<VendaOrcamentoDetalheModel> resultList = [];
		for (var vendaOrcamentoDetalheModel in vendaOrcamentoDetalheModelList) {
			resultList.add(
				VendaOrcamentoDetalheModel(
					id: vendaOrcamentoDetalheModel.id,
					idVendaOrcamentoCabecalho: vendaOrcamentoDetalheModel.idVendaOrcamentoCabecalho,
					idProduto: vendaOrcamentoDetalheModel.idProduto,
					quantidade: vendaOrcamentoDetalheModel.quantidade,
					valorUnitario: vendaOrcamentoDetalheModel.valorUnitario,
					valorSubtotal: vendaOrcamentoDetalheModel.valorSubtotal,
					taxaDesconto: vendaOrcamentoDetalheModel.taxaDesconto,
					valorDesconto: vendaOrcamentoDetalheModel.valorDesconto,
					valorTotal: vendaOrcamentoDetalheModel.valorTotal,
				)
			);
		}
		return resultList;
	}

	
}