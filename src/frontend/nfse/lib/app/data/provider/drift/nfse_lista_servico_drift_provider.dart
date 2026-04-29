import 'package:nfse/app/data/provider/drift/database/database_imports.dart';
import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/provider/provider_base.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/model/model_imports.dart';

class NfseListaServicoDriftProvider extends ProviderBase {

	Future<List<NfseListaServicoModel>?> getList({Filter? filter}) async {
		List<NfseListaServicoGrouped> nfseListaServicoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfseListaServicoDriftList = await Session.database.nfseListaServicoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfseListaServicoDriftList = await Session.database.nfseListaServicoDao.getGroupedList(); 
			}
			if (nfseListaServicoDriftList.isNotEmpty) {
				return toListModel(nfseListaServicoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfseListaServicoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfseListaServicoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfseListaServicoModel?>? insert(NfseListaServicoModel nfseListaServicoModel) async {
		try {
			final lastPk = await Session.database.nfseListaServicoDao.insertObject(toDrift(nfseListaServicoModel));
			nfseListaServicoModel.id = lastPk;
			return nfseListaServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfseListaServicoModel?>? update(NfseListaServicoModel nfseListaServicoModel) async {
		try {
			await Session.database.nfseListaServicoDao.updateObject(toDrift(nfseListaServicoModel));
			return nfseListaServicoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfseListaServicoDao.deleteObject(toDrift(NfseListaServicoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfseListaServicoModel> toListModel(List<NfseListaServicoGrouped> nfseListaServicoDriftList) {
		List<NfseListaServicoModel> listModel = [];
		for (var nfseListaServicoDrift in nfseListaServicoDriftList) {
			listModel.add(toModel(nfseListaServicoDrift)!);
		}
		return listModel;
	}	

	NfseListaServicoModel? toModel(NfseListaServicoGrouped? nfseListaServicoDrift) {
		if (nfseListaServicoDrift != null) {
			return NfseListaServicoModel(
				id: nfseListaServicoDrift.nfseListaServico?.id,
				codigo: nfseListaServicoDrift.nfseListaServico?.codigo,
				descricao: nfseListaServicoDrift.nfseListaServico?.descricao,
			);
		} else {
			return null;
		}
	}


	NfseListaServicoGrouped toDrift(NfseListaServicoModel nfseListaServicoModel) {
		return NfseListaServicoGrouped(
			nfseListaServico: NfseListaServico(
				id: nfseListaServicoModel.id,
				codigo: nfseListaServicoModel.codigo,
				descricao: nfseListaServicoModel.descricao,
			),
		);
	}

		
}
