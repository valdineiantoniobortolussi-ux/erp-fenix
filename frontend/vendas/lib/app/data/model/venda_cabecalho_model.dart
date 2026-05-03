import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:vendas/app/data/domain/domain_imports.dart';

class VendaCabecalhoModel {
	int? id;
	int? idVendaOrcamentoCabecalho;
	int? idNotaFiscalTipo;
	int? idVendedor;
	int? idVendaCondicoesPagamento;
	int? idTransportadora;
	int? idCliente;
	String? localEntrega;
	String? localCobranca;
	String? tipoFrete;
	String? formaPagamento;
	DateTime? dataVenda;
	DateTime? dataSaida;
	String? horaSaida;
	int? numeroFatura;
	double? valorFrete;
	double? valorSeguro;
	double? valorSubtotal;
	double? taxaComissao;
	double? valorComissao;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	String? situacao;
	String? diaFixoParcela;
	String? observacao;
	VendaComissaoModel? vendaComissaoModel;
	List<VendaDetalheModel>? vendaDetalheModelList;
	List<VendaFreteModel>? vendaFreteModelList;
	VendaCondicoesPagamentoModel? vendaCondicoesPagamentoModel;
	ViewPessoaVendedorModel? viewPessoaVendedorModel;
	ViewPessoaTransportadoraModel? viewPessoaTransportadoraModel;
	ViewPessoaClienteModel? viewPessoaClienteModel;
	VendaOrcamentoCabecalhoModel? vendaOrcamentoCabecalhoModel;
	NotaFiscalTipoModel? notaFiscalTipoModel;

