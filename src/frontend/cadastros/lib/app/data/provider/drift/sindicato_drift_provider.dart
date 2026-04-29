import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';
import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/provider/provider_base.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class SindicatoDriftProvider extends ProviderBase {

	Future<List<SindicatoModel>?> getList({Filter? filter}) async {
		List<SindicatoGrouped> sindicatoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				sindicatoDriftList = await Session.database.sindicatoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				sindicatoDriftList = await Session.database.sindicatoDao.getGroupedList(); 
			}
			if (sindicatoDriftList.isNotEmpty) {
				return toListModel(sindicatoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SindicatoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.sindicatoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SindicatoModel?>? insert(SindicatoModel sindicatoModel) async {
		try {
			final lastPk = await Session.database.sindicatoDao.insertObject(toDrift(sindicatoModel));
			sindicatoModel.id = lastPk;
			return sindicatoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SindicatoModel?>? update(SindicatoModel sindicatoModel) async {
		try {
			await Session.database.sindicatoDao.updateObject(toDrift(sindicatoModel));
			return sindicatoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.sindicatoDao.deleteObject(toDrift(SindicatoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SindicatoModel> toListModel(List<SindicatoGrouped> sindicatoDriftList) {
		List<SindicatoModel> listModel = [];
		for (var sindicatoDrift in sindicatoDriftList) {
			listModel.add(toModel(sindicatoDrift)!);
		}
		return listModel;
	}	

	SindicatoModel? toModel(SindicatoGrouped? sindicatoDrift) {
		if (sindicatoDrift != null) {
			return SindicatoModel(
				id: sindicatoDrift.sindicato?.id,
				nome: sindicatoDrift.sindicato?.nome,
				codigoBanco: sindicatoDrift.sindicato?.codigoBanco,
				codigoAgencia: sindicatoDrift.sindicato?.codigoAgencia,
				contaBanco: sindicatoDrift.sindicato?.contaBanco,
				codigoCedente: sindicatoDrift.sindicato?.codigoCedente,
				logradouro: sindicatoDrift.sindicato?.logradouro,
				numero: sindicatoDrift.sindicato?.numero,
				bairro: sindicatoDrift.sindicato?.bairro,
				municipioIbge: sindicatoDrift.sindicato?.municipioIbge,
				uf: SindicatoDomain.getUf(sindicatoDrift.sindicato?.uf),
				fone1: sindicatoDrift.sindicato?.fone1,
				fone2: sindicatoDrift.sindicato?.fone2,
				email: sindicatoDrift.sindicato?.email,
				tipoSindicato: SindicatoDomain.getTipoSindicato(sindicatoDrift.sindicato?.tipoSindicato),
				dataBase: sindicatoDrift.sindicato?.dataBase,
				pisoSalarial: sindicatoDrift.sindicato?.pisoSalarial,
				cnpj: sindicatoDrift.sindicato?.cnpj,
				classificacaoContabilConta: sindicatoDrift.sindicato?.classificacaoContabilConta,
			);
		} else {
			return null;
		}
	}


	SindicatoGrouped toDrift(SindicatoModel sindicatoModel) {
		return SindicatoGrouped(
			sindicato: Sindicato(
				id: sindicatoModel.id,
				nome: sindicatoModel.nome,
				codigoBanco: sindicatoModel.codigoBanco,
				codigoAgencia: sindicatoModel.codigoAgencia,
				contaBanco: sindicatoModel.contaBanco,
				codigoCedente: sindicatoModel.codigoCedente,
				logradouro: sindicatoModel.logradouro,
				numero: sindicatoModel.numero,
				bairro: sindicatoModel.bairro,
				municipioIbge: sindicatoModel.municipioIbge,
				uf: SindicatoDomain.setUf(sindicatoModel.uf),
				fone1: Util.removeMask(sindicatoModel.fone1),
				fone2: Util.removeMask(sindicatoModel.fone2),
				email: sindicatoModel.email,
				tipoSindicato: SindicatoDomain.setTipoSindicato(sindicatoModel.tipoSindicato),
				dataBase: sindicatoModel.dataBase,
				pisoSalarial: sindicatoModel.pisoSalarial,
				cnpj: Util.removeMask(sindicatoModel.cnpj),
				classificacaoContabilConta: sindicatoModel.classificacaoContabilConta,
			),
		);
	}

		
}
