import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';

class BancoDriftProvider extends ProviderBase {

	Future<List<BancoModel>?> getList({Filter? filter}) async {
		List<BancoGrouped> bancoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				bancoDriftList = await Session.database.bancoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				bancoDriftList = await Session.database.bancoDao.getGroupedList(); 
			}
			if (bancoDriftList.isNotEmpty) {
				return toListModel(bancoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<BancoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.bancoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoModel?>? insert(BancoModel bancoModel) async {
		try {
			final lastPk = await Session.database.bancoDao.insertObject(toDrift(bancoModel));
			bancoModel.id = lastPk;
			return bancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<BancoModel?>? update(BancoModel bancoModel) async {
		try {
			await Session.database.bancoDao.updateObject(toDrift(bancoModel));
			return bancoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.bancoDao.deleteObject(toDrift(BancoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<BancoModel> toListModel(List<BancoGrouped> bancoDriftList) {
		List<BancoModel> listModel = [];
		for (var bancoDrift in bancoDriftList) {
			listModel.add(toModel(bancoDrift)!);
		}
		return listModel;
	}	

	BancoModel? toModel(BancoGrouped? bancoDrift) {
		if (bancoDrift != null) {
			return BancoModel(
				id: bancoDrift.banco?.id,
				codigo: bancoDrift.banco?.codigo,
				nome: bancoDrift.banco?.nome,
				url: bancoDrift.banco?.url,
			);
		} else {
			return null;
		}
	}


	BancoGrouped toDrift(BancoModel bancoModel) {
		return BancoGrouped(
			banco: Banco(
				id: bancoModel.id,
				codigo: bancoModel.codigo,
				nome: bancoModel.nome,
				url: bancoModel.url,
			),
		);
	}

		
}
