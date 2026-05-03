import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaFisicaModel {
	int? id;
	int? idPessoa;
	int? idNivelFormacao;
	int? idEstadoCivil;
	String? cpf;
	String? rg;
	String? orgaoRg;
	DateTime? dataEmissaoRg;
	DateTime? dataNascimento;
	String? sexo;
	String? raca;
	String? nacionalidade;
	String? naturalidade;
	String? nomePai;
	String? nomeMae;
	EstadoCivilModel? estadoCivilModel;
	NivelFormacaoModel? nivelFormacaoModel;

	PessoaFisicaModel({
		this.id,
		this.idPessoa,
		this.idNivelFormacao,
		this.idEstadoCivil,
		this.cpf,
		this.rg,
		this.orgaoRg,
		this.dataEmissaoRg,
		this.dataNascimento,
		this.sexo,
		this.raca,
		this.nacionalidade,
		this.naturalidade,
		this.nomePai,
		this.nomeMae,
		this.estadoCivilModel,
		this.nivelFormacaoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cpf',
		'rg',
		'orgao_rg',
		'data_emissao_rg',
		'data_nascimento',
		'sexo',
		'raca',
		'nacionalidade',
		'naturalidade',
		'nome_pai',
		'nome_mae',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cpf',
		'Rg',
		'Orgao Rg',
		'Data Emissao Rg',
		'Data Nascimento',
		'Sexo',
		'Raca',
		'Nacionalidade',
		'Naturalidade',
		'Nome Pai',
		'Nome Mae',
	];

	PessoaFisicaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		idNivelFormacao = jsonData['idNivelFormacao'];
		idEstadoCivil = jsonData['idEstadoCivil'];
		cpf = jsonData['cpf'];
		rg = jsonData['rg'];
		orgaoRg = jsonData['orgaoRg'];
		dataEmissaoRg = jsonData['dataEmissaoRg'] != null ? DateTime.tryParse(jsonData['dataEmissaoRg']) : null;
		dataNascimento = jsonData['dataNascimento'] != null ? DateTime.tryParse(jsonData['dataNascimento']) : null;
		sexo = PessoaFisicaDomain.getSexo(jsonData['sexo']);
		raca = PessoaFisicaDomain.getRaca(jsonData['raca']);
		nacionalidade = jsonData['nacionalidade'];
		naturalidade = jsonData['naturalidade'];
		nomePai = jsonData['nomePai'];
		nomeMae = jsonData['nomeMae'];
		estadoCivilModel = jsonData['estadoCivilModel'] == null ? EstadoCivilModel() : EstadoCivilModel.fromJson(jsonData['estadoCivilModel']);
		nivelFormacaoModel = jsonData['nivelFormacaoModel'] == null ? NivelFormacaoModel() : NivelFormacaoModel.fromJson(jsonData['nivelFormacaoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['idNivelFormacao'] = idNivelFormacao != 0 ? idNivelFormacao : null;
		jsonData['idEstadoCivil'] = idEstadoCivil != 0 ? idEstadoCivil : null;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['rg'] = rg;
		jsonData['orgaoRg'] = orgaoRg;
		jsonData['dataEmissaoRg'] = dataEmissaoRg != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissaoRg!) : null;
		jsonData['dataNascimento'] = dataNascimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataNascimento!) : null;
		jsonData['sexo'] = PessoaFisicaDomain.setSexo(sexo);
		jsonData['raca'] = PessoaFisicaDomain.setRaca(raca);
		jsonData['nacionalidade'] = nacionalidade;
		jsonData['naturalidade'] = naturalidade;
		jsonData['nomePai'] = nomePai;
		jsonData['nomeMae'] = nomeMae;
		jsonData['estadoCivilModel'] = estadoCivilModel?.toJson;
		jsonData['nivelFormacaoModel'] = nivelFormacaoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		idNivelFormacao = plutoRow.cells['idNivelFormacao']?.value;
		idEstadoCivil = plutoRow.cells['idEstadoCivil']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		rg = plutoRow.cells['rg']?.value;
		orgaoRg = plutoRow.cells['orgaoRg']?.value;
		dataEmissaoRg = Util.stringToDate(plutoRow.cells['dataEmissaoRg']?.value);
		dataNascimento = Util.stringToDate(plutoRow.cells['dataNascimento']?.value);
		sexo = plutoRow.cells['sexo']?.value != '' ? plutoRow.cells['sexo']?.value : 'Masculino';
		raca = plutoRow.cells['raca']?.value != '' ? plutoRow.cells['raca']?.value : 'Branco';
		nacionalidade = plutoRow.cells['nacionalidade']?.value;
		naturalidade = plutoRow.cells['naturalidade']?.value;
		nomePai = plutoRow.cells['nomePai']?.value;
		nomeMae = plutoRow.cells['nomeMae']?.value;
		estadoCivilModel = EstadoCivilModel();
		estadoCivilModel?.nome = plutoRow.cells['estadoCivilModel']?.value;
		nivelFormacaoModel = NivelFormacaoModel();
		nivelFormacaoModel?.nome = plutoRow.cells['nivelFormacaoModel']?.value;
	}	

	PessoaFisicaModel clone() {
		return PessoaFisicaModel(
			id: id,
			idPessoa: idPessoa,
			idNivelFormacao: idNivelFormacao,
			idEstadoCivil: idEstadoCivil,
			cpf: cpf,
			rg: rg,
			orgaoRg: orgaoRg,
			dataEmissaoRg: dataEmissaoRg,
			dataNascimento: dataNascimento,
			sexo: sexo,
			raca: raca,
			nacionalidade: nacionalidade,
			naturalidade: naturalidade,
			nomePai: nomePai,
			nomeMae: nomeMae,
		);			
	}

	
}