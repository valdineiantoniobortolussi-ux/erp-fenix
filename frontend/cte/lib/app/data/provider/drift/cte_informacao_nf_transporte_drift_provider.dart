import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteInformacaoNfTransporteDriftProvider extends ProviderBase {

	Future<List<CteInformacaoNfTransporteModel>?> getList({Filter? filter}) async {
		List<CteInformacaoNfTransporteGrouped> cteInformacaoNfTransporteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteInformacaoNfTransporteDriftList = await Session.database.cteInformacaoNfTransporteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteInformacaoNfTransporteDriftList = await Session.database.cteInformacaoNfTransporteDao.getGroupedList(); 
			}
			if (cteInformacaoNfTransporteDriftList.isNotEmpty) {
				return toListModel(cteInformacaoNfTransporteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteInformacaoNfTransporteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteInformacaoNfTransporteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInformacaoNfTransporteModel?>? insert(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) async {
		try {
			final lastPk = await Session.database.cteInformacaoNfTransporteDao.insertObject(toDrift(cteInformacaoNfTransporteModel));
			cteInformacaoNfTransporteModel.id = lastPk;
			return cteInformacaoNfTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInformacaoNfTransporteModel?>? update(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) async {
		try {
			await Session.database.cteInformacaoNfTransporteDao.updateObject(toDrift(cteInformacaoNfTransporteModel));
			return cteInformacaoNfTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteInformacaoNfTransporteDao.deleteObject(toDrift(CteInformacaoNfTransporteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteInformacaoNfTransporteModel> toListModel(List<CteInformacaoNfTransporteGrouped> cteInformacaoNfTransporteDriftList) {
		List<CteInformacaoNfTransporteModel> listModel = [];
		for (var cteInformacaoNfTransporteDrift in cteInformacaoNfTransporteDriftList) {
			listModel.add(toModel(cteInformacaoNfTransporteDrift)!);
		}
		return listModel;
	}	

	CteInformacaoNfTransporteModel? toModel(CteInformacaoNfTransporteGrouped? cteInformacaoNfTransporteDrift) {
		if (cteInformacaoNfTransporteDrift != null) {
			return CteInformacaoNfTransporteModel(
				id: cteInformacaoNfTransporteDrift.cteInformacaoNfTransporte?.id,
				idCteInformacaoNf: cteInformacaoNfTransporteDrift.cteInformacaoNfTransporte?.idCteInformacaoNf,
				tipoUnidadeTransporte: CteInformacaoNfTransporteDomain.getTipoUnidadeTransporte(cteInformacaoNfTransporteDrift.cteInformacaoNfTransporte?.tipoUnidadeTransporte),
				idUnidadeTransporte: cteInformacaoNfTransporteDrift.cteInformacaoNfTransporte?.idUnidadeTransporte,
				cteInformacaoNfOutrosModel: CteInformacaoNfOutrosModel(
					id: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.id,
					idCteCabecalho: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.idCteCabecalho,
					numeroRomaneio: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.numeroRomaneio,
					numeroPedido: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.numeroPedido,
					chaveAcessoNfe: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.chaveAcessoNfe,
					codigoModelo: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.codigoModelo,
					serie: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.serie,
					numero: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.numero,
					dataEmissao: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.dataEmissao,
					ufEmitente: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.ufEmitente,
					baseCalculoIcms: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.baseCalculoIcms,
					valorIcms: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.valorIcms,
					baseCalculoIcmsSt: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.baseCalculoIcmsSt,
					valorIcmsSt: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.valorIcmsSt,
					valorTotalProdutos: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.valorTotalProdutos,
					valorTotal: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.valorTotal,
					cfopPredominante: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.cfopPredominante,
					pesoTotalKg: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.pesoTotalKg,
					pinSuframa: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.pinSuframa,
					dataPrevistaEntrega: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.dataPrevistaEntrega,
					outroTipoDocOrig: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.outroTipoDocOrig,
					outroDescricao: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.outroDescricao,
					outroValorDocumento: cteInformacaoNfTransporteDrift.cteInformacaoNfOutros?.outroValorDocumento,
				),
			);
		} else {
			return null;
		}
	}


	CteInformacaoNfTransporteGrouped toDrift(CteInformacaoNfTransporteModel cteInformacaoNfTransporteModel) {
		return CteInformacaoNfTransporteGrouped(
			cteInformacaoNfTransporte: CteInformacaoNfTransporte(
				id: cteInformacaoNfTransporteModel.id,
				idCteInformacaoNf: cteInformacaoNfTransporteModel.idCteInformacaoNf,
				tipoUnidadeTransporte: CteInformacaoNfTransporteDomain.setTipoUnidadeTransporte(cteInformacaoNfTransporteModel.tipoUnidadeTransporte),
				idUnidadeTransporte: cteInformacaoNfTransporteModel.idUnidadeTransporte,
			),
		);
	}

		
}