	VendaCabecalhoModel({
		this.id,
		this.idVendaOrcamentoCabecalho,
		this.idNotaFiscalTipo,
		this.idVendedor,
		this.idVendaCondicoesPagamento,
		this.idTransportadora,
		this.idCliente,
		this.localEntrega,
		this.localCobranca,
		this.tipoFrete,
		this.formaPagamento,
		this.dataVenda,
		this.dataSaida,
		this.horaSaida,
		this.numeroFatura,
		this.valorFrete,
		this.valorSeguro,
		this.valorSubtotal,
		this.taxaComissao,
		this.valorComissao,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.situacao,
		this.diaFixoParcela,
		this.observacao,
		this.vendaComissaoModel,
		this.vendaDetalheModelList,
		this.vendaFreteModelList,
		this.vendaCondicoesPagamentoModel,
		this.viewPessoaVendedorModel,
		this.viewPessoaTransportadoraModel,
		this.viewPessoaClienteModel,
		this.vendaOrcamentoCabecalhoModel,
		this.notaFiscalTipoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'local_entrega',
		'local_cobranca',
		'tipo_frete',
		'forma_pagamento',
		'data_venda',
		'data_saida',
		'hora_saida',
		'numero_fatura',
		'valor_frete',
		'valor_seguro',
		'valor_subtotal',
		'taxa_comissao',
		'valor_comissao',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
		'situacao',
		'dia_fixo_parcela',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Local Entrega',
		'Local Cobranca',
		'Tipo Frete',
		'Forma Pagamento',
		'Data Venda',
		'Data Saida',
		'Hora Saida',
		'Numero Fatura',
		'Valor Frete',
		'Valor Seguro',
		'Valor Subtotal',
		'Taxa Comissao',
		'Valor Comissao',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
		'Situacao',
		'Dia Fixo Parcela',
		'Observacao',
	];

	VendaCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaOrcamentoCabecalho = jsonData['idVendaOrcamentoCabecalho'];
		idNotaFiscalTipo = jsonData['idNotaFiscalTipo'];
		idVendedor = jsonData['idVendedor'];
		idVendaCondicoesPagamento = jsonData['idVendaCondicoesPagamento'];
		idTransportadora = jsonData['idTransportadora'];
		idCliente = jsonData['idCliente'];
		localEntrega = jsonData['localEntrega'];
		localCobranca = jsonData['localCobranca'];
		tipoFrete = VendaCabecalhoDomain.getTipoFrete(jsonData['tipoFrete']);
		formaPagamento = VendaCabecalhoDomain.getFormaPagamento(jsonData['formaPagamento']);
		dataVenda = jsonData['dataVenda'] != null ? DateTime.tryParse(jsonData['dataVenda']) : null;
		dataSaida = jsonData['dataSaida'] != null ? DateTime.tryParse(jsonData['dataSaida']) : null;
		horaSaida = jsonData['horaSaida'];
		numeroFatura = jsonData['numeroFatura'];
		valorFrete = jsonData['valorFrete']?.toDouble();
		valorSeguro = jsonData['valorSeguro']?.toDouble();
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaComissao = jsonData['taxaComissao']?.toDouble();
		valorComissao = jsonData['valorComissao']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		situacao = VendaCabecalhoDomain.getSituacao(jsonData['situacao']);
		diaFixoParcela = jsonData['diaFixoParcela'];
		observacao = jsonData['observacao'];
		vendaComissaoModel = jsonData['vendaComissaoModel'] == null ? VendaComissaoModel(viewPessoaVendedorModel: ViewPessoaVendedorModel(), ) : VendaComissaoModel.fromJson(jsonData['vendaComissaoModel']);
		vendaDetalheModelList = (jsonData['vendaDetalheModelList'] as Iterable?)?.map((m) => VendaDetalheModel.fromJson(m)).toList() ?? [];
		vendaFreteModelList = (jsonData['vendaFreteModelList'] as Iterable?)?.map((m) => VendaFreteModel.fromJson(m)).toList() ?? [];
		vendaCondicoesPagamentoModel = jsonData['vendaCondicoesPagamentoModel'] == null ? VendaCondicoesPagamentoModel() : VendaCondicoesPagamentoModel.fromJson(jsonData['vendaCondicoesPagamentoModel']);
		viewPessoaVendedorModel = jsonData['viewPessoaVendedorModel'] == null ? ViewPessoaVendedorModel() : ViewPessoaVendedorModel.fromJson(jsonData['viewPessoaVendedorModel']);
		viewPessoaTransportadoraModel = jsonData['viewPessoaTransportadoraModel'] == null ? ViewPessoaTransportadoraModel() : ViewPessoaTransportadoraModel.fromJson(jsonData['viewPessoaTransportadoraModel']);
		viewPessoaClienteModel = jsonData['viewPessoaClienteModel'] == null ? ViewPessoaClienteModel() : ViewPessoaClienteModel.fromJson(jsonData['viewPessoaClienteModel']);
		vendaOrcamentoCabecalhoModel = jsonData['vendaOrcamentoCabecalhoModel'] == null ? VendaOrcamentoCabecalhoModel() : VendaOrcamentoCabecalhoModel.fromJson(jsonData['vendaOrcamentoCabecalhoModel']);
		notaFiscalTipoModel = jsonData['notaFiscalTipoModel'] == null ? NotaFiscalTipoModel() : NotaFiscalTipoModel.fromJson(jsonData['notaFiscalTipoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaOrcamentoCabecalho'] = idVendaOrcamentoCabecalho != 0 ? idVendaOrcamentoCabecalho : null;
		jsonData['idNotaFiscalTipo'] = idNotaFiscalTipo != 0 ? idNotaFiscalTipo : null;
		jsonData['idVendedor'] = idVendedor != 0 ? idVendedor : null;
		jsonData['idVendaCondicoesPagamento'] = idVendaCondicoesPagamento != 0 ? idVendaCondicoesPagamento : null;
		jsonData['idTransportadora'] = idTransportadora != 0 ? idTransportadora : null;
		jsonData['idCliente'] = idCliente != 0 ? idCliente : null;
		jsonData['localEntrega'] = localEntrega;
		jsonData['localCobranca'] = localCobranca;
		jsonData['tipoFrete'] = VendaCabecalhoDomain.setTipoFrete(tipoFrete);
		jsonData['formaPagamento'] = VendaCabecalhoDomain.setFormaPagamento(formaPagamento);
		jsonData['dataVenda'] = dataVenda != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVenda!) : null;
		jsonData['dataSaida'] = dataSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSaida!) : null;
		jsonData['horaSaida'] = Util.removeMask(horaSaida);
		jsonData['numeroFatura'] = numeroFatura;
		jsonData['valorFrete'] = valorFrete;
		jsonData['valorSeguro'] = valorSeguro;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaComissao'] = taxaComissao;
		jsonData['valorComissao'] = valorComissao;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['situacao'] = VendaCabecalhoDomain.setSituacao(situacao);
		jsonData['diaFixoParcela'] = diaFixoParcela;
		jsonData['observacao'] = observacao;
		jsonData['vendaComissaoModel'] = vendaComissaoModel?.toJson;
		
