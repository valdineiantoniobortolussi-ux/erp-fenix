import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class SindicatoModel {
	int? id;
	String? nome;
	int? codigoBanco;
	int? codigoAgencia;
	String? contaBanco;
	String? codigoCedente;
	String? logradouro;
	String? numero;
	String? bairro;
	int? municipioIbge;
	String? uf;
	String? fone1;
	String? fone2;
	String? email;
	String? tipoSindicato;
	DateTime? dataBase;
	double? pisoSalarial;
	String? cnpj;
	String? classificacaoContabilConta;

	SindicatoModel({
		this.id,
		this.nome,
		this.codigoBanco,
		this.codigoAgencia,
		this.contaBanco,
		this.codigoCedente,
		this.logradouro,
		this.numero,
		this.bairro,
		this.municipioIbge,
		this.uf,
		this.fone1,
		this.fone2,
		this.email,
		this.tipoSindicato,
		this.dataBase,
		this.pisoSalarial,
		this.cnpj,
		this.classificacaoContabilConta,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'codigo_banco',
		'codigo_agencia',
		'conta_banco',
		'codigo_cedente',
		'logradouro',
		'numero',
		'bairro',
		'municipio_ibge',
		'uf',
		'fone1',
		'fone2',
		'email',
		'tipo_sindicato',
		'data_base',
		'piso_salarial',
		'cnpj',
		'classificacao_contabil_conta',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Codigo Banco',
		'Codigo Agencia',
		'Conta Banco',
		'Codigo Cedente',
		'Logradouro',
		'Numero',
		'Bairro',
		'Municipio Ibge',
		'Uf',
		'Fone1',
		'Fone2',
		'Email',
		'Tipo Sindicato',
		'Data Base',
		'Piso Salarial',
		'Cnpj',
		'Classificacao Contabil Conta',
	];

	SindicatoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		codigoBanco = jsonData['codigoBanco'];
		codigoAgencia = jsonData['codigoAgencia'];
		contaBanco = jsonData['contaBanco'];
		codigoCedente = jsonData['codigoCedente'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		bairro = jsonData['bairro'];
		municipioIbge = jsonData['municipioIbge'];
		uf = SindicatoDomain.getUf(jsonData['uf']);
		fone1 = jsonData['fone1'];
		fone2 = jsonData['fone2'];
		email = jsonData['email'];
		tipoSindicato = SindicatoDomain.getTipoSindicato(jsonData['tipoSindicato']);
		dataBase = jsonData['dataBase'] != null ? DateTime.tryParse(jsonData['dataBase']) : null;
		pisoSalarial = jsonData['pisoSalarial']?.toDouble();
		cnpj = jsonData['cnpj'];
		classificacaoContabilConta = jsonData['classificacaoContabilConta'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['codigoBanco'] = codigoBanco;
		jsonData['codigoAgencia'] = codigoAgencia;
		jsonData['contaBanco'] = contaBanco;
		jsonData['codigoCedente'] = codigoCedente;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['bairro'] = bairro;
		jsonData['municipioIbge'] = municipioIbge;
		jsonData['uf'] = SindicatoDomain.setUf(uf);
		jsonData['fone1'] = Util.removeMask(fone1);
		jsonData['fone2'] = Util.removeMask(fone2);
		jsonData['email'] = email;
		jsonData['tipoSindicato'] = SindicatoDomain.setTipoSindicato(tipoSindicato);
		jsonData['dataBase'] = dataBase != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBase!) : null;
		jsonData['pisoSalarial'] = pisoSalarial;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['classificacaoContabilConta'] = classificacaoContabilConta;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		codigoBanco = plutoRow.cells['codigoBanco']?.value;
		codigoAgencia = plutoRow.cells['codigoAgencia']?.value;
		contaBanco = plutoRow.cells['contaBanco']?.value;
		codigoCedente = plutoRow.cells['codigoCedente']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		municipioIbge = plutoRow.cells['municipioIbge']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		fone1 = plutoRow.cells['fone1']?.value;
		fone2 = plutoRow.cells['fone2']?.value;
		email = plutoRow.cells['email']?.value;
		tipoSindicato = plutoRow.cells['tipoSindicato']?.value != '' ? plutoRow.cells['tipoSindicato']?.value : 'Patronal';
		dataBase = Util.stringToDate(plutoRow.cells['dataBase']?.value);
		pisoSalarial = plutoRow.cells['pisoSalarial']?.value?.toDouble();
		cnpj = plutoRow.cells['cnpj']?.value;
		classificacaoContabilConta = plutoRow.cells['classificacaoContabilConta']?.value;
	}	

	SindicatoModel clone() {
		return SindicatoModel(
			id: id,
			nome: nome,
			codigoBanco: codigoBanco,
			codigoAgencia: codigoAgencia,
			contaBanco: contaBanco,
			codigoCedente: codigoCedente,
			logradouro: logradouro,
			numero: numero,
			bairro: bairro,
			municipioIbge: municipioIbge,
			uf: uf,
			fone1: fone1,
			fone2: fone2,
			email: email,
			tipoSindicato: tipoSindicato,
			dataBase: dataBase,
			pisoSalarial: pisoSalarial,
			cnpj: cnpj,
			classificacaoContabilConta: classificacaoContabilConta,
		);			
	}

	
}