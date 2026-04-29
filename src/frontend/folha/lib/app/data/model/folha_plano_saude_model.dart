import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaPlanoSaudeModel {
	int? id;
	int? idOperadoraPlanoSaude;
	int? idColaborador;
	DateTime? dataInicio;
	String? beneficiario;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	OperadoraPlanoSaudeModel? operadoraPlanoSaudeModel;

	FolhaPlanoSaudeModel({
		this.id,
		this.idOperadoraPlanoSaude,
		this.idColaborador,
		this.dataInicio,
		this.beneficiario,
		this.viewPessoaColaboradorModel,
		this.operadoraPlanoSaudeModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'beneficiario',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Beneficiario',
	];

	FolhaPlanoSaudeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOperadoraPlanoSaude = jsonData['idOperadoraPlanoSaude'];
		idColaborador = jsonData['idColaborador'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		beneficiario = FolhaPlanoSaudeDomain.getBeneficiario(jsonData['beneficiario']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		operadoraPlanoSaudeModel = jsonData['operadoraPlanoSaudeModel'] == null ? OperadoraPlanoSaudeModel() : OperadoraPlanoSaudeModel.fromJson(jsonData['operadoraPlanoSaudeModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOperadoraPlanoSaude'] = idOperadoraPlanoSaude != 0 ? idOperadoraPlanoSaude : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['beneficiario'] = FolhaPlanoSaudeDomain.setBeneficiario(beneficiario);
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['operadoraPlanoSaudeModel'] = operadoraPlanoSaudeModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOperadoraPlanoSaude = plutoRow.cells['idOperadoraPlanoSaude']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		beneficiario = plutoRow.cells['beneficiario']?.value != '' ? plutoRow.cells['beneficiario']?.value : '1=Somente Colaborador';
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		operadoraPlanoSaudeModel = OperadoraPlanoSaudeModel();
		operadoraPlanoSaudeModel?.nome = plutoRow.cells['operadoraPlanoSaudeModel']?.value;
	}	

	FolhaPlanoSaudeModel clone() {
		return FolhaPlanoSaudeModel(
			id: id,
			idOperadoraPlanoSaude: idOperadoraPlanoSaude,
			idColaborador: idColaborador,
			dataInicio: dataInicio,
			beneficiario: beneficiario,
		);			
	}

	
}