		var vendaDetalheModelLocalList = []; 
		for (VendaDetalheModel object in vendaDetalheModelList ?? []) { 
			vendaDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['vendaDetalheModelList'] = vendaDetalheModelLocalList;
		
		var vendaFreteModelLocalList = []; 
		for (VendaFreteModel object in vendaFreteModelList ?? []) { 
			vendaFreteModelLocalList.add(object.toJson); 
		}
		jsonData['vendaFreteModelList'] = vendaFreteModelLocalList;
		jsonData['vendaCondicoesPagamentoModel'] = vendaCondicoesPagamentoModel?.toJson;
		jsonData['viewPessoaVendedorModel'] = viewPessoaVendedorModel?.toJson;
		jsonData['viewPessoaTransportadoraModel'] = viewPessoaTransportadoraModel?.toJson;
		jsonData['viewPessoaClienteModel'] = viewPessoaClienteModel?.toJson;
		jsonData['vendaOrcamentoCabecalhoModel'] = vendaOrcamentoCabecalhoModel?.toJson;
		jsonData['notaFiscalTipoModel'] = notaFiscalTipoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaOrcamentoCabecalho = plutoRow.cells['idVendaOrcamentoCabecalho']?.value;
		idNotaFiscalTipo = plutoRow.cells['idNotaFiscalTipo']?.value;
		idVendedor = plutoRow.cells['idVendedor']?.value;
		idVendaCondicoesPagamento = plutoRow.cells['idVendaCondicoesPagamento']?.value;
		idTransportadora = plutoRow.cells['idTransportadora']?.value;
		idCliente = plutoRow.cells['idCliente']?.value;
		localEntrega = plutoRow.cells['localEntrega']?.value;
		localCobranca = plutoRow.cells['localCobranca']?.value;
		tipoFrete = plutoRow.cells['tipoFrete']?.value != '' ? plutoRow.cells['tipoFrete']?.value : 'CIF';
		formaPagamento = plutoRow.cells['formaPagamento']?.value != '' ? plutoRow.cells['formaPagamento']?.value : 'A Vista';
		dataVenda = Util.stringToDate(plutoRow.cells['dataVenda']?.value);
		dataSaida = Util.stringToDate(plutoRow.cells['dataSaida']?.value);
		horaSaida = plutoRow.cells['horaSaida']?.value;
		numeroFatura = plutoRow.cells['numeroFatura']?.value;
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		valorSeguro = plutoRow.cells['valorSeguro']?.value?.toDouble();
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaComissao = plutoRow.cells['taxaComissao']?.value?.toDouble();
		valorComissao = plutoRow.cells['valorComissao']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : 'Digitação';
		diaFixoParcela = plutoRow.cells['diaFixoParcela']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		vendaComissaoModel = VendaComissaoModel(viewPessoaVendedorModel: ViewPessoaVendedorModel(), );
		vendaDetalheModelList = [];
		vendaFreteModelList = [];
		vendaCondicoesPagamentoModel = VendaCondicoesPagamentoModel();
		vendaCondicoesPagamentoModel?.nome = plutoRow.cells['vendaCondicoesPagamentoModel']?.value;
		viewPessoaVendedorModel = ViewPessoaVendedorModel();
		viewPessoaVendedorModel?.nome = plutoRow.cells['viewPessoaVendedorModel']?.value;
		viewPessoaTransportadoraModel = ViewPessoaTransportadoraModel();
		viewPessoaTransportadoraModel?.nome = plutoRow.cells['viewPessoaTransportadoraModel']?.value;
		viewPessoaClienteModel = ViewPessoaClienteModel();
		viewPessoaClienteModel?.nome = plutoRow.cells['viewPessoaClienteModel']?.value;
		vendaOrcamentoCabecalhoModel = VendaOrcamentoCabecalhoModel();
		vendaOrcamentoCabecalhoModel?.codigo = plutoRow.cells['vendaOrcamentoCabecalhoModel']?.value;
		notaFiscalTipoModel = NotaFiscalTipoModel();
		notaFiscalTipoModel?.nome = plutoRow.cells['notaFiscalTipoModel']?.value;
	}	

