import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class RecadoRemetenteModel {
	int? id;
	int? idColaborador;
	DateTime? dataEnvio;
	String? horaEnvio;
	String? assunto;
	String? texto;
	List<RecadoDestinatarioModel>? recadoDestinatarioModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	RecadoRemetenteModel({
		this.id,
		this.idColaborador,
		this.dataEnvio,
		this.horaEnvio,
		this.assunto,
		this.texto,
		this.recadoDestinatarioModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_envio',
		'hora_envio',
		'assunto',
		'texto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Envio',
		'Hora Envio',
		'Assunto',
		'Texto',
	];

	RecadoRemetenteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		dataEnvio = jsonData['dataEnvio'] != null ? DateTime.tryParse(jsonData['dataEnvio']) : null;
		horaEnvio = jsonData['horaEnvio'];
		assunto = jsonData['assunto'];
		texto = jsonData['texto'];
		recadoDestinatarioModelList = (jsonData['recadoDestinatarioModelList'] as Iterable?)?.map((m) => RecadoDestinatarioModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataEnvio'] = dataEnvio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEnvio!) : null;
		jsonData['horaEnvio'] = Util.removeMask(horaEnvio);
		jsonData['assunto'] = assunto;
		jsonData['texto'] = texto;
		
		var recadoDestinatarioModelLocalList = []; 
		for (RecadoDestinatarioModel object in recadoDestinatarioModelList ?? []) { 
			recadoDestinatarioModelLocalList.add(object.toJson); 
		}
		jsonData['recadoDestinatarioModelList'] = recadoDestinatarioModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataEnvio = Util.stringToDate(plutoRow.cells['dataEnvio']?.value);
		horaEnvio = plutoRow.cells['horaEnvio']?.value;
		assunto = plutoRow.cells['assunto']?.value;
		texto = plutoRow.cells['texto']?.value;
		recadoDestinatarioModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	RecadoRemetenteModel clone() {
		return RecadoRemetenteModel(
			id: id,
			idColaborador: idColaborador,
			dataEnvio: dataEnvio,
			horaEnvio: horaEnvio,
			assunto: assunto,
			texto: texto,
			recadoDestinatarioModelList: recadoDestinatarioModelListClone(recadoDestinatarioModelList!),
		);			
	}

	recadoDestinatarioModelListClone(List<RecadoDestinatarioModel> recadoDestinatarioModelList) { 
		List<RecadoDestinatarioModel> resultList = [];
		for (var recadoDestinatarioModel in recadoDestinatarioModelList) {
			resultList.add(
				RecadoDestinatarioModel(
					id: recadoDestinatarioModel.id,
					idColaborador: recadoDestinatarioModel.idColaborador,
					idRecadoRemetente: recadoDestinatarioModel.idRecadoRemetente,
				)
			);
		}
		return resultList;
	}

	
}