import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';

class NfeImportacaoDetalheModel {
	int? id;
	int? idNfeDeclaracaoImportacao;
	int? numeroAdicao;
	int? numeroSequencial;
	String? codigoFabricanteEstrangeiro;
	double? valorDesconto;
	int? drawback;
	NfeDeclaracaoImportacaoModel? nfeDeclaracaoImportacaoModel;

	NfeImportacaoDetalheModel({
		this.id,
		this.idNfeDeclaracaoImportacao,
		this.numeroAdicao,
		this.numeroSequencial,
		this.codigoFabricanteEstrangeiro,
		this.valorDesconto,
		this.drawback,
		this.nfeDeclaracaoImportacaoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_adicao',
		'numero_sequencial',
		'codigo_fabricante_estrangeiro',
		'valor_desconto',
		'drawback',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Adicao',
		'Numero Sequencial',
		'Codigo Fabricante Estrangeiro',
		'Valor Desconto',
		'Drawback',
	];

	NfeImportacaoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDeclaracaoImportacao = jsonData['idNfeDeclaracaoImportacao'];
		numeroAdicao = jsonData['numeroAdicao'];
		numeroSequencial = jsonData['numeroSequencial'];
		codigoFabricanteEstrangeiro = jsonData['codigoFabricanteEstrangeiro'];
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		drawback = jsonData['drawback'];
		nfeDeclaracaoImportacaoModel = jsonData['nfeDeclaracaoImportacaoModel'] == null ? NfeDeclaracaoImportacaoModel() : NfeDeclaracaoImportacaoModel.fromJson(jsonData['nfeDeclaracaoImportacaoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDeclaracaoImportacao'] = idNfeDeclaracaoImportacao != 0 ? idNfeDeclaracaoImportacao : null;
		jsonData['numeroAdicao'] = numeroAdicao;
		jsonData['numeroSequencial'] = numeroSequencial;
		jsonData['codigoFabricanteEstrangeiro'] = codigoFabricanteEstrangeiro;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['drawback'] = drawback;
		jsonData['nfeDeclaracaoImportacaoModel'] = nfeDeclaracaoImportacaoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDeclaracaoImportacao = plutoRow.cells['idNfeDeclaracaoImportacao']?.value;
		numeroAdicao = plutoRow.cells['numeroAdicao']?.value;
		numeroSequencial = plutoRow.cells['numeroSequencial']?.value;
		codigoFabricanteEstrangeiro = plutoRow.cells['codigoFabricanteEstrangeiro']?.value;
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		drawback = plutoRow.cells['drawback']?.value;
		nfeDeclaracaoImportacaoModel = NfeDeclaracaoImportacaoModel();
		nfeDeclaracaoImportacaoModel?.numeroDocumento = plutoRow.cells['nfeDeclaracaoImportacaoModel']?.value;
	}	

	NfeImportacaoDetalheModel clone() {
		return NfeImportacaoDetalheModel(
			id: id,
			idNfeDeclaracaoImportacao: idNfeDeclaracaoImportacao,
			numeroAdicao: numeroAdicao,
			numeroSequencial: numeroSequencial,
			codigoFabricanteEstrangeiro: codigoFabricanteEstrangeiro,
			valorDesconto: valorDesconto,
			drawback: drawback,
		);			
	}

	
}