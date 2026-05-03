import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeInformacaoCteModel {
	int? id;
	int? idMdfeMunicipioDescarrega;
	String? chaveCte;
	String? segundoCodigoBarra;
	int? indicadorReentrega;
	MdfeMunicipioDescarregaModel? mdfeMunicipioDescarregaModel;

	MdfeInformacaoCteModel({
		this.id,
		this.idMdfeMunicipioDescarrega,
		this.chaveCte,
		this.segundoCodigoBarra,
		this.indicadorReentrega,
		this.mdfeMunicipioDescarregaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'chave_cte',
		'segundo_codigo_barra',
		'indicador_reentrega',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Chave Cte',
		'Segundo Codigo Barra',
		'Indicador Reentrega',
	];

	MdfeInformacaoCteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeMunicipioDescarrega = jsonData['idMdfeMunicipioDescarrega'];
		chaveCte = jsonData['chaveCte'];
		segundoCodigoBarra = jsonData['segundoCodigoBarra'];
		indicadorReentrega = jsonData['indicadorReentrega'];
		mdfeMunicipioDescarregaModel = jsonData['mdfeMunicipioDescarregaModel'] == null ? MdfeMunicipioDescarregaModel() : MdfeMunicipioDescarregaModel.fromJson(jsonData['mdfeMunicipioDescarregaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeMunicipioDescarrega'] = idMdfeMunicipioDescarrega != 0 ? idMdfeMunicipioDescarrega : null;
		jsonData['chaveCte'] = chaveCte;
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
		chaveCte = plutoRow.cells['chaveCte']?.value;
		segundoCodigoBarra = plutoRow.cells['segundoCodigoBarra']?.value;
		indicadorReentrega = plutoRow.cells['indicadorReentrega']?.value;
		mdfeMunicipioDescarregaModel = MdfeMunicipioDescarregaModel();
		mdfeMunicipioDescarregaModel?.nomeMunicipio = plutoRow.cells['mdfeMunicipioDescarregaModel']?.value;
	}	

	MdfeInformacaoCteModel clone() {
		return MdfeInformacaoCteModel(
			id: id,
			idMdfeMunicipioDescarrega: idMdfeMunicipioDescarrega,
			chaveCte: chaveCte,
			segundoCodigoBarra: segundoCodigoBarra,
			indicadorReentrega: indicadorReentrega,
		);			
	}

	
}