import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class SimplesNacionalCabecalhoDriftProvider extends ProviderBase {

	Future<List<SimplesNacionalCabecalhoModel>?> getList({Filter? filter}) async {
		List<SimplesNacionalCabecalhoGrouped> simplesNacionalCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				simplesNacionalCabecalhoDriftList = await Session.database.simplesNacionalCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				simplesNacionalCabecalhoDriftList = await Session.database.simplesNacionalCabecalhoDao.getGroupedList(); 
			}
			if (simplesNacionalCabecalhoDriftList.isNotEmpty) {
				return toListModel(simplesNacionalCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<SimplesNacionalCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.simplesNacionalCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SimplesNacionalCabecalhoModel?>? insert(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) async {
		try {
			final lastPk = await Session.database.simplesNacionalCabecalhoDao.insertObject(toDrift(simplesNacionalCabecalhoModel));
			simplesNacionalCabecalhoModel.id = lastPk;
			return simplesNacionalCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<SimplesNacionalCabecalhoModel?>? update(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) async {
		try {
			await Session.database.simplesNacionalCabecalhoDao.updateObject(toDrift(simplesNacionalCabecalhoModel));
			return simplesNacionalCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.simplesNacionalCabecalhoDao.deleteObject(toDrift(SimplesNacionalCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<SimplesNacionalCabecalhoModel> toListModel(List<SimplesNacionalCabecalhoGrouped> simplesNacionalCabecalhoDriftList) {
		List<SimplesNacionalCabecalhoModel> listModel = [];
		for (var simplesNacionalCabecalhoDrift in simplesNacionalCabecalhoDriftList) {
			listModel.add(toModel(simplesNacionalCabecalhoDrift)!);
		}
		return listModel;
	}	

	SimplesNacionalCabecalhoModel? toModel(SimplesNacionalCabecalhoGrouped? simplesNacionalCabecalhoDrift) {
		if (simplesNacionalCabecalhoDrift != null) {
			return SimplesNacionalCabecalhoModel(
				id: simplesNacionalCabecalhoDrift.simplesNacionalCabecalho?.id,
				vigenciaInicial: simplesNacionalCabecalhoDrift.simplesNacionalCabecalho?.vigenciaInicial,
				vigenciaFinal: simplesNacionalCabecalhoDrift.simplesNacionalCabecalho?.vigenciaFinal,
				anexo: simplesNacionalCabecalhoDrift.simplesNacionalCabecalho?.anexo,
				tabela: simplesNacionalCabecalhoDrift.simplesNacionalCabecalho?.tabela,
				simplesNacionalDetalheModelList: simplesNacionalDetalheDriftToModel(simplesNacionalCabecalhoDrift.simplesNacionalDetalheGroupedList),
			);
		} else {
			return null;
		}
	}

	List<SimplesNacionalDetalheModel> simplesNacionalDetalheDriftToModel(List<SimplesNacionalDetalheGrouped>? simplesNacionalDetalheDriftList) { 
		List<SimplesNacionalDetalheModel> simplesNacionalDetalheModelList = [];
		if (simplesNacionalDetalheDriftList != null) {
			for (var simplesNacionalDetalheGrouped in simplesNacionalDetalheDriftList) {
				simplesNacionalDetalheModelList.add(
					SimplesNacionalDetalheModel(
						id: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.id,
						idSimplesNacionalCabecalho: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.idSimplesNacionalCabecalho,
						faixa: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.faixa,
						valorInicial: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.valorInicial,
						valorFinal: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.valorFinal,
						aliquota: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.aliquota,
						irpj: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.irpj,
						csll: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.csll,
						cofins: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.cofins,
						pisPasep: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.pisPasep,
						cpp: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.cpp,
						icms: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.icms,
						ipi: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.ipi,
						iss: simplesNacionalDetalheGrouped.simplesNacionalDetalhe?.iss,
					)
				);
			}
			return simplesNacionalDetalheModelList;
		}
		return [];
	}


	SimplesNacionalCabecalhoGrouped toDrift(SimplesNacionalCabecalhoModel simplesNacionalCabecalhoModel) {
		return SimplesNacionalCabecalhoGrouped(
			simplesNacionalCabecalho: SimplesNacionalCabecalho(
				id: simplesNacionalCabecalhoModel.id,
				vigenciaInicial: simplesNacionalCabecalhoModel.vigenciaInicial,
				vigenciaFinal: simplesNacionalCabecalhoModel.vigenciaFinal,
				anexo: simplesNacionalCabecalhoModel.anexo,
				tabela: simplesNacionalCabecalhoModel.tabela,
			),
			simplesNacionalDetalheGroupedList: simplesNacionalDetalheModelToDrift(simplesNacionalCabecalhoModel.simplesNacionalDetalheModelList),
		);
	}

	List<SimplesNacionalDetalheGrouped> simplesNacionalDetalheModelToDrift(List<SimplesNacionalDetalheModel>? simplesNacionalDetalheModelList) { 
		List<SimplesNacionalDetalheGrouped> simplesNacionalDetalheGroupedList = [];
		if (simplesNacionalDetalheModelList != null) {
			for (var simplesNacionalDetalheModel in simplesNacionalDetalheModelList) {
				simplesNacionalDetalheGroupedList.add(
					SimplesNacionalDetalheGrouped(
						simplesNacionalDetalhe: SimplesNacionalDetalhe(
							id: simplesNacionalDetalheModel.id,
							idSimplesNacionalCabecalho: simplesNacionalDetalheModel.idSimplesNacionalCabecalho,
							faixa: simplesNacionalDetalheModel.faixa,
							valorInicial: simplesNacionalDetalheModel.valorInicial,
							valorFinal: simplesNacionalDetalheModel.valorFinal,
							aliquota: simplesNacionalDetalheModel.aliquota,
							irpj: simplesNacionalDetalheModel.irpj,
							csll: simplesNacionalDetalheModel.csll,
							cofins: simplesNacionalDetalheModel.cofins,
							pisPasep: simplesNacionalDetalheModel.pisPasep,
							cpp: simplesNacionalDetalheModel.cpp,
							icms: simplesNacionalDetalheModel.icms,
							ipi: simplesNacionalDetalheModel.ipi,
							iss: simplesNacionalDetalheModel.iss,
						),
					),
				);
			}
			return simplesNacionalDetalheGroupedList;
		}
		return [];
	}

		
}
