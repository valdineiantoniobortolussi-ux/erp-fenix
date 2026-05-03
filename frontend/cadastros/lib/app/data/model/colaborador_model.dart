import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class ColaboradorModel {
	int? id;
	int? idPessoa;
	int? idCargo;
	int? idSetor;
	int? idColaboradorSituacao;
	int? idTipoAdmissao;
	int? idColaboradorTipo;
	int? idSindicato;
	String? matricula;
	DateTime? dataCadastro;
	DateTime? dataAdmissao;
	DateTime? dataDemissao;
	String? ctpsNumero;
	String? ctpsSerie;
	DateTime? ctpsDataExpedicao;
	String? ctpsUf;
	String? observacao;
	VendedorModel? vendedorModel;
	PessoaModel? pessoaModel;
	ColaboradorSituacaoModel? colaboradorSituacaoModel;
	ColaboradorTipoModel? colaboradorTipoModel;
	SetorModel? setorModel;
	CargoModel? cargoModel;
	TipoAdmissaoModel? tipoAdmissaoModel;
	List<ColaboradorRelacionamentoModel>? colaboradorRelacionamentoModelList;
	SindicatoModel? sindicatoModel;

	ColaboradorModel({
		this.id,
		this.idPessoa,
		this.idCargo,
		this.idSetor,
		this.idColaboradorSituacao,
		this.idTipoAdmissao,
		this.idColaboradorTipo,
		this.idSindicato,
		this.matricula,
		this.dataCadastro,
		this.dataAdmissao,
		this.dataDemissao,
		this.ctpsNumero,
		this.ctpsSerie,
		this.ctpsDataExpedicao,
		this.ctpsUf,
		this.observacao,
		this.vendedorModel,
		this.pessoaModel,
		this.colaboradorSituacaoModel,
		this.colaboradorTipoModel,
		this.setorModel,
		this.cargoModel,
		this.tipoAdmissaoModel,
		this.colaboradorRelacionamentoModelList,
		this.sindicatoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'matricula',
		'data_cadastro',
		'data_admissao',
		'data_demissao',
		'ctps_numero',
		'ctps_serie',
		'ctps_data_expedicao',
		'ctps_uf',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Matricula',
		'Data Cadastro',
		'Data Admissao',
		'Data Demissao',
		'Ctps Numero',
		'Ctps Serie',
		'Ctps Data Expedicao',
		'Ctps Uf',
		'Observacao',
	];

	ColaboradorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		idCargo = jsonData['idCargo'];
		idSetor = jsonData['idSetor'];
		idColaboradorSituacao = jsonData['idColaboradorSituacao'];
		idTipoAdmissao = jsonData['idTipoAdmissao'];
		idColaboradorTipo = jsonData['idColaboradorTipo'];
		idSindicato = jsonData['idSindicato'];
		matricula = jsonData['matricula'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataAdmissao = jsonData['dataAdmissao'] != null ? DateTime.tryParse(jsonData['dataAdmissao']) : null;
		dataDemissao = jsonData['dataDemissao'] != null ? DateTime.tryParse(jsonData['dataDemissao']) : null;
		ctpsNumero = jsonData['ctpsNumero'];
		ctpsSerie = jsonData['ctpsSerie'];
		ctpsDataExpedicao = jsonData['ctpsDataExpedicao'] != null ? DateTime.tryParse(jsonData['ctpsDataExpedicao']) : null;
		ctpsUf = ColaboradorDomain.getCtpsUf(jsonData['ctpsUf']);
		observacao = jsonData['observacao'];
		vendedorModel = jsonData['vendedorModel'] == null ? VendedorModel(comissaoPerfilModel: ComissaoPerfilModel(), ) : VendedorModel.fromJson(jsonData['vendedorModel']);
		pessoaModel = jsonData['pessoaModel'] == null ? PessoaModel() : PessoaModel.fromJson(jsonData['pessoaModel']);
		colaboradorSituacaoModel = jsonData['colaboradorSituacaoModel'] == null ? ColaboradorSituacaoModel() : ColaboradorSituacaoModel.fromJson(jsonData['colaboradorSituacaoModel']);
		colaboradorTipoModel = jsonData['colaboradorTipoModel'] == null ? ColaboradorTipoModel() : ColaboradorTipoModel.fromJson(jsonData['colaboradorTipoModel']);
		setorModel = jsonData['setorModel'] == null ? SetorModel() : SetorModel.fromJson(jsonData['setorModel']);
		cargoModel = jsonData['cargoModel'] == null ? CargoModel() : CargoModel.fromJson(jsonData['cargoModel']);
		tipoAdmissaoModel = jsonData['tipoAdmissaoModel'] == null ? TipoAdmissaoModel() : TipoAdmissaoModel.fromJson(jsonData['tipoAdmissaoModel']);
		colaboradorRelacionamentoModelList = (jsonData['colaboradorRelacionamentoModelList'] as Iterable?)?.map((m) => ColaboradorRelacionamentoModel.fromJson(m)).toList() ?? [];
		sindicatoModel = jsonData['sindicatoModel'] == null ? SindicatoModel() : SindicatoModel.fromJson(jsonData['sindicatoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['idCargo'] = idCargo != 0 ? idCargo : null;
		jsonData['idSetor'] = idSetor != 0 ? idSetor : null;
		jsonData['idColaboradorSituacao'] = idColaboradorSituacao != 0 ? idColaboradorSituacao : null;
		jsonData['idTipoAdmissao'] = idTipoAdmissao != 0 ? idTipoAdmissao : null;
		jsonData['idColaboradorTipo'] = idColaboradorTipo != 0 ? idColaboradorTipo : null;
		jsonData['idSindicato'] = idSindicato != 0 ? idSindicato : null;
		jsonData['matricula'] = matricula;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataAdmissao'] = dataAdmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAdmissao!) : null;
		jsonData['dataDemissao'] = dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDemissao!) : null;
		jsonData['ctpsNumero'] = ctpsNumero;
		jsonData['ctpsSerie'] = ctpsSerie;
		jsonData['ctpsDataExpedicao'] = ctpsDataExpedicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(ctpsDataExpedicao!) : null;
		jsonData['ctpsUf'] = ColaboradorDomain.setCtpsUf(ctpsUf);
		jsonData['observacao'] = observacao;
		jsonData['vendedorModel'] = vendedorModel?.toJson;
		jsonData['pessoaModel'] = pessoaModel?.toJson;
		jsonData['colaboradorSituacaoModel'] = colaboradorSituacaoModel?.toJson;
		jsonData['colaboradorTipoModel'] = colaboradorTipoModel?.toJson;
		jsonData['setorModel'] = setorModel?.toJson;
		jsonData['cargoModel'] = cargoModel?.toJson;
		jsonData['tipoAdmissaoModel'] = tipoAdmissaoModel?.toJson;
		
		var colaboradorRelacionamentoModelLocalList = []; 
		for (ColaboradorRelacionamentoModel object in colaboradorRelacionamentoModelList ?? []) { 
			colaboradorRelacionamentoModelLocalList.add(object.toJson); 
		}
		jsonData['colaboradorRelacionamentoModelList'] = colaboradorRelacionamentoModelLocalList;
		jsonData['sindicatoModel'] = sindicatoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		idCargo = plutoRow.cells['idCargo']?.value;
		idSetor = plutoRow.cells['idSetor']?.value;
		idColaboradorSituacao = plutoRow.cells['idColaboradorSituacao']?.value;
		idTipoAdmissao = plutoRow.cells['idTipoAdmissao']?.value;
		idColaboradorTipo = plutoRow.cells['idColaboradorTipo']?.value;
		idSindicato = plutoRow.cells['idSindicato']?.value;
		matricula = plutoRow.cells['matricula']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataAdmissao = Util.stringToDate(plutoRow.cells['dataAdmissao']?.value);
		dataDemissao = Util.stringToDate(plutoRow.cells['dataDemissao']?.value);
		ctpsNumero = plutoRow.cells['ctpsNumero']?.value;
		ctpsSerie = plutoRow.cells['ctpsSerie']?.value;
		ctpsDataExpedicao = Util.stringToDate(plutoRow.cells['ctpsDataExpedicao']?.value);
		ctpsUf = plutoRow.cells['ctpsUf']?.value != '' ? plutoRow.cells['ctpsUf']?.value : 'AC';
		observacao = plutoRow.cells['observacao']?.value;
		vendedorModel = VendedorModel(comissaoPerfilModel: ComissaoPerfilModel(), );
		pessoaModel = PessoaModel();
		pessoaModel?.nome = plutoRow.cells['pessoaModel']?.value;
		colaboradorSituacaoModel = ColaboradorSituacaoModel();
		colaboradorSituacaoModel?.nome = plutoRow.cells['colaboradorSituacaoModel']?.value;
		colaboradorTipoModel = ColaboradorTipoModel();
		colaboradorTipoModel?.nome = plutoRow.cells['colaboradorTipoModel']?.value;
		setorModel = SetorModel();
		setorModel?.nome = plutoRow.cells['setorModel']?.value;
		cargoModel = CargoModel();
		cargoModel?.nome = plutoRow.cells['cargoModel']?.value;
		tipoAdmissaoModel = TipoAdmissaoModel();
		tipoAdmissaoModel?.nome = plutoRow.cells['tipoAdmissaoModel']?.value;
		colaboradorRelacionamentoModelList = [];
		sindicatoModel = SindicatoModel();
		sindicatoModel?.nome = plutoRow.cells['sindicatoModel']?.value;
	}	

	ColaboradorModel clone() {
		return ColaboradorModel(
			id: id,
			idPessoa: idPessoa,
			idCargo: idCargo,
			idSetor: idSetor,
			idColaboradorSituacao: idColaboradorSituacao,
			idTipoAdmissao: idTipoAdmissao,
			idColaboradorTipo: idColaboradorTipo,
			idSindicato: idSindicato,
			matricula: matricula,
			dataCadastro: dataCadastro,
			dataAdmissao: dataAdmissao,
			dataDemissao: dataDemissao,
			ctpsNumero: ctpsNumero,
			ctpsSerie: ctpsSerie,
			ctpsDataExpedicao: ctpsDataExpedicao,
			ctpsUf: ctpsUf,
			observacao: observacao,
			vendedorModel: VendedorModel(
				id: vendedorModel?.id,
				idColaborador: vendedorModel?.idColaborador,
				idComissaoPerfil: vendedorModel?.idComissaoPerfil,
				comissao: vendedorModel?.comissao,
				metaVenda: vendedorModel?.metaVenda,
				comissaoPerfilModel: ComissaoPerfilModel(
					id: vendedorModel?.comissaoPerfilModel?.id,
					codigo: vendedorModel?.comissaoPerfilModel?.codigo,
					nome: vendedorModel?.comissaoPerfilModel?.nome,
				),
			),
			colaboradorRelacionamentoModelList: colaboradorRelacionamentoModelListClone(colaboradorRelacionamentoModelList!),
		);			
	}

	colaboradorRelacionamentoModelListClone(List<ColaboradorRelacionamentoModel> colaboradorRelacionamentoModelList) { 
		List<ColaboradorRelacionamentoModel> resultList = [];
		for (var colaboradorRelacionamentoModel in colaboradorRelacionamentoModelList) {
			resultList.add(
				ColaboradorRelacionamentoModel(
					id: colaboradorRelacionamentoModel.id,
					idColaborador: colaboradorRelacionamentoModel.idColaborador,
					idTipoRelacionamento: colaboradorRelacionamentoModel.idTipoRelacionamento,
					nome: colaboradorRelacionamentoModel.nome,
					dataNascimento: colaboradorRelacionamentoModel.dataNascimento,
					cpf: colaboradorRelacionamentoModel.cpf,
					registroMatricula: colaboradorRelacionamentoModel.registroMatricula,
					registroCartorio: colaboradorRelacionamentoModel.registroCartorio,
					registroCartorioNumero: colaboradorRelacionamentoModel.registroCartorioNumero,
					registroNumeroLivro: colaboradorRelacionamentoModel.registroNumeroLivro,
					registroNumeroFolha: colaboradorRelacionamentoModel.registroNumeroFolha,
					dataEntregaDocumento: colaboradorRelacionamentoModel.dataEntregaDocumento,
					salarioFamilia: colaboradorRelacionamentoModel.salarioFamilia,
					salarioFamiliaIdadeLimite: colaboradorRelacionamentoModel.salarioFamiliaIdadeLimite,
					salarioFamiliaDataFim: colaboradorRelacionamentoModel.salarioFamiliaDataFim,
					impostoRendaIdadeLimite: colaboradorRelacionamentoModel.impostoRendaIdadeLimite,
					impostoRendaDataFim: colaboradorRelacionamentoModel.impostoRendaDataFim,
				)
			);
		}
		return resultList;
	}

	
}