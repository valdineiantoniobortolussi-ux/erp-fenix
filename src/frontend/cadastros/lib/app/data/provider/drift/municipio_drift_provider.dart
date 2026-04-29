import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class MunicipioDriftProvider extends ProviderBase {

	Future<List<MunicipioModel>?> getList({Filter? filter}) async {
		List<MunicipioGrouped> municipioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				municipioDriftList = await Session.database.municipioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				municipioDriftList = await Session.database.municipioDao.getGroupedList(); 
			}
			if (municipioDriftList.isNotEmpty) {
				return toListModel(municipioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MunicipioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.municipioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MunicipioModel?>? insert(MunicipioModel municipioModel) async {
		try {
			final lastPk = await Session.database.municipioDao.insertObject(toDrift(municipioModel));
			municipioModel.id = lastPk;
			return municipioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MunicipioModel?>? update(MunicipioModel municipioModel) async {
		try {
			await Session.database.municipioDao.updateObject(toDrift(municipioModel));
			return municipioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.municipioDao.deleteObject(toDrift(MunicipioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MunicipioModel> toListModel(List<MunicipioGrouped> municipioDriftList) {
		List<MunicipioModel> listModel = [];
		for (var municipioDrift in municipioDriftList) {
			listModel.add(toModel(municipioDrift)!);
		}
		return listModel;
	}	

	MunicipioModel? toModel(MunicipioGrouped? municipioDrift) {
		if (municipioDrift != null) {
			return MunicipioModel(
				id: municipioDrift.municipio?.id,
				idUf: municipioDrift.municipio?.idUf,
				nome: municipioDrift.municipio?.nome,
				codigoIbge: municipioDrift.municipio?.codigoIbge,
				codigoReceitaFederal: municipioDrift.municipio?.codigoReceitaFederal,
				codigoEstadual: municipioDrift.municipio?.codigoEstadual,
				ufModel: UfModel(
					id: municipioDrift.uf?.id,
					nome: municipioDrift.uf?.nome,
					sigla: municipioDrift.uf?.sigla,
					codigoIbge: municipioDrift.uf?.codigoIbge,
				),
			);
		} else {
			return null;
		}
	}


	MunicipioGrouped toDrift(MunicipioModel municipioModel) {
		return MunicipioGrouped(
			municipio: Municipio(
				id: municipioModel.id,
				idUf: municipioModel.idUf,
				nome: municipioModel.nome,
				codigoIbge: municipioModel.codigoIbge,
				codigoReceitaFederal: municipioModel.codigoReceitaFederal,
				codigoEstadual: municipioModel.codigoEstadual,
			),
		);
	}

		
}
