import 'package:contratos/app/data/provider/drift/database/database_imports.dart';
import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/provider/provider_base.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/model/model_imports.dart';

class ContratoTipoServicoDriftProvider extends ProviderBase {

	Future<List<ContratoTipoServicoModel>?> getList({Filter? filter}) async {
		List<ContratoTipoServicoGrouped> contratoTipoServicoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contratoTipoServicoDriftList = await Session.database.contratoTipoServicoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contratoTipoServicoDriftList = await Session.database.contratoTipoServicoDao.getGroupedList(); 
			}
			if (contratoTipoServicoDriftList.isNotEmpty) {
				return toListModel(contratoTipoServicoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContratoTipoServicoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contratoTipoServicoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoTipoServicoModel?>? insert(ContratoTipoServicoModel contratoTipoServicoModel) async {
		try {
			final lastPk = await Session.database.contratoTipoServicoDao.insertObject(toDrift(contratoTipoServicoModel));
			contratoTipoServicoModel.id = lastPk;
			return contratoTipoServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContratoTipoServicoModel?>? update(ContratoTipoServicoModel contratoTipoServicoModel) async {
		try {
			await Session.database.contratoTipoServicoDao.updateObject(toDrift(contratoTipoServicoModel));
			return contratoTipoServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contratoTipoServicoDao.deleteObject(toDrift(ContratoTipoServicoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContratoTipoServicoModel> toListModel(List<ContratoTipoServicoGrouped> contratoTipoServicoDriftList) {
		List<ContratoTipoServicoModel> listModel = [];
		for (var contratoTipoServicoDrift in contratoTipoServicoDriftList) {
			listModel.add(toModel(contratoTipoServicoDrift)!);
		}
		return listModel;
	}	

	ContratoTipoServicoModel? toModel(ContratoTipoServicoGrouped? contratoTipoServicoDrift) {
		if (contratoTipoServicoDrift != null) {
			return ContratoTipoServicoModel(
				id: contratoTipoServicoDrift.contratoTipoServico?.id,
				nome: contratoTipoServicoDrift.contratoTipoServico?.nome,
				descricao: contratoTipoServicoDrift.contratoTipoServico?.descricao,
			);
		} else {
			return null;
		}
	}


	ContratoTipoServicoGrouped toDrift(ContratoTipoServicoModel contratoTipoServicoModel) {
		return ContratoTipoServicoGrouped(
			contratoTipoServico: ContratoTipoServico(
				id: contratoTipoServicoModel.id,
				nome: contratoTipoServicoModel.nome,
				descricao: contratoTipoServicoModel.descricao,
			),
		);
	}

		
}
