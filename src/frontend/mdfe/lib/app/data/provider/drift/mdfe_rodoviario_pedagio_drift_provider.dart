import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioPedagioDriftProvider extends ProviderBase {

	Future<List<MdfeRodoviarioPedagioModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioPedagioGrouped> mdfeRodoviarioPedagioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeRodoviarioPedagioDriftList = await Session.database.mdfeRodoviarioPedagioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeRodoviarioPedagioDriftList = await Session.database.mdfeRodoviarioPedagioDao.getGroupedList(); 
			}
			if (mdfeRodoviarioPedagioDriftList.isNotEmpty) {
				return toListModel(mdfeRodoviarioPedagioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeRodoviarioPedagioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeRodoviarioPedagioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioPedagioModel?>? insert(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) async {
		try {
			final lastPk = await Session.database.mdfeRodoviarioPedagioDao.insertObject(toDrift(mdfeRodoviarioPedagioModel));
			mdfeRodoviarioPedagioModel.id = lastPk;
			return mdfeRodoviarioPedagioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioPedagioModel?>? update(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) async {
		try {
			await Session.database.mdfeRodoviarioPedagioDao.updateObject(toDrift(mdfeRodoviarioPedagioModel));
			return mdfeRodoviarioPedagioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeRodoviarioPedagioDao.deleteObject(toDrift(MdfeRodoviarioPedagioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeRodoviarioPedagioModel> toListModel(List<MdfeRodoviarioPedagioGrouped> mdfeRodoviarioPedagioDriftList) {
		List<MdfeRodoviarioPedagioModel> listModel = [];
		for (var mdfeRodoviarioPedagioDrift in mdfeRodoviarioPedagioDriftList) {
			listModel.add(toModel(mdfeRodoviarioPedagioDrift)!);
		}
		return listModel;
	}	

	MdfeRodoviarioPedagioModel? toModel(MdfeRodoviarioPedagioGrouped? mdfeRodoviarioPedagioDrift) {
		if (mdfeRodoviarioPedagioDrift != null) {
			return MdfeRodoviarioPedagioModel(
				id: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.id,
				idMdfeRodoviario: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.idMdfeRodoviario,
				cnpjFornecedor: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.cnpjFornecedor,
				cnpjResponsavel: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.cnpjResponsavel,
				cpfResponsavel: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.cpfResponsavel,
				numeroComprovante: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.numeroComprovante,
				valor: mdfeRodoviarioPedagioDrift.mdfeRodoviarioPedagio?.valor,
				mdfeRodoviarioModel: MdfeRodoviarioModel(
					id: mdfeRodoviarioPedagioDrift.mdfeRodoviario?.id,
					idMdfeCabecalho: mdfeRodoviarioPedagioDrift.mdfeRodoviario?.idMdfeCabecalho,
					rntrc: mdfeRodoviarioPedagioDrift.mdfeRodoviario?.rntrc,
					codigoAgendamento: mdfeRodoviarioPedagioDrift.mdfeRodoviario?.codigoAgendamento,
				),
			);
		} else {
			return null;
		}
	}


	MdfeRodoviarioPedagioGrouped toDrift(MdfeRodoviarioPedagioModel mdfeRodoviarioPedagioModel) {
		return MdfeRodoviarioPedagioGrouped(
			mdfeRodoviarioPedagio: MdfeRodoviarioPedagio(
				id: mdfeRodoviarioPedagioModel.id,
				idMdfeRodoviario: mdfeRodoviarioPedagioModel.idMdfeRodoviario,
				cnpjFornecedor: Util.removeMask(mdfeRodoviarioPedagioModel.cnpjFornecedor),
				cnpjResponsavel: Util.removeMask(mdfeRodoviarioPedagioModel.cnpjResponsavel),
				cpfResponsavel: Util.removeMask(mdfeRodoviarioPedagioModel.cpfResponsavel),
				numeroComprovante: mdfeRodoviarioPedagioModel.numeroComprovante,
				valor: mdfeRodoviarioPedagioModel.valor,
			),
		);
	}

		
}
