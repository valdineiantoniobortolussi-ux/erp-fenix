import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeTransporteReboqueDriftProvider extends ProviderBase {

	Future<List<NfeTransporteReboqueModel>?> getList({Filter? filter}) async {
		List<NfeTransporteReboqueGrouped> nfeTransporteReboqueDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeTransporteReboqueDriftList = await Session.database.nfeTransporteReboqueDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeTransporteReboqueDriftList = await Session.database.nfeTransporteReboqueDao.getGroupedList(); 
			}
			if (nfeTransporteReboqueDriftList.isNotEmpty) {
				return toListModel(nfeTransporteReboqueDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeTransporteReboqueModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeTransporteReboqueDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteReboqueModel?>? insert(NfeTransporteReboqueModel nfeTransporteReboqueModel) async {
		try {
			final lastPk = await Session.database.nfeTransporteReboqueDao.insertObject(toDrift(nfeTransporteReboqueModel));
			nfeTransporteReboqueModel.id = lastPk;
			return nfeTransporteReboqueModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteReboqueModel?>? update(NfeTransporteReboqueModel nfeTransporteReboqueModel) async {
		try {
			await Session.database.nfeTransporteReboqueDao.updateObject(toDrift(nfeTransporteReboqueModel));
			return nfeTransporteReboqueModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeTransporteReboqueDao.deleteObject(toDrift(NfeTransporteReboqueModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeTransporteReboqueModel> toListModel(List<NfeTransporteReboqueGrouped> nfeTransporteReboqueDriftList) {
		List<NfeTransporteReboqueModel> listModel = [];
		for (var nfeTransporteReboqueDrift in nfeTransporteReboqueDriftList) {
			listModel.add(toModel(nfeTransporteReboqueDrift)!);
		}
		return listModel;
	}	

	NfeTransporteReboqueModel? toModel(NfeTransporteReboqueGrouped? nfeTransporteReboqueDrift) {
		if (nfeTransporteReboqueDrift != null) {
			return NfeTransporteReboqueModel(
				id: nfeTransporteReboqueDrift.nfeTransporteReboque?.id,
				idNfeTransporte: nfeTransporteReboqueDrift.nfeTransporteReboque?.idNfeTransporte,
				placa: nfeTransporteReboqueDrift.nfeTransporteReboque?.placa,
				uf: NfeTransporteReboqueDomain.getUf(nfeTransporteReboqueDrift.nfeTransporteReboque?.uf),
				rntc: nfeTransporteReboqueDrift.nfeTransporteReboque?.rntc,
				vagao: nfeTransporteReboqueDrift.nfeTransporteReboque?.vagao,
				balsa: nfeTransporteReboqueDrift.nfeTransporteReboque?.balsa,
				nfeTransporteModel: NfeTransporteModel(
					id: nfeTransporteReboqueDrift.nfeTransporte?.id,
					idNfeCabecalho: nfeTransporteReboqueDrift.nfeTransporte?.idNfeCabecalho,
					idTransportadora: nfeTransporteReboqueDrift.nfeTransporte?.idTransportadora,
					modalidadeFrete: nfeTransporteReboqueDrift.nfeTransporte?.modalidadeFrete,
					cnpj: nfeTransporteReboqueDrift.nfeTransporte?.cnpj,
					cpf: nfeTransporteReboqueDrift.nfeTransporte?.cpf,
					nome: nfeTransporteReboqueDrift.nfeTransporte?.nome,
					inscricaoEstadual: nfeTransporteReboqueDrift.nfeTransporte?.inscricaoEstadual,
					endereco: nfeTransporteReboqueDrift.nfeTransporte?.endereco,
					nomeMunicipio: nfeTransporteReboqueDrift.nfeTransporte?.nomeMunicipio,
					uf: nfeTransporteReboqueDrift.nfeTransporte?.uf,
					valorServico: nfeTransporteReboqueDrift.nfeTransporte?.valorServico,
					valorBcRetencaoIcms: nfeTransporteReboqueDrift.nfeTransporte?.valorBcRetencaoIcms,
					aliquotaRetencaoIcms: nfeTransporteReboqueDrift.nfeTransporte?.aliquotaRetencaoIcms,
					valorIcmsRetido: nfeTransporteReboqueDrift.nfeTransporte?.valorIcmsRetido,
					cfop: nfeTransporteReboqueDrift.nfeTransporte?.cfop,
					municipio: nfeTransporteReboqueDrift.nfeTransporte?.municipio,
					placaVeiculo: nfeTransporteReboqueDrift.nfeTransporte?.placaVeiculo,
					ufVeiculo: nfeTransporteReboqueDrift.nfeTransporte?.ufVeiculo,
					rntcVeiculo: nfeTransporteReboqueDrift.nfeTransporte?.rntcVeiculo,
				),
			);
		} else {
			return null;
		}
	}


	NfeTransporteReboqueGrouped toDrift(NfeTransporteReboqueModel nfeTransporteReboqueModel) {
		return NfeTransporteReboqueGrouped(
			nfeTransporteReboque: NfeTransporteReboque(
				id: nfeTransporteReboqueModel.id,
				idNfeTransporte: nfeTransporteReboqueModel.idNfeTransporte,
				placa: nfeTransporteReboqueModel.placa,
				uf: NfeTransporteReboqueDomain.setUf(nfeTransporteReboqueModel.uf),
				rntc: nfeTransporteReboqueModel.rntc,
				vagao: nfeTransporteReboqueModel.vagao,
				balsa: nfeTransporteReboqueModel.balsa,
			),
		);
	}

		
}
