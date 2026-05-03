import 'package:nfe/app/data/provider/drift/database/database_imports.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/provider/provider_base.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/model/model_imports.dart';

class NfeImportacaoDetalheDriftProvider extends ProviderBase {

	Future<List<NfeImportacaoDetalheModel>?> getList({Filter? filter}) async {
		List<NfeImportacaoDetalheGrouped> nfeImportacaoDetalheDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				nfeImportacaoDetalheDriftList = await Session.database.nfeImportacaoDetalheDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				nfeImportacaoDetalheDriftList = await Session.database.nfeImportacaoDetalheDao.getGroupedList(); 
			}
			if (nfeImportacaoDetalheDriftList.isNotEmpty) {
				return toListModel(nfeImportacaoDetalheDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<NfeImportacaoDetalheModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.nfeImportacaoDetalheDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeImportacaoDetalheModel?>? insert(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) async {
		try {
			final lastPk = await Session.database.nfeImportacaoDetalheDao.insertObject(toDrift(nfeImportacaoDetalheModel));
			nfeImportacaoDetalheModel.id = lastPk;
			return nfeImportacaoDetalheModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<NfeImportacaoDetalheModel?>? update(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) async {
		try {
			await Session.database.nfeImportacaoDetalheDao.updateObject(toDrift(nfeImportacaoDetalheModel));
			return nfeImportacaoDetalheModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.nfeImportacaoDetalheDao.deleteObject(toDrift(NfeImportacaoDetalheModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<NfeImportacaoDetalheModel> toListModel(List<NfeImportacaoDetalheGrouped> nfeImportacaoDetalheDriftList) {
		List<NfeImportacaoDetalheModel> listModel = [];
		for (var nfeImportacaoDetalheDrift in nfeImportacaoDetalheDriftList) {
			listModel.add(toModel(nfeImportacaoDetalheDrift)!);
		}
		return listModel;
	}	

	NfeImportacaoDetalheModel? toModel(NfeImportacaoDetalheGrouped? nfeImportacaoDetalheDrift) {
		if (nfeImportacaoDetalheDrift != null) {
			return NfeImportacaoDetalheModel(
				id: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.id,
				idNfeDeclaracaoImportacao: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.idNfeDeclaracaoImportacao,
				numeroAdicao: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.numeroAdicao,
				numeroSequencial: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.numeroSequencial,
				codigoFabricanteEstrangeiro: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.codigoFabricanteEstrangeiro,
				valorDesconto: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.valorDesconto,
				drawback: nfeImportacaoDetalheDrift.nfeImportacaoDetalhe?.drawback,
				nfeDeclaracaoImportacaoModel: NfeDeclaracaoImportacaoModel(
					id: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.id,
					idNfeDetalhe: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.idNfeDetalhe,
					numeroDocumento: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.numeroDocumento,
					dataRegistro: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.dataRegistro,
					localDesembaraco: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.localDesembaraco,
					ufDesembaraco: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.ufDesembaraco,
					dataDesembaraco: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.dataDesembaraco,
					viaTransporte: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.viaTransporte,
					valorAfrmm: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.valorAfrmm,
					formaIntermediacao: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.formaIntermediacao,
					cnpj: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.cnpj,
					ufTerceiro: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.ufTerceiro,
					codigoExportador: nfeImportacaoDetalheDrift.nfeDeclaracaoImportacao?.codigoExportador,
				),
			);
		} else {
			return null;
		}
	}


	NfeImportacaoDetalheGrouped toDrift(NfeImportacaoDetalheModel nfeImportacaoDetalheModel) {
		return NfeImportacaoDetalheGrouped(
			nfeImportacaoDetalhe: NfeImportacaoDetalhe(
				id: nfeImportacaoDetalheModel.id,
				idNfeDeclaracaoImportacao: nfeImportacaoDetalheModel.idNfeDeclaracaoImportacao,
				numeroAdicao: nfeImportacaoDetalheModel.numeroAdicao,
				numeroSequencial: nfeImportacaoDetalheModel.numeroSequencial,
				codigoFabricanteEstrangeiro: nfeImportacaoDetalheModel.codigoFabricanteEstrangeiro,
				valorDesconto: nfeImportacaoDetalheModel.valorDesconto,
				drawback: nfeImportacaoDetalheModel.drawback,
			),
		);
	}

		
}
