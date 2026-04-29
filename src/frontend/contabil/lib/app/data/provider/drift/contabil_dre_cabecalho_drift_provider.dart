import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilDreCabecalhoDriftProvider extends ProviderBase {

	Future<List<ContabilDreCabecalhoModel>?> getList({Filter? filter}) async {
		List<ContabilDreCabecalhoGrouped> contabilDreCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilDreCabecalhoDriftList = await Session.database.contabilDreCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilDreCabecalhoDriftList = await Session.database.contabilDreCabecalhoDao.getGroupedList(); 
			}
			if (contabilDreCabecalhoDriftList.isNotEmpty) {
				return toListModel(contabilDreCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilDreCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilDreCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilDreCabecalhoModel?>? insert(ContabilDreCabecalhoModel contabilDreCabecalhoModel) async {
		try {
			final lastPk = await Session.database.contabilDreCabecalhoDao.insertObject(toDrift(contabilDreCabecalhoModel));
			contabilDreCabecalhoModel.id = lastPk;
			return contabilDreCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilDreCabecalhoModel?>? update(ContabilDreCabecalhoModel contabilDreCabecalhoModel) async {
		try {
			await Session.database.contabilDreCabecalhoDao.updateObject(toDrift(contabilDreCabecalhoModel));
			return contabilDreCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilDreCabecalhoDao.deleteObject(toDrift(ContabilDreCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilDreCabecalhoModel> toListModel(List<ContabilDreCabecalhoGrouped> contabilDreCabecalhoDriftList) {
		List<ContabilDreCabecalhoModel> listModel = [];
		for (var contabilDreCabecalhoDrift in contabilDreCabecalhoDriftList) {
			listModel.add(toModel(contabilDreCabecalhoDrift)!);
		}
		return listModel;
	}	

	ContabilDreCabecalhoModel? toModel(ContabilDreCabecalhoGrouped? contabilDreCabecalhoDrift) {
		if (contabilDreCabecalhoDrift != null) {
			return ContabilDreCabecalhoModel(
				id: contabilDreCabecalhoDrift.contabilDreCabecalho?.id,
				descricao: contabilDreCabecalhoDrift.contabilDreCabecalho?.descricao,
				padrao: ContabilDreCabecalhoDomain.getPadrao(contabilDreCabecalhoDrift.contabilDreCabecalho?.padrao),
				periodoInicial: contabilDreCabecalhoDrift.contabilDreCabecalho?.periodoInicial,
				periodoFinal: contabilDreCabecalhoDrift.contabilDreCabecalho?.periodoFinal,
				contabilDreDetalheModelList: contabilDreDetalheDriftToModel(contabilDreCabecalhoDrift.contabilDreDetalheGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ContabilDreDetalheModel> contabilDreDetalheDriftToModel(List<ContabilDreDetalheGrouped>? contabilDreDetalheDriftList) { 
		List<ContabilDreDetalheModel> contabilDreDetalheModelList = [];
		if (contabilDreDetalheDriftList != null) {
			for (var contabilDreDetalheGrouped in contabilDreDetalheDriftList) {
				contabilDreDetalheModelList.add(
					ContabilDreDetalheModel(
						id: contabilDreDetalheGrouped.contabilDreDetalhe?.id,
						idContabilDreCabecalho: contabilDreDetalheGrouped.contabilDreDetalhe?.idContabilDreCabecalho,
						classificacao: contabilDreDetalheGrouped.contabilDreDetalhe?.classificacao,
						descricao: contabilDreDetalheGrouped.contabilDreDetalhe?.descricao,
						formaCalculo: ContabilDreDetalheDomain.getFormaCalculo(contabilDreDetalheGrouped.contabilDreDetalhe?.formaCalculo),
						sinal: ContabilDreDetalheDomain.getSinal(contabilDreDetalheGrouped.contabilDreDetalhe?.sinal),
						natureza: ContabilDreDetalheDomain.getNatureza(contabilDreDetalheGrouped.contabilDreDetalhe?.natureza),
						valor: contabilDreDetalheGrouped.contabilDreDetalhe?.valor,
					)
				);
			}
			return contabilDreDetalheModelList;
		}
		return [];
	}


	ContabilDreCabecalhoGrouped toDrift(ContabilDreCabecalhoModel contabilDreCabecalhoModel) {
		return ContabilDreCabecalhoGrouped(
			contabilDreCabecalho: ContabilDreCabecalho(
				id: contabilDreCabecalhoModel.id,
				descricao: contabilDreCabecalhoModel.descricao,
				padrao: ContabilDreCabecalhoDomain.setPadrao(contabilDreCabecalhoModel.padrao),
				periodoInicial: Util.removeMask(contabilDreCabecalhoModel.periodoInicial),
				periodoFinal: Util.removeMask(contabilDreCabecalhoModel.periodoFinal),
			),
			contabilDreDetalheGroupedList: contabilDreDetalheModelToDrift(contabilDreCabecalhoModel.contabilDreDetalheModelList),
		);
	}

	List<ContabilDreDetalheGrouped> contabilDreDetalheModelToDrift(List<ContabilDreDetalheModel>? contabilDreDetalheModelList) { 
		List<ContabilDreDetalheGrouped> contabilDreDetalheGroupedList = [];
		if (contabilDreDetalheModelList != null) {
			for (var contabilDreDetalheModel in contabilDreDetalheModelList) {
				contabilDreDetalheGroupedList.add(
					ContabilDreDetalheGrouped(
						contabilDreDetalhe: ContabilDreDetalhe(
							id: contabilDreDetalheModel.id,
							idContabilDreCabecalho: contabilDreDetalheModel.idContabilDreCabecalho,
							classificacao: contabilDreDetalheModel.classificacao,
							descricao: contabilDreDetalheModel.descricao,
							formaCalculo: ContabilDreDetalheDomain.setFormaCalculo(contabilDreDetalheModel.formaCalculo),
							sinal: ContabilDreDetalheDomain.setSinal(contabilDreDetalheModel.sinal),
							natureza: ContabilDreDetalheDomain.setNatureza(contabilDreDetalheModel.natureza),
							valor: contabilDreDetalheModel.valor,
						),
					),
				);
			}
			return contabilDreDetalheGroupedList;
		}
		return [];
	}

		
}
