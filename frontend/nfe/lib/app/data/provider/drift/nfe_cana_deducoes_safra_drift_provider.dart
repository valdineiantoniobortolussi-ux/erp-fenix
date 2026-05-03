import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaDeducoesSafraDriftProvider extends ProviderBase {

	Future<List<NfeCanaDeducoesSafraModel>?> getList({Filter? filter}) async {
		List<NfeCanaDeducoesSafraGrouped> nfeCanaDeducoesSafraDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeCanaDeducoesSafraDriftList = await Session.database.nfeCanaDeducoesSafraDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeCanaDeducoesSafraDriftList = await Session.database.nfeCanaDeducoesSafraDao.getGroupedList(); 
			}
			if (nfeCanaDeducoesSafraDriftList.isNotEmpty) {
				return toListModel(nfeCanaDeducoesSafraDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeCanaDeducoesSafraModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeCanaDeducoesSafraDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCanaDeducoesSafraModel?>? insert(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) async {
		try {
			final lastPk = await Session.database.nfeCanaDeducoesSafraDao.insertObject(toDrift(nfeCanaDeducoesSafraModel));
			nfeCanaDeducoesSafraModel.id = lastPk;
			return nfeCanaDeducoesSafraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCanaDeducoesSafraModel?>? update(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) async {
		try {
			await Session.database.nfeCanaDeducoesSafraDao.updateObject(toDrift(nfeCanaDeducoesSafraModel));
			return nfeCanaDeducoesSafraModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeCanaDeducoesSafraDao.deleteObject(toDrift(NfeCanaDeducoesSafraModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeCanaDeducoesSafraModel> toListModel(List<NfeCanaDeducoesSafraGrouped> nfeCanaDeducoesSafraDriftList) {
		List<NfeCanaDeducoesSafraModel> listModel = [];
		for (var nfeCanaDeducoesSafraDrift in nfeCanaDeducoesSafraDriftList) {
			listModel.add(toModel(nfeCanaDeducoesSafraDrift)!);
		}
		return listModel;
	}	

	NfeCanaDeducoesSafraModel? toModel(NfeCanaDeducoesSafraGrouped? nfeCanaDeducoesSafraDrift) {
		if (nfeCanaDeducoesSafraDrift != null) {
			return NfeCanaDeducoesSafraModel(
				id: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.id,
				idNfeCana: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.idNfeCana,
				decricao: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.decricao,
				valorDeducao: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.valorDeducao,
				valorFornecimento: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.valorFornecimento,
				valorTotalDeducao: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.valorTotalDeducao,
				valorLiquidoFornecimento: nfeCanaDeducoesSafraDrift.nfeCanaDeducoesSafra?.valorLiquidoFornecimento,
				nfeCanaModel: NfeCanaModel(
					id: nfeCanaDeducoesSafraDrift.nfeCana?.id,
					idNfeCabecalho: nfeCanaDeducoesSafraDrift.nfeCana?.idNfeCabecalho,
					safra: nfeCanaDeducoesSafraDrift.nfeCana?.safra,
					mesAnoReferencia: nfeCanaDeducoesSafraDrift.nfeCana?.mesAnoReferencia,
				),
			);
		} else {
			return null;
		}
	}


	NfeCanaDeducoesSafraGrouped toDrift(NfeCanaDeducoesSafraModel nfeCanaDeducoesSafraModel) {
		return NfeCanaDeducoesSafraGrouped(
			nfeCanaDeducoesSafra: NfeCanaDeducoesSafra(
				id: nfeCanaDeducoesSafraModel.id,
				idNfeCana: nfeCanaDeducoesSafraModel.idNfeCana,
				decricao: nfeCanaDeducoesSafraModel.decricao,
				valorDeducao: nfeCanaDeducoesSafraModel.valorDeducao,
				valorFornecimento: nfeCanaDeducoesSafraModel.valorFornecimento,
				valorTotalDeducao: nfeCanaDeducoesSafraModel.valorTotalDeducao,
				valorLiquidoFornecimento: nfeCanaDeducoesSafraModel.valorLiquidoFornecimento,
			),
		);
	}

		
}
