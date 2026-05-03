import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class FolhaAfastamentoModel {
	int? id;
	int? idColaborador;
	int? idFolhaTipoAfastamento;
	DateTime? dataInicio;
	DateTime? dataFim;
	int? diasAfastado;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	FolhaTipoAfastamentoModel? folhaTipoAfastamentoModel;

	FolhaAfastamentoModel({
		this.id,
		this.idColaborador,
		this.idFolhaTipoAfastamento,
		this.dataInicio,
		this.dataFim,
		this.diasAfastado,
		this.viewPessoaColaboradorModel,
		this.folhaTipoAfastamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'dias_afastado',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Dias Afastado',
	];

	FolhaAfastamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		idFolhaTipoAfastamento = jsonData['idFolhaTipoAfastamento'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		diasAfastado = jsonData['diasAfastado'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		folhaTipoAfastamentoModel = jsonData['folhaTipoAfastamentoModel'] == null ? FolhaTipoAfastamentoModel() : FolhaTipoAfastamentoModel.fromJson(jsonData['folhaTipoAfastamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idFolhaTipoAfastamento'] = idFolhaTipoAfastamento != 0 ? idFolhaTipoAfastamento : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['diasAfastado'] = diasAfastado;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['folhaTipoAfastamentoModel'] = folhaTipoAfastamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idFolhaTipoAfastamento = plutoRow.cells['idFolhaTipoAfastamento']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		diasAfastado = plutoRow.cells['diasAfastado']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		folhaTipoAfastamentoModel = FolhaTipoAfastamentoModel();
		folhaTipoAfastamentoModel?.nome = plutoRow.cells['folhaTipoAfastamentoModel']?.value;
	}	

	FolhaAfastamentoModel clone() {
		return FolhaAfastamentoModel(
			id: id,
			idColaborador: idColaborador,
			idFolhaTipoAfastamento: idFolhaTipoAfastamento,
			dataInicio: dataInicio,
			dataFim: dataFim,
			diasAfastado: diasAfastado,
		);			
	}

	
}