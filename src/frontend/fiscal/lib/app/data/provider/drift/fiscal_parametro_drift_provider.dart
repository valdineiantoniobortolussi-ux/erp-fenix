import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalParametroDriftProvider extends ProviderBase {

	Future<List<FiscalParametroModel>?> getList({Filter? filter}) async {
		List<FiscalParametroGrouped> fiscalParametroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalParametroDriftList = await Session.database.fiscalParametroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalParametroDriftList = await Session.database.fiscalParametroDao.getGroupedList(); 
			}
			if (fiscalParametroDriftList.isNotEmpty) {
				return toListModel(fiscalParametroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalParametroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalParametroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalParametroModel?>? insert(FiscalParametroModel fiscalParametroModel) async {
		try {
			final lastPk = await Session.database.fiscalParametroDao.insertObject(toDrift(fiscalParametroModel));
			fiscalParametroModel.id = lastPk;
			return fiscalParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalParametroModel?>? update(FiscalParametroModel fiscalParametroModel) async {
		try {
			await Session.database.fiscalParametroDao.updateObject(toDrift(fiscalParametroModel));
			return fiscalParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalParametroDao.deleteObject(toDrift(FiscalParametroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalParametroModel> toListModel(List<FiscalParametroGrouped> fiscalParametroDriftList) {
		List<FiscalParametroModel> listModel = [];
		for (var fiscalParametroDrift in fiscalParametroDriftList) {
			listModel.add(toModel(fiscalParametroDrift)!);
		}
		return listModel;
	}	

	FiscalParametroModel? toModel(FiscalParametroGrouped? fiscalParametroDrift) {
		if (fiscalParametroDrift != null) {
			return FiscalParametroModel(
				id: fiscalParametroDrift.fiscalParametro?.id,
				idFiscalEstadualPorte: fiscalParametroDrift.fiscalParametro?.idFiscalEstadualPorte,
				idFiscalEstadualRegime: fiscalParametroDrift.fiscalParametro?.idFiscalEstadualRegime,
				idFiscalMunicipalRegime: fiscalParametroDrift.fiscalParametro?.idFiscalMunicipalRegime,
				vigencia: fiscalParametroDrift.fiscalParametro?.vigencia,
				descricaoVigencia: fiscalParametroDrift.fiscalParametro?.descricaoVigencia,
				criterioLancamento: FiscalParametroDomain.getCriterioLancamento(fiscalParametroDrift.fiscalParametro?.criterioLancamento),
				apuracao: FiscalParametroDomain.getApuracao(fiscalParametroDrift.fiscalParametro?.apuracao),
				microempreeIndividual: FiscalParametroDomain.getMicroempreeIndividual(fiscalParametroDrift.fiscalParametro?.microempreeIndividual),
				calcPisCofinsEfd: FiscalParametroDomain.getCalcPisCofinsEfd(fiscalParametroDrift.fiscalParametro?.calcPisCofinsEfd),
				simplesCodigoAcesso: fiscalParametroDrift.fiscalParametro?.simplesCodigoAcesso,
				simplesTabela: FiscalParametroDomain.getSimplesTabela(fiscalParametroDrift.fiscalParametro?.simplesTabela),
				simplesAtividade: FiscalParametroDomain.getSimplesAtividade(fiscalParametroDrift.fiscalParametro?.simplesAtividade),
				perfilSped: FiscalParametroDomain.getPerfilSped(fiscalParametroDrift.fiscalParametro?.perfilSped),
				apuracaoConsolidada: FiscalParametroDomain.getApuracaoConsolidada(fiscalParametroDrift.fiscalParametro?.apuracaoConsolidada),
				substituicaoTributaria: FiscalParametroDomain.getSubstituicaoTributaria(fiscalParametroDrift.fiscalParametro?.substituicaoTributaria),
				formaCalculoIss: FiscalParametroDomain.getFormaCalculoIss(fiscalParametroDrift.fiscalParametro?.formaCalculoIss),
				fiscalInscricoesSubstitutasModelList: fiscalInscricoesSubstitutasDriftToModel(fiscalParametroDrift.fiscalInscricoesSubstitutasGroupedList),
				fiscalEstadualRegimeModel: FiscalEstadualRegimeModel(
					id: fiscalParametroDrift.fiscalEstadualRegime?.id,
					uf: fiscalParametroDrift.fiscalEstadualRegime?.uf,
					codigo: fiscalParametroDrift.fiscalEstadualRegime?.codigo,
					nome: fiscalParametroDrift.fiscalEstadualRegime?.nome,
				),
				fiscalEstadualPorteModel: FiscalEstadualPorteModel(
					id: fiscalParametroDrift.fiscalEstadualPorte?.id,
					uf: fiscalParametroDrift.fiscalEstadualPorte?.uf,
					codigo: fiscalParametroDrift.fiscalEstadualPorte?.codigo,
					nome: fiscalParametroDrift.fiscalEstadualPorte?.nome,
				),
				fiscalMunicipalRegimeModel: FiscalMunicipalRegimeModel(
					id: fiscalParametroDrift.fiscalMunicipalRegime?.id,
					uf: fiscalParametroDrift.fiscalMunicipalRegime?.uf,
					codigo: fiscalParametroDrift.fiscalMunicipalRegime?.codigo,
					nome: fiscalParametroDrift.fiscalMunicipalRegime?.nome,
				),
			);
		} else {
			return null;
		}
	}

	List<FiscalInscricoesSubstitutasModel> fiscalInscricoesSubstitutasDriftToModel(List<FiscalInscricoesSubstitutasGrouped>? fiscalInscricoesSubstitutasDriftList) { 
		List<FiscalInscricoesSubstitutasModel> fiscalInscricoesSubstitutasModelList = [];
		if (fiscalInscricoesSubstitutasDriftList != null) {
			for (var fiscalInscricoesSubstitutasGrouped in fiscalInscricoesSubstitutasDriftList) {
				fiscalInscricoesSubstitutasModelList.add(
					FiscalInscricoesSubstitutasModel(
						id: fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.id,
						idFiscalParametros: fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.idFiscalParametros,
						uf: FiscalInscricoesSubstitutasDomain.getUf(fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.uf),
						inscricaoEstadual: fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.inscricaoEstadual,
						pmpf: FiscalInscricoesSubstitutasDomain.getPmpf(fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.pmpf),
					)
				);
			}
			return fiscalInscricoesSubstitutasModelList;
		}
		return [];
	}


	FiscalParametroGrouped toDrift(FiscalParametroModel fiscalParametroModel) {
		return FiscalParametroGrouped(
			fiscalParametro: FiscalParametro(
				id: fiscalParametroModel.id,
				idFiscalEstadualPorte: fiscalParametroModel.idFiscalEstadualPorte,
				idFiscalEstadualRegime: fiscalParametroModel.idFiscalEstadualRegime,
				idFiscalMunicipalRegime: fiscalParametroModel.idFiscalMunicipalRegime,
				vigencia: Util.removeMask(fiscalParametroModel.vigencia),
				descricaoVigencia: fiscalParametroModel.descricaoVigencia,
				criterioLancamento: FiscalParametroDomain.setCriterioLancamento(fiscalParametroModel.criterioLancamento),
				apuracao: FiscalParametroDomain.setApuracao(fiscalParametroModel.apuracao),
				microempreeIndividual: FiscalParametroDomain.setMicroempreeIndividual(fiscalParametroModel.microempreeIndividual),
				calcPisCofinsEfd: FiscalParametroDomain.setCalcPisCofinsEfd(fiscalParametroModel.calcPisCofinsEfd),
				simplesCodigoAcesso: fiscalParametroModel.simplesCodigoAcesso,
				simplesTabela: FiscalParametroDomain.setSimplesTabela(fiscalParametroModel.simplesTabela),
				simplesAtividade: FiscalParametroDomain.setSimplesAtividade(fiscalParametroModel.simplesAtividade),
				perfilSped: FiscalParametroDomain.setPerfilSped(fiscalParametroModel.perfilSped),
				apuracaoConsolidada: FiscalParametroDomain.setApuracaoConsolidada(fiscalParametroModel.apuracaoConsolidada),
				substituicaoTributaria: FiscalParametroDomain.setSubstituicaoTributaria(fiscalParametroModel.substituicaoTributaria),
				formaCalculoIss: FiscalParametroDomain.setFormaCalculoIss(fiscalParametroModel.formaCalculoIss),
			),
			fiscalInscricoesSubstitutasGroupedList: fiscalInscricoesSubstitutasModelToDrift(fiscalParametroModel.fiscalInscricoesSubstitutasModelList),
		);
	}

	List<FiscalInscricoesSubstitutasGrouped> fiscalInscricoesSubstitutasModelToDrift(List<FiscalInscricoesSubstitutasModel>? fiscalInscricoesSubstitutasModelList) { 
		List<FiscalInscricoesSubstitutasGrouped> fiscalInscricoesSubstitutasGroupedList = [];
		if (fiscalInscricoesSubstitutasModelList != null) {
			for (var fiscalInscricoesSubstitutasModel in fiscalInscricoesSubstitutasModelList) {
				fiscalInscricoesSubstitutasGroupedList.add(
					FiscalInscricoesSubstitutasGrouped(
						fiscalInscricoesSubstitutas: FiscalInscricoesSubstitutas(
							id: fiscalInscricoesSubstitutasModel.id,
							idFiscalParametros: fiscalInscricoesSubstitutasModel.idFiscalParametros,
							uf: FiscalInscricoesSubstitutasDomain.setUf(fiscalInscricoesSubstitutasModel.uf),
							inscricaoEstadual: fiscalInscricoesSubstitutasModel.inscricaoEstadual,
							pmpf: FiscalInscricoesSubstitutasDomain.setPmpf(fiscalInscricoesSubstitutasModel.pmpf),
						),
					),
				);
			}
			return fiscalInscricoesSubstitutasGroupedList;
		}
		return [];
	}

		
}
