import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class CargoDriftProvider extends ProviderBase {

	Future<List<CargoModel>?> getList({Filter? filter}) async {
		List<CargoGrouped> cargoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cargoDriftList = await Session.database.cargoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cargoDriftList = await Session.database.cargoDao.getGroupedList(); 
			}
			if (cargoDriftList.isNotEmpty) {
				return toListModel(cargoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CargoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cargoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CargoModel?>? insert(CargoModel cargoModel) async {
		try {
			final lastPk = await Session.database.cargoDao.insertObject(toDrift(cargoModel));
			cargoModel.id = lastPk;
			return cargoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CargoModel?>? update(CargoModel cargoModel) async {
		try {
			await Session.database.cargoDao.updateObject(toDrift(cargoModel));
			return cargoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cargoDao.deleteObject(toDrift(CargoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CargoModel> toListModel(List<CargoGrouped> cargoDriftList) {
		List<CargoModel> listModel = [];
		for (var cargoDrift in cargoDriftList) {
			listModel.add(toModel(cargoDrift)!);
		}
		return listModel;
	}	

	CargoModel? toModel(CargoGrouped? cargoDrift) {
		if (cargoDrift != null) {
			return CargoModel(
				id: cargoDrift.cargo?.id,
				nome: cargoDrift.cargo?.nome,
				descricao: cargoDrift.cargo?.descricao,
				salario: cargoDrift.cargo?.salario,
				cbo1994: cargoDrift.cargo?.cbo1994,
				cbo2002: cargoDrift.cargo?.cbo2002,
			);
		} else {
			return null;
		}
	}


	CargoGrouped toDrift(CargoModel cargoModel) {
		return CargoGrouped(
			cargo: Cargo(
				id: cargoModel.id,
				nome: cargoModel.nome,
				descricao: cargoModel.descricao,
				salario: cargoModel.salario,
				cbo1994: cargoModel.cbo1994,
				cbo2002: cargoModel.cbo2002,
			),
		);
	}

		
}
