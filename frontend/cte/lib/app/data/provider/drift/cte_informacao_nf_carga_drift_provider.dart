import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteInformacaoNfCargaDriftProvider extends ProviderBase {

	Future<List<CteInformacaoNfCargaModel>?> getList({Filter? filter}) async {
		List<CteInformacaoNfCargaGrouped> cteInformacaoNfCargaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteInformacaoNfCargaDriftList = await Session.database.cteInformacaoNfCargaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteInformacaoNfCargaDriftList = await Session.database.cteInformacaoNfCargaDao.getGroupedList(); 
			}
			if (cteInformacaoNfCargaDriftList.isNotEmpty) {
				return toListModel(cteInformacaoNfCargaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteInformacaoNfCargaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteInformacaoNfCargaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInformacaoNfCargaModel?>? insert(CteInformacaoNfCargaModel cteInformacaoNfCargaModel) async {
		try {
			final lastPk = await Session.database.cteInformacaoNfCargaDao.insertObject(toDrift(cteInformacaoNfCargaModel));
			cteInformacaoNfCargaModel.id = lastPk;
			return cteInformacaoNfCargaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInformacaoNfCargaModel?>? update(CteInformacaoNfCargaModel cteInformacaoNfCargaModel) async {
		try {
			await Session.database.cteInformacaoNfCargaDao.updateObject(toDrift(cteInformacaoNfCargaModel));
			return cteInformacaoNfCargaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteInformacaoNfCargaDao.deleteObject(toDrift(CteInformacaoNfCargaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteInformacaoNfCargaModel> toListModel(List<CteInformacaoNfCargaGrouped> cteInformacaoNfCargaDriftList) {
		List<CteInformacaoNfCargaModel> listModel = [];
		for (var cteInformacaoNfCargaDrift in cteInformacaoNfCargaDriftList) {
			listModel.add(toModel(cteInformacaoNfCargaDrift)!);
		}
		return listModel;
	}	

	CteInformacaoNfCargaModel? toModel(CteInformacaoNfCargaGrouped? cteInformacaoNfCargaDrift) {
		if (cteInformacaoNfCargaDrift != null) {
			return CteInformacaoNfCargaModel(
				id: cteInformacaoNfCargaDrift.cteInformacaoNfCarga?.id,
				idCteInformacaoNf: cteInformacaoNfCargaDrift.cteInformacaoNfCarga?.idCteInformacaoNf,
				tipoUnidadeCarga: CteInformacaoNfCargaDomain.getTipoUnidadeCarga(cteInformacaoNfCargaDrift.cteInformacaoNfCarga?.tipoUnidadeCarga),
				idUnidadeCarga: cteInformacaoNfCargaDrift.cteInformacaoNfCarga?.idUnidadeCarga,
				cteInformacaoNfOutrosModel: CteInformacaoNfOutrosModel(
					id: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.id,
					idCteCabecalho: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.idCteCabecalho,
					numeroRomaneio: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.numeroRomaneio,
					numeroPedido: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.numeroPedido,
					chaveAcessoNfe: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.chaveAcessoNfe,
					codigoModelo: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.codigoModelo,
					serie: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.serie,
					numero: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.numero,
					dataEmissao: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.dataEmissao,
					ufEmitente: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.ufEmitente,
					baseCalculoIcms: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.baseCalculoIcms,
					valorIcms: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.valorIcms,
					baseCalculoIcmsSt: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.baseCalculoIcmsSt,
					valorIcmsSt: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.valorIcmsSt,
					valorTotalProdutos: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.valorTotalProdutos,
					valorTotal: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.valorTotal,
					cfopPredominante: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.cfopPredominante,
					pesoTotalKg: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.pesoTotalKg,
					pinSuframa: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.pinSuframa,
					dataPrevistaEntrega: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.dataPrevistaEntrega,
					outroTipoDocOrig: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.outroTipoDocOrig,
					outroDescricao: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.outroDescricao,
					outroValorDocumento: cteInformacaoNfCargaDrift.cteInformacaoNfOutros?.outroValorDocumento,
				),
			);
		} else {
			return null;
		}
	}


	CteInformacaoNfCargaGrouped toDrift(CteInformacaoNfCargaModel cteInformacaoNfCargaModel) {
		return CteInformacaoNfCargaGrouped(
			cteInformacaoNfCarga: CteInformacaoNfCarga(
				id: cteInformacaoNfCargaModel.id,
				idCteInformacaoNf: cteInformacaoNfCargaModel.idCteInformacaoNf,
				tipoUnidadeCarga: CteInformacaoNfCargaDomain.setTipoUnidadeCarga(cteInformacaoNfCargaModel.tipoUnidadeCarga),
				idUnidadeCarga: cteInformacaoNfCargaModel.idUnidadeCarga,
			),
		);
	}

		
}
