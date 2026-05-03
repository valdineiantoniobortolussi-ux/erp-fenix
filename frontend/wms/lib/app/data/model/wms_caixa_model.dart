import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/model/model_imports.dart';

class WmsCaixaModel {
	int? id;
	int? idWmsEstante;
	String? codigo;
	int? altura;
	int? largura;
	int? profundidade;
	List<WmsArmazenamentoModel>? wmsArmazenamentoModelList;
	WmsEstanteModel? wmsEstanteModel;

	WmsCaixaModel({
		this.id,
		this.idWmsEstante,
		this.codigo,
		this.altura,
		this.largura,
		this.profundidade,
		this.wmsArmazenamentoModelList,
		this.wmsEstanteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'altura',
		'largura',
		'profundidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Altura',
		'Largura',
		'Profundidade',
	];

	WmsCaixaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsEstante = jsonData['idWmsEstante'];
		codigo = jsonData['codigo'];
		altura = jsonData['altura'];
		largura = jsonData['largura'];
		profundidade = jsonData['profundidade'];
		wmsArmazenamentoModelList = (jsonData['wmsArmazenamentoModelList'] as Iterable?)?.map((m) => WmsArmazenamentoModel.fromJson(m)).toList() ?? [];
		wmsEstanteModel = jsonData['wmsEstanteModel'] == null ? WmsEstanteModel() : WmsEstanteModel.fromJson(jsonData['wmsEstanteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsEstante'] = idWmsEstante != 0 ? idWmsEstante : null;
		jsonData['codigo'] = codigo;
		jsonData['altura'] = altura;
		jsonData['largura'] = largura;
		jsonData['profundidade'] = profundidade;
		
		var wmsArmazenamentoModelLocalList = []; 
		for (WmsArmazenamentoModel object in wmsArmazenamentoModelList ?? []) { 
			wmsArmazenamentoModelLocalList.add(object.toJson); 
		}
		jsonData['wmsArmazenamentoModelList'] = wmsArmazenamentoModelLocalList;
		jsonData['wmsEstanteModel'] = wmsEstanteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsEstante = plutoRow.cells['idWmsEstante']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		altura = plutoRow.cells['altura']?.value;
		largura = plutoRow.cells['largura']?.value;
		profundidade = plutoRow.cells['profundidade']?.value;
		wmsArmazenamentoModelList = [];
		wmsEstanteModel = WmsEstanteModel();
		wmsEstanteModel?.codigo = plutoRow.cells['wmsEstanteModel']?.value;
	}	

	WmsCaixaModel clone() {
		return WmsCaixaModel(
			id: id,
			idWmsEstante: idWmsEstante,
			codigo: codigo,
			altura: altura,
			largura: largura,
			profundidade: profundidade,
			wmsArmazenamentoModelList: wmsArmazenamentoModelListClone(wmsArmazenamentoModelList!),
		);			
	}

	wmsArmazenamentoModelListClone(List<WmsArmazenamentoModel> wmsArmazenamentoModelList) { 
		List<WmsArmazenamentoModel> resultList = [];
		for (var wmsArmazenamentoModel in wmsArmazenamentoModelList) {
			resultList.add(
				WmsArmazenamentoModel(
					id: wmsArmazenamentoModel.id,
					idWmsCaixa: wmsArmazenamentoModel.idWmsCaixa,
					idWmsRecebimentoDetalhe: wmsArmazenamentoModel.idWmsRecebimentoDetalhe,
					quantidade: wmsArmazenamentoModel.quantidade,
				)
			);
		}
		return resultList;
	}

	
}