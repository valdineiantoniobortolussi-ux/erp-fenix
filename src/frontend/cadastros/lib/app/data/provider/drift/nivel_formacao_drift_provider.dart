import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class NivelFormacaoDriftProvider extends ProviderBase {

	Future<List<NivelFormacaoModel>?> getList({Filter? filter}) async {
		List<NivelFormacaoGrouped> nivelFormacaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nivelFormacaoDriftList = await Session.database.nivelFormacaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nivelFormacaoDriftList = await Session.database.nivelFormacaoDao.getGroupedList(); 
			}
			if (nivelFormacaoDriftList.isNotEmpty) {
				return toListModel(nivelFormacaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NivelFormacaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nivelFormacaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NivelFormacaoModel?>? insert(NivelFormacaoModel nivelFormacaoModel) async {
		try {
			final lastPk = await Session.database.nivelFormacaoDao.insertObject(toDrift(nivelFormacaoModel));
			nivelFormacaoModel.id = lastPk;
			return nivelFormacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NivelFormacaoModel?>? update(NivelFormacaoModel nivelFormacaoModel) async {
		try {
			await Session.database.nivelFormacaoDao.updateObject(toDrift(nivelFormacaoModel));
			return nivelFormacaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nivelFormacaoDao.deleteObject(toDrift(NivelFormacaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NivelFormacaoModel> toListModel(List<NivelFormacaoGrouped> nivelFormacaoDriftList) {
		List<NivelFormacaoModel> listModel = [];
		for (var nivelFormacaoDrift in nivelFormacaoDriftList) {
			listModel.add(toModel(nivelFormacaoDrift)!);
		}
		return listModel;
	}	

	NivelFormacaoModel? toModel(NivelFormacaoGrouped? nivelFormacaoDrift) {
		if (nivelFormacaoDrift != null) {
			return NivelFormacaoModel(
				id: nivelFormacaoDrift.nivelFormacao?.id,
				nome: nivelFormacaoDrift.nivelFormacao?.nome,
				descricao: nivelFormacaoDrift.nivelFormacao?.descricao,
			);
		} else {
			return null;
		}
	}


	NivelFormacaoGrouped toDrift(NivelFormacaoModel nivelFormacaoModel) {
		return NivelFormacaoGrouped(
			nivelFormacao: NivelFormacao(
				id: nivelFormacaoModel.id,
				nome: nivelFormacaoModel.nome,
				descricao: nivelFormacaoModel.descricao,
			),
		);
	}

		
}
