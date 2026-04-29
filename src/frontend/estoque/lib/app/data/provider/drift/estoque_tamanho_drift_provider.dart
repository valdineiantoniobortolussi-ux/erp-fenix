import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueTamanhoDriftProvider extends ProviderBase {

	Future<List<EstoqueTamanhoModel>?> getList({Filter? filter}) async {
		List<EstoqueTamanhoGrouped> estoqueTamanhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueTamanhoDriftList = await Session.database.estoqueTamanhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueTamanhoDriftList = await Session.database.estoqueTamanhoDao.getGroupedList(); 
			}
			if (estoqueTamanhoDriftList.isNotEmpty) {
				return toListModel(estoqueTamanhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueTamanhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueTamanhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueTamanhoModel?>? insert(EstoqueTamanhoModel estoqueTamanhoModel) async {
		try {
			final lastPk = await Session.database.estoqueTamanhoDao.insertObject(toDrift(estoqueTamanhoModel));
			estoqueTamanhoModel.id = lastPk;
			return estoqueTamanhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueTamanhoModel?>? update(EstoqueTamanhoModel estoqueTamanhoModel) async {
		try {
			await Session.database.estoqueTamanhoDao.updateObject(toDrift(estoqueTamanhoModel));
			return estoqueTamanhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueTamanhoDao.deleteObject(toDrift(EstoqueTamanhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueTamanhoModel> toListModel(List<EstoqueTamanhoGrouped> estoqueTamanhoDriftList) {
		List<EstoqueTamanhoModel> listModel = [];
		for (var estoqueTamanhoDrift in estoqueTamanhoDriftList) {
			listModel.add(toModel(estoqueTamanhoDrift)!);
		}
		return listModel;
	}	

	EstoqueTamanhoModel? toModel(EstoqueTamanhoGrouped? estoqueTamanhoDrift) {
		if (estoqueTamanhoDrift != null) {
			return EstoqueTamanhoModel(
				id: estoqueTamanhoDrift.estoqueTamanho?.id,
				codigo: estoqueTamanhoDrift.estoqueTamanho?.codigo,
				nome: estoqueTamanhoDrift.estoqueTamanho?.nome,
				altura: estoqueTamanhoDrift.estoqueTamanho?.altura,
				comprimento: estoqueTamanhoDrift.estoqueTamanho?.comprimento,
				largura: estoqueTamanhoDrift.estoqueTamanho?.largura,
			);
		} else {
			return null;
		}
	}


	EstoqueTamanhoGrouped toDrift(EstoqueTamanhoModel estoqueTamanhoModel) {
		return EstoqueTamanhoGrouped(
			estoqueTamanho: EstoqueTamanho(
				id: estoqueTamanhoModel.id,
				codigo: estoqueTamanhoModel.codigo,
				nome: estoqueTamanhoModel.nome,
				altura: estoqueTamanhoModel.altura,
				comprimento: estoqueTamanhoModel.comprimento,
				largura: estoqueTamanhoModel.largura,
			),
		);
	}

		
}
