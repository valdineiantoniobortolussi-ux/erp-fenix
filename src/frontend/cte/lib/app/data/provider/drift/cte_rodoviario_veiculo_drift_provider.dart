import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteRodoviarioVeiculoDriftProvider extends ProviderBase {

	Future<List<CteRodoviarioVeiculoModel>?> getList({Filter? filter}) async {
		List<CteRodoviarioVeiculoGrouped> cteRodoviarioVeiculoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteRodoviarioVeiculoDriftList = await Session.database.cteRodoviarioVeiculoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteRodoviarioVeiculoDriftList = await Session.database.cteRodoviarioVeiculoDao.getGroupedList(); 
			}
			if (cteRodoviarioVeiculoDriftList.isNotEmpty) {
				return toListModel(cteRodoviarioVeiculoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteRodoviarioVeiculoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteRodoviarioVeiculoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioVeiculoModel?>? insert(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) async {
		try {
			final lastPk = await Session.database.cteRodoviarioVeiculoDao.insertObject(toDrift(cteRodoviarioVeiculoModel));
			cteRodoviarioVeiculoModel.id = lastPk;
			return cteRodoviarioVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteRodoviarioVeiculoModel?>? update(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) async {
		try {
			await Session.database.cteRodoviarioVeiculoDao.updateObject(toDrift(cteRodoviarioVeiculoModel));
			return cteRodoviarioVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteRodoviarioVeiculoDao.deleteObject(toDrift(CteRodoviarioVeiculoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteRodoviarioVeiculoModel> toListModel(List<CteRodoviarioVeiculoGrouped> cteRodoviarioVeiculoDriftList) {
		List<CteRodoviarioVeiculoModel> listModel = [];
		for (var cteRodoviarioVeiculoDrift in cteRodoviarioVeiculoDriftList) {
			listModel.add(toModel(cteRodoviarioVeiculoDrift)!);
		}
		return listModel;
	}	

	CteRodoviarioVeiculoModel? toModel(CteRodoviarioVeiculoGrouped? cteRodoviarioVeiculoDrift) {
		if (cteRodoviarioVeiculoDrift != null) {
			return CteRodoviarioVeiculoModel(
				id: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.id,
				idCteRodoviario: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.idCteRodoviario,
				codigoInterno: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.codigoInterno,
				renavam: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.renavam,
				placa: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.placa,
				tara: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.tara,
				capacidadeKg: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.capacidadeKg,
				capacidadeM3: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.capacidadeM3,
				tipoPropriedade: CteRodoviarioVeiculoDomain.getTipoPropriedade(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.tipoPropriedade),
				tipoVeiculo: CteRodoviarioVeiculoDomain.getTipoVeiculo(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.tipoVeiculo),
				tipoRodado: CteRodoviarioVeiculoDomain.getTipoRodado(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.tipoRodado),
				tipoCarroceria: CteRodoviarioVeiculoDomain.getTipoCarroceria(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.tipoCarroceria),
				uf: CteRodoviarioVeiculoDomain.getUf(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.uf),
				proprietarioCpf: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioCpf,
				proprietarioCnpj: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioCnpj,
				proprietarioRntrc: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioRntrc,
				proprietarioNome: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioNome,
				proprietarioIe: cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioIe,
				proprietarioUf: CteRodoviarioVeiculoDomain.getProprietarioUf(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioUf),
				proprietarioTipo: CteRodoviarioVeiculoDomain.getProprietarioTipo(cteRodoviarioVeiculoDrift.cteRodoviarioVeiculo?.proprietarioTipo),
				cteRodoviarioModel: CteRodoviarioModel(
					id: cteRodoviarioVeiculoDrift.cteRodoviario?.id,
					idCteCabecalho: cteRodoviarioVeiculoDrift.cteRodoviario?.idCteCabecalho,
					rntrc: cteRodoviarioVeiculoDrift.cteRodoviario?.rntrc,
					dataPrevistaEntrega: cteRodoviarioVeiculoDrift.cteRodoviario?.dataPrevistaEntrega,
					indicadorLotacao: cteRodoviarioVeiculoDrift.cteRodoviario?.indicadorLotacao,
					ciot: cteRodoviarioVeiculoDrift.cteRodoviario?.ciot,
				),
			);
		} else {
			return null;
		}
	}


	CteRodoviarioVeiculoGrouped toDrift(CteRodoviarioVeiculoModel cteRodoviarioVeiculoModel) {
		return CteRodoviarioVeiculoGrouped(
			cteRodoviarioVeiculo: CteRodoviarioVeiculo(
				id: cteRodoviarioVeiculoModel.id,
				idCteRodoviario: cteRodoviarioVeiculoModel.idCteRodoviario,
				codigoInterno: cteRodoviarioVeiculoModel.codigoInterno,
				renavam: cteRodoviarioVeiculoModel.renavam,
				placa: cteRodoviarioVeiculoModel.placa,
				tara: cteRodoviarioVeiculoModel.tara,
				capacidadeKg: cteRodoviarioVeiculoModel.capacidadeKg,
				capacidadeM3: cteRodoviarioVeiculoModel.capacidadeM3,
				tipoPropriedade: CteRodoviarioVeiculoDomain.setTipoPropriedade(cteRodoviarioVeiculoModel.tipoPropriedade),
				tipoVeiculo: CteRodoviarioVeiculoDomain.setTipoVeiculo(cteRodoviarioVeiculoModel.tipoVeiculo),
				tipoRodado: CteRodoviarioVeiculoDomain.setTipoRodado(cteRodoviarioVeiculoModel.tipoRodado),
				tipoCarroceria: CteRodoviarioVeiculoDomain.setTipoCarroceria(cteRodoviarioVeiculoModel.tipoCarroceria),
				uf: CteRodoviarioVeiculoDomain.setUf(cteRodoviarioVeiculoModel.uf),
				proprietarioCpf: Util.removeMask(cteRodoviarioVeiculoModel.proprietarioCpf),
				proprietarioCnpj: Util.removeMask(cteRodoviarioVeiculoModel.proprietarioCnpj),
				proprietarioRntrc: cteRodoviarioVeiculoModel.proprietarioRntrc,
				proprietarioNome: cteRodoviarioVeiculoModel.proprietarioNome,
				proprietarioIe: cteRodoviarioVeiculoModel.proprietarioIe,
				proprietarioUf: CteRodoviarioVeiculoDomain.setProprietarioUf(cteRodoviarioVeiculoModel.proprietarioUf),
				proprietarioTipo: CteRodoviarioVeiculoDomain.setProprietarioTipo(cteRodoviarioVeiculoModel.proprietarioTipo),
			),
		);
	}

		
}
