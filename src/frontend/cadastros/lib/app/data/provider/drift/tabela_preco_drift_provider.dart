import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class TabelaPrecoDriftProvider extends ProviderBase {

	Future<List<TabelaPrecoModel>?> getList({Filter? filter}) async {
		List<TabelaPrecoGrouped> tabelaPrecoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				tabelaPrecoDriftList = await Session.database.tabelaPrecoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				tabelaPrecoDriftList = await Session.database.tabelaPrecoDao.getGroupedList(); 
			}
			if (tabelaPrecoDriftList.isNotEmpty) {
				return toListModel(tabelaPrecoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<TabelaPrecoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.tabelaPrecoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TabelaPrecoModel?>? insert(TabelaPrecoModel tabelaPrecoModel) async {
		try {
			final lastPk = await Session.database.tabelaPrecoDao.insertObject(toDrift(tabelaPrecoModel));
			tabelaPrecoModel.id = lastPk;
			return tabelaPrecoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<TabelaPrecoModel?>? update(TabelaPrecoModel tabelaPrecoModel) async {
		try {
			await Session.database.tabelaPrecoDao.updateObject(toDrift(tabelaPrecoModel));
			return tabelaPrecoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.tabelaPrecoDao.deleteObject(toDrift(TabelaPrecoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<TabelaPrecoModel> toListModel(List<TabelaPrecoGrouped> tabelaPrecoDriftList) {
		List<TabelaPrecoModel> listModel = [];
		for (var tabelaPrecoDrift in tabelaPrecoDriftList) {
			listModel.add(toModel(tabelaPrecoDrift)!);
		}
		return listModel;
	}	

	TabelaPrecoModel? toModel(TabelaPrecoGrouped? tabelaPrecoDrift) {
		if (tabelaPrecoDrift != null) {
			return TabelaPrecoModel(
				id: tabelaPrecoDrift.tabelaPreco?.id,
				nome: tabelaPrecoDrift.tabelaPreco?.nome,
				principal: TabelaPrecoDomain.getPrincipal(tabelaPrecoDrift.tabelaPreco?.principal),
				coeficiente: tabelaPrecoDrift.tabelaPreco?.coeficiente,
			);
		} else {
			return null;
		}
	}


	TabelaPrecoGrouped toDrift(TabelaPrecoModel tabelaPrecoModel) {
		return TabelaPrecoGrouped(
			tabelaPreco: TabelaPreco(
				id: tabelaPrecoModel.id,
				nome: tabelaPrecoModel.nome,
				principal: TabelaPrecoDomain.setPrincipal(tabelaPrecoModel.principal),
				coeficiente: tabelaPrecoModel.coeficiente,
			),
		);
	}

		
}
