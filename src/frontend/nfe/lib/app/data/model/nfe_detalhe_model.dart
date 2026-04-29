import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheModel {
	int? id;
	int? idNfeCabecalho;
	int? idProduto;
	int? numeroItem;
	String? codigoProduto;
	String? gtin;
	String? nomeProduto;
	String? ncm;
	String? nve;
	String? cest;
	String? indicadorEscalaRelevante;
	String? cnpjFabricante;
	String? codigoBeneficioFiscal;
	int? exTipi;
	int? cfop;
	String? unidadeComercial;
	double? quantidadeComercial;
	String? numeroPedidoCompra;
	int? itemPedidoCompra;
	String? numeroFci;
	String? numeroRecopi;
	double? valorUnitarioComercial;
	double? valorBrutoProduto;
	String? gtinUnidadeTributavel;
	String? unidadeTributavel;
	double? quantidadeTributavel;
	double? valorUnitarioTributavel;
	double? valorFrete;
	double? valorSeguro;
	double? valorDesconto;
	double? valorOutrasDespesas;
	String? entraTotal;
	double? valorTotalTributos;
	double? percentualDevolvido;
	double? valorIpiDevolvido;
	String? informacoesAdicionais;
	double? valorSubtotal;
	double? valorTotal;
	List<NfeDetEspecificoVeiculoModel>? nfeDetEspecificoVeiculoModelList;
	List<NfeDetEspecificoMedicamentoModel>? nfeDetEspecificoMedicamentoModelList;
	List<NfeDetEspecificoArmamentoModel>? nfeDetEspecificoArmamentoModelList;
	List<NfeDetEspecificoCombustivelModel>? nfeDetEspecificoCombustivelModelList;
	List<NfeDeclaracaoImportacaoModel>? nfeDeclaracaoImportacaoModelList;
	List<NfeDetalheImpostoIcmsModel>? nfeDetalheImpostoIcmsModelList;
	List<NfeDetalheImpostoIpiModel>? nfeDetalheImpostoIpiModelList;
	List<NfeDetalheImpostoIiModel>? nfeDetalheImpostoIiModelList;
	List<NfeDetalheImpostoPisModel>? nfeDetalheImpostoPisModelList;
	List<NfeDetalheImpostoCofinsModel>? nfeDetalheImpostoCofinsModelList;
	List<NfeDetalheImpostoIssqnModel>? nfeDetalheImpostoIssqnModelList;
	List<NfeExportacaoModel>? nfeExportacaoModelList;
	List<NfeItemRastreadoModel>? nfeItemRastreadoModelList;
	List<NfeDetalheImpostoPisStModel>? nfeDetalheImpostoPisStModelList;
	List<NfeDetalheImpostoIcmsUfdestModel>? nfeDetalheImpostoIcmsUfdestModelList;
	List<NfeDetalheImpostoCofinsStModel>? nfeDetalheImpostoCofinsStModelList;
	NfeCabecalhoModel? nfeCabecalhoModel;
	ProdutoModel? produtoModel;

	NfeDetalheModel({
		this.id,
		this.idNfeCabecalho,
		this.idProduto,
		this.numeroItem,
		this.codigoProduto,
		this.gtin,
		this.nomeProduto,
		this.ncm,
		this.nve,
		this.cest,
		this.indicadorEscalaRelevante,
		this.cnpjFabricante,
		this.codigoBeneficioFiscal,
		this.exTipi,
		this.cfop,
		this.unidadeComercial,
		this.quantidadeComercial,
		this.numeroPedidoCompra,
		this.itemPedidoCompra,
		this.numeroFci,
		this.numeroRecopi,
		this.valorUnitarioComercial,
		this.valorBrutoProduto,
		this.gtinUnidadeTributavel,
		this.unidadeTributavel,
		this.quantidadeTributavel,
		this.valorUnitarioTributavel,
		this.valorFrete,
		this.valorSeguro,
		this.valorDesconto,
		this.valorOutrasDespesas,
		this.entraTotal,
		this.valorTotalTributos,
		this.percentualDevolvido,
		this.valorIpiDevolvido,
		this.informacoesAdicionais,
		this.valorSubtotal,
		this.valorTotal,
		this.nfeDetEspecificoVeiculoModelList,
		this.nfeDetEspecificoMedicamentoModelList,
		this.nfeDetEspecificoArmamentoModelList,
		this.nfeDetEspecificoCombustivelModelList,
		this.nfeDeclaracaoImportacaoModelList,
		this.nfeDetalheImpostoIcmsModelList,
		this.nfeDetalheImpostoIpiModelList,
		this.nfeDetalheImpostoIiModelList,
		this.nfeDetalheImpostoPisModelList,
		this.nfeDetalheImpostoCofinsModelList,
		this.nfeDetalheImpostoIssqnModelList,
		this.nfeExportacaoModelList,
		this.nfeItemRastreadoModelList,
		this.nfeDetalheImpostoPisStModelList,
		this.nfeDetalheImpostoIcmsUfdestModelList,
		this.nfeDetalheImpostoCofinsStModelList,
		this.nfeCabecalhoModel,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_item',
		'codigo_produto',
		'gtin',
		'nome_produto',
		'ncm',
		'nve',
		'cest',
		'indicador_escala_relevante',
		'cnpj_fabricante',
		'codigo_beneficio_fiscal',
		'ex_tipi',
		'cfop',
		'unidade_comercial',
		'quantidade_comercial',
		'numero_pedido_compra',
		'item_pedido_compra',
		'numero_fci',
		'numero_recopi',
		'valor_unitario_comercial',
		'valor_bruto_produto',
		'gtin_unidade_tributavel',
		'unidade_tributavel',
		'quantidade_tributavel',
		'valor_unitario_tributavel',
		'valor_frete',
		'valor_seguro',
		'valor_desconto',
		'valor_outras_despesas',
		'entra_total',
		'valor_total_tributos',
		'percentual_devolvido',
		'valor_ipi_devolvido',
		'informacoes_adicionais',
		'valor_subtotal',
		'valor_total',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Item',
		'Codigo Produto',
		'Gtin',
		'Nome Produto',
		'Ncm',
		'Nve',
		'Cest',
		'Indicador Escala Relevante',
		'Cnpj Fabricante',
		'Codigo Beneficio Fiscal',
		'Ex Tipi',
		'Cfop',
		'Unidade Comercial',
		'Quantidade Comercial',
		'Numero Pedido Compra',
		'Item Pedido Compra',
		'Numero Fci',
		'Numero Recopi',
		'Valor Unitario Comercial',
		'Valor Bruto Produto',
		'Gtin Unidade Tributavel',
		'Unidade Tributavel',
		'Quantidade Tributavel',
		'Valor Unitario Tributavel',
		'Valor Frete',
		'Valor Seguro',
		'Valor Desconto',
		'Valor Outras Despesas',
		'Entra Total',
		'Valor Total Tributos',
		'Percentual Devolvido',
		'Valor Ipi Devolvido',
		'Informacoes Adicionais',
		'Valor Subtotal',
		'Valor Total',
	];

	NfeDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		idProduto = jsonData['idProduto'];
		numeroItem = jsonData['numeroItem'];
		codigoProduto = jsonData['codigoProduto'];
		gtin = jsonData['gtin'];
		nomeProduto = jsonData['nomeProduto'];
		ncm = jsonData['ncm'];
		nve = jsonData['nve'];
		cest = jsonData['cest'];
		indicadorEscalaRelevante = NfeDetalheDomain.getIndicadorEscalaRelevante(jsonData['indicadorEscalaRelevante']);
		cnpjFabricante = jsonData['cnpjFabricante'];
		codigoBeneficioFiscal = jsonData['codigoBeneficioFiscal'];
		exTipi = jsonData['exTipi'];
		cfop = jsonData['cfop'];
		unidadeComercial = jsonData['unidadeComercial'];
		quantidadeComercial = jsonData['quantidadeComercial']?.toDouble();
		numeroPedidoCompra = jsonData['numeroPedidoCompra'];
		itemPedidoCompra = jsonData['itemPedidoCompra'];
		numeroFci = jsonData['numeroFci'];
		numeroRecopi = jsonData['numeroRecopi'];
		valorUnitarioComercial = jsonData['valorUnitarioComercial']?.toDouble();
		valorBrutoProduto = jsonData['valorBrutoProduto']?.toDouble();
		gtinUnidadeTributavel = jsonData['gtinUnidadeTributavel'];
		unidadeTributavel = jsonData['unidadeTributavel'];
		quantidadeTributavel = jsonData['quantidadeTributavel']?.toDouble();
		valorUnitarioTributavel = jsonData['valorUnitarioTributavel']?.toDouble();
		valorFrete = jsonData['valorFrete']?.toDouble();
		valorSeguro = jsonData['valorSeguro']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorOutrasDespesas = jsonData['valorOutrasDespesas']?.toDouble();
		entraTotal = NfeDetalheDomain.getEntraTotal(jsonData['entraTotal']);
		valorTotalTributos = jsonData['valorTotalTributos']?.toDouble();
		percentualDevolvido = jsonData['percentualDevolvido']?.toDouble();
		valorIpiDevolvido = jsonData['valorIpiDevolvido']?.toDouble();
		informacoesAdicionais = jsonData['informacoesAdicionais'];
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		nfeDetEspecificoVeiculoModelList = (jsonData['nfeDetEspecificoVeiculoModelList'] as Iterable?)?.map((m) => NfeDetEspecificoVeiculoModel.fromJson(m)).toList() ?? [];
		nfeDetEspecificoMedicamentoModelList = (jsonData['nfeDetEspecificoMedicamentoModelList'] as Iterable?)?.map((m) => NfeDetEspecificoMedicamentoModel.fromJson(m)).toList() ?? [];
		nfeDetEspecificoArmamentoModelList = (jsonData['nfeDetEspecificoArmamentoModelList'] as Iterable?)?.map((m) => NfeDetEspecificoArmamentoModel.fromJson(m)).toList() ?? [];
		nfeDetEspecificoCombustivelModelList = (jsonData['nfeDetEspecificoCombustivelModelList'] as Iterable?)?.map((m) => NfeDetEspecificoCombustivelModel.fromJson(m)).toList() ?? [];
		nfeDeclaracaoImportacaoModelList = (jsonData['nfeDeclaracaoImportacaoModelList'] as Iterable?)?.map((m) => NfeDeclaracaoImportacaoModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoIcmsModelList = (jsonData['nfeDetalheImpostoIcmsModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoIcmsModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoIpiModelList = (jsonData['nfeDetalheImpostoIpiModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoIpiModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoIiModelList = (jsonData['nfeDetalheImpostoIiModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoIiModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoPisModelList = (jsonData['nfeDetalheImpostoPisModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoPisModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoCofinsModelList = (jsonData['nfeDetalheImpostoCofinsModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoCofinsModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoIssqnModelList = (jsonData['nfeDetalheImpostoIssqnModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoIssqnModel.fromJson(m)).toList() ?? [];
		nfeExportacaoModelList = (jsonData['nfeExportacaoModelList'] as Iterable?)?.map((m) => NfeExportacaoModel.fromJson(m)).toList() ?? [];
		nfeItemRastreadoModelList = (jsonData['nfeItemRastreadoModelList'] as Iterable?)?.map((m) => NfeItemRastreadoModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoPisStModelList = (jsonData['nfeDetalheImpostoPisStModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoPisStModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoIcmsUfdestModelList = (jsonData['nfeDetalheImpostoIcmsUfdestModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoIcmsUfdestModel.fromJson(m)).toList() ?? [];
		nfeDetalheImpostoCofinsStModelList = (jsonData['nfeDetalheImpostoCofinsStModelList'] as Iterable?)?.map((m) => NfeDetalheImpostoCofinsStModel.fromJson(m)).toList() ?? [];
		nfeCabecalhoModel = jsonData['nfeCabecalhoModel'] == null ? NfeCabecalhoModel() : NfeCabecalhoModel.fromJson(jsonData['nfeCabecalhoModel']);
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['numeroItem'] = numeroItem;
		jsonData['codigoProduto'] = codigoProduto;
		jsonData['gtin'] = gtin;
		jsonData['nomeProduto'] = nomeProduto;
		jsonData['ncm'] = ncm;
		jsonData['nve'] = nve;
		jsonData['cest'] = cest;
		jsonData['indicadorEscalaRelevante'] = NfeDetalheDomain.setIndicadorEscalaRelevante(indicadorEscalaRelevante);
		jsonData['cnpjFabricante'] = Util.removeMask(cnpjFabricante);
		jsonData['codigoBeneficioFiscal'] = codigoBeneficioFiscal;
		jsonData['exTipi'] = exTipi;
		jsonData['cfop'] = cfop;
		jsonData['unidadeComercial'] = unidadeComercial;
		jsonData['quantidadeComercial'] = quantidadeComercial;
		jsonData['numeroPedidoCompra'] = numeroPedidoCompra;
		jsonData['itemPedidoCompra'] = itemPedidoCompra;
		jsonData['numeroFci'] = numeroFci;
		jsonData['numeroRecopi'] = numeroRecopi;
		jsonData['valorUnitarioComercial'] = valorUnitarioComercial;
		jsonData['valorBrutoProduto'] = valorBrutoProduto;
		jsonData['gtinUnidadeTributavel'] = gtinUnidadeTributavel;
		jsonData['unidadeTributavel'] = unidadeTributavel;
		jsonData['quantidadeTributavel'] = quantidadeTributavel;
		jsonData['valorUnitarioTributavel'] = valorUnitarioTributavel;
		jsonData['valorFrete'] = valorFrete;
		jsonData['valorSeguro'] = valorSeguro;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorOutrasDespesas'] = valorOutrasDespesas;
		jsonData['entraTotal'] = NfeDetalheDomain.setEntraTotal(entraTotal);
		jsonData['valorTotalTributos'] = valorTotalTributos;
		jsonData['percentualDevolvido'] = percentualDevolvido;
		jsonData['valorIpiDevolvido'] = valorIpiDevolvido;
		jsonData['informacoesAdicionais'] = informacoesAdicionais;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['valorTotal'] = valorTotal;
		
		var nfeDetEspecificoVeiculoModelLocalList = []; 
		for (NfeDetEspecificoVeiculoModel object in nfeDetEspecificoVeiculoModelList ?? []) { 
			nfeDetEspecificoVeiculoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetEspecificoVeiculoModelList'] = nfeDetEspecificoVeiculoModelLocalList;
		
		var nfeDetEspecificoMedicamentoModelLocalList = []; 
		for (NfeDetEspecificoMedicamentoModel object in nfeDetEspecificoMedicamentoModelList ?? []) { 
			nfeDetEspecificoMedicamentoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetEspecificoMedicamentoModelList'] = nfeDetEspecificoMedicamentoModelLocalList;
		
		var nfeDetEspecificoArmamentoModelLocalList = []; 
		for (NfeDetEspecificoArmamentoModel object in nfeDetEspecificoArmamentoModelList ?? []) { 
			nfeDetEspecificoArmamentoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetEspecificoArmamentoModelList'] = nfeDetEspecificoArmamentoModelLocalList;
		
		var nfeDetEspecificoCombustivelModelLocalList = []; 
		for (NfeDetEspecificoCombustivelModel object in nfeDetEspecificoCombustivelModelList ?? []) { 
			nfeDetEspecificoCombustivelModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetEspecificoCombustivelModelList'] = nfeDetEspecificoCombustivelModelLocalList;
		
		var nfeDeclaracaoImportacaoModelLocalList = []; 
		for (NfeDeclaracaoImportacaoModel object in nfeDeclaracaoImportacaoModelList ?? []) { 
			nfeDeclaracaoImportacaoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDeclaracaoImportacaoModelList'] = nfeDeclaracaoImportacaoModelLocalList;
		
		var nfeDetalheImpostoIcmsModelLocalList = []; 
		for (NfeDetalheImpostoIcmsModel object in nfeDetalheImpostoIcmsModelList ?? []) { 
			nfeDetalheImpostoIcmsModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoIcmsModelList'] = nfeDetalheImpostoIcmsModelLocalList;
		
		var nfeDetalheImpostoIpiModelLocalList = []; 
		for (NfeDetalheImpostoIpiModel object in nfeDetalheImpostoIpiModelList ?? []) { 
			nfeDetalheImpostoIpiModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoIpiModelList'] = nfeDetalheImpostoIpiModelLocalList;
		
		var nfeDetalheImpostoIiModelLocalList = []; 
		for (NfeDetalheImpostoIiModel object in nfeDetalheImpostoIiModelList ?? []) { 
			nfeDetalheImpostoIiModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoIiModelList'] = nfeDetalheImpostoIiModelLocalList;
		
		var nfeDetalheImpostoPisModelLocalList = []; 
		for (NfeDetalheImpostoPisModel object in nfeDetalheImpostoPisModelList ?? []) { 
			nfeDetalheImpostoPisModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoPisModelList'] = nfeDetalheImpostoPisModelLocalList;
		
		var nfeDetalheImpostoCofinsModelLocalList = []; 
		for (NfeDetalheImpostoCofinsModel object in nfeDetalheImpostoCofinsModelList ?? []) { 
			nfeDetalheImpostoCofinsModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoCofinsModelList'] = nfeDetalheImpostoCofinsModelLocalList;
		
		var nfeDetalheImpostoIssqnModelLocalList = []; 
		for (NfeDetalheImpostoIssqnModel object in nfeDetalheImpostoIssqnModelList ?? []) { 
			nfeDetalheImpostoIssqnModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoIssqnModelList'] = nfeDetalheImpostoIssqnModelLocalList;
		
		var nfeExportacaoModelLocalList = []; 
		for (NfeExportacaoModel object in nfeExportacaoModelList ?? []) { 
			nfeExportacaoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeExportacaoModelList'] = nfeExportacaoModelLocalList;
		
		var nfeItemRastreadoModelLocalList = []; 
		for (NfeItemRastreadoModel object in nfeItemRastreadoModelList ?? []) { 
			nfeItemRastreadoModelLocalList.add(object.toJson); 
		}
		jsonData['nfeItemRastreadoModelList'] = nfeItemRastreadoModelLocalList;
		
		var nfeDetalheImpostoPisStModelLocalList = []; 
		for (NfeDetalheImpostoPisStModel object in nfeDetalheImpostoPisStModelList ?? []) { 
			nfeDetalheImpostoPisStModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoPisStModelList'] = nfeDetalheImpostoPisStModelLocalList;
		
		var nfeDetalheImpostoIcmsUfdestModelLocalList = []; 
		for (NfeDetalheImpostoIcmsUfdestModel object in nfeDetalheImpostoIcmsUfdestModelList ?? []) { 
			nfeDetalheImpostoIcmsUfdestModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoIcmsUfdestModelList'] = nfeDetalheImpostoIcmsUfdestModelLocalList;
		
		var nfeDetalheImpostoCofinsStModelLocalList = []; 
		for (NfeDetalheImpostoCofinsStModel object in nfeDetalheImpostoCofinsStModelList ?? []) { 
			nfeDetalheImpostoCofinsStModelLocalList.add(object.toJson); 
		}
		jsonData['nfeDetalheImpostoCofinsStModelList'] = nfeDetalheImpostoCofinsStModelLocalList;
		jsonData['nfeCabecalhoModel'] = nfeCabecalhoModel?.toJson;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		numeroItem = plutoRow.cells['numeroItem']?.value;
		codigoProduto = plutoRow.cells['codigoProduto']?.value;
		gtin = plutoRow.cells['gtin']?.value;
		nomeProduto = plutoRow.cells['nomeProduto']?.value;
		ncm = plutoRow.cells['ncm']?.value;
		nve = plutoRow.cells['nve']?.value;
		cest = plutoRow.cells['cest']?.value;
		indicadorEscalaRelevante = plutoRow.cells['indicadorEscalaRelevante']?.value != '' ? plutoRow.cells['indicadorEscalaRelevante']?.value : 'Sim';
		cnpjFabricante = plutoRow.cells['cnpjFabricante']?.value;
		codigoBeneficioFiscal = plutoRow.cells['codigoBeneficioFiscal']?.value;
		exTipi = plutoRow.cells['exTipi']?.value;
		cfop = plutoRow.cells['cfop']?.value;
		unidadeComercial = plutoRow.cells['unidadeComercial']?.value;
		quantidadeComercial = plutoRow.cells['quantidadeComercial']?.value?.toDouble();
		numeroPedidoCompra = plutoRow.cells['numeroPedidoCompra']?.value;
		itemPedidoCompra = plutoRow.cells['itemPedidoCompra']?.value;
		numeroFci = plutoRow.cells['numeroFci']?.value;
		numeroRecopi = plutoRow.cells['numeroRecopi']?.value;
		valorUnitarioComercial = plutoRow.cells['valorUnitarioComercial']?.value?.toDouble();
		valorBrutoProduto = plutoRow.cells['valorBrutoProduto']?.value?.toDouble();
		gtinUnidadeTributavel = plutoRow.cells['gtinUnidadeTributavel']?.value;
		unidadeTributavel = plutoRow.cells['unidadeTributavel']?.value;
		quantidadeTributavel = plutoRow.cells['quantidadeTributavel']?.value?.toDouble();
		valorUnitarioTributavel = plutoRow.cells['valorUnitarioTributavel']?.value?.toDouble();
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
		valorSeguro = plutoRow.cells['valorSeguro']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorOutrasDespesas = plutoRow.cells['valorOutrasDespesas']?.value?.toDouble();
		entraTotal = plutoRow.cells['entraTotal']?.value != '' ? plutoRow.cells['entraTotal']?.value : '0=Valor do item (vProd) não compõe o valor total da NF-e';
		valorTotalTributos = plutoRow.cells['valorTotalTributos']?.value?.toDouble();
		percentualDevolvido = plutoRow.cells['percentualDevolvido']?.value?.toDouble();
		valorIpiDevolvido = plutoRow.cells['valorIpiDevolvido']?.value?.toDouble();
		informacoesAdicionais = plutoRow.cells['informacoesAdicionais']?.value;
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		nfeDetEspecificoVeiculoModelList = [];
		nfeDetEspecificoMedicamentoModelList = [];
		nfeDetEspecificoArmamentoModelList = [];
		nfeDetEspecificoCombustivelModelList = [];
		nfeDeclaracaoImportacaoModelList = [];
		nfeDetalheImpostoIcmsModelList = [];
		nfeDetalheImpostoIpiModelList = [];
		nfeDetalheImpostoIiModelList = [];
		nfeDetalheImpostoPisModelList = [];
		nfeDetalheImpostoCofinsModelList = [];
		nfeDetalheImpostoIssqnModelList = [];
		nfeExportacaoModelList = [];
		nfeItemRastreadoModelList = [];
		nfeDetalheImpostoPisStModelList = [];
		nfeDetalheImpostoIcmsUfdestModelList = [];
		nfeDetalheImpostoCofinsStModelList = [];
		nfeCabecalhoModel = NfeCabecalhoModel();
		nfeCabecalhoModel?.numero = plutoRow.cells['nfeCabecalhoModel']?.value;
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	NfeDetalheModel clone() {
		return NfeDetalheModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			idProduto: idProduto,
			numeroItem: numeroItem,
			codigoProduto: codigoProduto,
			gtin: gtin,
			nomeProduto: nomeProduto,
			ncm: ncm,
			nve: nve,
			cest: cest,
			indicadorEscalaRelevante: indicadorEscalaRelevante,
			cnpjFabricante: cnpjFabricante,
			codigoBeneficioFiscal: codigoBeneficioFiscal,
			exTipi: exTipi,
			cfop: cfop,
			unidadeComercial: unidadeComercial,
			quantidadeComercial: quantidadeComercial,
			numeroPedidoCompra: numeroPedidoCompra,
			itemPedidoCompra: itemPedidoCompra,
			numeroFci: numeroFci,
			numeroRecopi: numeroRecopi,
			valorUnitarioComercial: valorUnitarioComercial,
			valorBrutoProduto: valorBrutoProduto,
			gtinUnidadeTributavel: gtinUnidadeTributavel,
			unidadeTributavel: unidadeTributavel,
			quantidadeTributavel: quantidadeTributavel,
			valorUnitarioTributavel: valorUnitarioTributavel,
			valorFrete: valorFrete,
			valorSeguro: valorSeguro,
			valorDesconto: valorDesconto,
			valorOutrasDespesas: valorOutrasDespesas,
			entraTotal: entraTotal,
			valorTotalTributos: valorTotalTributos,
			percentualDevolvido: percentualDevolvido,
			valorIpiDevolvido: valorIpiDevolvido,
			informacoesAdicionais: informacoesAdicionais,
			valorSubtotal: valorSubtotal,
			valorTotal: valorTotal,
			nfeDetEspecificoVeiculoModelList: nfeDetEspecificoVeiculoModelListClone(nfeDetEspecificoVeiculoModelList!),
			nfeDetEspecificoMedicamentoModelList: nfeDetEspecificoMedicamentoModelListClone(nfeDetEspecificoMedicamentoModelList!),
			nfeDetEspecificoArmamentoModelList: nfeDetEspecificoArmamentoModelListClone(nfeDetEspecificoArmamentoModelList!),
			nfeDetEspecificoCombustivelModelList: nfeDetEspecificoCombustivelModelListClone(nfeDetEspecificoCombustivelModelList!),
			nfeDeclaracaoImportacaoModelList: nfeDeclaracaoImportacaoModelListClone(nfeDeclaracaoImportacaoModelList!),
			nfeDetalheImpostoIcmsModelList: nfeDetalheImpostoIcmsModelListClone(nfeDetalheImpostoIcmsModelList!),
			nfeDetalheImpostoIpiModelList: nfeDetalheImpostoIpiModelListClone(nfeDetalheImpostoIpiModelList!),
			nfeDetalheImpostoIiModelList: nfeDetalheImpostoIiModelListClone(nfeDetalheImpostoIiModelList!),
			nfeDetalheImpostoPisModelList: nfeDetalheImpostoPisModelListClone(nfeDetalheImpostoPisModelList!),
			nfeDetalheImpostoCofinsModelList: nfeDetalheImpostoCofinsModelListClone(nfeDetalheImpostoCofinsModelList!),
			nfeDetalheImpostoIssqnModelList: nfeDetalheImpostoIssqnModelListClone(nfeDetalheImpostoIssqnModelList!),
			nfeExportacaoModelList: nfeExportacaoModelListClone(nfeExportacaoModelList!),
			nfeItemRastreadoModelList: nfeItemRastreadoModelListClone(nfeItemRastreadoModelList!),
			nfeDetalheImpostoPisStModelList: nfeDetalheImpostoPisStModelListClone(nfeDetalheImpostoPisStModelList!),
			nfeDetalheImpostoIcmsUfdestModelList: nfeDetalheImpostoIcmsUfdestModelListClone(nfeDetalheImpostoIcmsUfdestModelList!),
			nfeDetalheImpostoCofinsStModelList: nfeDetalheImpostoCofinsStModelListClone(nfeDetalheImpostoCofinsStModelList!),
		);			
	}

	nfeDetEspecificoVeiculoModelListClone(List<NfeDetEspecificoVeiculoModel> nfeDetEspecificoVeiculoModelList) { 
		List<NfeDetEspecificoVeiculoModel> resultList = [];
		for (var nfeDetEspecificoVeiculoModel in nfeDetEspecificoVeiculoModelList) {
			resultList.add(
				NfeDetEspecificoVeiculoModel(
					id: nfeDetEspecificoVeiculoModel.id,
					idNfeDetalhe: nfeDetEspecificoVeiculoModel.idNfeDetalhe,
					tipoOperacao: nfeDetEspecificoVeiculoModel.tipoOperacao,
					chassi: nfeDetEspecificoVeiculoModel.chassi,
					cor: nfeDetEspecificoVeiculoModel.cor,
					descricaoCor: nfeDetEspecificoVeiculoModel.descricaoCor,
					potenciaMotor: nfeDetEspecificoVeiculoModel.potenciaMotor,
					cilindradas: nfeDetEspecificoVeiculoModel.cilindradas,
					pesoLiquido: nfeDetEspecificoVeiculoModel.pesoLiquido,
					pesoBruto: nfeDetEspecificoVeiculoModel.pesoBruto,
					numeroSerie: nfeDetEspecificoVeiculoModel.numeroSerie,
					tipoCombustivel: nfeDetEspecificoVeiculoModel.tipoCombustivel,
					numeroMotor: nfeDetEspecificoVeiculoModel.numeroMotor,
					capacidadeMaximaTracao: nfeDetEspecificoVeiculoModel.capacidadeMaximaTracao,
					distanciaEixos: nfeDetEspecificoVeiculoModel.distanciaEixos,
					anoModelo: nfeDetEspecificoVeiculoModel.anoModelo,
					anoFabricacao: nfeDetEspecificoVeiculoModel.anoFabricacao,
					tipoPintura: nfeDetEspecificoVeiculoModel.tipoPintura,
					tipoVeiculo: nfeDetEspecificoVeiculoModel.tipoVeiculo,
					especieVeiculo: nfeDetEspecificoVeiculoModel.especieVeiculo,
					condicaoVin: nfeDetEspecificoVeiculoModel.condicaoVin,
					condicaoVeiculo: nfeDetEspecificoVeiculoModel.condicaoVeiculo,
					codigoMarcaModelo: nfeDetEspecificoVeiculoModel.codigoMarcaModelo,
					codigoCorDenatran: nfeDetEspecificoVeiculoModel.codigoCorDenatran,
					lotacaoMaxima: nfeDetEspecificoVeiculoModel.lotacaoMaxima,
					restricao: nfeDetEspecificoVeiculoModel.restricao,
				)
			);
		}
		return resultList;
	}

	nfeDetEspecificoMedicamentoModelListClone(List<NfeDetEspecificoMedicamentoModel> nfeDetEspecificoMedicamentoModelList) { 
		List<NfeDetEspecificoMedicamentoModel> resultList = [];
		for (var nfeDetEspecificoMedicamentoModel in nfeDetEspecificoMedicamentoModelList) {
			resultList.add(
				NfeDetEspecificoMedicamentoModel(
					id: nfeDetEspecificoMedicamentoModel.id,
					idNfeDetalhe: nfeDetEspecificoMedicamentoModel.idNfeDetalhe,
					codigoAnvisa: nfeDetEspecificoMedicamentoModel.codigoAnvisa,
					motivoIsencao: nfeDetEspecificoMedicamentoModel.motivoIsencao,
					precoMaximoConsumidor: nfeDetEspecificoMedicamentoModel.precoMaximoConsumidor,
				)
			);
		}
		return resultList;
	}

	nfeDetEspecificoArmamentoModelListClone(List<NfeDetEspecificoArmamentoModel> nfeDetEspecificoArmamentoModelList) { 
		List<NfeDetEspecificoArmamentoModel> resultList = [];
		for (var nfeDetEspecificoArmamentoModel in nfeDetEspecificoArmamentoModelList) {
			resultList.add(
				NfeDetEspecificoArmamentoModel(
					id: nfeDetEspecificoArmamentoModel.id,
					idNfeDetalhe: nfeDetEspecificoArmamentoModel.idNfeDetalhe,
					tipoArma: nfeDetEspecificoArmamentoModel.tipoArma,
					numeroSerieArma: nfeDetEspecificoArmamentoModel.numeroSerieArma,
					numeroSerieCano: nfeDetEspecificoArmamentoModel.numeroSerieCano,
					descricao: nfeDetEspecificoArmamentoModel.descricao,
				)
			);
		}
		return resultList;
	}

	nfeDetEspecificoCombustivelModelListClone(List<NfeDetEspecificoCombustivelModel> nfeDetEspecificoCombustivelModelList) { 
		List<NfeDetEspecificoCombustivelModel> resultList = [];
		for (var nfeDetEspecificoCombustivelModel in nfeDetEspecificoCombustivelModelList) {
			resultList.add(
				NfeDetEspecificoCombustivelModel(
					id: nfeDetEspecificoCombustivelModel.id,
					idNfeDetalhe: nfeDetEspecificoCombustivelModel.idNfeDetalhe,
					codigoAnp: nfeDetEspecificoCombustivelModel.codigoAnp,
					descricaoAnp: nfeDetEspecificoCombustivelModel.descricaoAnp,
					percentualGlp: nfeDetEspecificoCombustivelModel.percentualGlp,
					percentualGasNacional: nfeDetEspecificoCombustivelModel.percentualGasNacional,
					percentualGasImportado: nfeDetEspecificoCombustivelModel.percentualGasImportado,
					valorPartida: nfeDetEspecificoCombustivelModel.valorPartida,
					codif: nfeDetEspecificoCombustivelModel.codif,
					quantidadeTempAmbiente: nfeDetEspecificoCombustivelModel.quantidadeTempAmbiente,
					ufConsumo: nfeDetEspecificoCombustivelModel.ufConsumo,
					cideBaseCalculo: nfeDetEspecificoCombustivelModel.cideBaseCalculo,
					cideAliquota: nfeDetEspecificoCombustivelModel.cideAliquota,
					cideValor: nfeDetEspecificoCombustivelModel.cideValor,
					encerranteBico: nfeDetEspecificoCombustivelModel.encerranteBico,
					encerranteBomba: nfeDetEspecificoCombustivelModel.encerranteBomba,
					encerranteTanque: nfeDetEspecificoCombustivelModel.encerranteTanque,
					encerranteValorInicio: nfeDetEspecificoCombustivelModel.encerranteValorInicio,
					encerranteValorFim: nfeDetEspecificoCombustivelModel.encerranteValorFim,
				)
			);
		}
		return resultList;
	}

	nfeDeclaracaoImportacaoModelListClone(List<NfeDeclaracaoImportacaoModel> nfeDeclaracaoImportacaoModelList) { 
		List<NfeDeclaracaoImportacaoModel> resultList = [];
		for (var nfeDeclaracaoImportacaoModel in nfeDeclaracaoImportacaoModelList) {
			resultList.add(
				NfeDeclaracaoImportacaoModel(
					id: nfeDeclaracaoImportacaoModel.id,
					idNfeDetalhe: nfeDeclaracaoImportacaoModel.idNfeDetalhe,
					numeroDocumento: nfeDeclaracaoImportacaoModel.numeroDocumento,
					dataRegistro: nfeDeclaracaoImportacaoModel.dataRegistro,
					localDesembaraco: nfeDeclaracaoImportacaoModel.localDesembaraco,
					ufDesembaraco: nfeDeclaracaoImportacaoModel.ufDesembaraco,
					dataDesembaraco: nfeDeclaracaoImportacaoModel.dataDesembaraco,
					viaTransporte: nfeDeclaracaoImportacaoModel.viaTransporte,
					valorAfrmm: nfeDeclaracaoImportacaoModel.valorAfrmm,
					formaIntermediacao: nfeDeclaracaoImportacaoModel.formaIntermediacao,
					cnpj: nfeDeclaracaoImportacaoModel.cnpj,
					ufTerceiro: nfeDeclaracaoImportacaoModel.ufTerceiro,
					codigoExportador: nfeDeclaracaoImportacaoModel.codigoExportador,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoIcmsModelListClone(List<NfeDetalheImpostoIcmsModel> nfeDetalheImpostoIcmsModelList) { 
		List<NfeDetalheImpostoIcmsModel> resultList = [];
		for (var nfeDetalheImpostoIcmsModel in nfeDetalheImpostoIcmsModelList) {
			resultList.add(
				NfeDetalheImpostoIcmsModel(
					id: nfeDetalheImpostoIcmsModel.id,
					idNfeDetalhe: nfeDetalheImpostoIcmsModel.idNfeDetalhe,
					origemMercadoria: nfeDetalheImpostoIcmsModel.origemMercadoria,
					cstIcms: nfeDetalheImpostoIcmsModel.cstIcms,
					csosn: nfeDetalheImpostoIcmsModel.csosn,
					modalidadeBcIcms: nfeDetalheImpostoIcmsModel.modalidadeBcIcms,
					percentualReducaoBcIcms: nfeDetalheImpostoIcmsModel.percentualReducaoBcIcms,
					valorBcIcms: nfeDetalheImpostoIcmsModel.valorBcIcms,
					aliquotaIcms: nfeDetalheImpostoIcmsModel.aliquotaIcms,
					valorIcmsOperacao: nfeDetalheImpostoIcmsModel.valorIcmsOperacao,
					percentualDiferimento: nfeDetalheImpostoIcmsModel.percentualDiferimento,
					valorIcmsDiferido: nfeDetalheImpostoIcmsModel.valorIcmsDiferido,
					valorIcms: nfeDetalheImpostoIcmsModel.valorIcms,
					baseCalculoFcp: nfeDetalheImpostoIcmsModel.baseCalculoFcp,
					percentualFcp: nfeDetalheImpostoIcmsModel.percentualFcp,
					valorFcp: nfeDetalheImpostoIcmsModel.valorFcp,
					modalidadeBcIcmsSt: nfeDetalheImpostoIcmsModel.modalidadeBcIcmsSt,
					percentualMvaIcmsSt: nfeDetalheImpostoIcmsModel.percentualMvaIcmsSt,
					percentualReducaoBcIcmsSt: nfeDetalheImpostoIcmsModel.percentualReducaoBcIcmsSt,
					valorBaseCalculoIcmsSt: nfeDetalheImpostoIcmsModel.valorBaseCalculoIcmsSt,
					aliquotaIcmsSt: nfeDetalheImpostoIcmsModel.aliquotaIcmsSt,
					valorIcmsSt: nfeDetalheImpostoIcmsModel.valorIcmsSt,
					baseCalculoFcpSt: nfeDetalheImpostoIcmsModel.baseCalculoFcpSt,
					percentualFcpSt: nfeDetalheImpostoIcmsModel.percentualFcpSt,
					valorFcpSt: nfeDetalheImpostoIcmsModel.valorFcpSt,
					ufSt: nfeDetalheImpostoIcmsModel.ufSt,
					percentualBcOperacaoPropria: nfeDetalheImpostoIcmsModel.percentualBcOperacaoPropria,
					valorBcIcmsStRetido: nfeDetalheImpostoIcmsModel.valorBcIcmsStRetido,
					aliquotaSuportadaConsumidor: nfeDetalheImpostoIcmsModel.aliquotaSuportadaConsumidor,
					valorIcmsSubstituto: nfeDetalheImpostoIcmsModel.valorIcmsSubstituto,
					valorIcmsStRetido: nfeDetalheImpostoIcmsModel.valorIcmsStRetido,
					baseCalculoFcpStRetido: nfeDetalheImpostoIcmsModel.baseCalculoFcpStRetido,
					percentualFcpStRetido: nfeDetalheImpostoIcmsModel.percentualFcpStRetido,
					valorFcpStRetido: nfeDetalheImpostoIcmsModel.valorFcpStRetido,
					motivoDesoneracaoIcms: nfeDetalheImpostoIcmsModel.motivoDesoneracaoIcms,
					valorIcmsDesonerado: nfeDetalheImpostoIcmsModel.valorIcmsDesonerado,
					aliquotaCreditoIcmsSn: nfeDetalheImpostoIcmsModel.aliquotaCreditoIcmsSn,
					valorCreditoIcmsSn: nfeDetalheImpostoIcmsModel.valorCreditoIcmsSn,
					valorBcIcmsStDestino: nfeDetalheImpostoIcmsModel.valorBcIcmsStDestino,
					valorIcmsStDestino: nfeDetalheImpostoIcmsModel.valorIcmsStDestino,
					percentualReducaoBcEfetivo: nfeDetalheImpostoIcmsModel.percentualReducaoBcEfetivo,
					valorBcEfetivo: nfeDetalheImpostoIcmsModel.valorBcEfetivo,
					aliquotaIcmsEfetivo: nfeDetalheImpostoIcmsModel.aliquotaIcmsEfetivo,
					valorIcmsEfetivo: nfeDetalheImpostoIcmsModel.valorIcmsEfetivo,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoIpiModelListClone(List<NfeDetalheImpostoIpiModel> nfeDetalheImpostoIpiModelList) { 
		List<NfeDetalheImpostoIpiModel> resultList = [];
		for (var nfeDetalheImpostoIpiModel in nfeDetalheImpostoIpiModelList) {
			resultList.add(
				NfeDetalheImpostoIpiModel(
					id: nfeDetalheImpostoIpiModel.id,
					idNfeDetalhe: nfeDetalheImpostoIpiModel.idNfeDetalhe,
					cnpjProdutor: nfeDetalheImpostoIpiModel.cnpjProdutor,
					codigoSeloIpi: nfeDetalheImpostoIpiModel.codigoSeloIpi,
					quantidadeSeloIpi: nfeDetalheImpostoIpiModel.quantidadeSeloIpi,
					enquadramentoLegalIpi: nfeDetalheImpostoIpiModel.enquadramentoLegalIpi,
					cstIpi: nfeDetalheImpostoIpiModel.cstIpi,
					valorBaseCalculoIpi: nfeDetalheImpostoIpiModel.valorBaseCalculoIpi,
					quantidadeUnidadeTributavel: nfeDetalheImpostoIpiModel.quantidadeUnidadeTributavel,
					valorUnidadeTributavel: nfeDetalheImpostoIpiModel.valorUnidadeTributavel,
					aliquotaIpi: nfeDetalheImpostoIpiModel.aliquotaIpi,
					valorIpi: nfeDetalheImpostoIpiModel.valorIpi,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoIiModelListClone(List<NfeDetalheImpostoIiModel> nfeDetalheImpostoIiModelList) { 
		List<NfeDetalheImpostoIiModel> resultList = [];
		for (var nfeDetalheImpostoIiModel in nfeDetalheImpostoIiModelList) {
			resultList.add(
				NfeDetalheImpostoIiModel(
					id: nfeDetalheImpostoIiModel.id,
					idNfeDetalhe: nfeDetalheImpostoIiModel.idNfeDetalhe,
					valorBcIi: nfeDetalheImpostoIiModel.valorBcIi,
					valorDespesasAduaneiras: nfeDetalheImpostoIiModel.valorDespesasAduaneiras,
					valorImpostoImportacao: nfeDetalheImpostoIiModel.valorImpostoImportacao,
					valorIof: nfeDetalheImpostoIiModel.valorIof,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoPisModelListClone(List<NfeDetalheImpostoPisModel> nfeDetalheImpostoPisModelList) { 
		List<NfeDetalheImpostoPisModel> resultList = [];
		for (var nfeDetalheImpostoPisModel in nfeDetalheImpostoPisModelList) {
			resultList.add(
				NfeDetalheImpostoPisModel(
					id: nfeDetalheImpostoPisModel.id,
					idNfeDetalhe: nfeDetalheImpostoPisModel.idNfeDetalhe,
					cstPis: nfeDetalheImpostoPisModel.cstPis,
					valorBaseCalculoPis: nfeDetalheImpostoPisModel.valorBaseCalculoPis,
					aliquotaPisPercentual: nfeDetalheImpostoPisModel.aliquotaPisPercentual,
					valorPis: nfeDetalheImpostoPisModel.valorPis,
					quantidadeVendida: nfeDetalheImpostoPisModel.quantidadeVendida,
					aliquotaPisReais: nfeDetalheImpostoPisModel.aliquotaPisReais,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoCofinsModelListClone(List<NfeDetalheImpostoCofinsModel> nfeDetalheImpostoCofinsModelList) { 
		List<NfeDetalheImpostoCofinsModel> resultList = [];
		for (var nfeDetalheImpostoCofinsModel in nfeDetalheImpostoCofinsModelList) {
			resultList.add(
				NfeDetalheImpostoCofinsModel(
					id: nfeDetalheImpostoCofinsModel.id,
					idNfeDetalhe: nfeDetalheImpostoCofinsModel.idNfeDetalhe,
					cstCofins: nfeDetalheImpostoCofinsModel.cstCofins,
					baseCalculoCofins: nfeDetalheImpostoCofinsModel.baseCalculoCofins,
					aliquotaCofinsPercentual: nfeDetalheImpostoCofinsModel.aliquotaCofinsPercentual,
					quantidadeVendida: nfeDetalheImpostoCofinsModel.quantidadeVendida,
					aliquotaCofinsReais: nfeDetalheImpostoCofinsModel.aliquotaCofinsReais,
					valorCofins: nfeDetalheImpostoCofinsModel.valorCofins,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoIssqnModelListClone(List<NfeDetalheImpostoIssqnModel> nfeDetalheImpostoIssqnModelList) { 
		List<NfeDetalheImpostoIssqnModel> resultList = [];
		for (var nfeDetalheImpostoIssqnModel in nfeDetalheImpostoIssqnModelList) {
			resultList.add(
				NfeDetalheImpostoIssqnModel(
					id: nfeDetalheImpostoIssqnModel.id,
					idNfeDetalhe: nfeDetalheImpostoIssqnModel.idNfeDetalhe,
					baseCalculoIssqn: nfeDetalheImpostoIssqnModel.baseCalculoIssqn,
					aliquotaIssqn: nfeDetalheImpostoIssqnModel.aliquotaIssqn,
					valorIssqn: nfeDetalheImpostoIssqnModel.valorIssqn,
					municipioIssqn: nfeDetalheImpostoIssqnModel.municipioIssqn,
					itemListaServicos: nfeDetalheImpostoIssqnModel.itemListaServicos,
					valorDeducao: nfeDetalheImpostoIssqnModel.valorDeducao,
					valorOutrasRetencoes: nfeDetalheImpostoIssqnModel.valorOutrasRetencoes,
					valorDescontoIncondicionado: nfeDetalheImpostoIssqnModel.valorDescontoIncondicionado,
					valorDescontoCondicionado: nfeDetalheImpostoIssqnModel.valorDescontoCondicionado,
					valorRetencaoIss: nfeDetalheImpostoIssqnModel.valorRetencaoIss,
					indicadorExigibilidadeIss: nfeDetalheImpostoIssqnModel.indicadorExigibilidadeIss,
					codigoServico: nfeDetalheImpostoIssqnModel.codigoServico,
					municipioIncidencia: nfeDetalheImpostoIssqnModel.municipioIncidencia,
					paisSevicoPrestado: nfeDetalheImpostoIssqnModel.paisSevicoPrestado,
					numeroProcesso: nfeDetalheImpostoIssqnModel.numeroProcesso,
					indicadorIncentivoFiscal: nfeDetalheImpostoIssqnModel.indicadorIncentivoFiscal,
				)
			);
		}
		return resultList;
	}

	nfeExportacaoModelListClone(List<NfeExportacaoModel> nfeExportacaoModelList) { 
		List<NfeExportacaoModel> resultList = [];
		for (var nfeExportacaoModel in nfeExportacaoModelList) {
			resultList.add(
				NfeExportacaoModel(
					id: nfeExportacaoModel.id,
					idNfeDetalhe: nfeExportacaoModel.idNfeDetalhe,
					drawback: nfeExportacaoModel.drawback,
					numeroRegistro: nfeExportacaoModel.numeroRegistro,
					chaveAcesso: nfeExportacaoModel.chaveAcesso,
					quantidade: nfeExportacaoModel.quantidade,
				)
			);
		}
		return resultList;
	}

	nfeItemRastreadoModelListClone(List<NfeItemRastreadoModel> nfeItemRastreadoModelList) { 
		List<NfeItemRastreadoModel> resultList = [];
		for (var nfeItemRastreadoModel in nfeItemRastreadoModelList) {
			resultList.add(
				NfeItemRastreadoModel(
					id: nfeItemRastreadoModel.id,
					idNfeDetalhe: nfeItemRastreadoModel.idNfeDetalhe,
					numeroLote: nfeItemRastreadoModel.numeroLote,
					quantidadeItens: nfeItemRastreadoModel.quantidadeItens,
					dataFabricacao: nfeItemRastreadoModel.dataFabricacao,
					dataValidade: nfeItemRastreadoModel.dataValidade,
					codigoAgregacao: nfeItemRastreadoModel.codigoAgregacao,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoPisStModelListClone(List<NfeDetalheImpostoPisStModel> nfeDetalheImpostoPisStModelList) { 
		List<NfeDetalheImpostoPisStModel> resultList = [];
		for (var nfeDetalheImpostoPisStModel in nfeDetalheImpostoPisStModelList) {
			resultList.add(
				NfeDetalheImpostoPisStModel(
					id: nfeDetalheImpostoPisStModel.id,
					idNfeDetalhe: nfeDetalheImpostoPisStModel.idNfeDetalhe,
					valorBaseCalculoPisSt: nfeDetalheImpostoPisStModel.valorBaseCalculoPisSt,
					aliquotaPisStPercentual: nfeDetalheImpostoPisStModel.aliquotaPisStPercentual,
					quantidadeVendidaPisSt: nfeDetalheImpostoPisStModel.quantidadeVendidaPisSt,
					aliquotaPisStReais: nfeDetalheImpostoPisStModel.aliquotaPisStReais,
					valorPisSt: nfeDetalheImpostoPisStModel.valorPisSt,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoIcmsUfdestModelListClone(List<NfeDetalheImpostoIcmsUfdestModel> nfeDetalheImpostoIcmsUfdestModelList) { 
		List<NfeDetalheImpostoIcmsUfdestModel> resultList = [];
		for (var nfeDetalheImpostoIcmsUfdestModel in nfeDetalheImpostoIcmsUfdestModelList) {
			resultList.add(
				NfeDetalheImpostoIcmsUfdestModel(
					id: nfeDetalheImpostoIcmsUfdestModel.id,
					idNfeDetalhe: nfeDetalheImpostoIcmsUfdestModel.idNfeDetalhe,
					valorBcIcmsUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorBcIcmsUfDestino,
					valorBcFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorBcFcpUfDestino,
					percentualFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.percentualFcpUfDestino,
					aliquotaInternaUfDestino: nfeDetalheImpostoIcmsUfdestModel.aliquotaInternaUfDestino,
					aliquotaInteresdatualUfEnvolvidas: nfeDetalheImpostoIcmsUfdestModel.aliquotaInteresdatualUfEnvolvidas,
					percentualProvisorioPartilhaIcms: nfeDetalheImpostoIcmsUfdestModel.percentualProvisorioPartilhaIcms,
					valorIcmsFcpUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorIcmsFcpUfDestino,
					valorInterestadualUfDestino: nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfDestino,
					valorInterestadualUfRemetente: nfeDetalheImpostoIcmsUfdestModel.valorInterestadualUfRemetente,
				)
			);
		}
		return resultList;
	}

	nfeDetalheImpostoCofinsStModelListClone(List<NfeDetalheImpostoCofinsStModel> nfeDetalheImpostoCofinsStModelList) { 
		List<NfeDetalheImpostoCofinsStModel> resultList = [];
		for (var nfeDetalheImpostoCofinsStModel in nfeDetalheImpostoCofinsStModelList) {
			resultList.add(
				NfeDetalheImpostoCofinsStModel(
					id: nfeDetalheImpostoCofinsStModel.id,
					idNfeDetalhe: nfeDetalheImpostoCofinsStModel.idNfeDetalhe,
					baseCalculoCofinsSt: nfeDetalheImpostoCofinsStModel.baseCalculoCofinsSt,
					aliquotaCofinsStPercentual: nfeDetalheImpostoCofinsStModel.aliquotaCofinsStPercentual,
					quantidadeVendidaCofinsSt: nfeDetalheImpostoCofinsStModel.quantidadeVendidaCofinsSt,
					aliquotaCofinsStReais: nfeDetalheImpostoCofinsStModel.aliquotaCofinsStReais,
					valorCofinsSt: nfeDetalheImpostoCofinsStModel.valorCofinsSt,
				)
			);
		}
		return resultList;
	}

	
}