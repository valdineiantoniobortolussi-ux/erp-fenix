import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class EmpresaTransporteDriftProvider extends ProviderBase {

	Future<List<EmpresaTransporteModel>?> getList({Filter? filter}) async {
		List<EmpresaTransporteGrouped> empresaTransporteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				empresaTransporteDriftList = await Session.database.empresaTransporteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				empresaTransporteDriftList = await Session.database.empresaTransporteDao.getGroupedList(); 
			}
			if (empresaTransporteDriftList.isNotEmpty) {
				return toListModel(empresaTransporteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EmpresaTransporteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.empresaTransporteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EmpresaTransporteModel?>? insert(EmpresaTransporteModel empresaTransporteModel) async {
		try {
			final lastPk = await Session.database.empresaTransporteDao.insertObject(toDrift(empresaTransporteModel));
			empresaTransporteModel.id = lastPk;
			return empresaTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EmpresaTransporteModel?>? update(EmpresaTransporteModel empresaTransporteModel) async {
		try {
			await Session.database.empresaTransporteDao.updateObject(toDrift(empresaTransporteModel));
			return empresaTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.empresaTransporteDao.deleteObject(toDrift(EmpresaTransporteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EmpresaTransporteModel> toListModel(List<EmpresaTransporteGrouped> empresaTransporteDriftList) {
		List<EmpresaTransporteModel> listModel = [];
		for (var empresaTransporteDrift in empresaTransporteDriftList) {
			listModel.add(toModel(empresaTransporteDrift)!);
		}
		return listModel;
	}	

	EmpresaTransporteModel? toModel(EmpresaTransporteGrouped? empresaTransporteDrift) {
		if (empresaTransporteDrift != null) {
			return EmpresaTransporteModel(
				id: empresaTransporteDrift.empresaTransporte?.id,
				nome: empresaTransporteDrift.empresaTransporte?.nome,
				uf: EmpresaTransporteDomain.getUf(empresaTransporteDrift.empresaTransporte?.uf),
				classificacaoContabilConta: empresaTransporteDrift.empresaTransporte?.classificacaoContabilConta,
				empresaTransporteItinerarioModelList: empresaTransporteItinerarioDriftToModel(empresaTransporteDrift.empresaTransporteItinerarioGroupedList),
			);
		} else {
			return null;
		}
	}

	List<EmpresaTransporteItinerarioModel> empresaTransporteItinerarioDriftToModel(List<EmpresaTransporteItinerarioGrouped>? empresaTransporteItinerarioDriftList) { 
		List<EmpresaTransporteItinerarioModel> empresaTransporteItinerarioModelList = [];
		if (empresaTransporteItinerarioDriftList != null) {
			for (var empresaTransporteItinerarioGrouped in empresaTransporteItinerarioDriftList) {
				empresaTransporteItinerarioModelList.add(
					EmpresaTransporteItinerarioModel(
						id: empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.id,
						idEmpresaTransporte: empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.idEmpresaTransporte,
						nome: empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.nome,
						tarifa: empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.tarifa,
						trajeto: empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.trajeto,
					)
				);
			}
			return empresaTransporteItinerarioModelList;
		}
		return [];
	}


	EmpresaTransporteGrouped toDrift(EmpresaTransporteModel empresaTransporteModel) {
		return EmpresaTransporteGrouped(
			empresaTransporte: EmpresaTransporte(
				id: empresaTransporteModel.id,
				nome: empresaTransporteModel.nome,
				uf: EmpresaTransporteDomain.setUf(empresaTransporteModel.uf),
				classificacaoContabilConta: empresaTransporteModel.classificacaoContabilConta,
			),
			empresaTransporteItinerarioGroupedList: empresaTransporteItinerarioModelToDrift(empresaTransporteModel.empresaTransporteItinerarioModelList),
		);
	}

	List<EmpresaTransporteItinerarioGrouped> empresaTransporteItinerarioModelToDrift(List<EmpresaTransporteItinerarioModel>? empresaTransporteItinerarioModelList) { 
		List<EmpresaTransporteItinerarioGrouped> empresaTransporteItinerarioGroupedList = [];
		if (empresaTransporteItinerarioModelList != null) {
			for (var empresaTransporteItinerarioModel in empresaTransporteItinerarioModelList) {
				empresaTransporteItinerarioGroupedList.add(
					EmpresaTransporteItinerarioGrouped(
						empresaTransporteItinerario: EmpresaTransporteItinerario(
							id: empresaTransporteItinerarioModel.id,
							idEmpresaTransporte: empresaTransporteItinerarioModel.idEmpresaTransporte,
							nome: empresaTransporteItinerarioModel.nome,
							tarifa: empresaTransporteItinerarioModel.tarifa,
							trajeto: empresaTransporteItinerarioModel.trajeto,
						),
					),
				);
			}
			return empresaTransporteItinerarioGroupedList;
		}
		return [];
	}

		
}
