import 'package:wms/app/data/provider/drift/database/database_imports.dart';
import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/provider/provider_base.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';
import 'package:wms/app/data/model/model_imports.dart';

class WmsAgendamentoDriftProvider extends ProviderBase {

	Future<List<WmsAgendamentoModel>?> getList({Filter? filter}) async {
		List<WmsAgendamentoGrouped> wmsAgendamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				wmsAgendamentoDriftList = await Session.database.wmsAgendamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				wmsAgendamentoDriftList = await Session.database.wmsAgendamentoDao.getGroupedList(); 
			}
			if (wmsAgendamentoDriftList.isNotEmpty) {
				return toListModel(wmsAgendamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<WmsAgendamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.wmsAgendamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsAgendamentoModel?>? insert(WmsAgendamentoModel wmsAgendamentoModel) async {
		try {
			final lastPk = await Session.database.wmsAgendamentoDao.insertObject(toDrift(wmsAgendamentoModel));
			wmsAgendamentoModel.id = lastPk;
			return wmsAgendamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<WmsAgendamentoModel?>? update(WmsAgendamentoModel wmsAgendamentoModel) async {
		try {
			await Session.database.wmsAgendamentoDao.updateObject(toDrift(wmsAgendamentoModel));
			return wmsAgendamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.wmsAgendamentoDao.deleteObject(toDrift(WmsAgendamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<WmsAgendamentoModel> toListModel(List<WmsAgendamentoGrouped> wmsAgendamentoDriftList) {
		List<WmsAgendamentoModel> listModel = [];
		for (var wmsAgendamentoDrift in wmsAgendamentoDriftList) {
			listModel.add(toModel(wmsAgendamentoDrift)!);
		}
		return listModel;
	}	

	WmsAgendamentoModel? toModel(WmsAgendamentoGrouped? wmsAgendamentoDrift) {
		if (wmsAgendamentoDrift != null) {
			return WmsAgendamentoModel(
				id: wmsAgendamentoDrift.wmsAgendamento?.id,
				dataOperacao: wmsAgendamentoDrift.wmsAgendamento?.dataOperacao,
				horaOperacao: wmsAgendamentoDrift.wmsAgendamento?.horaOperacao,
				localOperacao: wmsAgendamentoDrift.wmsAgendamento?.localOperacao,
				quantidadeVolume: wmsAgendamentoDrift.wmsAgendamento?.quantidadeVolume,
				pesoTotalVolume: wmsAgendamentoDrift.wmsAgendamento?.pesoTotalVolume,
				quantidadePessoa: wmsAgendamentoDrift.wmsAgendamento?.quantidadePessoa,
				quantidadeHora: wmsAgendamentoDrift.wmsAgendamento?.quantidadeHora,
			);
		} else {
			return null;
		}
	}


	WmsAgendamentoGrouped toDrift(WmsAgendamentoModel wmsAgendamentoModel) {
		return WmsAgendamentoGrouped(
			wmsAgendamento: WmsAgendamento(
				id: wmsAgendamentoModel.id,
				dataOperacao: wmsAgendamentoModel.dataOperacao,
				horaOperacao: Util.removeMask(wmsAgendamentoModel.horaOperacao),
				localOperacao: wmsAgendamentoModel.localOperacao,
				quantidadeVolume: wmsAgendamentoModel.quantidadeVolume,
				pesoTotalVolume: wmsAgendamentoModel.pesoTotalVolume,
				quantidadePessoa: wmsAgendamentoModel.quantidadePessoa,
				quantidadeHora: wmsAgendamentoModel.quantidadeHora,
			),
		);
	}

		
}
