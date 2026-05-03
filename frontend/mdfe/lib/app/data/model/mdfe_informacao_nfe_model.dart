import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoNfeModel {
	int? id;
	int? idMdfeMunicipioDescarrega;
	String? chaveNfe;
	String? segundoCodigoBarra;
	int? indicadorReentrega;
	MdfeMunicipioDescarregaModel? mdfeMunicipioDescarregaModel;

	MdfeInformacaoNfeModel({
		this.id,
		this.idMdfeMunicipioDescarrega,
		this.chaveNfe,
		this.segundoCodigoBarra,
		this.indicadorReentrega,
		this.mdfeMunicipioDescarregaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'chave_nfe',
		'segundo_codigo_barra',
		'indicador_reentrega',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Chave Nfe',
		'Segundo Codigo Barra',
		'Indicador Reentrega',
	];

	MdfeInformacaoNfeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeMunicipioDescarrega = jsonData['idMdfeMunicipioDescarrega'];
		chaveNfe = jsonData['chaveNfe'];
		segundoCodigoBarra = jsonData['segundoCodigoBarra'];
		indicadorReentrega = jsonData['indicadorReentrega'];
		mdfeMunicipioDescarregaModel = jsonData['mdfeMunicipioDescarregaModel'] == null ? MdfeMunicipioDescarregaModel() : MdfeMunicipioDescarregaModel.fromJson(jsonData['mdfeMunicipioDescarregaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeMunicipioDescarrega'] = idMdfeMunicipioDescarrega != 0 ? idMdfeMunicipioDescarrega : null;
		jsonData['chaveNfe'] = chaveNfe;
		jsonData['segundoCodigoBarra'] = segundoCodigoBarra;
		jsonData['indicadorReentrega'] = indicadorReentrega;
		jsonData['mdfeMunicipioDescarregaModel'] = mdfeMunicipioDescarregaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeMunicipioDescarrega = plutoRow.cells['idMdfeMunicipioDescarrega']?.value;
		chaveNfe = plutoRow.cells['chaveNfe']?.value;
		segundoCodigoBarra = plutoRow.cells['segundoCodigoBarra']?.value;
		indicadorReentrega = plutoRow.cells['indicadorReentrega']?.value;
		mdfeMunicipioDescarregaModel = MdfeMunicipioDescarregaModel();
		mdfeMunicipioDescarregaModel?.nomeMunicipio = plutoRow.cells['mdfeMunicipioDescarregaModel']?.value;
	}	

	MdfeInformacaoNfeModel clone() {
		return MdfeInformacaoNfeModel(
			id: id,
			idMdfeMunicipioDescarrega: idMdfeMunicipioDescarrega,
			chaveNfe: chaveNfe,
			segundoCodigoBarra: segundoCodigoBarra,
			indicadorReentrega: indicadorReentrega,
		);			
	}

	
}