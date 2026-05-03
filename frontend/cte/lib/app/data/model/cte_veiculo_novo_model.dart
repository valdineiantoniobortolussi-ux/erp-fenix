import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CteVeiculoNovoModel {
	int? id;
	int? idCteCabecalho;
	String? chassi;
	String? cor;
	String? descricaoCor;
	String? codigoMarcaModelo;
	double? valorUnitario;
	double? valorFrete;

	CteVeiculoNovoModel({
		this.id,
		this.idCteCabecalho,
		this.chassi,
		this.cor,
		this.descricaoCor,
		this.codigoMarcaModelo,
		this.valorUnitario,
		this.valorFrete,
	});

	static List<String> dbColumns = <String>[
		'id',
		'chassi',
		'cor',
		'descricao_cor',
		'codigo_marca_modelo',
		'valor_unitario',
		'valor_frete',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Chassi',
		'Cor',
		'Descricao Cor',
		'Codigo Marca Modelo',
		'Valor Unitario',
		'Valor Frete',
	];

	CteVeiculoNovoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		chassi = jsonData['chassi'];
		cor = jsonData['cor'];
		descricaoCor = jsonData['descricaoCor'];
		codigoMarcaModelo = jsonData['codigoMarcaModelo'];
		valorUnitario = jsonData['valorUnitario']?.toDouble();
		valorFrete = jsonData['valorFrete']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['chassi'] = chassi;
		jsonData['cor'] = cor;
		jsonData['descricaoCor'] = descricaoCor;
		jsonData['codigoMarcaModelo'] = codigoMarcaModelo;
		jsonData['valorUnitario'] = valorUnitario;
		jsonData['valorFrete'] = valorFrete;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		chassi = plutoRow.cells['chassi']?.value;
		cor = plutoRow.cells['cor']?.value;
		descricaoCor = plutoRow.cells['descricaoCor']?.value;
		codigoMarcaModelo = plutoRow.cells['codigoMarcaModelo']?.value;
		valorUnitario = plutoRow.cells['valorUnitario']?.value?.toDouble();
		valorFrete = plutoRow.cells['valorFrete']?.value?.toDouble();
	}	

	CteVeiculoNovoModel clone() {
		return CteVeiculoNovoModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			chassi: chassi,
			cor: cor,
			descricaoCor: descricaoCor,
			codigoMarcaModelo: codigoMarcaModelo,
			valorUnitario: valorUnitario,
			valorFrete: valorFrete,
		);			
	}

	
}