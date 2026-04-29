import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioPedagioDriftProvider extends ProviderBase {

	Future<List<CteRodoviarioPedagioModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioPedagioGrouped> cteRodoviarioPedagioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteRodoviarioPedagioDriftList = await Session.database.cteRodoviarioPedagioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteRodoviarioPedagioDriftList = await Session.database.cteRodoviarioPedagioDao.getGroupedList(); 
			}
			if (cteRodoviarioPedagioDriftList.isNotEmpty) {
				return toListModel(cteRodoviarioPedagioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteRodoviarioPedagioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteRodoviarioPedagioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioPedagioModel?>? insert(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) async {
		try {
			final lastPk = await Session.database.cteRodoviarioPedagioDao.insertObject(toDrift(cteRodoviarioPedagioModel));
			cteRodoviarioPedagioModel.id = lastPk;
			return cteRodoviarioPedagioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioPedagioModel?>? update(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) async {
		try {
			await Session.database.cteRodoviarioPedagioDao.updateObject(toDrift(cteRodoviarioPedagioModel));
			return cteRodoviarioPedagioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteRodoviarioPedagioDao.deleteObject(toDrift(CteRodoviarioPedagioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteRodoviarioPedagioModel> toListModel(List<CteRodoviarioPedagioGrouped> cteRodoviarioPedagioDriftList) {
		List<CteRodoviarioPedagioModel> listModel = [];
		for (var cteRodoviarioPedagioDrift in cteRodoviarioPedagioDriftList) {
			listModel.add(toModel(cteRodoviarioPedagioDrift)!);
		}
		return listModel;
	}	

	CteRodoviarioPedagioModel? toModel(CteRodoviarioPedagioGrouped? cteRodoviarioPedagioDrift) {
		if (cteRodoviarioPedagioDrift != null) {
			return CteRodoviarioPedagioModel(
				id: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.id,
				idCteRodoviario: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.idCteRodoviario,
				cnpjFornecedor: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.cnpjFornecedor,
				comprovanteCompra: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.comprovanteCompra,
				cnpjResponsavel: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.cnpjResponsavel,
				valor: cteRodoviarioPedagioDrift.cteRodoviarioPedagio?.valor,
				cteRodoviarioModel: CteRodoviarioModel(
					id: cteRodoviarioPedagioDrift.cteRodoviario?.id,
					idCteCabecalho: cteRodoviarioPedagioDrift.cteRodoviario?.idCteCabecalho,
					rntrc: cteRodoviarioPedagioDrift.cteRodoviario?.rntrc,
					dataPrevistaEntrega: cteRodoviarioPedagioDrift.cteRodoviario?.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioPedagioDrift.cteRodoviario?.indicadorLotacao,
					ciot: cteRodoviarioPedagioDrift.cteRodoviario?.ciot,
				),
			);
		} else {
			return null;
		}
	}


	CteRodoviarioPedagioGrouped toDrift(CteRodoviarioPedagioModel cteRodoviarioPedagioModel) {
		return CteRodoviarioPedagioGrouped(
			cteRodoviarioPedagio: CteRodoviarioPedagio(
				id: cteRodoviarioPedagioModel.id,
				idCteRodoviario: cteRodoviarioPedagioModel.idCteRodoviario,
				cnpjFornecedor: Util.removeMask(cteRodoviarioPedagioModel.cnpjFornecedor),
				comprovanteCompra: cteRodoviarioPedagioModel.comprovanteCompra,
				cnpjResponsavel: Util.removeMask(cteRodoviarioPedagioModel.cnpjResponsavel),
				valor: cteRodoviarioPedagioModel.valor,
			),
		);
	}

		
}
