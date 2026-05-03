import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfeRodoviarioVeiculoModel {
	int? id;
	int? idMdfeRodoviario;
	String? codigoInterno;
	String? placa;
	String? renavam;
	int? tara;
	int? capacidadeKg;
	int? capacidadeM3;
	String? tipoRodado;
	String? tipoCarroceria;
	String? ufLicenciamento;
	String? proprietarioCpf;
	String? proprietarioCnpj;
	String? proprietarioRntrc;
	String? proprietarioNome;
	String? proprietarioIe;
	int? proprietarioTipo;
	MdfeRodoviarioModel? mdfeRodoviarioModel;

	MdfeRodoviarioVeiculoModel({
		this.id,
		this.idMdfeRodoviario,
		this.codigoInterno,
		this.placa,
		this.renavam,
		this.tara,
		this.capacidadeKg,
		this.capacidadeM3,
		this.tipoRodado,
		this.tipoCarroceria,
		this.ufLicenciamento,
		this.proprietarioCpf,
		this.proprietarioCnpj,
		this.proprietarioRntrc,
		this.proprietarioNome,
		this.proprietarioIe,
		this.proprietarioTipo,
		this.mdfeRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_interno',
		'placa',
		'renavam',
		'tara',
		'capacidade_kg',
		'capacidade_m3',
		'tipo_rodado',
		'tipo_carroceria',
		'uf_licenciamento',
		'proprietario_cpf',
		'proprietario_cnpj',
		'proprietario_rntrc',
		'proprietario_nome',
		'proprietario_ie',
		'proprietario_tipo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Interno',
		'Placa',
		'Renavam',
		'Tara',
		'Capacidade Kg',
		'Capacidade M3',
		'Tipo Rodado',
		'Tipo Carroceria',
		'Uf Licenciamento',
		'Proprietario Cpf',
		'Proprietario Cnpj',
		'Proprietario Rntrc',
		'Proprietario Nome',
		'Proprietario Ie',
		'Proprietario Tipo',
	];

	MdfeRodoviarioVeiculoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeRodoviario = jsonData['idMdfeRodoviario'];
		codigoInterno = jsonData['codigoInterno'];
		placa = jsonData['placa'];
		renavam = jsonData['renavam'];
		tara = jsonData['tara'];
		capacidadeKg = jsonData['capacidadeKg'];
		capacidadeM3 = jsonData['capacidadeM3'];
		tipoRodado = MdfeRodoviarioVeiculoDomain.getTipoRodado(jsonData['tipoRodado']);
		tipoCarroceria = MdfeRodoviarioVeiculoDomain.getTipoCarroceria(jsonData['tipoCarroceria']);
		ufLicenciamento = MdfeRodoviarioVeiculoDomain.getUfLicenciamento(jsonData['ufLicenciamento']);
		proprietarioCpf = jsonData['proprietarioCpf'];
		proprietarioCnpj = jsonData['proprietarioCnpj'];
		proprietarioRntrc = jsonData['proprietarioRntrc'];
		proprietarioNome = jsonData['proprietarioNome'];
		proprietarioIe = jsonData['proprietarioIe'];
		proprietarioTipo = jsonData['proprietarioTipo'];
		mdfeRodoviarioModel = jsonData['mdfeRodoviarioModel'] == null ? MdfeRodoviarioModel() : MdfeRodoviarioModel.fromJson(jsonData['mdfeRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeRodoviario'] = idMdfeRodoviario != 0 ? idMdfeRodoviario : null;
		jsonData['codigoInterno'] = codigoInterno;
		jsonData['placa'] = placa;
		jsonData['renavam'] = renavam;
		jsonData['tara'] = tara;
		jsonData['capacidadeKg'] = capacidadeKg;
		jsonData['capacidadeM3'] = capacidadeM3;
		jsonData['tipoRodado'] = MdfeRodoviarioVeiculoDomain.setTipoRodado(tipoRodado);
		jsonData['tipoCarroceria'] = MdfeRodoviarioVeiculoDomain.setTipoCarroceria(tipoCarroceria);
		jsonData['ufLicenciamento'] = MdfeRodoviarioVeiculoDomain.setUfLicenciamento(ufLicenciamento);
		jsonData['proprietarioCpf'] = Util.removeMask(proprietarioCpf);
		jsonData['proprietarioCnpj'] = Util.removeMask(proprietarioCnpj);
		jsonData['proprietarioRntrc'] = proprietarioRntrc;
		jsonData['proprietarioNome'] = proprietarioNome;
		jsonData['proprietarioIe'] = proprietarioIe;
		jsonData['proprietarioTipo'] = proprietarioTipo;
		jsonData['mdfeRodoviarioModel'] = mdfeRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeRodoviario = plutoRow.cells['idMdfeRodoviario']?.value;
		codigoInterno = plutoRow.cells['codigoInterno']?.value;
		placa = plutoRow.cells['placa']?.value;
		renavam = plutoRow.cells['renavam']?.value;
		tara = plutoRow.cells['tara']?.value;
		capacidadeKg = plutoRow.cells['capacidadeKg']?.value;
		capacidadeM3 = plutoRow.cells['capacidadeM3']?.value;
		tipoRodado = plutoRow.cells['tipoRodado']?.value != '' ? plutoRow.cells['tipoRodado']?.value : 'AAA';
		tipoCarroceria = plutoRow.cells['tipoCarroceria']?.value != '' ? plutoRow.cells['tipoCarroceria']?.value : 'AAA';
		ufLicenciamento = plutoRow.cells['ufLicenciamento']?.value != '' ? plutoRow.cells['ufLicenciamento']?.value : 'AC';
		proprietarioCpf = plutoRow.cells['proprietarioCpf']?.value;
		proprietarioCnpj = plutoRow.cells['proprietarioCnpj']?.value;
		proprietarioRntrc = plutoRow.cells['proprietarioRntrc']?.value;
		proprietarioNome = plutoRow.cells['proprietarioNome']?.value;
		proprietarioIe = plutoRow.cells['proprietarioIe']?.value;
		proprietarioTipo = plutoRow.cells['proprietarioTipo']?.value;
		mdfeRodoviarioModel = MdfeRodoviarioModel();
		mdfeRodoviarioModel?.codigoAgendamento = plutoRow.cells['mdfeRodoviarioModel']?.value;
	}	

	MdfeRodoviarioVeiculoModel clone() {
		return MdfeRodoviarioVeiculoModel(
			id: id,
			idMdfeRodoviario: idMdfeRodoviario,
			codigoInterno: codigoInterno,
			placa: placa,
			renavam: renavam,
			tara: tara,
			capacidadeKg: capacidadeKg,
			capacidadeM3: capacidadeM3,
			tipoRodado: tipoRodado,
			tipoCarroceria: tipoCarroceria,
			ufLicenciamento: ufLicenciamento,
			proprietarioCpf: proprietarioCpf,
			proprietarioCnpj: proprietarioCnpj,
			proprietarioRntrc: proprietarioRntrc,
			proprietarioNome: proprietarioNome,
			proprietarioIe: proprietarioIe,
			proprietarioTipo: proprietarioTipo,
		);			
	}

	
}