import 'package:cte/app/data/provider/drift/database/database_imports.dart';
import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/provider/provider_base.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteFerroviarioVagaoDriftProvider extends ProviderBase {

	Future<List<CteFerroviarioVagaoModel>?> getList({Filter? filter}) async {
		List<CteFerroviarioVagaoGrouped> cteFerroviarioVagaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				cteFerroviarioVagaoDriftList = await Session.database.cteFerroviarioVagaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				cteFerroviarioVagaoDriftList = await Session.database.cteFerroviarioVagaoDao.getGroupedList(); 
			}
			if (cteFerroviarioVagaoDriftList.isNotEmpty) {
				return toListModel(cteFerroviarioVagaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<CteFerroviarioVagaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.cteFerroviarioVagaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteFerroviarioVagaoModel?>? insert(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) async {
		try {
			final lastPk = await Session.database.cteFerroviarioVagaoDao.insertObject(toDrift(cteFerroviarioVagaoModel));
			cteFerroviarioVagaoModel.id = lastPk;
			return cteFerroviarioVagaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<CteFerroviarioVagaoModel?>? update(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) async {
		try {
			await Session.database.cteFerroviarioVagaoDao.updateObject(toDrift(cteFerroviarioVagaoModel));
			return cteFerroviarioVagaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.cteFerroviarioVagaoDao.deleteObject(toDrift(CteFerroviarioVagaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<CteFerroviarioVagaoModel> toListModel(List<CteFerroviarioVagaoGrouped> cteFerroviarioVagaoDriftList) {
		List<CteFerroviarioVagaoModel> listModel = [];
		for (var cteFerroviarioVagaoDrift in cteFerroviarioVagaoDriftList) {
			listModel.add(toModel(cteFerroviarioVagaoDrift)!);
		}
		return listModel;
	}	

	CteFerroviarioVagaoModel? toModel(CteFerroviarioVagaoGrouped? cteFerroviarioVagaoDrift) {
		if (cteFerroviarioVagaoDrift != null) {
			return CteFerroviarioVagaoModel(
				id: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.id,
				idCteFerroviario: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.idCteFerroviario,
				numeroVagao: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.numeroVagao,
				capacidade: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.capacidade,
				tipoVagao: CteFerroviarioVagaoDomain.getTipoVagao(cteFerroviarioVagaoDrift.cteFerroviarioVagao?.tipoVagao),
				pesoReal: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.pesoReal,
				pesoBc: cteFerroviarioVagaoDrift.cteFerroviarioVagao?.pesoBc,
				cteFerroviarioModel: CteFerroviarioModel(
					id: cteFerroviarioVagaoDrift.cteFerroviario?.id,
					idCteCabecalho: cteFerroviarioVagaoDrift.cteFerroviario?.idCteCabecalho,
					tipoTrafego: cteFerroviarioVagaoDrift.cteFerroviario?.tipoTrafego,
					responsavelFaturamento: cteFerroviarioVagaoDrift.cteFerroviario?.responsavelFaturamento,
					ferroviaEmitenteCte: cteFerroviarioVagaoDrift.cteFerroviario?.ferroviaEmitenteCte,
					fluxo: cteFerroviarioVagaoDrift.cteFerroviario?.fluxo,
					idTrem: cteFerroviarioVagaoDrift.cteFerroviario?.idTrem,
					valorFrete: cteFerroviarioVagaoDrift.cteFerroviario?.valorFrete,
				),
			);
		} else {
			return null;
		}
	}


	CteFerroviarioVagaoGrouped toDrift(CteFerroviarioVagaoModel cteFerroviarioVagaoModel) {
		return CteFerroviarioVagaoGrouped(
			cteFerroviarioVagao: CteFerroviarioVagao(
				id: cteFerroviarioVagaoModel.id,
				idCteFerroviario: cteFerroviarioVagaoModel.idCteFerroviario,
				numeroVagao: cteFerroviarioVagaoModel.numeroVagao,
				capacidade: cteFerroviarioVagaoModel.capacidade,
				tipoVagao: CteFerroviarioVagaoDomain.setTipoVagao(cteFerroviarioVagaoModel.tipoVagao),
				pesoReal: cteFerroviarioVagaoModel.pesoReal,
				pesoBc: cteFerroviarioVagaoModel.pesoBc,
			),
		);
	}

		
}
