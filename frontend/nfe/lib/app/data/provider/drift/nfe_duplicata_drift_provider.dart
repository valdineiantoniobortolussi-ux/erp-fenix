import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeDuplicataDriftProvider extends ProviderBase {

	Future<List<NfeDuplicataModel>?> getList({Filter? filter}) async {
		List<NfeDuplicataGrouped> nfeDuplicataDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeDuplicataDriftList = await Session.database.nfeDuplicataDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeDuplicataDriftList = await Session.database.nfeDuplicataDao.getGroupedList(); 
			}
			if (nfeDuplicataDriftList.isNotEmpty) {
				return toListModel(nfeDuplicataDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeDuplicataModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeDuplicataDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeDuplicataModel?>? insert(NfeDuplicataModel nfeDuplicataModel) async {
		try {
			final lastPk = await Session.database.nfeDuplicataDao.insertObject(toDrift(nfeDuplicataModel));
			nfeDuplicataModel.id = lastPk;
			return nfeDuplicataModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeDuplicataModel?>? update(NfeDuplicataModel nfeDuplicataModel) async {
		try {
			await Session.database.nfeDuplicataDao.updateObject(toDrift(nfeDuplicataModel));
			return nfeDuplicataModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeDuplicataDao.deleteObject(toDrift(NfeDuplicataModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeDuplicataModel> toListModel(List<NfeDuplicataGrouped> nfeDuplicataDriftList) {
		List<NfeDuplicataModel> listModel = [];
		for (var nfeDuplicataDrift in nfeDuplicataDriftList) {
			listModel.add(toModel(nfeDuplicataDrift)!);
		}
		return listModel;
	}	

	NfeDuplicataModel? toModel(NfeDuplicataGrouped? nfeDuplicataDrift) {
		if (nfeDuplicataDrift != null) {
			return NfeDuplicataModel(
				id: nfeDuplicataDrift.nfeDuplicata?.id,
				idNfeFatura: nfeDuplicataDrift.nfeDuplicata?.idNfeFatura,
				numero: nfeDuplicataDrift.nfeDuplicata?.numero,
				dataVencimento: nfeDuplicataDrift.nfeDuplicata?.dataVencimento,
				valor: nfeDuplicataDrift.nfeDuplicata?.valor,
				nfeFaturaModel: NfeFaturaModel(
					id: nfeDuplicataDrift.nfeFatura?.id,
					idNfeCabecalho: nfeDuplicataDrift.nfeFatura?.idNfeCabecalho,
					numero: nfeDuplicataDrift.nfeFatura?.numero,
					valorOriginal: nfeDuplicataDrift.nfeFatura?.valorOriginal,
					valorDesconto: nfeDuplicataDrift.nfeFatura?.valorDesconto,
					valorLiquido: nfeDuplicataDrift.nfeFatura?.valorLiquido,
				),
			);
		} else {
			return null;
		}
	}


	NfeDuplicataGrouped toDrift(NfeDuplicataModel nfeDuplicataModel) {
		return NfeDuplicataGrouped(
			nfeDuplicata: NfeDuplicata(
				id: nfeDuplicataModel.id,
				idNfeFatura: nfeDuplicataModel.idNfeFatura,
				numero: nfeDuplicataModel.numero,
				dataVencimento: nfeDuplicataModel.dataVencimento,
				valor: nfeDuplicataModel.valor,
			),
		);
	}

		
}
