import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ProdutoModel {
	int? id;
	int? idProdutoSubgrupo;
	int? idProdutoMarca;
	int? idProdutoUnidade;
	int? idTributIcmsCustomCab;
	int? idTributGrupoTributario;
	String? nome;
	String? descricao;
	String? gtin;
	String? codigoInterno;
	double? valorCompra;
	double? valorVenda;
	String? codigoNcm;
	double? estoqueMinimo;
	double? estoqueMaximo;
	double? quantidadeEstoque;
	DateTime? dataCadastro;
	ProdutoMarcaModel? produtoMarcaModel;
	TributIcmsCustomCabModel? tributIcmsCustomCabModel;
	TributGrupoTributarioModel? tributGrupoTributarioModel;
	ProdutoUnidadeModel? produtoUnidadeModel;
	ProdutoSubgrupoModel? produtoSubgrupoModel;

	ProdutoModel({
		this.id,
		this.idProdutoSubgrupo,
		this.idProdutoMarca,
		this.idProdutoUnidade,
		this.idTributIcmsCustomCab,
		this.idTributGrupoTributario,
		this.nome,
		this.descricao,
		this.gtin,
		this.codigoInterno,
		this.valorCompra,
		this.valorVenda,
		this.codigoNcm,
		this.estoqueMinimo,
		this.estoqueMaximo,
		this.quantidadeEstoque,
		this.dataCadastro,
		this.produtoMarcaModel,
		this.tributIcmsCustomCabModel,
		this.tributGrupoTributarioModel,
		this.produtoUnidadeModel,
		this.produtoSubgrupoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'gtin',
		'codigo_interno',
		'valor_compra',
		'valor_venda',
		'codigo_ncm',
		'estoque_minimo',
		'estoque_maximo',
		'quantidade_estoque',
		'data_cadastro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Gtin',
		'Codigo Interno',
		'Valor Compra',
		'Valor Venda',
		'Codigo Ncm',
		'Estoque Minimo',
		'Estoque Maximo',
		'Quantidade Estoque',
		'Data Cadastro',
	];

	ProdutoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProdutoSubgrupo = jsonData['idProdutoSubgrupo'];
		idProdutoMarca = jsonData['idProdutoMarca'];
		idProdutoUnidade = jsonData['idProdutoUnidade'];
		idTributIcmsCustomCab = jsonData['idTributIcmsCustomCab'];
		idTributGrupoTributario = jsonData['idTributGrupoTributario'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		gtin = jsonData['gtin'];
		codigoInterno = jsonData['codigoInterno'];
		valorCompra = jsonData['valorCompra']?.toDouble();
		valorVenda = jsonData['valorVenda']?.toDouble();
		codigoNcm = jsonData['codigoNcm'];
		estoqueMinimo = jsonData['estoqueMinimo']?.toDouble();
		estoqueMaximo = jsonData['estoqueMaximo']?.toDouble();
		quantidadeEstoque = jsonData['quantidadeEstoque']?.toDouble();
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		produtoMarcaModel = jsonData['produtoMarcaModel'] == null ? ProdutoMarcaModel() : ProdutoMarcaModel.fromJson(jsonData['produtoMarcaModel']);
		tributIcmsCustomCabModel = jsonData['tributIcmsCustomCabModel'] == null ? TributIcmsCustomCabModel() : TributIcmsCustomCabModel.fromJson(jsonData['tributIcmsCustomCabModel']);
		tributGrupoTributarioModel = jsonData['tributGrupoTributarioModel'] == null ? TributGrupoTributarioModel() : TributGrupoTributarioModel.fromJson(jsonData['tributGrupoTributarioModel']);
		produtoUnidadeModel = jsonData['produtoUnidadeModel'] == null ? ProdutoUnidadeModel() : ProdutoUnidadeModel.fromJson(jsonData['produtoUnidadeModel']);
		produtoSubgrupoModel = jsonData['produtoSubgrupoModel'] == null ? ProdutoSubgrupoModel() : ProdutoSubgrupoModel.fromJson(jsonData['produtoSubgrupoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProdutoSubgrupo'] = idProdutoSubgrupo != 0 ? idProdutoSubgrupo : null;
		jsonData['idProdutoMarca'] = idProdutoMarca != 0 ? idProdutoMarca : null;
		jsonData['idProdutoUnidade'] = idProdutoUnidade != 0 ? idProdutoUnidade : null;
		jsonData['idTributIcmsCustomCab'] = idTributIcmsCustomCab != 0 ? idTributIcmsCustomCab : null;
		jsonData['idTributGrupoTributario'] = idTributGrupoTributario != 0 ? idTributGrupoTributario : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['gtin'] = gtin;
		jsonData['codigoInterno'] = codigoInterno;
		jsonData['valorCompra'] = valorCompra;
		jsonData['valorVenda'] = valorVenda;
		jsonData['codigoNcm'] = codigoNcm;
		jsonData['estoqueMinimo'] = estoqueMinimo;
		jsonData['estoqueMaximo'] = estoqueMaximo;
		jsonData['quantidadeEstoque'] = quantidadeEstoque;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['produtoMarcaModel'] = produtoMarcaModel?.toJson;
		jsonData['tributIcmsCustomCabModel'] = tributIcmsCustomCabModel?.toJson;
		jsonData['tributGrupoTributarioModel'] = tributGrupoTributarioModel?.toJson;
		jsonData['produtoUnidadeModel'] = produtoUnidadeModel?.toJson;
		jsonData['produtoSubgrupoModel'] = produtoSubgrupoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProdutoSubgrupo = plutoRow.cells['idProdutoSubgrupo']?.value;
		idProdutoMarca = plutoRow.cells['idProdutoMarca']?.value;
		idProdutoUnidade = plutoRow.cells['idProdutoUnidade']?.value;
		idTributIcmsCustomCab = plutoRow.cells['idTributIcmsCustomCab']?.value;
		idTributGrupoTributario = plutoRow.cells['idTributGrupoTributario']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		gtin = plutoRow.cells['gtin']?.value;
		codigoInterno = plutoRow.cells['codigoInterno']?.value;
		valorCompra = plutoRow.cells['valorCompra']?.value?.toDouble();
		valorVenda = plutoRow.cells['valorVenda']?.value?.toDouble();
		codigoNcm = plutoRow.cells['codigoNcm']?.value;
		estoqueMinimo = plutoRow.cells['estoqueMinimo']?.value?.toDouble();
		estoqueMaximo = plutoRow.cells['estoqueMaximo']?.value?.toDouble();
		quantidadeEstoque = plutoRow.cells['quantidadeEstoque']?.value?.toDouble();
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		produtoMarcaModel = ProdutoMarcaModel();
		produtoMarcaModel?.nome = plutoRow.cells['produtoMarcaModel']?.value;
		tributIcmsCustomCabModel = TributIcmsCustomCabModel();
		tributIcmsCustomCabModel?.descricao = plutoRow.cells['tributIcmsCustomCabModel']?.value;
		tributGrupoTributarioModel = TributGrupoTributarioModel();
		tributGrupoTributarioModel?.descricao = plutoRow.cells['tributGrupoTributarioModel']?.value;
		produtoUnidadeModel = ProdutoUnidadeModel();
		produtoUnidadeModel?.sigla = plutoRow.cells['produtoUnidadeModel']?.value;
		produtoSubgrupoModel = ProdutoSubgrupoModel();
		produtoSubgrupoModel?.nome = plutoRow.cells['produtoSubgrupoModel']?.value;
	}	

	ProdutoModel clone() {
		return ProdutoModel(
			id: id,
			idProdutoSubgrupo: idProdutoSubgrupo,
			idProdutoMarca: idProdutoMarca,
			idProdutoUnidade: idProdutoUnidade,
			idTributIcmsCustomCab: idTributIcmsCustomCab,
			idTributGrupoTributario: idTributGrupoTributario,
			nome: nome,
			descricao: descricao,
			gtin: gtin,
			codigoInterno: codigoInterno,
			valorCompra: valorCompra,
			valorVenda: valorVenda,
			codigoNcm: codigoNcm,
			estoqueMinimo: estoqueMinimo,
			estoqueMaximo: estoqueMaximo,
			quantidadeEstoque: quantidadeEstoque,
			dataCadastro: dataCadastro,
		);			
	}

	
}