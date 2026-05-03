import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioMotoristaDriftProvider extends ProviderBase {

	Future<List<MdfeRodoviarioMotoristaModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioMotoristaGrouped> mdfeRodoviarioMotoristaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeRodoviarioMotoristaDriftList = await Session.database.mdfeRodoviarioMotoristaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeRodoviarioMotoristaDriftList = await Session.database.mdfeRodoviarioMotoristaDao.getGroupedList(); 
			}
			if (mdfeRodoviarioMotoristaDriftList.isNotEmpty) {
				return toListModel(mdfeRodoviarioMotoristaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeRodoviarioMotoristaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeRodoviarioMotoristaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioMotoristaModel?>? insert(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) async {
		try {
			final lastPk = await Session.database.mdfeRodoviarioMotoristaDao.insertObject(toDrift(mdfeRodoviarioMotoristaModel));
			mdfeRodoviarioMotoristaModel.id = lastPk;
			return mdfeRodoviarioMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioMotoristaModel?>? update(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) async {
		try {
			await Session.database.mdfeRodoviarioMotoristaDao.updateObject(toDrift(mdfeRodoviarioMotoristaModel));
			return mdfeRodoviarioMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeRodoviarioMotoristaDao.deleteObject(toDrift(MdfeRodoviarioMotoristaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeRodoviarioMotoristaModel> toListModel(List<MdfeRodoviarioMotoristaGrouped> mdfeRodoviarioMotoristaDriftList) {
		List<MdfeRodoviarioMotoristaModel> listModel = [];
		for (var mdfeRodoviarioMotoristaDrift in mdfeRodoviarioMotoristaDriftList) {
			listModel.add(toModel(mdfeRodoviarioMotoristaDrift)!);
		}
		return listModel;
	}	

	MdfeRodoviarioMotoristaModel? toModel(MdfeRodoviarioMotoristaGrouped? mdfeRodoviarioMotoristaDrift) {
		if (mdfeRodoviarioMotoristaDrift != null) {
			return MdfeRodoviarioMotoristaModel(
				id: mdfeRodoviarioMotoristaDrift.mdfeRodoviarioMotorista?.id,
				idMdfeRodoviario: mdfeRodoviarioMotoristaDrift.mdfeRodoviarioMotorista?.idMdfeRodoviario,
				nome: mdfeRodoviarioMotoristaDrift.mdfeRodoviarioMotorista?.nome,
				cpf: mdfeRodoviarioMotoristaDrift.mdfeRodoviarioMotorista?.cpf,
				mdfeRodoviarioModel: MdfeRodoviarioModel(
					id: mdfeRodoviarioMotoristaDrift.mdfeRodoviario?.id,
					idMdfeCabecalho: mdfeRodoviarioMotoristaDrift.mdfeRodoviario?.idMdfeCabecalho,
					rntrc: mdfeRodoviarioMotoristaDrift.mdfeRodoviario?.rntrc,
					codigoAgendamento: mdfeRodoviarioMotoristaDrift.mdfeRodoviario?.codigoAgendamento,
				),
			);
		} else {
			return null;
		}
	}


	MdfeRodoviarioMotoristaGrouped toDrift(MdfeRodoviarioMotoristaModel mdfeRodoviarioMotoristaModel) {
		return MdfeRodoviarioMotoristaGrouped(
			mdfeRodoviarioMotorista: MdfeRodoviarioMotorista(
				id: mdfeRodoviarioMotoristaModel.id,
				idMdfeRodoviario: mdfeRodoviarioMotoristaModel.idMdfeRodoviario,
				nome: mdfeRodoviarioMotoristaModel.nome,
				cpf: Util.removeMask(mdfeRodoviarioMotoristaModel.cpf),
			),
		);
	}

		
}
