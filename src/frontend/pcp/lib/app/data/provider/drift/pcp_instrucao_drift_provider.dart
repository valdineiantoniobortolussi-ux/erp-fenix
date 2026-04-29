import 'package:pcp/app/data/provider/drift/database/database_imports.dart';
import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/provider/provider_base.dart';
import 'package:pcp/app/data/provider/drift/database/database.dart';
import 'package:pcp/app/data/model/model_imports.dart';

class PcpInstrucaoDriftProvider extends ProviderBase {

	Future<List<PcpInstrucaoModel>?> getList({Filter? filter}) async {
		List<PcpInstrucaoGrouped> pcpInstrucaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pcpInstrucaoDriftList = await Session.database.pcpInstrucaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pcpInstrucaoDriftList = await Session.database.pcpInstrucaoDao.getGroupedList(); 
			}
			if (pcpInstrucaoDriftList.isNotEmpty) {
				return toListModel(pcpInstrucaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PcpInstrucaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pcpInstrucaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpInstrucaoModel?>? insert(PcpInstrucaoModel pcpInstrucaoModel) async {
		try {
			final lastPk = await Session.database.pcpInstrucaoDao.insertObject(toDrift(pcpInstrucaoModel));
			pcpInstrucaoModel.id = lastPk;
			return pcpInstrucaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PcpInstrucaoModel?>? update(PcpInstrucaoModel pcpInstrucaoModel) async {
		try {
			await Session.database.pcpInstrucaoDao.updateObject(toDrift(pcpInstrucaoModel));
			return pcpInstrucaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pcpInstrucaoDao.deleteObject(toDrift(PcpInstrucaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PcpInstrucaoModel> toListModel(List<PcpInstrucaoGrouped> pcpInstrucaoDriftList) {
		List<PcpInstrucaoModel> listModel = [];
		for (var pcpInstrucaoDrift in pcpInstrucaoDriftList) {
			listModel.add(toModel(pcpInstrucaoDrift)!);
		}
		return listModel;
	}	

	PcpInstrucaoModel? toModel(PcpInstrucaoGrouped? pcpInstrucaoDrift) {
		if (pcpInstrucaoDrift != null) {
			return PcpInstrucaoModel(
				id: pcpInstrucaoDrift.pcpInstrucao?.id,
				codigo: pcpInstrucaoDrift.pcpInstrucao?.codigo,
				descricao: pcpInstrucaoDrift.pcpInstrucao?.descricao,
			);
		} else {
			return null;
		}
	}


	PcpInstrucaoGrouped toDrift(PcpInstrucaoModel pcpInstrucaoModel) {
		return PcpInstrucaoGrouped(
			pcpInstrucao: PcpInstrucao(
				id: pcpInstrucaoModel.id,
				codigo: pcpInstrucaoModel.codigo,
				descricao: pcpInstrucaoModel.descricao,
			),
		);
	}

		
}
