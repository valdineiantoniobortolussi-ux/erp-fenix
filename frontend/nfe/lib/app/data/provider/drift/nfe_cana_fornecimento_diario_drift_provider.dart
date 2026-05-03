import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeCanaFornecimentoDiarioDriftProvider extends ProviderBase {

	Future<List<NfeCanaFornecimentoDiarioModel>?> getList({Filter? filter}) async {
		List<NfeCanaFornecimentoDiarioGrouped> nfeCanaFornecimentoDiarioDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeCanaFornecimentoDiarioDriftList = await Session.database.nfeCanaFornecimentoDiarioDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeCanaFornecimentoDiarioDriftList = await Session.database.nfeCanaFornecimentoDiarioDao.getGroupedList(); 
			}
			if (nfeCanaFornecimentoDiarioDriftList.isNotEmpty) {
				return toListModel(nfeCanaFornecimentoDiarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeCanaFornecimentoDiarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeCanaFornecimentoDiarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCanaFornecimentoDiarioModel?>? insert(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) async {
		try {
			final lastPk = await Session.database.nfeCanaFornecimentoDiarioDao.insertObject(toDrift(nfeCanaFornecimentoDiarioModel));
			nfeCanaFornecimentoDiarioModel.id = lastPk;
			return nfeCanaFornecimentoDiarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeCanaFornecimentoDiarioModel?>? update(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) async {
		try {
			await Session.database.nfeCanaFornecimentoDiarioDao.updateObject(toDrift(nfeCanaFornecimentoDiarioModel));
			return nfeCanaFornecimentoDiarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeCanaFornecimentoDiarioDao.deleteObject(toDrift(NfeCanaFornecimentoDiarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeCanaFornecimentoDiarioModel> toListModel(List<NfeCanaFornecimentoDiarioGrouped> nfeCanaFornecimentoDiarioDriftList) {
		List<NfeCanaFornecimentoDiarioModel> listModel = [];
		for (var nfeCanaFornecimentoDiarioDrift in nfeCanaFornecimentoDiarioDriftList) {
			listModel.add(toModel(nfeCanaFornecimentoDiarioDrift)!);
		}
		return listModel;
	}	

	NfeCanaFornecimentoDiarioModel? toModel(NfeCanaFornecimentoDiarioGrouped? nfeCanaFornecimentoDiarioDrift) {
		if (nfeCanaFornecimentoDiarioDrift != null) {
			return NfeCanaFornecimentoDiarioModel(
				id: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.id,
				idNfeCana: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.idNfeCana,
				dia: NfeCanaFornecimentoDiarioDomain.getDia(nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.dia),
				quantidade: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.quantidade,
				quantidadeTotalMes: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.quantidadeTotalMes,
				quantidadeTotalAnterior: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.quantidadeTotalAnterior,
				quantidadeTotalGeral: nfeCanaFornecimentoDiarioDrift.nfeCanaFornecimentoDiario?.quantidadeTotalGeral,
				nfeCanaModel: NfeCanaModel(
					id: nfeCanaFornecimentoDiarioDrift.nfeCana?.id,
					idNfeCabecalho: nfeCanaFornecimentoDiarioDrift.nfeCana?.idNfeCabecalho,
					safra: nfeCanaFornecimentoDiarioDrift.nfeCana?.safra,
					mesAnoReferencia: nfeCanaFornecimentoDiarioDrift.nfeCana?.mesAnoReferencia,
				),
			);
		} else {
			return null;
		}
	}


	NfeCanaFornecimentoDiarioGrouped toDrift(NfeCanaFornecimentoDiarioModel nfeCanaFornecimentoDiarioModel) {
		return NfeCanaFornecimentoDiarioGrouped(
			nfeCanaFornecimentoDiario: NfeCanaFornecimentoDiario(
				id: nfeCanaFornecimentoDiarioModel.id,
				idNfeCana: nfeCanaFornecimentoDiarioModel.idNfeCana,
				dia: NfeCanaFornecimentoDiarioDomain.setDia(nfeCanaFornecimentoDiarioModel.dia),
				quantidade: nfeCanaFornecimentoDiarioModel.quantidade,
				quantidadeTotalMes: nfeCanaFornecimentoDiarioModel.quantidadeTotalMes,
				quantidadeTotalAnterior: nfeCanaFornecimentoDiarioModel.quantidadeTotalAnterior,
				quantidadeTotalGeral: nfeCanaFornecimentoDiarioModel.quantidadeTotalGeral,
			),
		);
	}

		
}
