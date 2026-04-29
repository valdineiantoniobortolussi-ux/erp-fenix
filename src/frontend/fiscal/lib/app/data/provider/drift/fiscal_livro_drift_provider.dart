import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';
import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/provider/provider_base.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalLivroDriftProvider extends ProviderBase {

	Future<List<FiscalLivroModel>?> getList({Filter? filter}) async {
		List<FiscalLivroGrouped> fiscalLivroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				fiscalLivroDriftList = await Session.database.fiscalLivroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				fiscalLivroDriftList = await Session.database.fiscalLivroDao.getGroupedList(); 
			}
			if (fiscalLivroDriftList.isNotEmpty) {
				return toListModel(fiscalLivroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FiscalLivroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.fiscalLivroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalLivroModel?>? insert(FiscalLivroModel fiscalLivroModel) async {
		try {
			final lastPk = await Session.database.fiscalLivroDao.insertObject(toDrift(fiscalLivroModel));
			fiscalLivroModel.id = lastPk;
			return fiscalLivroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FiscalLivroModel?>? update(FiscalLivroModel fiscalLivroModel) async {
		try {
			await Session.database.fiscalLivroDao.updateObject(toDrift(fiscalLivroModel));
			return fiscalLivroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.fiscalLivroDao.deleteObject(toDrift(FiscalLivroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FiscalLivroModel> toListModel(List<FiscalLivroGrouped> fiscalLivroDriftList) {
		List<FiscalLivroModel> listModel = [];
		for (var fiscalLivroDrift in fiscalLivroDriftList) {
			listModel.add(toModel(fiscalLivroDrift)!);
		}
		return listModel;
	}	

	FiscalLivroModel? toModel(FiscalLivroGrouped? fiscalLivroDrift) {
		if (fiscalLivroDrift != null) {
			return FiscalLivroModel(
				id: fiscalLivroDrift.fiscalLivro?.id,
				descricao: fiscalLivroDrift.fiscalLivro?.descricao,
				fiscalTermoModelList: fiscalTermoDriftToModel(fiscalLivroDrift.fiscalTermoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<FiscalTermoModel> fiscalTermoDriftToModel(List<FiscalTermoGrouped>? fiscalTermoDriftList) { 
		List<FiscalTermoModel> fiscalTermoModelList = [];
		if (fiscalTermoDriftList != null) {
			for (var fiscalTermoGrouped in fiscalTermoDriftList) {
				fiscalTermoModelList.add(
					FiscalTermoModel(
						id: fiscalTermoGrouped.fiscalTermo?.id,
						idFiscalLivro: fiscalTermoGrouped.fiscalTermo?.idFiscalLivro,
						aberturaEncerramento: FiscalTermoDomain.getAberturaEncerramento(fiscalTermoGrouped.fiscalTermo?.aberturaEncerramento),
						numero: fiscalTermoGrouped.fiscalTermo?.numero,
						paginaInicial: fiscalTermoGrouped.fiscalTermo?.paginaInicial,
						paginaFinal: fiscalTermoGrouped.fiscalTermo?.paginaFinal,
						numeroRegistro: fiscalTermoGrouped.fiscalTermo?.numeroRegistro,
						registrado: fiscalTermoGrouped.fiscalTermo?.registrado,
						dataDespacho: fiscalTermoGrouped.fiscalTermo?.dataDespacho,
						dataAbertura: fiscalTermoGrouped.fiscalTermo?.dataAbertura,
						dataEncerramento: fiscalTermoGrouped.fiscalTermo?.dataEncerramento,
						escrituracaoInicio: fiscalTermoGrouped.fiscalTermo?.escrituracaoInicio,
						escrituracaoFim: fiscalTermoGrouped.fiscalTermo?.escrituracaoFim,
						texto: fiscalTermoGrouped.fiscalTermo?.texto,
					)
				);
			}
			return fiscalTermoModelList;
		}
		return [];
	}


	FiscalLivroGrouped toDrift(FiscalLivroModel fiscalLivroModel) {
		return FiscalLivroGrouped(
			fiscalLivro: FiscalLivro(
				id: fiscalLivroModel.id,
				descricao: fiscalLivroModel.descricao,
			),
			fiscalTermoGroupedList: fiscalTermoModelToDrift(fiscalLivroModel.fiscalTermoModelList),
		);
	}

	List<FiscalTermoGrouped> fiscalTermoModelToDrift(List<FiscalTermoModel>? fiscalTermoModelList) { 
		List<FiscalTermoGrouped> fiscalTermoGroupedList = [];
		if (fiscalTermoModelList != null) {
			for (var fiscalTermoModel in fiscalTermoModelList) {
				fiscalTermoGroupedList.add(
					FiscalTermoGrouped(
						fiscalTermo: FiscalTermo(
							id: fiscalTermoModel.id,
							idFiscalLivro: fiscalTermoModel.idFiscalLivro,
							aberturaEncerramento: FiscalTermoDomain.setAberturaEncerramento(fiscalTermoModel.aberturaEncerramento),
							numero: fiscalTermoModel.numero,
							paginaInicial: fiscalTermoModel.paginaInicial,
							paginaFinal: fiscalTermoModel.paginaFinal,
							numeroRegistro: fiscalTermoModel.numeroRegistro,
							registrado: fiscalTermoModel.registrado,
							dataDespacho: fiscalTermoModel.dataDespacho,
							dataAbertura: fiscalTermoModel.dataAbertura,
							dataEncerramento: fiscalTermoModel.dataEncerramento,
							escrituracaoInicio: fiscalTermoModel.escrituracaoInicio,
							escrituracaoFim: fiscalTermoModel.escrituracaoFim,
							texto: fiscalTermoModel.texto,
						),
					),
				);
			}
			return fiscalTermoGroupedList;
		}
		return [];
	}

		
}
