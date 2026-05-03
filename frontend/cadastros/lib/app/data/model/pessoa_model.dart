import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaModel {
	int? id;
	String? nome;
	String? tipo;
	String? site;
	String? email;
	String? ehCliente;
	String? ehFornecedor;
	String? ehTransportadora;
	String? ehColaborador;
	String? ehContador;
	PessoaJuridicaModel? pessoaJuridicaModel;
	FornecedorModel? fornecedorModel;
	ClienteModel? clienteModel;
	PessoaFisicaModel? pessoaFisicaModel;
	TransportadoraModel? transportadoraModel;
	ContadorModel? contadorModel;
	List<PessoaContatoModel>? pessoaContatoModelList;
	List<PessoaTelefoneModel>? pessoaTelefoneModelList;
	List<PessoaEnderecoModel>? pessoaEnderecoModelList;

	PessoaModel({
		this.id,
		this.nome,
		this.tipo,
		this.site,
		this.email,
		this.ehCliente,
		this.ehFornecedor,
		this.ehTransportadora,
		this.ehColaborador,
		this.ehContador,
		this.pessoaJuridicaModel,
		this.fornecedorModel,
		this.clienteModel,
		this.pessoaFisicaModel,
		this.transportadoraModel,
		this.contadorModel,
		this.pessoaContatoModelList,
		this.pessoaTelefoneModelList,
		this.pessoaEnderecoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'tipo',
		'site',
		'email',
		'eh_cliente',
		'eh_fornecedor',
		'eh_transportadora',
		'eh_colaborador',
		'eh_contador',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Tipo',
		'Site',
		'Email',
		'Eh Cliente',
		'Eh Fornecedor',
		'Eh Transportadora',
		'Eh Colaborador',
		'Eh Contador',
	];

	PessoaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		tipo = PessoaDomain.getTipo(jsonData['tipo']);
		site = jsonData['site'];
		email = jsonData['email'];
		ehCliente = PessoaDomain.getEhCliente(jsonData['ehCliente']);
		ehFornecedor = PessoaDomain.getEhFornecedor(jsonData['ehFornecedor']);
		ehTransportadora = PessoaDomain.getEhTransportadora(jsonData['ehTransportadora']);
		ehColaborador = PessoaDomain.getEhColaborador(jsonData['ehColaborador']);
		ehContador = PessoaDomain.getEhContador(jsonData['ehContador']);
		pessoaJuridicaModel = jsonData['pessoaJuridicaModel'] == null ? PessoaJuridicaModel() : PessoaJuridicaModel.fromJson(jsonData['pessoaJuridicaModel']);
		fornecedorModel = jsonData['fornecedorModel'] == null ? FornecedorModel() : FornecedorModel.fromJson(jsonData['fornecedorModel']);
		clienteModel = jsonData['clienteModel'] == null ? ClienteModel(tabelaPrecoModel: TabelaPrecoModel(), ) : ClienteModel.fromJson(jsonData['clienteModel']);
		pessoaFisicaModel = jsonData['pessoaFisicaModel'] == null ? PessoaFisicaModel(estadoCivilModel: EstadoCivilModel(), nivelFormacaoModel: NivelFormacaoModel(), ) : PessoaFisicaModel.fromJson(jsonData['pessoaFisicaModel']);
		transportadoraModel = jsonData['transportadoraModel'] == null ? TransportadoraModel() : TransportadoraModel.fromJson(jsonData['transportadoraModel']);
		contadorModel = jsonData['contadorModel'] == null ? ContadorModel() : ContadorModel.fromJson(jsonData['contadorModel']);
		pessoaContatoModelList = (jsonData['pessoaContatoModelList'] as Iterable?)?.map((m) => PessoaContatoModel.fromJson(m)).toList() ?? [];
		pessoaTelefoneModelList = (jsonData['pessoaTelefoneModelList'] as Iterable?)?.map((m) => PessoaTelefoneModel.fromJson(m)).toList() ?? [];
		pessoaEnderecoModelList = (jsonData['pessoaEnderecoModelList'] as Iterable?)?.map((m) => PessoaEnderecoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['tipo'] = PessoaDomain.setTipo(tipo);
		jsonData['site'] = site;
		jsonData['email'] = email;
		jsonData['ehCliente'] = PessoaDomain.setEhCliente(ehCliente);
		jsonData['ehFornecedor'] = PessoaDomain.setEhFornecedor(ehFornecedor);
		jsonData['ehTransportadora'] = PessoaDomain.setEhTransportadora(ehTransportadora);
		jsonData['ehColaborador'] = PessoaDomain.setEhColaborador(ehColaborador);
		jsonData['ehContador'] = PessoaDomain.setEhContador(ehContador);
		jsonData['pessoaJuridicaModel'] = pessoaJuridicaModel?.toJson;
		jsonData['fornecedorModel'] = fornecedorModel?.toJson;
		jsonData['clienteModel'] = clienteModel?.toJson;
		jsonData['pessoaFisicaModel'] = pessoaFisicaModel?.toJson;
		jsonData['transportadoraModel'] = transportadoraModel?.toJson;
		jsonData['contadorModel'] = contadorModel?.toJson;
		
		var pessoaContatoModelLocalList = []; 
		for (PessoaContatoModel object in pessoaContatoModelList ?? []) { 
			pessoaContatoModelLocalList.add(object.toJson); 
		}
		jsonData['pessoaContatoModelList'] = pessoaContatoModelLocalList;
		
		var pessoaTelefoneModelLocalList = []; 
		for (PessoaTelefoneModel object in pessoaTelefoneModelList ?? []) { 
			pessoaTelefoneModelLocalList.add(object.toJson); 
		}
		jsonData['pessoaTelefoneModelList'] = pessoaTelefoneModelLocalList;
		
		var pessoaEnderecoModelLocalList = []; 
		for (PessoaEnderecoModel object in pessoaEnderecoModelList ?? []) { 
			pessoaEnderecoModelLocalList.add(object.toJson); 
		}
		jsonData['pessoaEnderecoModelList'] = pessoaEnderecoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Física';
		site = plutoRow.cells['site']?.value;
		email = plutoRow.cells['email']?.value;
		ehCliente = plutoRow.cells['ehCliente']?.value != '' ? plutoRow.cells['ehCliente']?.value : 'Sim';
		ehFornecedor = plutoRow.cells['ehFornecedor']?.value != '' ? plutoRow.cells['ehFornecedor']?.value : 'Sim';
		ehTransportadora = plutoRow.cells['ehTransportadora']?.value != '' ? plutoRow.cells['ehTransportadora']?.value : 'Sim';
		ehColaborador = plutoRow.cells['ehColaborador']?.value != '' ? plutoRow.cells['ehColaborador']?.value : 'Sim';
		ehContador = plutoRow.cells['ehContador']?.value != '' ? plutoRow.cells['ehContador']?.value : 'Sim';
		pessoaJuridicaModel = PessoaJuridicaModel();
		fornecedorModel = FornecedorModel();
		clienteModel = ClienteModel(tabelaPrecoModel: TabelaPrecoModel(), );
		pessoaFisicaModel = PessoaFisicaModel(estadoCivilModel: EstadoCivilModel(), nivelFormacaoModel: NivelFormacaoModel(), );
		transportadoraModel = TransportadoraModel();
		contadorModel = ContadorModel();
		pessoaContatoModelList = [];
		pessoaTelefoneModelList = [];
		pessoaEnderecoModelList = [];
	}	

	PessoaModel clone() {
		return PessoaModel(
			id: id,
			nome: nome,
			tipo: tipo,
			site: site,
			email: email,
			ehCliente: ehCliente,
			ehFornecedor: ehFornecedor,
			ehTransportadora: ehTransportadora,
			ehColaborador: ehColaborador,
			ehContador: ehContador,
			pessoaJuridicaModel: PessoaJuridicaModel(
				id: pessoaJuridicaModel?.id,
				idPessoa: pessoaJuridicaModel?.idPessoa,
				cnpj: pessoaJuridicaModel?.cnpj,
				nomeFantasia: pessoaJuridicaModel?.nomeFantasia,
				inscricaoEstadual: pessoaJuridicaModel?.inscricaoEstadual,
				inscricaoMunicipal: pessoaJuridicaModel?.inscricaoMunicipal,
				dataConstituicao: pessoaJuridicaModel?.dataConstituicao,
				tipoRegime: pessoaJuridicaModel?.tipoRegime,
				crt: pessoaJuridicaModel?.crt,
			),
			fornecedorModel: FornecedorModel(
				id: fornecedorModel?.id,
				idPessoa: fornecedorModel?.idPessoa,
				desde: fornecedorModel?.desde,
				dataCadastro: fornecedorModel?.dataCadastro,
				observacao: fornecedorModel?.observacao,
			),
			clienteModel: ClienteModel(
				id: clienteModel?.id,
				idPessoa: clienteModel?.idPessoa,
				idTabelaPreco: clienteModel?.idTabelaPreco,
				desde: clienteModel?.desde,
				dataCadastro: clienteModel?.dataCadastro,
				taxaDesconto: clienteModel?.taxaDesconto,
				limiteCredito: clienteModel?.limiteCredito,
				observacao: clienteModel?.observacao,
				tabelaPrecoModel: TabelaPrecoModel(
					id: clienteModel?.tabelaPrecoModel?.id,
					nome: clienteModel?.tabelaPrecoModel?.nome,
					principal: clienteModel?.tabelaPrecoModel?.principal,
					coeficiente: clienteModel?.tabelaPrecoModel?.coeficiente,
				),
			),
			pessoaFisicaModel: PessoaFisicaModel(
				id: pessoaFisicaModel?.id,
				idPessoa: pessoaFisicaModel?.idPessoa,
				idNivelFormacao: pessoaFisicaModel?.idNivelFormacao,
				idEstadoCivil: pessoaFisicaModel?.idEstadoCivil,
				cpf: pessoaFisicaModel?.cpf,
				rg: pessoaFisicaModel?.rg,
				orgaoRg: pessoaFisicaModel?.orgaoRg,
				dataEmissaoRg: pessoaFisicaModel?.dataEmissaoRg,
				dataNascimento: pessoaFisicaModel?.dataNascimento,
				sexo: pessoaFisicaModel?.sexo,
				raca: pessoaFisicaModel?.raca,
				nacionalidade: pessoaFisicaModel?.nacionalidade,
				naturalidade: pessoaFisicaModel?.naturalidade,
				nomePai: pessoaFisicaModel?.nomePai,
				nomeMae: pessoaFisicaModel?.nomeMae,
				estadoCivilModel: EstadoCivilModel(
					id: pessoaFisicaModel?.estadoCivilModel?.id,
					nome: pessoaFisicaModel?.estadoCivilModel?.nome,
					descricao: pessoaFisicaModel?.estadoCivilModel?.descricao,
				),
				nivelFormacaoModel: NivelFormacaoModel(
					id: pessoaFisicaModel?.nivelFormacaoModel?.id,
					nome: pessoaFisicaModel?.nivelFormacaoModel?.nome,
					descricao: pessoaFisicaModel?.nivelFormacaoModel?.descricao,
				),
			),
			transportadoraModel: TransportadoraModel(
				id: transportadoraModel?.id,
				idPessoa: transportadoraModel?.idPessoa,
				dataCadastro: transportadoraModel?.dataCadastro,
				observacao: transportadoraModel?.observacao,
			),
			contadorModel: ContadorModel(
				id: contadorModel?.id,
				idPessoa: contadorModel?.idPessoa,
				crcInscricao: contadorModel?.crcInscricao,
				crcUf: contadorModel?.crcUf,
			),
			pessoaContatoModelList: pessoaContatoModelListClone(pessoaContatoModelList!),
			pessoaTelefoneModelList: pessoaTelefoneModelListClone(pessoaTelefoneModelList!),
			pessoaEnderecoModelList: pessoaEnderecoModelListClone(pessoaEnderecoModelList!),
		);			
	}

	pessoaContatoModelListClone(List<PessoaContatoModel> pessoaContatoModelList) { 
		List<PessoaContatoModel> resultList = [];
		for (var pessoaContatoModel in pessoaContatoModelList) {
			resultList.add(
				PessoaContatoModel(
					id: pessoaContatoModel.id,
					idPessoa: pessoaContatoModel.idPessoa,
					nome: pessoaContatoModel.nome,
					email: pessoaContatoModel.email,
					observacao: pessoaContatoModel.observacao,
				)
			);
		}
		return resultList;
	}

	pessoaTelefoneModelListClone(List<PessoaTelefoneModel> pessoaTelefoneModelList) { 
		List<PessoaTelefoneModel> resultList = [];
		for (var pessoaTelefoneModel in pessoaTelefoneModelList) {
			resultList.add(
				PessoaTelefoneModel(
					id: pessoaTelefoneModel.id,
					idPessoa: pessoaTelefoneModel.idPessoa,
					tipo: pessoaTelefoneModel.tipo,
					numero: pessoaTelefoneModel.numero,
				)
			);
		}
		return resultList;
	}

	pessoaEnderecoModelListClone(List<PessoaEnderecoModel> pessoaEnderecoModelList) { 
		List<PessoaEnderecoModel> resultList = [];
		for (var pessoaEnderecoModel in pessoaEnderecoModelList) {
			resultList.add(
				PessoaEnderecoModel(
					id: pessoaEnderecoModel.id,
					idPessoa: pessoaEnderecoModel.idPessoa,
					logradouro: pessoaEnderecoModel.logradouro,
					numero: pessoaEnderecoModel.numero,
					complemento: pessoaEnderecoModel.complemento,
					bairro: pessoaEnderecoModel.bairro,
					cidade: pessoaEnderecoModel.cidade,
					uf: pessoaEnderecoModel.uf,
					cep: pessoaEnderecoModel.cep,
					municipioIbge: pessoaEnderecoModel.municipioIbge,
					principal: pessoaEnderecoModel.principal,
					entrega: pessoaEnderecoModel.entrega,
					cobranca: pessoaEnderecoModel.cobranca,
					correspondencia: pessoaEnderecoModel.correspondencia,
				)
			);
		}
		return resultList;
	}

	
}