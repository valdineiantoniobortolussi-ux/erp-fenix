import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeDriftProvider extends ProviderBase {

	Future<List<NfeTransporteVolumeModel>?> getList({Filter? filter}) async {
		List<NfeTransporteVolumeGrouped> nfeTransporteVolumeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeTransporteVolumeDriftList = await Session.database.nfeTransporteVolumeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeTransporteVolumeDriftList = await Session.database.nfeTransporteVolumeDao.getGroupedList(); 
			}
			if (nfeTransporteVolumeDriftList.isNotEmpty) {
				return toListModel(nfeTransporteVolumeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeTransporteVolumeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeTransporteVolumeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteVolumeModel?>? insert(NfeTransporteVolumeModel nfeTransporteVolumeModel) async {
		try {
			final lastPk = await Session.database.nfeTransporteVolumeDao.insertObject(toDrift(nfeTransporteVolumeModel));
			nfeTransporteVolumeModel.id = lastPk;
			return nfeTransporteVolumeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeTransporteVolumeModel?>? update(NfeTransporteVolumeModel nfeTransporteVolumeModel) async {
		try {
			await Session.database.nfeTransporteVolumeDao.updateObject(toDrift(nfeTransporteVolumeModel));
			return nfeTransporteVolumeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeTransporteVolumeDao.deleteObject(toDrift(NfeTransporteVolumeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeTransporteVolumeModel> toListModel(List<NfeTransporteVolumeGrouped> nfeTransporteVolumeDriftList) {
		List<NfeTransporteVolumeModel> listModel = [];
		for (var nfeTransporteVolumeDrift in nfeTransporteVolumeDriftList) {
			listModel.add(toModel(nfeTransporteVolumeDrift)!);
		}
		return listModel;
	}	

	NfeTransporteVolumeModel? toModel(NfeTransporteVolumeGrouped? nfeTransporteVolumeDrift) {
		if (nfeTransporteVolumeDrift != null) {
			return NfeTransporteVolumeModel(
				id: nfeTransporteVolumeDrift.nfeTransporteVolume?.id,
				idNfeTransporte: nfeTransporteVolumeDrift.nfeTransporteVolume?.idNfeTransporte,
				quantidade: nfeTransporteVolumeDrift.nfeTransporteVolume?.quantidade,
				especie: nfeTransporteVolumeDrift.nfeTransporteVolume?.especie,
				marca: nfeTransporteVolumeDrift.nfeTransporteVolume?.marca,
				numeracao: nfeTransporteVolumeDrift.nfeTransporteVolume?.numeracao,
				pesoLiquido: nfeTransporteVolumeDrift.nfeTransporteVolume?.pesoLiquido,
				pesoBruto: nfeTransporteVolumeDrift.nfeTransporteVolume?.pesoBruto,
				nfeTransporteModel: NfeTransporteModel(
					id: nfeTransporteVolumeDrift.nfeTransporte?.id,
					idNfeCabecalho: nfeTransporteVolumeDrift.nfeTransporte?.idNfeCabecalho,
					idTransportadora: nfeTransporteVolumeDrift.nfeTransporte?.idTransportadora,
					modalidadeFrete: nfeTransporteVolumeDrift.nfeTransporte?.modalidadeFrete,
					cnpj: nfeTransporteVolumeDrift.nfeTransporte?.cnpj,
					cpf: nfeTransporteVolumeDrift.nfeTransporte?.cpf,
					nome: nfeTransporteVolumeDrift.nfeTransporte?.nome,
					inscricaoEstadual: nfeTransporteVolumeDrift.nfeTransporte?.inscricaoEstadual,
					endereco: nfeTransporteVolumeDrift.nfeTransporte?.endereco,
					nomeMunicipio: nfeTransporteVolumeDrift.nfeTransporte?.nomeMunicipio,
					uf: nfeTransporteVolumeDrift.nfeTransporte?.uf,
					valorServico: nfeTransporteVolumeDrift.nfeTransporte?.valorServico,
					valorBcRetencaoIcms: nfeTransporteVolumeDrift.nfeTransporte?.valorBcRetencaoIcms,
					aliquotaRetencaoIcms: nfeTransporteVolumeDrift.nfeTransporte?.aliquotaRetencaoIcms,
					valorIcmsRetido: nfeTransporteVolumeDrift.nfeTransporte?.valorIcmsRetido,
					cfop: nfeTransporteVolumeDrift.nfeTransporte?.cfop,
					municipio: nfeTransporteVolumeDrift.nfeTransporte?.municipio,
					placaVeiculo: nfeTransporteVolumeDrift.nfeTransporte?.placaVeiculo,
					ufVeiculo: nfeTransporteVolumeDrift.nfeTransporte?.ufVeiculo,
					rntcVeiculo: nfeTransporteVolumeDrift.nfeTransporte?.rntcVeiculo,
				),
			);
		} else {
			return null;
		}
	}


	NfeTransporteVolumeGrouped toDrift(NfeTransporteVolumeModel nfeTransporteVolumeModel) {
		return NfeTransporteVolumeGrouped(
			nfeTransporteVolume: NfeTransporteVolume(
				id: nfeTransporteVolumeModel.id,
				idNfeTransporte: nfeTransporteVolumeModel.idNfeTransporte,
				quantidade: nfeTransporteVolumeModel.quantidade,
				especie: nfeTransporteVolumeModel.especie,
				marca: nfeTransporteVolumeModel.marca,
				numeracao: nfeTransporteVolumeModel.numeracao,
				pesoLiquido: nfeTransporteVolumeModel.pesoLiquido,
				pesoBruto: nfeTransporteVolumeModel.pesoBruto,
			),
		);
	}

		
}
