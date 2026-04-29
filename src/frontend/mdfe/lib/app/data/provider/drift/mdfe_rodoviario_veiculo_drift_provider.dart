import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/provider/provider_base.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfeRodoviarioVeiculoDriftProvider extends ProviderBase {

	Future<List<MdfeRodoviarioVeiculoModel>?> getList({Filter? filter}) async {
		List<MdfeRodoviarioVeiculoGrouped> mdfeRodoviarioVeiculoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				mdfeRodoviarioVeiculoDriftList = await Session.database.mdfeRodoviarioVeiculoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				mdfeRodoviarioVeiculoDriftList = await Session.database.mdfeRodoviarioVeiculoDao.getGroupedList(); 
			}
			if (mdfeRodoviarioVeiculoDriftList.isNotEmpty) {
				return toListModel(mdfeRodoviarioVeiculoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MdfeRodoviarioVeiculoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.mdfeRodoviarioVeiculoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioVeiculoModel?>? insert(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) async {
		try {
			final lastPk = await Session.database.mdfeRodoviarioVeiculoDao.insertObject(toDrift(mdfeRodoviarioVeiculoModel));
			mdfeRodoviarioVeiculoModel.id = lastPk;
			return mdfeRodoviarioVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MdfeRodoviarioVeiculoModel?>? update(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) async {
		try {
			await Session.database.mdfeRodoviarioVeiculoDao.updateObject(toDrift(mdfeRodoviarioVeiculoModel));
			return mdfeRodoviarioVeiculoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.mdfeRodoviarioVeiculoDao.deleteObject(toDrift(MdfeRodoviarioVeiculoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MdfeRodoviarioVeiculoModel> toListModel(List<MdfeRodoviarioVeiculoGrouped> mdfeRodoviarioVeiculoDriftList) {
		List<MdfeRodoviarioVeiculoModel> listModel = [];
		for (var mdfeRodoviarioVeiculoDrift in mdfeRodoviarioVeiculoDriftList) {
			listModel.add(toModel(mdfeRodoviarioVeiculoDrift)!);
		}
		return listModel;
	}	

	MdfeRodoviarioVeiculoModel? toModel(MdfeRodoviarioVeiculoGrouped? mdfeRodoviarioVeiculoDrift) {
		if (mdfeRodoviarioVeiculoDrift != null) {
			return MdfeRodoviarioVeiculoModel(
				id: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.id,
				idMdfeRodoviario: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.idMdfeRodoviario,
				codigoInterno: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.codigoInterno,
				placa: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.placa,
				renavam: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.renavam,
				tara: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.tara,
				capacidadeKg: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.capacidadeKg,
				capacidadeM3: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.capacidadeM3,
				tipoRodado: MdfeRodoviarioVeiculoDomain.getTipoRodado(mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.tipoRodado),
				tipoCarroceria: MdfeRodoviarioVeiculoDomain.getTipoCarroceria(mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.tipoCarroceria),
				ufLicenciamento: MdfeRodoviarioVeiculoDomain.getUfLicenciamento(mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.ufLicenciamento),
				proprietarioCpf: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioCpf,
				proprietarioCnpj: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioCnpj,
				proprietarioRntrc: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioRntrc,
				proprietarioNome: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioNome,
				proprietarioIe: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioIe,
				proprietarioTipo: mdfeRodoviarioVeiculoDrift.mdfeRodoviarioVeiculo?.proprietarioTipo,
				mdfeRodoviarioModel: MdfeRodoviarioModel(
					id: mdfeRodoviarioVeiculoDrift.mdfeRodoviario?.id,
					idMdfeCabecalho: mdfeRodoviarioVeiculoDrift.mdfeRodoviario?.idMdfeCabecalho,
					rntrc: mdfeRodoviarioVeiculoDrift.mdfeRodoviario?.rntrc,
					codigoAgendamento: mdfeRodoviarioVeiculoDrift.mdfeRodoviario?.codigoAgendamento,
				),
			);
		} else {
			return null;
		}
	}


	MdfeRodoviarioVeiculoGrouped toDrift(MdfeRodoviarioVeiculoModel mdfeRodoviarioVeiculoModel) {
		return MdfeRodoviarioVeiculoGrouped(
			mdfeRodoviarioVeiculo: MdfeRodoviarioVeiculo(
				id: mdfeRodoviarioVeiculoModel.id,
				idMdfeRodoviario: mdfeRodoviarioVeiculoModel.idMdfeRodoviario,
				codigoInterno: mdfeRodoviarioVeiculoModel.codigoInterno,
				placa: mdfeRodoviarioVeiculoModel.placa,
				renavam: mdfeRodoviarioVeiculoModel.renavam,
				tara: mdfeRodoviarioVeiculoModel.tara,
				capacidadeKg: mdfeRodoviarioVeiculoModel.capacidadeKg,
				capacidadeM3: mdfeRodoviarioVeiculoModel.capacidadeM3,
				tipoRodado: MdfeRodoviarioVeiculoDomain.setTipoRodado(mdfeRodoviarioVeiculoModel.tipoRodado),
				tipoCarroceria: MdfeRodoviarioVeiculoDomain.setTipoCarroceria(mdfeRodoviarioVeiculoModel.tipoCarroceria),
				ufLicenciamento: MdfeRodoviarioVeiculoDomain.setUfLicenciamento(mdfeRodoviarioVeiculoModel.ufLicenciamento),
				proprietarioCpf: Util.removeMask(mdfeRodoviarioVeiculoModel.proprietarioCpf),
				proprietarioCnpj: Util.removeMask(mdfeRodoviarioVeiculoModel.proprietarioCnpj),
				proprietarioRntrc: mdfeRodoviarioVeiculoModel.proprietarioRntrc,
				proprietarioNome: mdfeRodoviarioVeiculoModel.proprietarioNome,
				proprietarioIe: mdfeRodoviarioVeiculoModel.proprietarioIe,
				proprietarioTipo: mdfeRodoviarioVeiculoModel.proprietarioTipo,
			),
		);
	}

		
}
