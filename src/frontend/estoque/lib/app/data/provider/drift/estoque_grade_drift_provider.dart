import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueGradeDriftProvider extends ProviderBase {

	Future<List<EstoqueGradeModel>?> getList({Filter? filter}) async {
		List<EstoqueGradeGrouped> estoqueGradeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueGradeDriftList = await Session.database.estoqueGradeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueGradeDriftList = await Session.database.estoqueGradeDao.getGroupedList(); 
			}
			if (estoqueGradeDriftList.isNotEmpty) {
				return toListModel(estoqueGradeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueGradeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueGradeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueGradeModel?>? insert(EstoqueGradeModel estoqueGradeModel) async {
		try {
			final lastPk = await Session.database.estoqueGradeDao.insertObject(toDrift(estoqueGradeModel));
			estoqueGradeModel.id = lastPk;
			return estoqueGradeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueGradeModel?>? update(EstoqueGradeModel estoqueGradeModel) async {
		try {
			await Session.database.estoqueGradeDao.updateObject(toDrift(estoqueGradeModel));
			return estoqueGradeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueGradeDao.deleteObject(toDrift(EstoqueGradeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueGradeModel> toListModel(List<EstoqueGradeGrouped> estoqueGradeDriftList) {
		List<EstoqueGradeModel> listModel = [];
		for (var estoqueGradeDrift in estoqueGradeDriftList) {
			listModel.add(toModel(estoqueGradeDrift)!);
		}
		return listModel;
	}	

	EstoqueGradeModel? toModel(EstoqueGradeGrouped? estoqueGradeDrift) {
		if (estoqueGradeDrift != null) {
			return EstoqueGradeModel(
				id: estoqueGradeDrift.estoqueGrade?.id,
				idProduto: estoqueGradeDrift.estoqueGrade?.idProduto,
				idEstoqueMarca: estoqueGradeDrift.estoqueGrade?.idEstoqueMarca,
				idEstoqueSabor: estoqueGradeDrift.estoqueGrade?.idEstoqueSabor,
				idEstoqueTamanho: estoqueGradeDrift.estoqueGrade?.idEstoqueTamanho,
				idEstoqueCor: estoqueGradeDrift.estoqueGrade?.idEstoqueCor,
				codigo: estoqueGradeDrift.estoqueGrade?.codigo,
				quantidade: estoqueGradeDrift.estoqueGrade?.quantidade,
				produtoModel: ProdutoModel(
					id: estoqueGradeDrift.produto?.id,
					idProdutoSubgrupo: estoqueGradeDrift.produto?.idProdutoSubgrupo,
					idProdutoMarca: estoqueGradeDrift.produto?.idProdutoMarca,
					idProdutoUnidade: estoqueGradeDrift.produto?.idProdutoUnidade,
					idTributIcmsCustomCab: estoqueGradeDrift.produto?.idTributIcmsCustomCab,
					idTributGrupoTributario: estoqueGradeDrift.produto?.idTributGrupoTributario,
					nome: estoqueGradeDrift.produto?.nome,
					descricao: estoqueGradeDrift.produto?.descricao,
					gtin: estoqueGradeDrift.produto?.gtin,
					codigoInterno: estoqueGradeDrift.produto?.codigoInterno,
					valorCompra: estoqueGradeDrift.produto?.valorCompra,
					valorVenda: estoqueGradeDrift.produto?.valorVenda,
					codigoNcm: estoqueGradeDrift.produto?.codigoNcm,
					estoqueMinimo: estoqueGradeDrift.produto?.estoqueMinimo,
					estoqueMaximo: estoqueGradeDrift.produto?.estoqueMaximo,
					quantidadeEstoque: estoqueGradeDrift.produto?.quantidadeEstoque,
					dataCadastro: estoqueGradeDrift.produto?.dataCadastro,
				),
				estoqueCorModel: EstoqueCorModel(
					id: estoqueGradeDrift.estoqueCor?.id,
					codigo: estoqueGradeDrift.estoqueCor?.codigo,
					nome: estoqueGradeDrift.estoqueCor?.nome,
				),
				estoqueTamanhoModel: EstoqueTamanhoModel(
					id: estoqueGradeDrift.estoqueTamanho?.id,
					codigo: estoqueGradeDrift.estoqueTamanho?.codigo,
					nome: estoqueGradeDrift.estoqueTamanho?.nome,
					altura: estoqueGradeDrift.estoqueTamanho?.altura,
					comprimento: estoqueGradeDrift.estoqueTamanho?.comprimento,
					largura: estoqueGradeDrift.estoqueTamanho?.largura,
				),
				estoqueSaborModel: EstoqueSaborModel(
					id: estoqueGradeDrift.estoqueSabor?.id,
					codigo: estoqueGradeDrift.estoqueSabor?.codigo,
					nome: estoqueGradeDrift.estoqueSabor?.nome,
				),
				estoqueMarcaModel: EstoqueMarcaModel(
					id: estoqueGradeDrift.estoqueMarca?.id,
					codigo: estoqueGradeDrift.estoqueMarca?.codigo,
					nome: estoqueGradeDrift.estoqueMarca?.nome,
				),
			);
		} else {
			return null;
		}
	}


	EstoqueGradeGrouped toDrift(EstoqueGradeModel estoqueGradeModel) {
		return EstoqueGradeGrouped(
			estoqueGrade: EstoqueGrade(
				id: estoqueGradeModel.id,
				idProduto: estoqueGradeModel.idProduto,
				idEstoqueMarca: estoqueGradeModel.idEstoqueMarca,
				idEstoqueSabor: estoqueGradeModel.idEstoqueSabor,
				idEstoqueTamanho: estoqueGradeModel.idEstoqueTamanho,
				idEstoqueCor: estoqueGradeModel.idEstoqueCor,
				codigo: estoqueGradeModel.codigo,
				quantidade: estoqueGradeModel.quantidade,
			),
		);
	}

		
}
