import 'package:contabil/app/data/provider/drift/database/database_imports.dart';
import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/provider/provider_base.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLivroDriftProvider extends ProviderBase {

	Future<List<ContabilLivroModel>?> getList({Filter? filter}) async {
		List<ContabilLivroGrouped> contabilLivroDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contabilLivroDriftList = await Session.database.contabilLivroDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contabilLivroDriftList = await Session.database.contabilLivroDao.getGroupedList(); 
			}
			if (contabilLivroDriftList.isNotEmpty) {
				return toListModel(contabilLivroDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContabilLivroModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contabilLivroDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLivroModel?>? insert(ContabilLivroModel contabilLivroModel) async {
		try {
			final lastPk = await Session.database.contabilLivroDao.insertObject(toDrift(contabilLivroModel));
			contabilLivroModel.id = lastPk;
			return contabilLivroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContabilLivroModel?>? update(ContabilLivroModel contabilLivroModel) async {
		try {
			await Session.database.contabilLivroDao.updateObject(toDrift(contabilLivroModel));
			return contabilLivroModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contabilLivroDao.deleteObject(toDrift(ContabilLivroModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContabilLivroModel> toListModel(List<ContabilLivroGrouped> contabilLivroDriftList) {
		List<ContabilLivroModel> listModel = [];
		for (var contabilLivroDrift in contabilLivroDriftList) {
			listModel.add(toModel(contabilLivroDrift)!);
		}
		return listModel;
	}	

	ContabilLivroModel? toModel(ContabilLivroGrouped? contabilLivroDrift) {
		if (contabilLivroDrift != null) {
			return ContabilLivroModel(
				id: contabilLivroDrift.contabilLivro?.id,
				competencia: contabilLivroDrift.contabilLivro?.competencia,
				formaEscrituracao: ContabilLivroDomain.getFormaEscrituracao(contabilLivroDrift.contabilLivro?.formaEscrituracao),
				descricao: contabilLivroDrift.contabilLivro?.descricao,
				contabilTermoModelList: contabilTermoDriftToModel(contabilLivroDrift.contabilTermoGroupedList),
			);
		} else {
			return null;
		}
	}

	List<ContabilTermoModel> contabilTermoDriftToModel(List<ContabilTermoGrouped>? contabilTermoDriftList) { 
		List<ContabilTermoModel> contabilTermoModelList = [];
		if (contabilTermoDriftList != null) {
			for (var contabilTermoGrouped in contabilTermoDriftList) {
				contabilTermoModelList.add(
					ContabilTermoModel(
						id: contabilTermoGrouped.contabilTermo?.id,
						idContabilLivro: contabilTermoGrouped.contabilTermo?.idContabilLivro,
						aberturaEncerramento: ContabilTermoDomain.getAberturaEncerramento(contabilTermoGrouped.contabilTermo?.aberturaEncerramento),
						numero: contabilTermoGrouped.contabilTermo?.numero,
						paginaInicial: contabilTermoGrouped.contabilTermo?.paginaInicial,
						paginaFinal: contabilTermoGrouped.contabilTermo?.paginaFinal,
						registrado: contabilTermoGrouped.contabilTermo?.registrado,
						numeroRegistro: contabilTermoGrouped.contabilTermo?.numeroRegistro,
						dataDespacho: contabilTermoGrouped.contabilTermo?.dataDespacho,
						dataAbertura: contabilTermoGrouped.contabilTermo?.dataAbertura,
						dataEncerramento: contabilTermoGrouped.contabilTermo?.dataEncerramento,
						escrituracaoInicio: contabilTermoGrouped.contabilTermo?.escrituracaoInicio,
						escrituracaoFim: contabilTermoGrouped.contabilTermo?.escrituracaoFim,
						texto: contabilTermoGrouped.contabilTermo?.texto,
					)
				);
			}
			return contabilTermoModelList;
		}
		return [];
	}


	ContabilLivroGrouped toDrift(ContabilLivroModel contabilLivroModel) {
		return ContabilLivroGrouped(
			contabilLivro: ContabilLivro(
				id: contabilLivroModel.id,
				competencia: Util.removeMask(contabilLivroModel.competencia),
				formaEscrituracao: ContabilLivroDomain.setFormaEscrituracao(contabilLivroModel.formaEscrituracao),
				descricao: contabilLivroModel.descricao,
			),
			contabilTermoGroupedList: contabilTermoModelToDrift(contabilLivroModel.contabilTermoModelList),
		);
	}

	List<ContabilTermoGrouped> contabilTermoModelToDrift(List<ContabilTermoModel>? contabilTermoModelList) { 
		List<ContabilTermoGrouped> contabilTermoGroupedList = [];
		if (contabilTermoModelList != null) {
			for (var contabilTermoModel in contabilTermoModelList) {
				contabilTermoGroupedList.add(
					ContabilTermoGrouped(
						contabilTermo: ContabilTermo(
							id: contabilTermoModel.id,
							idContabilLivro: contabilTermoModel.idContabilLivro,
							aberturaEncerramento: ContabilTermoDomain.setAberturaEncerramento(contabilTermoModel.aberturaEncerramento),
							numero: contabilTermoModel.numero,
							paginaInicial: contabilTermoModel.paginaInicial,
							paginaFinal: contabilTermoModel.paginaFinal,
							registrado: contabilTermoModel.registrado,
							numeroRegistro: contabilTermoModel.numeroRegistro,
							dataDespacho: contabilTermoModel.dataDespacho,
							dataAbertura: contabilTermoModel.dataAbertura,
							dataEncerramento: contabilTermoModel.dataEncerramento,
							escrituracaoInicio: contabilTermoModel.escrituracaoInicio,
							escrituracaoFim: contabilTermoModel.escrituracaoFim,
							texto: contabilTermoModel.texto,
						),
					),
				);
			}
			return contabilTermoGroupedList;
		}
		return [];
	}

		
}
