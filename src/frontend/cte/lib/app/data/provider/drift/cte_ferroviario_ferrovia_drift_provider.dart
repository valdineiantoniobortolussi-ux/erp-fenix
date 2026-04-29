import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteFerroviarioFerroviaDriftProvider extends ProviderBase {

	Future<List<CteFerroviarioFerroviaModel>?> getList({Filter? filter}) async {
		List<CteFerroviarioFerroviaGrouped> cteFerroviarioFerroviaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteFerroviarioFerroviaDriftList = await Session.database.cteFerroviarioFerroviaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteFerroviarioFerroviaDriftList = await Session.database.cteFerroviarioFerroviaDao.getGroupedList(); 
			}
			if (cteFerroviarioFerroviaDriftList.isNotEmpty) {
				return toListModel(cteFerroviarioFerroviaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteFerroviarioFerroviaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteFerroviarioFerroviaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteFerroviarioFerroviaModel?>? insert(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) async {
		try {
			final lastPk = await Session.database.cteFerroviarioFerroviaDao.insertObject(toDrift(cteFerroviarioFerroviaModel));
			cteFerroviarioFerroviaModel.id = lastPk;
			return cteFerroviarioFerroviaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteFerroviarioFerroviaModel?>? update(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) async {
		try {
			await Session.database.cteFerroviarioFerroviaDao.updateObject(toDrift(cteFerroviarioFerroviaModel));
			return cteFerroviarioFerroviaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteFerroviarioFerroviaDao.deleteObject(toDrift(CteFerroviarioFerroviaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteFerroviarioFerroviaModel> toListModel(List<CteFerroviarioFerroviaGrouped> cteFerroviarioFerroviaDriftList) {
		List<CteFerroviarioFerroviaModel> listModel = [];
		for (var cteFerroviarioFerroviaDrift in cteFerroviarioFerroviaDriftList) {
			listModel.add(toModel(cteFerroviarioFerroviaDrift)!);
		}
		return listModel;
	}	

	CteFerroviarioFerroviaModel? toModel(CteFerroviarioFerroviaGrouped? cteFerroviarioFerroviaDrift) {
		if (cteFerroviarioFerroviaDrift != null) {
			return CteFerroviarioFerroviaModel(
				id: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.id,
				idCteFerroviario: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.idCteFerroviario,
				cnpj: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.cnpj,
				codigoInterno: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.codigoInterno,
				ie: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.ie,
				nome: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.nome,
				logradouro: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.logradouro,
				numero: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.numero,
				complemento: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.complemento,
				bairro: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.bairro,
				codigoMunicipio: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.codigoMunicipio,
				nomeMunicipio: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.nomeMunicipio,
				uf: CteFerroviarioFerroviaDomain.getUf(cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.uf),
				cep: cteFerroviarioFerroviaDrift.cteFerroviarioFerrovia?.cep,
				cteFerroviarioModel: CteFerroviarioModel(
					id: cteFerroviarioFerroviaDrift.cteFerroviario?.id,
					idCteCabecalho: cteFerroviarioFerroviaDrift.cteFerroviario?.idCteCabecalho,
					tipoTrafego: cteFerroviarioFerroviaDrift.cteFerroviario?.tipoTrafego,
					responsavelFaturamento: cteFerroviarioFerroviaDrift.cteFerroviario?.responsavelFaturamento,
					ferroviaEmitenteCte: cteFerroviarioFerroviaDrift.cteFerroviario?.ferroviaEmitenteCte,
					fluxo: cteFerroviarioFerroviaDrift.cteFerroviario?.fluxo,
					idTrem: cteFerroviarioFerroviaDrift.cteFerroviario?.idTrem,
					valorFrete: cteFerroviarioFerroviaDrift.cteFerroviario?.valorFrete,
				),
			);
		} else {
			return null;
		}
	}


	CteFerroviarioFerroviaGrouped toDrift(CteFerroviarioFerroviaModel cteFerroviarioFerroviaModel) {
		return CteFerroviarioFerroviaGrouped(
			cteFerroviarioFerrovia: CteFerroviarioFerrovia(
				id: cteFerroviarioFerroviaModel.id,
				idCteFerroviario: cteFerroviarioFerroviaModel.idCteFerroviario,
				cnpj: Util.removeMask(cteFerroviarioFerroviaModel.cnpj),
				codigoInterno: cteFerroviarioFerroviaModel.codigoInterno,
				ie: cteFerroviarioFerroviaModel.ie,
				nome: cteFerroviarioFerroviaModel.nome,
				logradouro: cteFerroviarioFerroviaModel.logradouro,
				numero: cteFerroviarioFerroviaModel.numero,
				complemento: cteFerroviarioFerroviaModel.complemento,
				bairro: cteFerroviarioFerroviaModel.bairro,
				codigoMunicipio: cteFerroviarioFerroviaModel.codigoMunicipio,
				nomeMunicipio: cteFerroviarioFerroviaModel.nomeMunicipio,
				uf: CteFerroviarioFerroviaDomain.setUf(cteFerroviarioFerroviaModel.uf),
				cep: Util.removeMask(cteFerroviarioFerroviaModel.cep),
			),
		);
	}

		
}
