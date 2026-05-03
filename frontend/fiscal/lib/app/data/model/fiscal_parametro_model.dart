import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalParametroModel {
	int? id;
	int? idFiscalEstadualPorte;
	int? idFiscalEstadualRegime;
	int? idFiscalMunicipalRegime;
	String? vigencia;
	String? descricaoVigencia;
	String? criterioLancamento;
	String? apuracao;
	String? microempreeIndividual;
	String? calcPisCofinsEfd;
	String? simplesCodigoAcesso;
	String? simplesTabela;
	String? simplesAtividade;
	String? perfilSped;
	String? apuracaoConsolidada;
	String? substituicaoTributaria;
	String? formaCalculoIss;
	List<FiscalInscricoesSubstitutasModel>? fiscalInscricoesSubstitutasModelList;
	FiscalEstadualRegimeModel? fiscalEstadualRegimeModel;
	FiscalEstadualPorteModel? fiscalEstadualPorteModel;
	FiscalMunicipalRegimeModel? fiscalMunicipalRegimeModel;

	FiscalParametroModel({
		this.id,
		this.idFiscalEstadualPorte,
		this.idFiscalEstadualRegime,
		this.idFiscalMunicipalRegime,
		this.vigencia,
		this.descricaoVigencia,
		this.criterioLancamento,
		this.apuracao,
		this.microempreeIndividual,
		this.calcPisCofinsEfd,
		this.simplesCodigoAcesso,
		this.simplesTabela,
		this.simplesAtividade,
		this.perfilSped,
		this.apuracaoConsolidada,
		this.substituicaoTributaria,
		this.formaCalculoIss,
		this.fiscalInscricoesSubstitutasModelList,
		this.fiscalEstadualRegimeModel,
		this.fiscalEstadualPorteModel,
		this.fiscalMunicipalRegimeModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'vigencia',
		'descricao_vigencia',
		'criterio_lancamento',
		'apuracao',
		'microempree_individual',
		'calc_pis_cofins_efd',
		'simples_codigo_acesso',
		'simples_tabela',
		'simples_atividade',
		'perfil_sped',
		'apuracao_consolidada',
		'substituicao_tributaria',
		'forma_calculo_iss',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Vigencia',
		'Descricao Vigencia',
		'Criterio Lancamento',
		'Apuracao',
		'Microempree Individual',
		'Calc Pis Cofins Efd',
		'Simples Codigo Acesso',
		'Simples Tabela',
		'Simples Atividade',
		'Perfil Sped',
		'Apuracao Consolidada',
		'Substituicao Tributaria',
		'Forma Calculo Iss',
	];

	FiscalParametroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFiscalEstadualPorte = jsonData['idFiscalEstadualPorte'];
		idFiscalEstadualRegime = jsonData['idFiscalEstadualRegime'];
		idFiscalMunicipalRegime = jsonData['idFiscalMunicipalRegime'];
		vigencia = jsonData['vigencia'];
		descricaoVigencia = jsonData['descricaoVigencia'];
		criterioLancamento = FiscalParametroDomain.getCriterioLancamento(jsonData['criterioLancamento']);
		apuracao = FiscalParametroDomain.getApuracao(jsonData['apuracao']);
		microempreeIndividual = FiscalParametroDomain.getMicroempreeIndividual(jsonData['microempreeIndividual']);
		calcPisCofinsEfd = FiscalParametroDomain.getCalcPisCofinsEfd(jsonData['calcPisCofinsEfd']);
		simplesCodigoAcesso = jsonData['simplesCodigoAcesso'];
		simplesTabela = FiscalParametroDomain.getSimplesTabela(jsonData['simplesTabela']);
		simplesAtividade = FiscalParametroDomain.getSimplesAtividade(jsonData['simplesAtividade']);
		perfilSped = FiscalParametroDomain.getPerfilSped(jsonData['perfilSped']);
		apuracaoConsolidada = FiscalParametroDomain.getApuracaoConsolidada(jsonData['apuracaoConsolidada']);
		substituicaoTributaria = FiscalParametroDomain.getSubstituicaoTributaria(jsonData['substituicaoTributaria']);
		formaCalculoIss = FiscalParametroDomain.getFormaCalculoIss(jsonData['formaCalculoIss']);
		fiscalInscricoesSubstitutasModelList = (jsonData['fiscalInscricoesSubstitutasModelList'] as Iterable?)?.map((m) => FiscalInscricoesSubstitutasModel.fromJson(m)).toList() ?? [];
		fiscalEstadualRegimeModel = jsonData['fiscalEstadualRegimeModel'] == null ? FiscalEstadualRegimeModel() : FiscalEstadualRegimeModel.fromJson(jsonData['fiscalEstadualRegimeModel']);
		fiscalEstadualPorteModel = jsonData['fiscalEstadualPorteModel'] == null ? FiscalEstadualPorteModel() : FiscalEstadualPorteModel.fromJson(jsonData['fiscalEstadualPorteModel']);
		fiscalMunicipalRegimeModel = jsonData['fiscalMunicipalRegimeModel'] == null ? FiscalMunicipalRegimeModel() : FiscalMunicipalRegimeModel.fromJson(jsonData['fiscalMunicipalRegimeModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFiscalEstadualPorte'] = idFiscalEstadualPorte != 0 ? idFiscalEstadualPorte : null;
		jsonData['idFiscalEstadualRegime'] = idFiscalEstadualRegime != 0 ? idFiscalEstadualRegime : null;
		jsonData['idFiscalMunicipalRegime'] = idFiscalMunicipalRegime != 0 ? idFiscalMunicipalRegime : null;
		jsonData['vigencia'] = Util.removeMask(vigencia);
		jsonData['descricaoVigencia'] = descricaoVigencia;
		jsonData['criterioLancamento'] = FiscalParametroDomain.setCriterioLancamento(criterioLancamento);
		jsonData['apuracao'] = FiscalParametroDomain.setApuracao(apuracao);
		jsonData['microempreeIndividual'] = FiscalParametroDomain.setMicroempreeIndividual(microempreeIndividual);
		jsonData['calcPisCofinsEfd'] = FiscalParametroDomain.setCalcPisCofinsEfd(calcPisCofinsEfd);
		jsonData['simplesCodigoAcesso'] = simplesCodigoAcesso;
		jsonData['simplesTabela'] = FiscalParametroDomain.setSimplesTabela(simplesTabela);
		jsonData['simplesAtividade'] = FiscalParametroDomain.setSimplesAtividade(simplesAtividade);
		jsonData['perfilSped'] = FiscalParametroDomain.setPerfilSped(perfilSped);
		jsonData['apuracaoConsolidada'] = FiscalParametroDomain.setApuracaoConsolidada(apuracaoConsolidada);
		jsonData['substituicaoTributaria'] = FiscalParametroDomain.setSubstituicaoTributaria(substituicaoTributaria);
		jsonData['formaCalculoIss'] = FiscalParametroDomain.setFormaCalculoIss(formaCalculoIss);
		
		var fiscalInscricoesSubstitutasModelLocalList = []; 
		for (FiscalInscricoesSubstitutasModel object in fiscalInscricoesSubstitutasModelList ?? []) { 
			fiscalInscricoesSubstitutasModelLocalList.add(object.toJson); 
		}
		jsonData['fiscalInscricoesSubstitutasModelList'] = fiscalInscricoesSubstitutasModelLocalList;
		jsonData['fiscalEstadualRegimeModel'] = fiscalEstadualRegimeModel?.toJson;
		jsonData['fiscalEstadualPorteModel'] = fiscalEstadualPorteModel?.toJson;
		jsonData['fiscalMunicipalRegimeModel'] = fiscalMunicipalRegimeModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFiscalEstadualPorte = plutoRow.cells['idFiscalEstadualPorte']?.value;
		idFiscalEstadualRegime = plutoRow.cells['idFiscalEstadualRegime']?.value;
		idFiscalMunicipalRegime = plutoRow.cells['idFiscalMunicipalRegime']?.value;
		vigencia = plutoRow.cells['vigencia']?.value;
		descricaoVigencia = plutoRow.cells['descricaoVigencia']?.value;
		criterioLancamento = plutoRow.cells['criterioLancamento']?.value != '' ? plutoRow.cells['criterioLancamento']?.value : 'Livre';
		apuracao = plutoRow.cells['apuracao']?.value != '' ? plutoRow.cells['apuracao']?.value : '1-Regime Competencia';
		microempreeIndividual = plutoRow.cells['microempreeIndividual']?.value != '' ? plutoRow.cells['microempreeIndividual']?.value : 'Sim';
		calcPisCofinsEfd = plutoRow.cells['calcPisCofinsEfd']?.value != '' ? plutoRow.cells['calcPisCofinsEfd']?.value : 'AB=Alíquota Básica';
		simplesCodigoAcesso = plutoRow.cells['simplesCodigoAcesso']?.value;
		simplesTabela = plutoRow.cells['simplesTabela']?.value != '' ? plutoRow.cells['simplesTabela']?.value : '1=Federal';
		simplesAtividade = plutoRow.cells['simplesAtividade']?.value != '' ? plutoRow.cells['simplesAtividade']?.value : 'Comercio';
		perfilSped = plutoRow.cells['perfilSped']?.value != '' ? plutoRow.cells['perfilSped']?.value : 'A';
		apuracaoConsolidada = plutoRow.cells['apuracaoConsolidada']?.value != '' ? plutoRow.cells['apuracaoConsolidada']?.value : 'Sim';
		substituicaoTributaria = plutoRow.cells['substituicaoTributaria']?.value != '' ? plutoRow.cells['substituicaoTributaria']?.value : 'Sim';
		formaCalculoIss = plutoRow.cells['formaCalculoIss']?.value != '' ? plutoRow.cells['formaCalculoIss']?.value : 'Normal';
		fiscalInscricoesSubstitutasModelList = [];
		fiscalEstadualRegimeModel = FiscalEstadualRegimeModel();
		fiscalEstadualRegimeModel?.nome = plutoRow.cells['fiscalEstadualRegimeModel']?.value;
		fiscalEstadualPorteModel = FiscalEstadualPorteModel();
		fiscalEstadualPorteModel?.nome = plutoRow.cells['fiscalEstadualPorteModel']?.value;
		fiscalMunicipalRegimeModel = FiscalMunicipalRegimeModel();
		fiscalMunicipalRegimeModel?.nome = plutoRow.cells['fiscalMunicipalRegimeModel']?.value;
	}	

	FiscalParametroModel clone() {
		return FiscalParametroModel(
			id: id,
			idFiscalEstadualPorte: idFiscalEstadualPorte,
			idFiscalEstadualRegime: idFiscalEstadualRegime,
			idFiscalMunicipalRegime: idFiscalMunicipalRegime,
			vigencia: vigencia,
			descricaoVigencia: descricaoVigencia,
			criterioLancamento: criterioLancamento,
			apuracao: apuracao,
			microempreeIndividual: microempreeIndividual,
			calcPisCofinsEfd: calcPisCofinsEfd,
			simplesCodigoAcesso: simplesCodigoAcesso,
			simplesTabela: simplesTabela,
			simplesAtividade: simplesAtividade,
			perfilSped: perfilSped,
			apuracaoConsolidada: apuracaoConsolidada,
			substituicaoTributaria: substituicaoTributaria,
			formaCalculoIss: formaCalculoIss,
			fiscalInscricoesSubstitutasModelList: fiscalInscricoesSubstitutasModelListClone(fiscalInscricoesSubstitutasModelList!),
		);			
	}

	fiscalInscricoesSubstitutasModelListClone(List<FiscalInscricoesSubstitutasModel> fiscalInscricoesSubstitutasModelList) { 
		List<FiscalInscricoesSubstitutasModel> resultList = [];
		for (var fiscalInscricoesSubstitutasModel in fiscalInscricoesSubstitutasModelList) {
			resultList.add(
				FiscalInscricoesSubstitutasModel(
					id: fiscalInscricoesSubstitutasModel.id,
					idFiscalParametros: fiscalInscricoesSubstitutasModel.idFiscalParametros,
					uf: fiscalInscricoesSubstitutasModel.uf,
					inscricaoEstadual: fiscalInscricoesSubstitutasModel.inscricaoEstadual,
					pmpf: fiscalInscricoesSubstitutasModel.pmpf,
				)
			);
		}
		return resultList;
	}

	
}