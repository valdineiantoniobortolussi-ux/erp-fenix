import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteAquaviarioBalsaDriftProvider extends ProviderBase {

	Future<List<CteAquaviarioBalsaModel>?> getList({Filter? filter}) async {
		List<CteAquaviarioBalsaGrouped> cteAquaviarioBalsaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteAquaviarioBalsaDriftList = await Session.database.cteAquaviarioBalsaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteAquaviarioBalsaDriftList = await Session.database.cteAquaviarioBalsaDao.getGroupedList(); 
			}
			if (cteAquaviarioBalsaDriftList.isNotEmpty) {
				return toListModel(cteAquaviarioBalsaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteAquaviarioBalsaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteAquaviarioBalsaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteAquaviarioBalsaModel?>? insert(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) async {
		try {
			final lastPk = await Session.database.cteAquaviarioBalsaDao.insertObject(toDrift(cteAquaviarioBalsaModel));
			cteAquaviarioBalsaModel.id = lastPk;
			return cteAquaviarioBalsaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteAquaviarioBalsaModel?>? update(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) async {
		try {
			await Session.database.cteAquaviarioBalsaDao.updateObject(toDrift(cteAquaviarioBalsaModel));
			return cteAquaviarioBalsaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteAquaviarioBalsaDao.deleteObject(toDrift(CteAquaviarioBalsaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteAquaviarioBalsaModel> toListModel(List<CteAquaviarioBalsaGrouped> cteAquaviarioBalsaDriftList) {
		List<CteAquaviarioBalsaModel> listModel = [];
		for (var cteAquaviarioBalsaDrift in cteAquaviarioBalsaDriftList) {
			listModel.add(toModel(cteAquaviarioBalsaDrift)!);
		}
		return listModel;
	}	

	CteAquaviarioBalsaModel? toModel(CteAquaviarioBalsaGrouped? cteAquaviarioBalsaDrift) {
		if (cteAquaviarioBalsaDrift != null) {
			return CteAquaviarioBalsaModel(
				id: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.id,
				idCteAquaviario: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.idCteAquaviario,
				idBalsa: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.idBalsa,
				numeroViagem: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.numeroViagem,
				direcao: CteAquaviarioBalsaDomain.getDirecao(cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.direcao),
				portoEmbarque: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.portoEmbarque,
				portoTransbordo: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.portoTransbordo,
				portoDestino: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.portoDestino,
				tipoNavegacao: CteAquaviarioBalsaDomain.getTipoNavegacao(cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.tipoNavegacao),
				irin: cteAquaviarioBalsaDrift.cteAquaviarioBalsa?.irin,
				cteAquaviarioModel: CteAquaviarioModel(
					id: cteAquaviarioBalsaDrift.cteAquaviario?.id,
					idCteCabecalho: cteAquaviarioBalsaDrift.cteAquaviario?.idCteCabecalho,
					valorPrestacao: cteAquaviarioBalsaDrift.cteAquaviario?.valorPrestacao,
					afrmm: cteAquaviarioBalsaDrift.cteAquaviario?.afrmm,
					numeroBooking: cteAquaviarioBalsaDrift.cteAquaviario?.numeroBooking,
					numeroControle: cteAquaviarioBalsaDrift.cteAquaviario?.numeroControle,
					idNavio: cteAquaviarioBalsaDrift.cteAquaviario?.idNavio,
				),
			);
		} else {
			return null;
		}
	}


	CteAquaviarioBalsaGrouped toDrift(CteAquaviarioBalsaModel cteAquaviarioBalsaModel) {
		return CteAquaviarioBalsaGrouped(
			cteAquaviarioBalsa: CteAquaviarioBalsa(
				id: cteAquaviarioBalsaModel.id,
				idCteAquaviario: cteAquaviarioBalsaModel.idCteAquaviario,
				idBalsa: cteAquaviarioBalsaModel.idBalsa,
				numeroViagem: cteAquaviarioBalsaModel.numeroViagem,
				direcao: CteAquaviarioBalsaDomain.setDirecao(cteAquaviarioBalsaModel.direcao),
				portoEmbarque: cteAquaviarioBalsaModel.portoEmbarque,
				portoTransbordo: cteAquaviarioBalsaModel.portoTransbordo,
				portoDestino: cteAquaviarioBalsaModel.portoDestino,
				tipoNavegacao: CteAquaviarioBalsaDomain.setTipoNavegacao(cteAquaviarioBalsaModel.tipoNavegacao),
				irin: cteAquaviarioBalsaModel.irin,
			),
		);
	}

		
}
