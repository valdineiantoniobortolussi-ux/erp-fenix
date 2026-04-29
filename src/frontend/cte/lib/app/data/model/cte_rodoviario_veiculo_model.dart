import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteRodoviarioVeiculoModel {
	int? id;
	int? idCteRodoviario;
	String? codigoInterno;
	String? renavam;
	String? placa;
	int? tara;
	int? capacidadeKg;
	int? capacidadeM3;
	String? tipoPropriedade;
	String? tipoVeiculo;
	String? tipoRodado;
	String? tipoCarroceria;
	String? uf;
	String? proprietarioCpf;
	String? proprietarioCnpj;
	String? proprietarioRntrc;
	String? proprietarioNome;
	String? proprietarioIe;
	String? proprietarioUf;
	String? proprietarioTipo;
	CteRodoviarioModel? cteRodoviarioModel;

	CteRodoviarioVeiculoModel({
		this.id,
		this.idCteRodoviario,
		this.codigoInterno,
		this.renavam,
		this.placa,
		this.tara,
		this.capacidadeKg,
		this.capacidadeM3,
		this.tipoPropriedade,
		this.tipoVeiculo,
		this.tipoRodado,
		this.tipoCarroceria,
		this.uf,
		this.proprietarioCpf,
		this.proprietarioCnpj,
		this.proprietarioRntrc,
		this.proprietarioNome,
		this.proprietarioIe,
		this.proprietarioUf,
		this.proprietarioTipo,
		this.cteRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_interno',
		'renavam',
		'placa',
		'tara',
		'capacidade_kg',
		'capacidade_m3',
		'tipo_propriedade',
		'tipo_veiculo',
		'tipo_rodado',
		'tipo_carroceria',
		'uf',
		'proprietario_cpf',
		'proprietario_cnpj',
		'proprietario_rntrc',
		'proprietario_nome',
		'proprietario_ie',
		'proprietario_uf',
		'proprietario_tipo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Interno',
		'Renavam',
		'Placa',
		'Tara',
		'Capacidade Kg',
		'Capacidade M3',
		'Tipo Propriedade',
		'Tipo Veiculo',
		'Tipo Rodado',
		'Tipo Carroceria',
		'Uf',
		'Proprietario Cpf',
		'Proprietario Cnpj',
		'Proprietario Rntrc',
		'Proprietario Nome',
		'Proprietario Ie',
		'Proprietario Uf',
		'Proprietario Tipo',
	];

	CteRodoviarioVeiculoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteRodoviario = jsonData['idCteRodoviario'];
		codigoInterno = jsonData['codigoInterno'];
		renavam = jsonData['renavam'];
		placa = jsonData['placa'];
		tara = jsonData['tara'];
		capacidadeKg = jsonData['capacidadeKg'];
		capacidadeM3 = jsonData['capacidadeM3'];
		tipoPropriedade = CteRodoviarioVeiculoDomain.getTipoPropriedade(jsonData['tipoPropriedade']);
		tipoVeiculo = CteRodoviarioVeiculoDomain.getTipoVeiculo(jsonData['tipoVeiculo']);
		tipoRodado = CteRodoviarioVeiculoDomain.getTipoRodado(jsonData['tipoRodado']);
		tipoCarroceria = CteRodoviarioVeiculoDomain.getTipoCarroceria(jsonData['tipoCarroceria']);
		uf = CteRodoviarioVeiculoDomain.getUf(jsonData['uf']);
		proprietarioCpf = jsonData['proprietarioCpf'];
		proprietarioCnpj = jsonData['proprietarioCnpj'];
		proprietarioRntrc = jsonData['proprietarioRntrc'];
		proprietarioNome = jsonData['proprietarioNome'];
		proprietarioIe = jsonData['proprietarioIe'];
		proprietarioUf = CteRodoviarioVeiculoDomain.getProprietarioUf(jsonData['proprietarioUf']);
		proprietarioTipo = CteRodoviarioVeiculoDomain.getProprietarioTipo(jsonData['proprietarioTipo']);
		cteRodoviarioModel = jsonData['cteRodoviarioModel'] == null ? CteRodoviarioModel() : CteRodoviarioModel.fromJson(jsonData['cteRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteRodoviario'] = idCteRodoviario != 0 ? idCteRodoviario : null;
		jsonData['codigoInterno'] = codigoInterno;
		jsonData['renavam'] = renavam;
		jsonData['placa'] = placa;
		jsonData['tara'] = tara;
		jsonData['capacidadeKg'] = capacidadeKg;
		jsonData['capacidadeM3'] = capacidadeM3;
		jsonData['tipoPropriedade'] = CteRodoviarioVeiculoDomain.setTipoPropriedade(tipoPropriedade);
		jsonData['tipoVeiculo'] = CteRodoviarioVeiculoDomain.setTipoVeiculo(tipoVeiculo);
		jsonData['tipoRodado'] = CteRodoviarioVeiculoDomain.setTipoRodado(tipoRodado);
		jsonData['tipoCarroceria'] = CteRodoviarioVeiculoDomain.setTipoCarroceria(tipoCarroceria);
		jsonData['uf'] = CteRodoviarioVeiculoDomain.setUf(uf);
		jsonData['proprietarioCpf'] = Util.removeMask(proprietarioCpf);
		jsonData['proprietarioCnpj'] = Util.removeMask(proprietarioCnpj);
		jsonData['proprietarioRntrc'] = proprietarioRntrc;
		jsonData['proprietarioNome'] = proprietarioNome;
		jsonData['proprietarioIe'] = proprietarioIe;
		jsonData['proprietarioUf'] = CteRodoviarioVeiculoDomain.setProprietarioUf(proprietarioUf);
		jsonData['proprietarioTipo'] = CteRodoviarioVeiculoDomain.setProprietarioTipo(proprietarioTipo);
		jsonData['cteRodoviarioModel'] = cteRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteRodoviario = plutoRow.cells['idCteRodoviario']?.value;
		codigoInterno = plutoRow.cells['codigoInterno']?.value;
		renavam = plutoRow.cells['renavam']?.value;
		placa = plutoRow.cells['placa']?.value;
		tara = plutoRow.cells['tara']?.value;
		capacidadeKg = plutoRow.cells['capacidadeKg']?.value;
		capacidadeM3 = plutoRow.cells['capacidadeM3']?.value;
		tipoPropriedade = plutoRow.cells['tipoPropriedade']?.value != '' ? plutoRow.cells['tipoPropriedade']?.value : 'AAA';
		tipoVeiculo = plutoRow.cells['tipoVeiculo']?.value != '' ? plutoRow.cells['tipoVeiculo']?.value : 'AAA';
		tipoRodado = plutoRow.cells['tipoRodado']?.value != '' ? plutoRow.cells['tipoRodado']?.value : 'AAA';
		tipoCarroceria = plutoRow.cells['tipoCarroceria']?.value != '' ? plutoRow.cells['tipoCarroceria']?.value : 'AAA';
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		proprietarioCpf = plutoRow.cells['proprietarioCpf']?.value;
		proprietarioCnpj = plutoRow.cells['proprietarioCnpj']?.value;
		proprietarioRntrc = plutoRow.cells['proprietarioRntrc']?.value;
		proprietarioNome = plutoRow.cells['proprietarioNome']?.value;
		proprietarioIe = plutoRow.cells['proprietarioIe']?.value;
		proprietarioUf = plutoRow.cells['proprietarioUf']?.value != '' ? plutoRow.cells['proprietarioUf']?.value : 'AC';
		proprietarioTipo = plutoRow.cells['proprietarioTipo']?.value != '' ? plutoRow.cells['proprietarioTipo']?.value : 'AAA';
		cteRodoviarioModel = CteRodoviarioModel();
		cteRodoviarioModel?.rntrc = plutoRow.cells['cteRodoviarioModel']?.value;
	}	

	CteRodoviarioVeiculoModel clone() {
		return CteRodoviarioVeiculoModel(
			id: id,
			idCteRodoviario: idCteRodoviario,
			codigoInterno: codigoInterno,
			renavam: renavam,
			placa: placa,
			tara: tara,
			capacidadeKg: capacidadeKg,
			capacidadeM3: capacidadeM3,
			tipoPropriedade: tipoPropriedade,
			tipoVeiculo: tipoVeiculo,
			tipoRodado: tipoRodado,
			tipoCarroceria: tipoCarroceria,
			uf: uf,
			proprietarioCpf: proprietarioCpf,
			proprietarioCnpj: proprietarioCnpj,
			proprietarioRntrc: proprietarioRntrc,
			proprietarioNome: proprietarioNome,
			proprietarioIe: proprietarioIe,
			proprietarioUf: proprietarioUf,
			proprietarioTipo: proprietarioTipo,
		);			
	}

	
}