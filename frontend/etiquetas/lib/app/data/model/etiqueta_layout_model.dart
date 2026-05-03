import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:etiquetas/app/data/model/model_imports.dart';

class EtiquetaLayoutModel {
	int? id;
	int? idFormatoPapel;
	String? codigoFabricante;
	int? quantidade;
	int? quantidadeHorizontal;
	int? quantidadeVertical;
	int? margemSuperior;
	int? margemInferior;
	int? margemEsquerda;
	int? margemDireita;
	int? espacamentoHorizontal;
	int? espacamentoVertical;
	List<EtiquetaTemplateModel>? etiquetaTemplateModelList;
	EtiquetaFormatoPapelModel? etiquetaFormatoPapelModel;

	EtiquetaLayoutModel({
		this.id,
		this.idFormatoPapel,
		this.codigoFabricante,
		this.quantidade,
		this.quantidadeHorizontal,
		this.quantidadeVertical,
		this.margemSuperior,
		this.margemInferior,
		this.margemEsquerda,
		this.margemDireita,
		this.espacamentoHorizontal,
		this.espacamentoVertical,
		this.etiquetaTemplateModelList,
		this.etiquetaFormatoPapelModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_fabricante',
		'quantidade',
		'quantidade_horizontal',
		'quantidade_vertical',
		'margem_superior',
		'margem_inferior',
		'margem_esquerda',
		'margem_direita',
		'espacamento_horizontal',
		'espacamento_vertical',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Fabricante',
		'Quantidade',
		'Quantidade Horizontal',
		'Quantidade Vertical',
		'Margem Superior',
		'Margem Inferior',
		'Margem Esquerda',
		'Margem Direita',
		'Espacamento Horizontal',
		'Espacamento Vertical',
	];

	EtiquetaLayoutModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFormatoPapel = jsonData['idFormatoPapel'];
		codigoFabricante = jsonData['codigoFabricante'];
		quantidade = jsonData['quantidade'];
		quantidadeHorizontal = jsonData['quantidadeHorizontal'];
		quantidadeVertical = jsonData['quantidadeVertical'];
		margemSuperior = jsonData['margemSuperior'];
		margemInferior = jsonData['margemInferior'];
		margemEsquerda = jsonData['margemEsquerda'];
		margemDireita = jsonData['margemDireita'];
		espacamentoHorizontal = jsonData['espacamentoHorizontal'];
		espacamentoVertical = jsonData['espacamentoVertical'];
		etiquetaTemplateModelList = (jsonData['etiquetaTemplateModelList'] as Iterable?)?.map((m) => EtiquetaTemplateModel.fromJson(m)).toList() ?? [];
		etiquetaFormatoPapelModel = jsonData['etiquetaFormatoPapelModel'] == null ? EtiquetaFormatoPapelModel() : EtiquetaFormatoPapelModel.fromJson(jsonData['etiquetaFormatoPapelModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFormatoPapel'] = idFormatoPapel != 0 ? idFormatoPapel : null;
		jsonData['codigoFabricante'] = codigoFabricante;
		jsonData['quantidade'] = quantidade;
		jsonData['quantidadeHorizontal'] = quantidadeHorizontal;
		jsonData['quantidadeVertical'] = quantidadeVertical;
		jsonData['margemSuperior'] = margemSuperior;
		jsonData['margemInferior'] = margemInferior;
		jsonData['margemEsquerda'] = margemEsquerda;
		jsonData['margemDireita'] = margemDireita;
		jsonData['espacamentoHorizontal'] = espacamentoHorizontal;
		jsonData['espacamentoVertical'] = espacamentoVertical;
		
		var etiquetaTemplateModelLocalList = []; 
		for (EtiquetaTemplateModel object in etiquetaTemplateModelList ?? []) { 
			etiquetaTemplateModelLocalList.add(object.toJson); 
		}
		jsonData['etiquetaTemplateModelList'] = etiquetaTemplateModelLocalList;
		jsonData['etiquetaFormatoPapelModel'] = etiquetaFormatoPapelModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFormatoPapel = plutoRow.cells['idFormatoPapel']?.value;
		codigoFabricante = plutoRow.cells['codigoFabricante']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		quantidadeHorizontal = plutoRow.cells['quantidadeHorizontal']?.value;
		quantidadeVertical = plutoRow.cells['quantidadeVertical']?.value;
		margemSuperior = plutoRow.cells['margemSuperior']?.value;
		margemInferior = plutoRow.cells['margemInferior']?.value;
		margemEsquerda = plutoRow.cells['margemEsquerda']?.value;
		margemDireita = plutoRow.cells['margemDireita']?.value;
		espacamentoHorizontal = plutoRow.cells['espacamentoHorizontal']?.value;
		espacamentoVertical = plutoRow.cells['espacamentoVertical']?.value;
		etiquetaTemplateModelList = [];
		etiquetaFormatoPapelModel = EtiquetaFormatoPapelModel();
		etiquetaFormatoPapelModel?.nome = plutoRow.cells['etiquetaFormatoPapelModel']?.value;
	}	

	EtiquetaLayoutModel clone() {
		return EtiquetaLayoutModel(
			id: id,
			idFormatoPapel: idFormatoPapel,
			codigoFabricante: codigoFabricante,
			quantidade: quantidade,
			quantidadeHorizontal: quantidadeHorizontal,
			quantidadeVertical: quantidadeVertical,
			margemSuperior: margemSuperior,
			margemInferior: margemInferior,
			margemEsquerda: margemEsquerda,
			margemDireita: margemDireita,
			espacamentoHorizontal: espacamentoHorizontal,
			espacamentoVertical: espacamentoVertical,
			etiquetaTemplateModelList: etiquetaTemplateModelListClone(etiquetaTemplateModelList!),
		);			
	}

	etiquetaTemplateModelListClone(List<EtiquetaTemplateModel> etiquetaTemplateModelList) { 
		List<EtiquetaTemplateModel> resultList = [];
		for (var etiquetaTemplateModel in etiquetaTemplateModelList) {
			resultList.add(
				EtiquetaTemplateModel(
					id: etiquetaTemplateModel.id,
					idEtiquetaLayout: etiquetaTemplateModel.idEtiquetaLayout,
					tabela: etiquetaTemplateModel.tabela,
					campo: etiquetaTemplateModel.campo,
					formato: etiquetaTemplateModel.formato,
					quantidadeRepeticoes: etiquetaTemplateModel.quantidadeRepeticoes,
					filtro: etiquetaTemplateModel.filtro,
				)
			);
		}
		return resultList;
	}

	
}