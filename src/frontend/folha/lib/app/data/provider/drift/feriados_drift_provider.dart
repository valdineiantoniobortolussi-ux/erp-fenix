import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FeriadosDriftProvider extends ProviderBase {

	Future<List<FeriadosModel>?> getList({Filter? filter}) async {
		List<FeriadosGrouped> feriadosDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				feriadosDriftList = await Session.database.feriadosDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				feriadosDriftList = await Session.database.feriadosDao.getGroupedList(); 
			}
			if (feriadosDriftList.isNotEmpty) {
				return toListModel(feriadosDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FeriadosModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.feriadosDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FeriadosModel?>? insert(FeriadosModel feriadosModel) async {
		try {
			final lastPk = await Session.database.feriadosDao.insertObject(toDrift(feriadosModel));
			feriadosModel.id = lastPk;
			return feriadosModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FeriadosModel?>? update(FeriadosModel feriadosModel) async {
		try {
			await Session.database.feriadosDao.updateObject(toDrift(feriadosModel));
			return feriadosModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.feriadosDao.deleteObject(toDrift(FeriadosModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FeriadosModel> toListModel(List<FeriadosGrouped> feriadosDriftList) {
		List<FeriadosModel> listModel = [];
		for (var feriadosDrift in feriadosDriftList) {
			listModel.add(toModel(feriadosDrift)!);
		}
		return listModel;
	}	

	FeriadosModel? toModel(FeriadosGrouped? feriadosDrift) {
		if (feriadosDrift != null) {
			return FeriadosModel(
				id: feriadosDrift.feriados?.id,
				ano: feriadosDrift.feriados?.ano,
				nome: feriadosDrift.feriados?.nome,
				abrangencia: FeriadosDomain.getAbrangencia(feriadosDrift.feriados?.abrangencia),
				uf: FeriadosDomain.getUf(feriadosDrift.feriados?.uf),
				municipioIbge: feriadosDrift.feriados?.municipioIbge,
				tipo: FeriadosDomain.getTipo(feriadosDrift.feriados?.tipo),
				dataFeriado: feriadosDrift.feriados?.dataFeriado,
			);
		} else {
			return null;
		}
	}


	FeriadosGrouped toDrift(FeriadosModel feriadosModel) {
		return FeriadosGrouped(
			feriados: Feriados(
				id: feriadosModel.id,
				ano: feriadosModel.ano,
				nome: feriadosModel.nome,
				abrangencia: FeriadosDomain.setAbrangencia(feriadosModel.abrangencia),
				uf: FeriadosDomain.setUf(feriadosModel.uf),
				municipioIbge: feriadosModel.municipioIbge,
				tipo: FeriadosDomain.setTipo(feriadosModel.tipo),
				dataFeriado: feriadosModel.dataFeriado,
			),
		);
	}

		
}
