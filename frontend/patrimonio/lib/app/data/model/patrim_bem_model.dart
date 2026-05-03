import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimBemModel {
	int? id;
	int? idCentroResultado;
	int? idFornecedor;
	int? idColaborador;
	int? idPatrimTipoAquisicaoBem;
	int? idPatrimEstadoConservacao;
	int? idPatrimGrupoBem;
	int? idSetor;
	String? numeroNb;
	String? nome;
	String? descricao;
	DateTime? dataAquisicao;
	DateTime? dataAceite;
	DateTime? dataCadastro;
	DateTime? dataContabilizado;
	DateTime? dataVistoria;
	DateTime? dataMarcacao;
	DateTime? dataBaixa;
	DateTime? vencimentoGarantia;
	String? numeroNotaFiscal;
	String? numeroSerie;
	String? chaveNfe;
	double? valorOriginal;
	double? valorCompra;
	double? valorAtualizado;
	double? valorBaixa;
	String? deprecia;
	String? metodoDepreciacao;
	DateTime? inicioDepreciacao;
	DateTime? ultimaDepreciacao;
	String? tipoDepreciacao;
	double? taxaAnualDepreciacao;
	double? taxaMensalDepreciacao;
	double? taxaDepreciacaoAcelerada;
	double? taxaDepreciacaoIncentivada;
	String? funcao;
	List<PatrimDocumentoBemModel>? patrimDocumentoBemModelList;
	List<PatrimDepreciacaoBemModel>? patrimDepreciacaoBemModelList;
	List<PatrimMovimentacaoBemModel>? patrimMovimentacaoBemModelList;
	List<PatrimApoliceSeguroModel>? patrimApoliceSeguroModelList;
	CentroResultadoModel? centroResultadoModel;
	PatrimEstadoConservacaoModel? patrimEstadoConservacaoModel;
	SetorModel? setorModel;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;
	PatrimTipoAquisicaoBemModel? patrimTipoAquisicaoBemModel;
	PatrimGrupoBemModel? patrimGrupoBemModel;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	PatrimBemModel({
		this.id,
		this.idCentroResultado,
		this.idFornecedor,
		this.idColaborador,
		this.idPatrimTipoAquisicaoBem,
		this.idPatrimEstadoConservacao,
		this.idPatrimGrupoBem,
		this.idSetor,
		this.numeroNb,
		this.nome,
		this.descricao,
		this.dataAquisicao,
		this.dataAceite,
		this.dataCadastro,
		this.dataContabilizado,
		this.dataVistoria,
		this.dataMarcacao,
		this.dataBaixa,
		this.vencimentoGarantia,
		this.numeroNotaFiscal,
		this.numeroSerie,
		this.chaveNfe,
		this.valorOriginal,
		this.valorCompra,
		this.valorAtualizado,
		this.valorBaixa,
		this.deprecia,
		this.metodoDepreciacao,
		this.inicioDepreciacao,
		this.ultimaDepreciacao,
		this.tipoDepreciacao,
		this.taxaAnualDepreciacao,
		this.taxaMensalDepreciacao,
		this.taxaDepreciacaoAcelerada,
		this.taxaDepreciacaoIncentivada,
		this.funcao,
		this.patrimDocumentoBemModelList,
		this.patrimDepreciacaoBemModelList,
		this.patrimMovimentacaoBemModelList,
		this.patrimApoliceSeguroModelList,
		this.centroResultadoModel,
		this.patrimEstadoConservacaoModel,
		this.setorModel,
		this.viewPessoaFornecedorModel,
		this.patrimTipoAquisicaoBemModel,
		this.patrimGrupoBemModel,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_nb',
		'nome',
		'descricao',
		'data_aquisicao',
		'data_aceite',
		'data_cadastro',
		'data_contabilizado',
		'data_vistoria',
		'data_marcacao',
		'data_baixa',
		'vencimento_garantia',
		'numero_nota_fiscal',
		'numero_serie',
		'chave_nfe',
		'valor_original',
		'valor_compra',
		'valor_atualizado',
		'valor_baixa',
		'deprecia',
		'metodo_depreciacao',
		'inicio_depreciacao',
		'ultima_depreciacao',
		'tipo_depreciacao',
		'taxa_anual_depreciacao',
		'taxa_mensal_depreciacao',
		'taxa_depreciacao_acelerada',
		'taxa_depreciacao_incentivada',
		'funcao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Nb',
		'Nome',
		'Descricao',
		'Data Aquisicao',
		'Data Aceite',
		'Data Cadastro',
		'Data Contabilizado',
		'Data Vistoria',
		'Data Marcacao',
		'Data Baixa',
		'Vencimento Garantia',
		'Numero Nota Fiscal',
		'Numero Serie',
		'Chave Nfe',
		'Valor Original',
		'Valor Compra',
		'Valor Atualizado',
		'Valor Baixa',
		'Deprecia',
		'Metodo Depreciacao',
		'Inicio Depreciacao',
		'Ultima Depreciacao',
		'Tipo Depreciacao',
		'Taxa Anual Depreciacao',
		'Taxa Mensal Depreciacao',
		'Taxa Depreciacao Acelerada',
		'Taxa Depreciacao Incentivada',
		'Funcao',
	];

	PatrimBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		idFornecedor = jsonData['idFornecedor'];
		idColaborador = jsonData['idColaborador'];
		idPatrimTipoAquisicaoBem = jsonData['idPatrimTipoAquisicaoBem'];
		idPatrimEstadoConservacao = jsonData['idPatrimEstadoConservacao'];
		idPatrimGrupoBem = jsonData['idPatrimGrupoBem'];
		idSetor = jsonData['idSetor'];
		numeroNb = jsonData['numeroNb'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		dataAquisicao = jsonData['dataAquisicao'] != null ? DateTime.tryParse(jsonData['dataAquisicao']) : null;
		dataAceite = jsonData['dataAceite'] != null ? DateTime.tryParse(jsonData['dataAceite']) : null;
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataContabilizado = jsonData['dataContabilizado'] != null ? DateTime.tryParse(jsonData['dataContabilizado']) : null;
		dataVistoria = jsonData['dataVistoria'] != null ? DateTime.tryParse(jsonData['dataVistoria']) : null;
		dataMarcacao = jsonData['dataMarcacao'] != null ? DateTime.tryParse(jsonData['dataMarcacao']) : null;
		dataBaixa = jsonData['dataBaixa'] != null ? DateTime.tryParse(jsonData['dataBaixa']) : null;
		vencimentoGarantia = jsonData['vencimentoGarantia'] != null ? DateTime.tryParse(jsonData['vencimentoGarantia']) : null;
		numeroNotaFiscal = jsonData['numeroNotaFiscal'];
		numeroSerie = jsonData['numeroSerie'];
		chaveNfe = jsonData['chaveNfe'];
		valorOriginal = jsonData['valorOriginal']?.toDouble();
		valorCompra = jsonData['valorCompra']?.toDouble();
		valorAtualizado = jsonData['valorAtualizado']?.toDouble();
		valorBaixa = jsonData['valorBaixa']?.toDouble();
		deprecia = PatrimBemDomain.getDeprecia(jsonData['deprecia']);
		metodoDepreciacao = PatrimBemDomain.getMetodoDepreciacao(jsonData['metodoDepreciacao']);
		inicioDepreciacao = jsonData['inicioDepreciacao'] != null ? DateTime.tryParse(jsonData['inicioDepreciacao']) : null;
		ultimaDepreciacao = jsonData['ultimaDepreciacao'] != null ? DateTime.tryParse(jsonData['ultimaDepreciacao']) : null;
		tipoDepreciacao = PatrimBemDomain.getTipoDepreciacao(jsonData['tipoDepreciacao']);
		taxaAnualDepreciacao = jsonData['taxaAnualDepreciacao']?.toDouble();
		taxaMensalDepreciacao = jsonData['taxaMensalDepreciacao']?.toDouble();
		taxaDepreciacaoAcelerada = jsonData['taxaDepreciacaoAcelerada']?.toDouble();
		taxaDepreciacaoIncentivada = jsonData['taxaDepreciacaoIncentivada']?.toDouble();
		funcao = jsonData['funcao'];
		patrimDocumentoBemModelList = (jsonData['patrimDocumentoBemModelList'] as Iterable?)?.map((m) => PatrimDocumentoBemModel.fromJson(m)).toList() ?? [];
		patrimDepreciacaoBemModelList = (jsonData['patrimDepreciacaoBemModelList'] as Iterable?)?.map((m) => PatrimDepreciacaoBemModel.fromJson(m)).toList() ?? [];
		patrimMovimentacaoBemModelList = (jsonData['patrimMovimentacaoBemModelList'] as Iterable?)?.map((m) => PatrimMovimentacaoBemModel.fromJson(m)).toList() ?? [];
		patrimApoliceSeguroModelList = (jsonData['patrimApoliceSeguroModelList'] as Iterable?)?.map((m) => PatrimApoliceSeguroModel.fromJson(m)).toList() ?? [];
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
		patrimEstadoConservacaoModel = jsonData['patrimEstadoConservacaoModel'] == null ? PatrimEstadoConservacaoModel() : PatrimEstadoConservacaoModel.fromJson(jsonData['patrimEstadoConservacaoModel']);
		setorModel = jsonData['setorModel'] == null ? SetorModel() : SetorModel.fromJson(jsonData['setorModel']);
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
		patrimTipoAquisicaoBemModel = jsonData['patrimTipoAquisicaoBemModel'] == null ? PatrimTipoAquisicaoBemModel() : PatrimTipoAquisicaoBemModel.fromJson(jsonData['patrimTipoAquisicaoBemModel']);
		patrimGrupoBemModel = jsonData['patrimGrupoBemModel'] == null ? PatrimGrupoBemModel() : PatrimGrupoBemModel.fromJson(jsonData['patrimGrupoBemModel']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['idPatrimTipoAquisicaoBem'] = idPatrimTipoAquisicaoBem != 0 ? idPatrimTipoAquisicaoBem : null;
		jsonData['idPatrimEstadoConservacao'] = idPatrimEstadoConservacao != 0 ? idPatrimEstadoConservacao : null;
		jsonData['idPatrimGrupoBem'] = idPatrimGrupoBem != 0 ? idPatrimGrupoBem : null;
		jsonData['idSetor'] = idSetor != 0 ? idSetor : null;
		jsonData['numeroNb'] = numeroNb;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['dataAquisicao'] = dataAquisicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAquisicao!) : null;
		jsonData['dataAceite'] = dataAceite != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAceite!) : null;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataContabilizado'] = dataContabilizado != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataContabilizado!) : null;
		jsonData['dataVistoria'] = dataVistoria != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVistoria!) : null;
		jsonData['dataMarcacao'] = dataMarcacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMarcacao!) : null;
		jsonData['dataBaixa'] = dataBaixa != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBaixa!) : null;
		jsonData['vencimentoGarantia'] = vencimentoGarantia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(vencimentoGarantia!) : null;
		jsonData['numeroNotaFiscal'] = numeroNotaFiscal;
		jsonData['numeroSerie'] = numeroSerie;
		jsonData['chaveNfe'] = chaveNfe;
		jsonData['valorOriginal'] = valorOriginal;
		jsonData['valorCompra'] = valorCompra;
		jsonData['valorAtualizado'] = valorAtualizado;
		jsonData['valorBaixa'] = valorBaixa;
		jsonData['deprecia'] = PatrimBemDomain.setDeprecia(deprecia);
		jsonData['metodoDepreciacao'] = PatrimBemDomain.setMetodoDepreciacao(metodoDepreciacao);
		jsonData['inicioDepreciacao'] = inicioDepreciacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(inicioDepreciacao!) : null;
		jsonData['ultimaDepreciacao'] = ultimaDepreciacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(ultimaDepreciacao!) : null;
		jsonData['tipoDepreciacao'] = PatrimBemDomain.setTipoDepreciacao(tipoDepreciacao);
		jsonData['taxaAnualDepreciacao'] = taxaAnualDepreciacao;
		jsonData['taxaMensalDepreciacao'] = taxaMensalDepreciacao;
		jsonData['taxaDepreciacaoAcelerada'] = taxaDepreciacaoAcelerada;
		jsonData['taxaDepreciacaoIncentivada'] = taxaDepreciacaoIncentivada;
		jsonData['funcao'] = funcao;
		
		var patrimDocumentoBemModelLocalList = []; 
		for (PatrimDocumentoBemModel object in patrimDocumentoBemModelList ?? []) { 
			patrimDocumentoBemModelLocalList.add(object.toJson); 
		}
		jsonData['patrimDocumentoBemModelList'] = patrimDocumentoBemModelLocalList;
		
		var patrimDepreciacaoBemModelLocalList = []; 
		for (PatrimDepreciacaoBemModel object in patrimDepreciacaoBemModelList ?? []) { 
			patrimDepreciacaoBemModelLocalList.add(object.toJson); 
		}
		jsonData['patrimDepreciacaoBemModelList'] = patrimDepreciacaoBemModelLocalList;
		
		var patrimMovimentacaoBemModelLocalList = []; 
		for (PatrimMovimentacaoBemModel object in patrimMovimentacaoBemModelList ?? []) { 
			patrimMovimentacaoBemModelLocalList.add(object.toJson); 
		}
		jsonData['patrimMovimentacaoBemModelList'] = patrimMovimentacaoBemModelLocalList;
		
		var patrimApoliceSeguroModelLocalList = []; 
		for (PatrimApoliceSeguroModel object in patrimApoliceSeguroModelList ?? []) { 
			patrimApoliceSeguroModelLocalList.add(object.toJson); 
		}
		jsonData['patrimApoliceSeguroModelList'] = patrimApoliceSeguroModelLocalList;
		jsonData['centroResultadoModel'] = centroResultadoModel?.toJson;
		jsonData['patrimEstadoConservacaoModel'] = patrimEstadoConservacaoModel?.toJson;
		jsonData['setorModel'] = setorModel?.toJson;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
		jsonData['patrimTipoAquisicaoBemModel'] = patrimTipoAquisicaoBemModel?.toJson;
		jsonData['patrimGrupoBemModel'] = patrimGrupoBemModel?.toJson;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCentroResultado = plutoRow.cells['idCentroResultado']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idPatrimTipoAquisicaoBem = plutoRow.cells['idPatrimTipoAquisicaoBem']?.value;
		idPatrimEstadoConservacao = plutoRow.cells['idPatrimEstadoConservacao']?.value;
		idPatrimGrupoBem = plutoRow.cells['idPatrimGrupoBem']?.value;
		idSetor = plutoRow.cells['idSetor']?.value;
		numeroNb = plutoRow.cells['numeroNb']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		dataAquisicao = Util.stringToDate(plutoRow.cells['dataAquisicao']?.value);
		dataAceite = Util.stringToDate(plutoRow.cells['dataAceite']?.value);
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataContabilizado = Util.stringToDate(plutoRow.cells['dataContabilizado']?.value);
		dataVistoria = Util.stringToDate(plutoRow.cells['dataVistoria']?.value);
		dataMarcacao = Util.stringToDate(plutoRow.cells['dataMarcacao']?.value);
		dataBaixa = Util.stringToDate(plutoRow.cells['dataBaixa']?.value);
		vencimentoGarantia = Util.stringToDate(plutoRow.cells['vencimentoGarantia']?.value);
		numeroNotaFiscal = plutoRow.cells['numeroNotaFiscal']?.value;
		numeroSerie = plutoRow.cells['numeroSerie']?.value;
		chaveNfe = plutoRow.cells['chaveNfe']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorCompra = plutoRow.cells['valorCompra']?.value?.toDouble();
		valorAtualizado = plutoRow.cells['valorAtualizado']?.value?.toDouble();
		valorBaixa = plutoRow.cells['valorBaixa']?.value?.toDouble();
		deprecia = plutoRow.cells['deprecia']?.value != '' ? plutoRow.cells['deprecia']?.value : 'Sim';
		metodoDepreciacao = plutoRow.cells['metodoDepreciacao']?.value != '' ? plutoRow.cells['metodoDepreciacao']?.value : '1=Linear';
		inicioDepreciacao = Util.stringToDate(plutoRow.cells['inicioDepreciacao']?.value);
		ultimaDepreciacao = Util.stringToDate(plutoRow.cells['ultimaDepreciacao']?.value);
		tipoDepreciacao = plutoRow.cells['tipoDepreciacao']?.value != '' ? plutoRow.cells['tipoDepreciacao']?.value : 'Normal';
		taxaAnualDepreciacao = plutoRow.cells['taxaAnualDepreciacao']?.value?.toDouble();
		taxaMensalDepreciacao = plutoRow.cells['taxaMensalDepreciacao']?.value?.toDouble();
		taxaDepreciacaoAcelerada = plutoRow.cells['taxaDepreciacaoAcelerada']?.value?.toDouble();
		taxaDepreciacaoIncentivada = plutoRow.cells['taxaDepreciacaoIncentivada']?.value?.toDouble();
		funcao = plutoRow.cells['funcao']?.value;
		patrimDocumentoBemModelList = [];
		patrimDepreciacaoBemModelList = [];
		patrimMovimentacaoBemModelList = [];
		patrimApoliceSeguroModelList = [];
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
		patrimEstadoConservacaoModel = PatrimEstadoConservacaoModel();
		patrimEstadoConservacaoModel?.nome = plutoRow.cells['patrimEstadoConservacaoModel']?.value;
		setorModel = SetorModel();
		setorModel?.nome = plutoRow.cells['setorModel']?.value;
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
		patrimTipoAquisicaoBemModel = PatrimTipoAquisicaoBemModel();
		patrimTipoAquisicaoBemModel?.nome = plutoRow.cells['patrimTipoAquisicaoBemModel']?.value;
		patrimGrupoBemModel = PatrimGrupoBemModel();
		patrimGrupoBemModel?.nome = plutoRow.cells['patrimGrupoBemModel']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	PatrimBemModel clone() {
		return PatrimBemModel(
			id: id,
			idCentroResultado: idCentroResultado,
			idFornecedor: idFornecedor,
			idColaborador: idColaborador,
			idPatrimTipoAquisicaoBem: idPatrimTipoAquisicaoBem,
			idPatrimEstadoConservacao: idPatrimEstadoConservacao,
			idPatrimGrupoBem: idPatrimGrupoBem,
			idSetor: idSetor,
			numeroNb: numeroNb,
			nome: nome,
			descricao: descricao,
			dataAquisicao: dataAquisicao,
			dataAceite: dataAceite,
			dataCadastro: dataCadastro,
			dataContabilizado: dataContabilizado,
			dataVistoria: dataVistoria,
			dataMarcacao: dataMarcacao,
			dataBaixa: dataBaixa,
			vencimentoGarantia: vencimentoGarantia,
			numeroNotaFiscal: numeroNotaFiscal,
			numeroSerie: numeroSerie,
			chaveNfe: chaveNfe,
			valorOriginal: valorOriginal,
			valorCompra: valorCompra,
			valorAtualizado: valorAtualizado,
			valorBaixa: valorBaixa,
			deprecia: deprecia,
			metodoDepreciacao: metodoDepreciacao,
			inicioDepreciacao: inicioDepreciacao,
			ultimaDepreciacao: ultimaDepreciacao,
			tipoDepreciacao: tipoDepreciacao,
			taxaAnualDepreciacao: taxaAnualDepreciacao,
			taxaMensalDepreciacao: taxaMensalDepreciacao,
			taxaDepreciacaoAcelerada: taxaDepreciacaoAcelerada,
			taxaDepreciacaoIncentivada: taxaDepreciacaoIncentivada,
			funcao: funcao,
			patrimDocumentoBemModelList: patrimDocumentoBemModelListClone(patrimDocumentoBemModelList!),
			patrimDepreciacaoBemModelList: patrimDepreciacaoBemModelListClone(patrimDepreciacaoBemModelList!),
			patrimMovimentacaoBemModelList: patrimMovimentacaoBemModelListClone(patrimMovimentacaoBemModelList!),
			patrimApoliceSeguroModelList: patrimApoliceSeguroModelListClone(patrimApoliceSeguroModelList!),
		);			
	}

	patrimDocumentoBemModelListClone(List<PatrimDocumentoBemModel> patrimDocumentoBemModelList) { 
		List<PatrimDocumentoBemModel> resultList = [];
		for (var patrimDocumentoBemModel in patrimDocumentoBemModelList) {
			resultList.add(
				PatrimDocumentoBemModel(
					id: patrimDocumentoBemModel.id,
					idPatrimBem: patrimDocumentoBemModel.idPatrimBem,
					nome: patrimDocumentoBemModel.nome,
					descricao: patrimDocumentoBemModel.descricao,
					imagem: patrimDocumentoBemModel.imagem,
				)
			);
		}
		return resultList;
	}

	patrimDepreciacaoBemModelListClone(List<PatrimDepreciacaoBemModel> patrimDepreciacaoBemModelList) { 
		List<PatrimDepreciacaoBemModel> resultList = [];
		for (var patrimDepreciacaoBemModel in patrimDepreciacaoBemModelList) {
			resultList.add(
				PatrimDepreciacaoBemModel(
					id: patrimDepreciacaoBemModel.id,
					idPatrimBem: patrimDepreciacaoBemModel.idPatrimBem,
					dataDepreciacao: patrimDepreciacaoBemModel.dataDepreciacao,
					dias: patrimDepreciacaoBemModel.dias,
					taxa: patrimDepreciacaoBemModel.taxa,
					indice: patrimDepreciacaoBemModel.indice,
					valor: patrimDepreciacaoBemModel.valor,
					depreciacaoAcumulada: patrimDepreciacaoBemModel.depreciacaoAcumulada,
				)
			);
		}
		return resultList;
	}

	patrimMovimentacaoBemModelListClone(List<PatrimMovimentacaoBemModel> patrimMovimentacaoBemModelList) { 
		List<PatrimMovimentacaoBemModel> resultList = [];
		for (var patrimMovimentacaoBemModel in patrimMovimentacaoBemModelList) {
			resultList.add(
				PatrimMovimentacaoBemModel(
					id: patrimMovimentacaoBemModel.id,
					idPatrimBem: patrimMovimentacaoBemModel.idPatrimBem,
					idPatrimTipoMovimentacao: patrimMovimentacaoBemModel.idPatrimTipoMovimentacao,
					dataMovimentacao: patrimMovimentacaoBemModel.dataMovimentacao,
					responsavel: patrimMovimentacaoBemModel.responsavel,
				)
			);
		}
		return resultList;
	}

	patrimApoliceSeguroModelListClone(List<PatrimApoliceSeguroModel> patrimApoliceSeguroModelList) { 
		List<PatrimApoliceSeguroModel> resultList = [];
		for (var patrimApoliceSeguroModel in patrimApoliceSeguroModelList) {
			resultList.add(
				PatrimApoliceSeguroModel(
					id: patrimApoliceSeguroModel.id,
					idPatrimBem: patrimApoliceSeguroModel.idPatrimBem,
					idSeguradora: patrimApoliceSeguroModel.idSeguradora,
					numero: patrimApoliceSeguroModel.numero,
					dataContratacao: patrimApoliceSeguroModel.dataContratacao,
					dataVencimento: patrimApoliceSeguroModel.dataVencimento,
					valorPremio: patrimApoliceSeguroModel.valorPremio,
					valorSegurado: patrimApoliceSeguroModel.valorSegurado,
					observacao: patrimApoliceSeguroModel.observacao,
					imagem: patrimApoliceSeguroModel.imagem,
				)
			);
		}
		return resultList;
	}

	
}