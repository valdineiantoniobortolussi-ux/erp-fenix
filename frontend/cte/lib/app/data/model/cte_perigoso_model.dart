import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CtePerigosoModel {
	int? id;
	int? idCteCabecalho;
	String? numeroOnu;
	String? nomeApropriado;
	String? classeRisco;
	String? grupoEmbalagem;
	String? quantidadeTotalProduto;
	String? quantidadeTipoVolume;
	String? pontoFulgor;

	CtePerigosoModel({
		this.id,
		this.idCteCabecalho,
		this.numeroOnu,
		this.nomeApropriado,
		this.classeRisco,
		this.grupoEmbalagem,
		this.quantidadeTotalProduto,
		this.quantidadeTipoVolume,
		this.pontoFulgor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_onu',
		'nome_apropriado',
		'classe_risco',
		'grupo_embalagem',
		'quantidade_total_produto',
		'quantidade_tipo_volume',
		'ponto_fulgor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Onu',
		'Nome Apropriado',
		'Classe Risco',
		'Grupo Embalagem',
		'Quantidade Total Produto',
		'Quantidade Tipo Volume',
		'Ponto Fulgor',
	];

	CtePerigosoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		numeroOnu = jsonData['numeroOnu'];
		nomeApropriado = jsonData['nomeApropriado'];
		classeRisco = jsonData['classeRisco'];
		grupoEmbalagem = jsonData['grupoEmbalagem'];
		quantidadeTotalProduto = jsonData['quantidadeTotalProduto'];
		quantidadeTipoVolume = jsonData['quantidadeTipoVolume'];
		pontoFulgor = jsonData['pontoFulgor'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['numeroOnu'] = numeroOnu;
		jsonData['nomeApropriado'] = nomeApropriado;
		jsonData['classeRisco'] = classeRisco;
		jsonData['grupoEmbalagem'] = grupoEmbalagem;
		jsonData['quantidadeTotalProduto'] = quantidadeTotalProduto;
		jsonData['quantidadeTipoVolume'] = quantidadeTipoVolume;
		jsonData['pontoFulgor'] = pontoFulgor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		numeroOnu = plutoRow.cells['numeroOnu']?.value;
		nomeApropriado = plutoRow.cells['nomeApropriado']?.value;
		classeRisco = plutoRow.cells['classeRisco']?.value;
		grupoEmbalagem = plutoRow.cells['grupoEmbalagem']?.value;
		quantidadeTotalProduto = plutoRow.cells['quantidadeTotalProduto']?.value;
		quantidadeTipoVolume = plutoRow.cells['quantidadeTipoVolume']?.value;
		pontoFulgor = plutoRow.cells['pontoFulgor']?.value;
	}	

	CtePerigosoModel clone() {
		return CtePerigosoModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			numeroOnu: numeroOnu,
			nomeApropriado: nomeApropriado,
			classeRisco: classeRisco,
			grupoEmbalagem: grupoEmbalagem,
			quantidadeTotalProduto: quantidadeTotalProduto,
			quantidadeTipoVolume: quantidadeTipoVolume,
			pontoFulgor: pontoFulgor,
		);			
	}

	
}