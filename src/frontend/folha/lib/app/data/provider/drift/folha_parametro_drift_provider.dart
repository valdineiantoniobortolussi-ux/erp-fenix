import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaParametroDriftProvider extends ProviderBase {

	Future<List<FolhaParametroModel>?> getList({Filter? filter}) async {
		List<FolhaParametroGrouped> folhaParametroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaParametroDriftList = await Session.database.folhaParametroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaParametroDriftList = await Session.database.folhaParametroDao.getGroupedList(); 
			}
			if (folhaParametroDriftList.isNotEmpty) {
				return toListModel(folhaParametroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaParametroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaParametroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaParametroModel?>? insert(FolhaParametroModel folhaParametroModel) async {
		try {
			final lastPk = await Session.database.folhaParametroDao.insertObject(toDrift(folhaParametroModel));
			folhaParametroModel.id = lastPk;
			return folhaParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaParametroModel?>? update(FolhaParametroModel folhaParametroModel) async {
		try {
			await Session.database.folhaParametroDao.updateObject(toDrift(folhaParametroModel));
			return folhaParametroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaParametroDao.deleteObject(toDrift(FolhaParametroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaParametroModel> toListModel(List<FolhaParametroGrouped> folhaParametroDriftList) {
		List<FolhaParametroModel> listModel = [];
		for (var folhaParametroDrift in folhaParametroDriftList) {
			listModel.add(toModel(folhaParametroDrift)!);
		}
		return listModel;
	}	

	FolhaParametroModel? toModel(FolhaParametroGrouped? folhaParametroDrift) {
		if (folhaParametroDrift != null) {
			return FolhaParametroModel(
				id: folhaParametroDrift.folhaParametro?.id,
				competencia: folhaParametroDrift.folhaParametro?.competencia,
				contribuiPis: FolhaParametroDomain.getContribuiPis(folhaParametroDrift.folhaParametro?.contribuiPis),
				aliquotaPis: folhaParametroDrift.folhaParametro?.aliquotaPis,
				discriminarDsr: FolhaParametroDomain.getDiscriminarDsr(folhaParametroDrift.folhaParametro?.discriminarDsr),
				diaPagamento: folhaParametroDrift.folhaParametro?.diaPagamento,
				calculoProporcionalidade: FolhaParametroDomain.getCalculoProporcionalidade(folhaParametroDrift.folhaParametro?.calculoProporcionalidade),
				descontarFaltas13: FolhaParametroDomain.getDescontarFaltas13(folhaParametroDrift.folhaParametro?.descontarFaltas13),
				pagarAdicionais13: FolhaParametroDomain.getPagarAdicionais13(folhaParametroDrift.folhaParametro?.pagarAdicionais13),
				pagarEstagiarios13: FolhaParametroDomain.getPagarEstagiarios13(folhaParametroDrift.folhaParametro?.pagarEstagiarios13),
				mesAdiantamento13: folhaParametroDrift.folhaParametro?.mesAdiantamento13,
				percentualAdiantam13: folhaParametroDrift.folhaParametro?.percentualAdiantam13,
				feriasDescontarFaltas: FolhaParametroDomain.getFeriasDescontarFaltas(folhaParametroDrift.folhaParametro?.feriasDescontarFaltas),
				feriasPagarAdicionais: FolhaParametroDomain.getFeriasPagarAdicionais(folhaParametroDrift.folhaParametro?.feriasPagarAdicionais),
				feriasAdiantar13: FolhaParametroDomain.getFeriasAdiantar13(folhaParametroDrift.folhaParametro?.feriasAdiantar13),
				feriasPagarEstagiarios: FolhaParametroDomain.getFeriasPagarEstagiarios(folhaParametroDrift.folhaParametro?.feriasPagarEstagiarios),
				feriasCalcJustaCausa: FolhaParametroDomain.getFeriasCalcJustaCausa(folhaParametroDrift.folhaParametro?.feriasCalcJustaCausa),
				feriasMovimentoMensal: FolhaParametroDomain.getFeriasMovimentoMensal(folhaParametroDrift.folhaParametro?.feriasMovimentoMensal),
			);
		} else {
			return null;
		}
	}


	FolhaParametroGrouped toDrift(FolhaParametroModel folhaParametroModel) {
		return FolhaParametroGrouped(
			folhaParametro: FolhaParametro(
				id: folhaParametroModel.id,
				competencia: Util.removeMask(folhaParametroModel.competencia),
				contribuiPis: FolhaParametroDomain.setContribuiPis(folhaParametroModel.contribuiPis),
				aliquotaPis: folhaParametroModel.aliquotaPis,
				discriminarDsr: FolhaParametroDomain.setDiscriminarDsr(folhaParametroModel.discriminarDsr),
				diaPagamento: folhaParametroModel.diaPagamento,
				calculoProporcionalidade: FolhaParametroDomain.setCalculoProporcionalidade(folhaParametroModel.calculoProporcionalidade),
				descontarFaltas13: FolhaParametroDomain.setDescontarFaltas13(folhaParametroModel.descontarFaltas13),
				pagarAdicionais13: FolhaParametroDomain.setPagarAdicionais13(folhaParametroModel.pagarAdicionais13),
				pagarEstagiarios13: FolhaParametroDomain.setPagarEstagiarios13(folhaParametroModel.pagarEstagiarios13),
				mesAdiantamento13: folhaParametroModel.mesAdiantamento13,
				percentualAdiantam13: folhaParametroModel.percentualAdiantam13,
				feriasDescontarFaltas: FolhaParametroDomain.setFeriasDescontarFaltas(folhaParametroModel.feriasDescontarFaltas),
				feriasPagarAdicionais: FolhaParametroDomain.setFeriasPagarAdicionais(folhaParametroModel.feriasPagarAdicionais),
				feriasAdiantar13: FolhaParametroDomain.setFeriasAdiantar13(folhaParametroModel.feriasAdiantar13),
				feriasPagarEstagiarios: FolhaParametroDomain.setFeriasPagarEstagiarios(folhaParametroModel.feriasPagarEstagiarios),
				feriasCalcJustaCausa: FolhaParametroDomain.setFeriasCalcJustaCausa(folhaParametroModel.feriasCalcJustaCausa),
				feriasMovimentoMensal: FolhaParametroDomain.setFeriasMovimentoMensal(folhaParametroModel.feriasMovimentoMensal),
			),
		);
	}

		
}
