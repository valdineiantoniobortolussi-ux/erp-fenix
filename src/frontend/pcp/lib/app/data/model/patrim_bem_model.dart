import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:pcp/app/data/domain/domain_imports.dart';

class PatrimBemModel {
	int? id;
	int? idCentroResultado;
	int? idPatrimTipoAquisicaoBem;
	int? idPatrimEstadoConservacao;
	int? idPatrimGrupoBem;
	int? idFornecedor;
	int? idSetor;
	String? numeroNb;
	String? nome;
	String? descricao;
	String? numeroSerie;
	DateTime? dataAquisicao;
	DateTime? dataAceite;
	DateTime? dataCadastro;
	DateTime? dataContabilizado;
	DateTime? dataVistoria;
	DateTime? dataMarcacao;
	DateTime? dataBaixa;
	DateTime? vencimentoGarantia;
	String? numeroNotaFiscal;
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

	PatrimBemModel({
		this.id,
		this.idCentroResultado,
		this.idPatrimTipoAquisicaoBem,
		this.idPatrimEstadoConservacao,
		this.idPatrimGrupoBem,
		this.idFornecedor,
		this.idSetor,
		this.numeroNb,
		this.nome,
		this.descricao,
		this.numeroSerie,
		this.dataAquisicao,
		this.dataAceite,
		this.dataCadastro,
		this.dataContabilizado,
		this.dataVistoria,
		this.dataMarcacao,
		this.dataBaixa,
		this.vencimentoGarantia,
		this.numeroNotaFiscal,
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
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_centro_resultado',
		'id_patrim_tipo_aquisicao_bem',
		'id_patrim_estado_conservacao',
		'id_patrim_grupo_bem',
		'id_fornecedor',
		'id_setor',
		'numero_nb',
		'nome',
		'descricao',
		'numero_serie',
		'data_aquisicao',
		'data_aceite',
		'data_cadastro',
		'data_contabilizado',
		'data_vistoria',
		'data_marcacao',
		'data_baixa',
		'vencimento_garantia',
		'numero_nota_fiscal',
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
		'Id Centro Resultado',
		'Id Patrim Tipo Aquisicao Bem',
		'Id Patrim Estado Conservacao',
		'Id Patrim Grupo Bem',
		'Id Fornecedor',
		'Id Setor',
		'Numero Nb',
		'Nome',
		'Descricao',
		'Numero Serie',
		'Data Aquisicao',
		'Data Aceite',
		'Data Cadastro',
		'Data Contabilizado',
		'Data Vistoria',
		'Data Marcacao',
		'Data Baixa',
		'Vencimento Garantia',
		'Numero Nota Fiscal',
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
		idPatrimTipoAquisicaoBem = jsonData['idPatrimTipoAquisicaoBem'];
		idPatrimEstadoConservacao = jsonData['idPatrimEstadoConservacao'];
		idPatrimGrupoBem = jsonData['idPatrimGrupoBem'];
		idFornecedor = jsonData['idFornecedor'];
		idSetor = jsonData['idSetor'];
		numeroNb = jsonData['numeroNb'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		numeroSerie = jsonData['numeroSerie'];
		dataAquisicao = jsonData['dataAquisicao'] != null ? DateTime.tryParse(jsonData['dataAquisicao']) : null;
		dataAceite = jsonData['dataAceite'] != null ? DateTime.tryParse(jsonData['dataAceite']) : null;
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataContabilizado = jsonData['dataContabilizado'] != null ? DateTime.tryParse(jsonData['dataContabilizado']) : null;
		dataVistoria = jsonData['dataVistoria'] != null ? DateTime.tryParse(jsonData['dataVistoria']) : null;
		dataMarcacao = jsonData['dataMarcacao'] != null ? DateTime.tryParse(jsonData['dataMarcacao']) : null;
		dataBaixa = jsonData['dataBaixa'] != null ? DateTime.tryParse(jsonData['dataBaixa']) : null;
		vencimentoGarantia = jsonData['vencimentoGarantia'] != null ? DateTime.tryParse(jsonData['vencimentoGarantia']) : null;
		numeroNotaFiscal = jsonData['numeroNotaFiscal'];
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
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado;
		jsonData['idPatrimTipoAquisicaoBem'] = idPatrimTipoAquisicaoBem;
		jsonData['idPatrimEstadoConservacao'] = idPatrimEstadoConservacao;
		jsonData['idPatrimGrupoBem'] = idPatrimGrupoBem;
		jsonData['idFornecedor'] = idFornecedor;
		jsonData['idSetor'] = idSetor;
		jsonData['numeroNb'] = numeroNb;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['numeroSerie'] = numeroSerie;
		jsonData['dataAquisicao'] = dataAquisicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAquisicao!) : null;
		jsonData['dataAceite'] = dataAceite != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAceite!) : null;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataContabilizado'] = dataContabilizado != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataContabilizado!) : null;
		jsonData['dataVistoria'] = dataVistoria != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVistoria!) : null;
		jsonData['dataMarcacao'] = dataMarcacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMarcacao!) : null;
		jsonData['dataBaixa'] = dataBaixa != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataBaixa!) : null;
		jsonData['vencimentoGarantia'] = vencimentoGarantia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(vencimentoGarantia!) : null;
		jsonData['numeroNotaFiscal'] = numeroNotaFiscal;
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
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCentroResultado = plutoRow.cells['idCentroResultado']?.value;
		idPatrimTipoAquisicaoBem = plutoRow.cells['idPatrimTipoAquisicaoBem']?.value;
		idPatrimEstadoConservacao = plutoRow.cells['idPatrimEstadoConservacao']?.value;
		idPatrimGrupoBem = plutoRow.cells['idPatrimGrupoBem']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		idSetor = plutoRow.cells['idSetor']?.value;
		numeroNb = plutoRow.cells['numeroNb']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		numeroSerie = plutoRow.cells['numeroSerie']?.value;
		dataAquisicao = Util.stringToDate(plutoRow.cells['dataAquisicao']?.value);
		dataAceite = Util.stringToDate(plutoRow.cells['dataAceite']?.value);
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataContabilizado = Util.stringToDate(plutoRow.cells['dataContabilizado']?.value);
		dataVistoria = Util.stringToDate(plutoRow.cells['dataVistoria']?.value);
		dataMarcacao = Util.stringToDate(plutoRow.cells['dataMarcacao']?.value);
		dataBaixa = Util.stringToDate(plutoRow.cells['dataBaixa']?.value);
		vencimentoGarantia = Util.stringToDate(plutoRow.cells['vencimentoGarantia']?.value);
		numeroNotaFiscal = plutoRow.cells['numeroNotaFiscal']?.value;
		chaveNfe = plutoRow.cells['chaveNfe']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorCompra = plutoRow.cells['valorCompra']?.value?.toDouble();
		valorAtualizado = plutoRow.cells['valorAtualizado']?.value?.toDouble();
		valorBaixa = plutoRow.cells['valorBaixa']?.value?.toDouble();
		deprecia = plutoRow.cells['deprecia']?.value != '' ? plutoRow.cells['deprecia']?.value : 'AAA';
		metodoDepreciacao = plutoRow.cells['metodoDepreciacao']?.value != '' ? plutoRow.cells['metodoDepreciacao']?.value : 'AAA';
		inicioDepreciacao = Util.stringToDate(plutoRow.cells['inicioDepreciacao']?.value);
		ultimaDepreciacao = Util.stringToDate(plutoRow.cells['ultimaDepreciacao']?.value);
		tipoDepreciacao = plutoRow.cells['tipoDepreciacao']?.value != '' ? plutoRow.cells['tipoDepreciacao']?.value : 'AAA';
		taxaAnualDepreciacao = plutoRow.cells['taxaAnualDepreciacao']?.value?.toDouble();
		taxaMensalDepreciacao = plutoRow.cells['taxaMensalDepreciacao']?.value?.toDouble();
		taxaDepreciacaoAcelerada = plutoRow.cells['taxaDepreciacaoAcelerada']?.value?.toDouble();
		taxaDepreciacaoIncentivada = plutoRow.cells['taxaDepreciacaoIncentivada']?.value?.toDouble();
		funcao = plutoRow.cells['funcao']?.value;
	}	

	PatrimBemModel clone() {
		return PatrimBemModel(
			id: id,
			idCentroResultado: idCentroResultado,
			idPatrimTipoAquisicaoBem: idPatrimTipoAquisicaoBem,
			idPatrimEstadoConservacao: idPatrimEstadoConservacao,
			idPatrimGrupoBem: idPatrimGrupoBem,
			idFornecedor: idFornecedor,
			idSetor: idSetor,
			numeroNb: numeroNb,
			nome: nome,
			descricao: descricao,
			numeroSerie: numeroSerie,
			dataAquisicao: dataAquisicao,
			dataAceite: dataAceite,
			dataCadastro: dataCadastro,
			dataContabilizado: dataContabilizado,
			dataVistoria: dataVistoria,
			dataMarcacao: dataMarcacao,
			dataBaixa: dataBaixa,
			vencimentoGarantia: vencimentoGarantia,
			numeroNotaFiscal: numeroNotaFiscal,
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
		);			
	}

	
}