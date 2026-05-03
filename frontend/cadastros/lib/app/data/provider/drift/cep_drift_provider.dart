import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class CepDriftProvider extends ProviderBase {

	Future<List<CepModel>?> getList({Filter? filter}) async {
		List<CepGrouped> cepDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cepDriftList = await Session.database.cepDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cepDriftList = await Session.database.cepDao.getGroupedList(); 
			}
			if (cepDriftList.isNotEmpty) {
				return toListModel(cepDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CepModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cepDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CepModel?>? insert(CepModel cepModel) async {
		try {
			final lastPk = await Session.database.cepDao.insertObject(toDrift(cepModel));
			cepModel.id = lastPk;
			return cepModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CepModel?>? update(CepModel cepModel) async {
		try {
			await Session.database.cepDao.updateObject(toDrift(cepModel));
			return cepModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cepDao.deleteObject(toDrift(CepModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CepModel> toListModel(List<CepGrouped> cepDriftList) {
		List<CepModel> listModel = [];
		for (var cepDrift in cepDriftList) {
			listModel.add(toModel(cepDrift)!);
		}
		return listModel;
	}	

	CepModel? toModel(CepGrouped? cepDrift) {
		if (cepDrift != null) {
			return CepModel(
				id: cepDrift.cep?.id,
				numero: cepDrift.cep?.numero,
				logradouro: cepDrift.cep?.logradouro,
				complemento: cepDrift.cep?.complemento,
				bairro: cepDrift.cep?.bairro,
				municipio: cepDrift.cep?.municipio,
				uf: CepDomain.getUf(cepDrift.cep?.uf),
				codigoIbgeMunicipio: cepDrift.cep?.codigoIbgeMunicipio,
			);
		} else {
			return null;
		}
	}


	CepGrouped toDrift(CepModel cepModel) {
		return CepGrouped(
			cep: Cep(
				id: cepModel.id,
				numero: cepModel.numero,
				logradouro: cepModel.logradouro,
				complemento: cepModel.complemento,
				bairro: cepModel.bairro,
				municipio: cepModel.municipio,
				uf: CepDomain.setUf(cepModel.uf),
				codigoIbgeMunicipio: cepModel.codigoIbgeMunicipio,
			),
		);
	}

		
}
