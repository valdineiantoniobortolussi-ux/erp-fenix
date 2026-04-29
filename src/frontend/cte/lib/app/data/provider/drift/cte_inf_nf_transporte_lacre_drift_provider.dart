import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfTransporteLacreDriftProvider extends ProviderBase {

	Future<List<CteInfNfTransporteLacreModel>?> getList({Filter? filter}) async {
		List<CteInfNfTransporteLacreGrouped> cteInfNfTransporteLacreDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteInfNfTransporteLacreDriftList = await Session.database.cteInfNfTransporteLacreDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteInfNfTransporteLacreDriftList = await Session.database.cteInfNfTransporteLacreDao.getGroupedList(); 
			}
			if (cteInfNfTransporteLacreDriftList.isNotEmpty) {
				return toListModel(cteInfNfTransporteLacreDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteInfNfTransporteLacreModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteInfNfTransporteLacreDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInfNfTransporteLacreModel?>? insert(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) async {
		try {
			final lastPk = await Session.database.cteInfNfTransporteLacreDao.insertObject(toDrift(cteInfNfTransporteLacreModel));
			cteInfNfTransporteLacreModel.id = lastPk;
			return cteInfNfTransporteLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteInfNfTransporteLacreModel?>? update(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) async {
		try {
			await Session.database.cteInfNfTransporteLacreDao.updateObject(toDrift(cteInfNfTransporteLacreModel));
			return cteInfNfTransporteLacreModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteInfNfTransporteLacreDao.deleteObject(toDrift(CteInfNfTransporteLacreModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteInfNfTransporteLacreModel> toListModel(List<CteInfNfTransporteLacreGrouped> cteInfNfTransporteLacreDriftList) {
		List<CteInfNfTransporteLacreModel> listModel = [];
		for (var cteInfNfTransporteLacreDrift in cteInfNfTransporteLacreDriftList) {
			listModel.add(toModel(cteInfNfTransporteLacreDrift)!);
		}
		return listModel;
	}	

	CteInfNfTransporteLacreModel? toModel(CteInfNfTransporteLacreGrouped? cteInfNfTransporteLacreDrift) {
		if (cteInfNfTransporteLacreDrift != null) {
			return CteInfNfTransporteLacreModel(
				id: cteInfNfTransporteLacreDrift.cteInfNfTransporteLacre?.id,
				idCteInformacaoNfTransporte: cteInfNfTransporteLacreDrift.cteInfNfTransporteLacre?.idCteInformacaoNfTransporte,
				numero: cteInfNfTransporteLacreDrift.cteInfNfTransporteLacre?.numero,
				cteInformacaoNfTransporteModel: CteInformacaoNfTransporteModel(
					id: cteInfNfTransporteLacreDrift.cteInformacaoNfTransporte?.id,
					idCteInformacaoNf: cteInfNfTransporteLacreDrift.cteInformacaoNfTransporte?.idCteInformacaoNf,
					tipoUnidadeTransporte: cteInfNfTransporteLacreDrift.cteInformacaoNfTransporte?.tipoUnidadeTransporte,
					idUnidadeTransporte: cteInfNfTransporteLacreDrift.cteInformacaoNfTransporte?.idUnidadeTransporte,
				),
			);
		} else {
			return null;
		}
	}


	CteInfNfTransporteLacreGrouped toDrift(CteInfNfTransporteLacreModel cteInfNfTransporteLacreModel) {
		return CteInfNfTransporteLacreGrouped(
			cteInfNfTransporteLacre: CteInfNfTransporteLacre(
				id: cteInfNfTransporteLacreModel.id,
				idCteInformacaoNfTransporte: cteInfNfTransporteLacreModel.idCteInformacaoNfTransporte,
				numero: cteInfNfTransporteLacreModel.numero,
			),
		);
	}

		
}
