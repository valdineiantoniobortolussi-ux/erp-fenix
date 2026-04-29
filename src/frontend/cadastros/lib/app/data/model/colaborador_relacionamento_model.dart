import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class ColaboradorRelacionamentoModel {
	int? id;
	int? idColaborador;
	int? idTipoRelacionamento;
	String? nome;
	DateTime? dataNascimento;
	String? cpf;
	String? registroMatricula;
	String? registroCartorio;
	String? registroCartorioNumero;
	String? registroNumeroLivro;
	String? registroNumeroFolha;
	DateTime? dataEntregaDocumento;
	String? salarioFamilia;
	int? salarioFamiliaIdadeLimite;
	DateTime? salarioFamiliaDataFim;
	int? impostoRendaIdadeLimite;
	int? impostoRendaDataFim;
	TipoRelacionamentoModel? tipoRelacionamentoModel;

	ColaboradorRelacionamentoModel({
		this.id,
		this.idColaborador,
		this.idTipoRelacionamento,
		this.nome,
		this.dataNascimento,
		this.cpf,
		this.registroMatricula,
		this.registroCartorio,
		this.registroCartorioNumero,
		this.registroNumeroLivro,
		this.registroNumeroFolha,
		this.dataEntregaDocumento,
		this.salarioFamilia,
		this.salarioFamiliaIdadeLimite,
		this.salarioFamiliaDataFim,
		this.impostoRendaIdadeLimite,
		this.impostoRendaDataFim,
		this.tipoRelacionamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'data_nascimento',
		'cpf',
		'registro_matricula',
		'registro_cartorio',
		'registro_cartorio_numero',
		'registro_numero_livro',
		'registro_numero_folha',
		'data_entrega_documento',
		'salario_familia',
		'salario_familia_idade_limite',
		'salario_familia_data_fim',
		'imposto_renda_idade_limite',
		'imposto_renda_data_fim',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Data Nascimento',
		'Cpf',
		'Registro Matricula',
		'Registro Cartorio',
		'Registro Cartorio Numero',
		'Registro Numero Livro',
		'Registro Numero Folha',
		'Data Entrega Documento',
		'Salario Familia',
		'Salario Familia Idade Limite',
		'Salario Familia Data Fim',
		'Imposto Renda Idade Limite',
		'Imposto Renda Data Fim',
	];

	ColaboradorRelacionamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		idTipoRelacionamento = jsonData['idTipoRelacionamento'];
		nome = jsonData['nome'];
		dataNascimento = jsonData['dataNascimento'] != null ? DateTime.tryParse(jsonData['dataNascimento']) : null;
		cpf = jsonData['cpf'];
		registroMatricula = jsonData['registroMatricula'];
		registroCartorio = jsonData['registroCartorio'];
		registroCartorioNumero = jsonData['registroCartorioNumero'];
		registroNumeroLivro = jsonData['registroNumeroLivro'];
		registroNumeroFolha = jsonData['registroNumeroFolha'];
		dataEntregaDocumento = jsonData['dataEntregaDocumento'] != null ? DateTime.tryParse(jsonData['dataEntregaDocumento']) : null;
		salarioFamilia = ColaboradorRelacionamentoDomain.getSalarioFamilia(jsonData['salarioFamilia']);
		salarioFamiliaIdadeLimite = jsonData['salarioFamiliaIdadeLimite'];
		salarioFamiliaDataFim = jsonData['salarioFamiliaDataFim'] != null ? DateTime.tryParse(jsonData['salarioFamiliaDataFim']) : null;
		impostoRendaIdadeLimite = jsonData['impostoRendaIdadeLimite'];
		impostoRendaDataFim = jsonData['impostoRendaDataFim'];
		tipoRelacionamentoModel = jsonData['tipoRelacionamentoModel'] == null ? TipoRelacionamentoModel() : TipoRelacionamentoModel.fromJson(jsonData['tipoRelacionamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idTipoRelacionamento'] = idTipoRelacionamento != 0 ? idTipoRelacionamento : null;
		jsonData['nome'] = nome;
		jsonData['dataNascimento'] = dataNascimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataNascimento!) : null;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['registroMatricula'] = registroMatricula;
		jsonData['registroCartorio'] = registroCartorio;
		jsonData['registroCartorioNumero'] = registroCartorioNumero;
		jsonData['registroNumeroLivro'] = registroNumeroLivro;
		jsonData['registroNumeroFolha'] = registroNumeroFolha;
		jsonData['dataEntregaDocumento'] = dataEntregaDocumento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEntregaDocumento!) : null;
		jsonData['salarioFamilia'] = ColaboradorRelacionamentoDomain.setSalarioFamilia(salarioFamilia);
		jsonData['salarioFamiliaIdadeLimite'] = salarioFamiliaIdadeLimite;
		jsonData['salarioFamiliaDataFim'] = salarioFamiliaDataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(salarioFamiliaDataFim!) : null;
		jsonData['impostoRendaIdadeLimite'] = impostoRendaIdadeLimite;
		jsonData['impostoRendaDataFim'] = impostoRendaDataFim;
		jsonData['tipoRelacionamentoModel'] = tipoRelacionamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idTipoRelacionamento = plutoRow.cells['idTipoRelacionamento']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataNascimento = Util.stringToDate(plutoRow.cells['dataNascimento']?.value);
		cpf = plutoRow.cells['cpf']?.value;
		registroMatricula = plutoRow.cells['registroMatricula']?.value;
		registroCartorio = plutoRow.cells['registroCartorio']?.value;
		registroCartorioNumero = plutoRow.cells['registroCartorioNumero']?.value;
		registroNumeroLivro = plutoRow.cells['registroNumeroLivro']?.value;
		registroNumeroFolha = plutoRow.cells['registroNumeroFolha']?.value;
		dataEntregaDocumento = Util.stringToDate(plutoRow.cells['dataEntregaDocumento']?.value);
		salarioFamilia = plutoRow.cells['salarioFamilia']?.value != '' ? plutoRow.cells['salarioFamilia']?.value : 'Sim';
		salarioFamiliaIdadeLimite = plutoRow.cells['salarioFamiliaIdadeLimite']?.value;
		salarioFamiliaDataFim = Util.stringToDate(plutoRow.cells['salarioFamiliaDataFim']?.value);
		impostoRendaIdadeLimite = plutoRow.cells['impostoRendaIdadeLimite']?.value;
		impostoRendaDataFim = plutoRow.cells['impostoRendaDataFim']?.value;
		tipoRelacionamentoModel = TipoRelacionamentoModel();
		tipoRelacionamentoModel?.nome = plutoRow.cells['tipoRelacionamentoModel']?.value;
	}	

	ColaboradorRelacionamentoModel clone() {
		return ColaboradorRelacionamentoModel(
			id: id,
			idColaborador: idColaborador,
			idTipoRelacionamento: idTipoRelacionamento,
			nome: nome,
			dataNascimento: dataNascimento,
			cpf: cpf,
			registroMatricula: registroMatricula,
			registroCartorio: registroCartorio,
			registroCartorioNumero: registroCartorioNumero,
			registroNumeroLivro: registroNumeroLivro,
			registroNumeroFolha: registroNumeroFolha,
			dataEntregaDocumento: dataEntregaDocumento,
			salarioFamilia: salarioFamilia,
			salarioFamiliaIdadeLimite: salarioFamiliaIdadeLimite,
			salarioFamiliaDataFim: salarioFamiliaDataFim,
			impostoRendaIdadeLimite: impostoRendaIdadeLimite,
			impostoRendaDataFim: impostoRendaDataFim,
		);			
	}

	
}