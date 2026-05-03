import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';

class MdfeInformacaoSeguroModel {
	int? id;
	int? idMdfeCabecalho;
	int? responsavel;
	String? cnpjCpf;
	String? seguradora;
	String? cnpjSeguradora;
	String? apolice;
	String? averbacao;

	MdfeInformacaoSeguroModel({
		this.id,
		this.idMdfeCabecalho,
		this.responsavel,
		this.cnpjCpf,
		this.seguradora,
		this.cnpjSeguradora,
		this.apolice,
		this.averbacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'responsavel',
		'cnpj_cpf',
		'seguradora',
		'cnpj_seguradora',
		'apolice',
		'averbacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Responsavel',
		'Cnpj Cpf',
		'Seguradora',
		'Cnpj Seguradora',
		'Apolice',
		'Averbacao',
	];

	MdfeInformacaoSeguroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		responsavel = jsonData['responsavel'];
		cnpjCpf = jsonData['cnpjCpf'];
		seguradora = jsonData['seguradora'];
		cnpjSeguradora = jsonData['cnpjSeguradora'];
		apolice = jsonData['apolice'];
		averbacao = jsonData['averbacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['responsavel'] = responsavel;
		jsonData['cnpjCpf'] = Util.removeMask(cnpjCpf);
		jsonData['seguradora'] = seguradora;
		jsonData['cnpjSeguradora'] = Util.removeMask(cnpjSeguradora);
		jsonData['apolice'] = apolice;
		jsonData['averbacao'] = averbacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		responsavel = plutoRow.cells['responsavel']?.value;
		cnpjCpf = plutoRow.cells['cnpjCpf']?.value;
		seguradora = plutoRow.cells['seguradora']?.value;
		cnpjSeguradora = plutoRow.cells['cnpjSeguradora']?.value;
		apolice = plutoRow.cells['apolice']?.value;
		averbacao = plutoRow.cells['averbacao']?.value;
	}	

	MdfeInformacaoSeguroModel clone() {
		return MdfeInformacaoSeguroModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			responsavel: responsavel,
			cnpjCpf: cnpjCpf,
			seguradora: seguradora,
			cnpjSeguradora: cnpjSeguradora,
			apolice: apolice,
			averbacao: averbacao,
		);			
	}

	
}