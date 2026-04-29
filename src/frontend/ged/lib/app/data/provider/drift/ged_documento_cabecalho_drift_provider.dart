import 'package:ged/app/data/provider/drift/database/database_imports.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/provider/provider_base.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class GedDocumentoCabecalhoDriftProvider extends ProviderBase {

	Future<List<GedDocumentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<GedDocumentoCabecalhoGrouped> gedDocumentoCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gedDocumentoCabecalhoDriftList = await Session.database.gedDocumentoCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gedDocumentoCabecalhoDriftList = await Session.database.gedDocumentoCabecalhoDao.getGroupedList(); 
			}
			if (gedDocumentoCabecalhoDriftList.isNotEmpty) {
				return toListModel(gedDocumentoCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GedDocumentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gedDocumentoCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedDocumentoCabecalhoModel?>? insert(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) async {
		try {
			final lastPk = await Session.database.gedDocumentoCabecalhoDao.insertObject(toDrift(gedDocumentoCabecalhoModel));
			gedDocumentoCabecalhoModel.id = lastPk;
			return gedDocumentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedDocumentoCabecalhoModel?>? update(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) async {
		try {
			await Session.database.gedDocumentoCabecalhoDao.updateObject(toDrift(gedDocumentoCabecalhoModel));
			return gedDocumentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gedDocumentoCabecalhoDao.deleteObject(toDrift(GedDocumentoCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GedDocumentoCabecalhoModel> toListModel(List<GedDocumentoCabecalhoGrouped> gedDocumentoCabecalhoDriftList) {
		List<GedDocumentoCabecalhoModel> listModel = [];
		for (var gedDocumentoCabecalhoDrift in gedDocumentoCabecalhoDriftList) {
			listModel.add(toModel(gedDocumentoCabecalhoDrift)!);
		}
		return listModel;
	}	

	GedDocumentoCabecalhoModel? toModel(GedDocumentoCabecalhoGrouped? gedDocumentoCabecalhoDrift) {
		if (gedDocumentoCabecalhoDrift != null) {
			return GedDocumentoCabecalhoModel(
				id: gedDocumentoCabecalhoDrift.gedDocumentoCabecalho?.id,
				nome: gedDocumentoCabecalhoDrift.gedDocumentoCabecalho?.nome,
				dataInclusao: gedDocumentoCabecalhoDrift.gedDocumentoCabecalho?.dataInclusao,
				descricao: gedDocumentoCabecalhoDrift.gedDocumentoCabecalho?.descricao,
				gedDocumentoDetalheModelList: gedDocumentoDetalheDriftToModel(gedDocumentoCabecalhoDrift.gedDocumentoDetalheGroupedList),
			);
		} else {
			return null;
		}
	}

	List<GedDocumentoDetalheModel> gedDocumentoDetalheDriftToModel(List<GedDocumentoDetalheGrouped>? gedDocumentoDetalheDriftList) { 
		List<GedDocumentoDetalheModel> gedDocumentoDetalheModelList = [];
		if (gedDocumentoDetalheDriftList != null) {
			for (var gedDocumentoDetalheGrouped in gedDocumentoDetalheDriftList) {
				gedDocumentoDetalheModelList.add(
					GedDocumentoDetalheModel(
						id: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.id,
						idGedDocumentoCabecalho: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.idGedDocumentoCabecalho,
						idGedTipoDocumento: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.idGedTipoDocumento,
						gedTipoDocumentoModel: GedTipoDocumentoModel(
							id: gedDocumentoDetalheGrouped.gedTipoDocumento?.id,
							nome: gedDocumentoDetalheGrouped.gedTipoDocumento?.nome,
							tamanhoMaximo: gedDocumentoDetalheGrouped.gedTipoDocumento?.tamanhoMaximo,
						),
						nome: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.nome,
						descricao: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.descricao,
						palavrasChave: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.palavrasChave,
						podeExcluir: GedDocumentoDetalheDomain.getPodeExcluir(gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.podeExcluir),
						podeAlterar: GedDocumentoDetalheDomain.getPodeAlterar(gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.podeAlterar),
						assinado: GedDocumentoDetalheDomain.getAssinado(gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.assinado),
						dataFimVigencia: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.dataFimVigencia,
						dataExclusao: gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.dataExclusao,
					)
				);
			}
			return gedDocumentoDetalheModelList;
		}
		return [];
	}


	GedDocumentoCabecalhoGrouped toDrift(GedDocumentoCabecalhoModel gedDocumentoCabecalhoModel) {
		return GedDocumentoCabecalhoGrouped(
			gedDocumentoCabecalho: GedDocumentoCabecalho(
				id: gedDocumentoCabecalhoModel.id,
				nome: gedDocumentoCabecalhoModel.nome,
				dataInclusao: gedDocumentoCabecalhoModel.dataInclusao,
				descricao: gedDocumentoCabecalhoModel.descricao,
			),
			gedDocumentoDetalheGroupedList: gedDocumentoDetalheModelToDrift(gedDocumentoCabecalhoModel.gedDocumentoDetalheModelList),
		);
	}

	List<GedDocumentoDetalheGrouped> gedDocumentoDetalheModelToDrift(List<GedDocumentoDetalheModel>? gedDocumentoDetalheModelList) { 
		List<GedDocumentoDetalheGrouped> gedDocumentoDetalheGroupedList = [];
		if (gedDocumentoDetalheModelList != null) {
			for (var gedDocumentoDetalheModel in gedDocumentoDetalheModelList) {
				gedDocumentoDetalheGroupedList.add(
					GedDocumentoDetalheGrouped(
						gedDocumentoDetalhe: GedDocumentoDetalhe(
							id: gedDocumentoDetalheModel.id,
							idGedDocumentoCabecalho: gedDocumentoDetalheModel.idGedDocumentoCabecalho,
							idGedTipoDocumento: gedDocumentoDetalheModel.idGedTipoDocumento,
							nome: gedDocumentoDetalheModel.nome,
							descricao: gedDocumentoDetalheModel.descricao,
							palavrasChave: gedDocumentoDetalheModel.palavrasChave,
							podeExcluir: GedDocumentoDetalheDomain.setPodeExcluir(gedDocumentoDetalheModel.podeExcluir),
							podeAlterar: GedDocumentoDetalheDomain.setPodeAlterar(gedDocumentoDetalheModel.podeAlterar),
							assinado: GedDocumentoDetalheDomain.setAssinado(gedDocumentoDetalheModel.assinado),
							dataFimVigencia: gedDocumentoDetalheModel.dataFimVigencia,
							dataExclusao: gedDocumentoDetalheModel.dataExclusao,
						),
					),
				);
			}
			return gedDocumentoDetalheGroupedList;
		}
		return [];
	}

		
}
