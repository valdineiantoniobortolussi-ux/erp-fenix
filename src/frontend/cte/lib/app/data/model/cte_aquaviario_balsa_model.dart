import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteAquaviarioBalsaModel {
	int? id;
	int? idCteAquaviario;
	String? idBalsa;
	int? numeroViagem;
	String? direcao;
	String? portoEmbarque;
	String? portoTransbordo;
	String? portoDestino;
	String? tipoNavegacao;
	String? irin;
	CteAquaviarioModel? cteAquaviarioModel;

	CteAquaviarioBalsaModel({
		this.id,
		this.idCteAquaviario,
		this.idBalsa,
		this.numeroViagem,
		this.direcao,
		this.portoEmbarque,
		this.portoTransbordo,
		this.portoDestino,
		this.tipoNavegacao,
		this.irin,
		this.cteAquaviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_balsa',
		'numero_viagem',
		'direcao',
		'porto_embarque',
		'porto_transbordo',
		'porto_destino',
		'tipo_navegacao',
		'irin',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Balsa',
		'Numero Viagem',
		'Direcao',
		'Porto Embarque',
		'Porto Transbordo',
		'Porto Destino',
		'Tipo Navegacao',
		'Irin',
	];

	CteAquaviarioBalsaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteAquaviario = jsonData['idCteAquaviario'];
		idBalsa = jsonData['idBalsa'];
		numeroViagem = jsonData['numeroViagem'];
		direcao = CteAquaviarioBalsaDomain.getDirecao(jsonData['direcao']);
		portoEmbarque = jsonData['portoEmbarque'];
		portoTransbordo = jsonData['portoTransbordo'];
		portoDestino = jsonData['portoDestino'];
		tipoNavegacao = CteAquaviarioBalsaDomain.getTipoNavegacao(jsonData['tipoNavegacao']);
		irin = jsonData['irin'];
		cteAquaviarioModel = jsonData['cteAquaviarioModel'] == null ? CteAquaviarioModel() : CteAquaviarioModel.fromJson(jsonData['cteAquaviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteAquaviario'] = idCteAquaviario != 0 ? idCteAquaviario : null;
		jsonData['idBalsa'] = idBalsa;
		jsonData['numeroViagem'] = numeroViagem;
		jsonData['direcao'] = CteAquaviarioBalsaDomain.setDirecao(direcao);
		jsonData['portoEmbarque'] = portoEmbarque;
		jsonData['portoTransbordo'] = portoTransbordo;
		jsonData['portoDestino'] = portoDestino;
		jsonData['tipoNavegacao'] = CteAquaviarioBalsaDomain.setTipoNavegacao(tipoNavegacao);
		jsonData['irin'] = irin;
		jsonData['cteAquaviarioModel'] = cteAquaviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteAquaviario = plutoRow.cells['idCteAquaviario']?.value;
		idBalsa = plutoRow.cells['idBalsa']?.value;
		numeroViagem = plutoRow.cells['numeroViagem']?.value;
		direcao = plutoRow.cells['direcao']?.value != '' ? plutoRow.cells['direcao']?.value : 'AAA';
		portoEmbarque = plutoRow.cells['portoEmbarque']?.value;
		portoTransbordo = plutoRow.cells['portoTransbordo']?.value;
		portoDestino = plutoRow.cells['portoDestino']?.value;
		tipoNavegacao = plutoRow.cells['tipoNavegacao']?.value != '' ? plutoRow.cells['tipoNavegacao']?.value : 'AAA';
		irin = plutoRow.cells['irin']?.value;
		cteAquaviarioModel = CteAquaviarioModel();
		cteAquaviarioModel?.numeroControle = plutoRow.cells['cteAquaviarioModel']?.value;
	}	

	CteAquaviarioBalsaModel clone() {
		return CteAquaviarioBalsaModel(
			id: id,
			idCteAquaviario: idCteAquaviario,
			idBalsa: idBalsa,
			numeroViagem: numeroViagem,
			direcao: direcao,
			portoEmbarque: portoEmbarque,
			portoTransbordo: portoTransbordo,
			portoDestino: portoDestino,
			tipoNavegacao: tipoNavegacao,
			irin: irin,
		);			
	}

	
}