	VendaCabecalhoModel clone() {
		return VendaCabecalhoModel(
			id: id,
			idVendaOrcamentoCabecalho: idVendaOrcamentoCabecalho,
			idNotaFiscalTipo: idNotaFiscalTipo,
			idVendedor: idVendedor,
			idVendaCondicoesPagamento: idVendaCondicoesPagamento,
			idTransportadora: idTransportadora,
			idCliente: idCliente,
			localEntrega: localEntrega,
			localCobranca: localCobranca,
			tipoFrete: tipoFrete,
			formaPagamento: formaPagamento,
			dataVenda: dataVenda,
			dataSaida: dataSaida,
			horaSaida: horaSaida,
			numeroFatura: numeroFatura,
			valorFrete: valorFrete,
			valorSeguro: valorSeguro,
			valorSubtotal: valorSubtotal,
			taxaComissao: taxaComissao,
			valorComissao: valorComissao,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
			situacao: situacao,
			diaFixoParcela: diaFixoParcela,
			observacao: observacao,
			vendaComissaoModel: VendaComissaoModel(
				id: vendaComissaoModel?.id,
				idVendaCabecalho: vendaComissaoModel?.idVendaCabecalho,
				idVendedor: vendaComissaoModel?.idVendedor,
				valorVenda: vendaComissaoModel?.valorVenda,
				tipoContabil: vendaComissaoModel?.tipoContabil,
				valorComissao: vendaComissaoModel?.valorComissao,
				situacao: vendaComissaoModel?.situacao,
				dataLancamento: vendaComissaoModel?.dataLancamento,
				viewPessoaVendedorModel: ViewPessoaVendedorModel(
					id: vendaComissaoModel?.viewPessoaVendedorModel?.id,
					nome: vendaComissaoModel?.viewPessoaVendedorModel?.nome,
					tipo: vendaComissaoModel?.viewPessoaVendedorModel?.tipo,
					email: vendaComissaoModel?.viewPessoaVendedorModel?.email,
					site: vendaComissaoModel?.viewPessoaVendedorModel?.site,
					cpfCnpj: vendaComissaoModel?.viewPessoaVendedorModel?.cpfCnpj,
					rgIe: vendaComissaoModel?.viewPessoaVendedorModel?.rgIe,
					matricula: vendaComissaoModel?.viewPessoaVendedorModel?.matricula,
					dataCadastro: vendaComissaoModel?.viewPessoaVendedorModel?.dataCadastro,
					dataAdmissao: vendaComissaoModel?.viewPessoaVendedorModel?.dataAdmissao,
					dataDemissao: vendaComissaoModel?.viewPessoaVendedorModel?.dataDemissao,
					ctpsNumero: vendaComissaoModel?.viewPessoaVendedorModel?.ctpsNumero,
					ctpsSerie: vendaComissaoModel?.viewPessoaVendedorModel?.ctpsSerie,
					ctpsDataExpedicao: vendaComissaoModel?.viewPessoaVendedorModel?.ctpsDataExpedicao,
					ctpsUf: vendaComissaoModel?.viewPessoaVendedorModel?.ctpsUf,
					observacao: vendaComissaoModel?.viewPessoaVendedorModel?.observacao,
					logradouro: vendaComissaoModel?.viewPessoaVendedorModel?.logradouro,
					numero: vendaComissaoModel?.viewPessoaVendedorModel?.numero,
					complemento: vendaComissaoModel?.viewPessoaVendedorModel?.complemento,
					bairro: vendaComissaoModel?.viewPessoaVendedorModel?.bairro,
					cidade: vendaComissaoModel?.viewPessoaVendedorModel?.cidade,
					cep: vendaComissaoModel?.viewPessoaVendedorModel?.cep,
					municipioIbge: vendaComissaoModel?.viewPessoaVendedorModel?.municipioIbge,
					uf: vendaComissaoModel?.viewPessoaVendedorModel?.uf,
					idPessoa: vendaComissaoModel?.viewPessoaVendedorModel?.idPessoa,
					idCargo: vendaComissaoModel?.viewPessoaVendedorModel?.idCargo,
					idSetor: vendaComissaoModel?.viewPessoaVendedorModel?.idSetor,
					comissao: vendaComissaoModel?.viewPessoaVendedorModel?.comissao,
					metaVenda: vendaComissaoModel?.viewPessoaVendedorModel?.metaVenda,
				),
			),
			vendaDetalheModelList: vendaDetalheModelListClone(vendaDetalheModelList!),
			vendaFreteModelList: vendaFreteModelListClone(vendaFreteModelList!),
		);			
	}

