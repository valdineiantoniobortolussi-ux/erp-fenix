import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioCiotDriftProvider extends ProviderBase {

	Future<List<MdfeRodoviarioCiotModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioCiotGrouped> mdfeRodoviarioCiotDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeRodoviarioCiotDriftList = await Session.database.mdfeRodoviarioCiotDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeRodoviarioCiotDriftList = await Session.database.mdfeRodoviarioCiotDao.getGroupedList(); 
			}
			if (mdfeRodoviarioCiotDriftList.isNotEmpty) {
				return toListModel(mdfeRodoviarioCiotDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeRodoviarioCiotModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeRodoviarioCiotDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioCiotModel?>? insert(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) async {
		try {
			final lastPk = await Session.database.mdfeRodoviarioCiotDao.insertObject(toDrift(mdfeRodoviarioCiotModel));
			mdfeRodoviarioCiotModel.id = lastPk;
			return mdfeRodoviarioCiotModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioCiotModel?>? update(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) async {
		try {
			await Session.database.mdfeRodoviarioCiotDao.updateObject(toDrift(mdfeRodoviarioCiotModel));
			return mdfeRodoviarioCiotModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeRodoviarioCiotDao.deleteObject(toDrift(MdfeRodoviarioCiotModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeRodoviarioCiotModel> toListModel(List<MdfeRodoviarioCiotGrouped> mdfeRodoviarioCiotDriftList) {
		List<MdfeRodoviarioCiotModel> listModel = [];
		for (var mdfeRodoviarioCiotDrift in mdfeRodoviarioCiotDriftList) {
			listModel.add(toModel(mdfeRodoviarioCiotDrift)!);
		}
		return listModel;
	}	

	MdfeRodoviarioCiotModel? toModel(MdfeRodoviarioCiotGrouped? mdfeRodoviarioCiotDrift) {
		if (mdfeRodoviarioCiotDrift != null) {
			return MdfeRodoviarioCiotModel(
				id: mdfeRodoviarioCiotDrift.mdfeRodoviarioCiot?.id,
				idMdfeRodoviario: mdfeRodoviarioCiotDrift.mdfeRodoviarioCiot?.idMdfeRodoviario,
				ciot: mdfeRodoviarioCiotDrift.mdfeRodoviarioCiot?.ciot,
				cpf: mdfeRodoviarioCiotDrift.mdfeRodoviarioCiot?.cpf,
				cnpj: mdfeRodoviarioCiotDrift.mdfeRodoviarioCiot?.cnpj,
				mdfeRodoviarioModel: MdfeRodoviarioModel(
					id: mdfeRodoviarioCiotDrift.mdfeRodoviario?.id,
					idMdfeCabecalho: mdfeRodoviarioCiotDrift.mdfeRodoviario?.idMdfeCabecalho,
					rntrc: mdfeRodoviarioCiotDrift.mdfeRodoviario?.rntrc,
					codigoAgendamento: mdfeRodoviarioCiotDrift.mdfeRodoviario?.codigoAgendamento,
				),
			);
		} else {
			return null;
		}
	}


	MdfeRodoviarioCiotGrouped toDrift(MdfeRodoviarioCiotModel mdfeRodoviarioCiotModel) {
		return MdfeRodoviarioCiotGrouped(
			mdfeRodoviarioCiot: MdfeRodoviarioCiot(
				id: mdfeRodoviarioCiotModel.id,
				idMdfeRodoviario: mdfeRodoviarioCiotModel.idMdfeRodoviario,
				ciot: mdfeRodoviarioCiotModel.ciot,
				cpf: Util.removeMask(mdfeRodoviarioCiotModel.cpf),
				cnpj: Util.removeMask(mdfeRodoviarioCiotModel.cnpj),
			),
		);
	}

		
}