	vendaDetalheModelListClone(List<VendaDetalheModel> vendaDetalheModelList) { 
		List<VendaDetalheModel> resultList = [];
		for (var vendaDetalheModel in vendaDetalheModelList) {
			resultList.add(
				VendaDetalheModel(
					id: vendaDetalheModel.id,
					idVendaCabecalho: vendaDetalheModel.idVendaCabecalho,
					idProduto: vendaDetalheModel.idProduto,
					quantidade: vendaDetalheModel.quantidade,
					valorUnitario: vendaDetalheModel.valorUnitario,
					valorSubtotal: vendaDetalheModel.valorSubtotal,
					taxaDesconto: vendaDetalheModel.taxaDesconto,
					valorDesconto: vendaDetalheModel.valorDesconto,
					valorTotal: vendaDetalheModel.valorTotal,
				)
			);
		}
		return resultList;
	}

	vendaFreteModelListClone(List<VendaFreteModel> vendaFreteModelList) { 
		List<VendaFreteModel> resultList = [];
		for (var vendaFreteModel in vendaFreteModelList) {
			resultList.add(
				VendaFreteModel(
					id: vendaFreteModel.id,
					idVendaCabecalho: vendaFreteModel.idVendaCabecalho,
					idTransportadora: vendaFreteModel.idTransportadora,
					responsavel: vendaFreteModel.responsavel,
					conhecimento: vendaFreteModel.conhecimento,
					placa: vendaFreteModel.placa,
					ufPlaca: vendaFreteModel.ufPlaca,
					seloFiscal: vendaFreteModel.seloFiscal,
					quantidadeVolume: vendaFreteModel.quantidadeVolume,
					marcaVolume: vendaFreteModel.marcaVolume,
					especieVolume: vendaFreteModel.especieVolume,
					pesoBruto: vendaFreteModel.pesoBruto,
					pesoLiquido: vendaFreteModel.pesoLiquido,
				)
			);
		}
		return resultList;
	}

	
}