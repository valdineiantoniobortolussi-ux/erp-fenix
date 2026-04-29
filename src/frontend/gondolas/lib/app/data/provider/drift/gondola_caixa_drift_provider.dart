import 'package:gondolas/app/data/provider/drift/database/database_imports.dart';
import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/data/provider/provider_base.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';
import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaCaixaDriftProvider extends ProviderBase {

	Future<List<GondolaCaixaModel>?> getList({Filter? filter}) async {
		List<GondolaCaixaGrouped> gondolaCaixaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gondolaCaixaDriftList = await Session.database.gondolaCaixaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gondolaCaixaDriftList = await Session.database.gondolaCaixaDao.getGroupedList(); 
			}
			if (gondolaCaixaDriftList.isNotEmpty) {
				return toListModel(gondolaCaixaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GondolaCaixaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gondolaCaixaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaCaixaModel?>? insert(GondolaCaixaModel gondolaCaixaModel) async {
		try {
			final lastPk = await Session.database.gondolaCaixaDao.insertObject(toDrift(gondolaCaixaModel));
			gondolaCaixaModel.id = lastPk;
			return gondolaCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GondolaCaixaModel?>? update(GondolaCaixaModel gondolaCaixaModel) async {
		try {
			await Session.database.gondolaCaixaDao.updateObject(toDrift(gondolaCaixaModel));
			return gondolaCaixaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gondolaCaixaDao.deleteObject(toDrift(GondolaCaixaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GondolaCaixaModel> toListModel(List<GondolaCaixaGrouped> gondolaCaixaDriftList) {
		List<GondolaCaixaModel> listModel = [];
		for (var gondolaCaixaDrift in gondolaCaixaDriftList) {
			listModel.add(toModel(gondolaCaixaDrift)!);
		}
		return listModel;
	}	

	GondolaCaixaModel? toModel(GondolaCaixaGrouped? gondolaCaixaDrift) {
		if (gondolaCaixaDrift != null) {
			return GondolaCaixaModel(
				id: gondolaCaixaDrift.gondolaCaixa?.id,
				idGondolaEstante: gondolaCaixaDrift.gondolaCaixa?.idGondolaEstante,
				codigo: gondolaCaixaDrift.gondolaCaixa?.codigo,
				altura: gondolaCaixaDrift.gondolaCaixa?.altura,
				largura: gondolaCaixaDrift.gondolaCaixa?.largura,
				profundidade: gondolaCaixaDrift.gondolaCaixa?.profundidade,
				gondolaArmazenamentoModelList: gondolaArmazenamentoDriftToModel(gondolaCaixaDrift.gondolaArmazenamentoGroupedList),
				gondolaEstanteModel: GondolaEstanteModel(
					id: gondolaCaixaDrift.gondolaEstante?.id,
					idGondolaRua: gondolaCaixaDrift.gondolaEstante?.idGondolaRua,
					codigo: gondolaCaixaDrift.gondolaEstante?.codigo,
					quantidadeCaixa: gondolaCaixaDrift.gondolaEstante?.quantidadeCaixa,
				),
			);
		} else {
			return null;
		}
	}

	List<GondolaArmazenamentoModel> gondolaArmazenamentoDriftToModel(List<GondolaArmazenamentoGrouped>? gondolaArmazenamentoDriftList) { 
		List<GondolaArmazenamentoModel> gondolaArmazenamentoModelList = [];
		if (gondolaArmazenamentoDriftList != null) {
			for (var gondolaArmazenamentoGrouped in gondolaArmazenamentoDriftList) {
				gondolaArmazenamentoModelList.add(
					GondolaArmazenamentoModel(
						id: gondolaArmazenamentoGrouped.gondolaArmazenamento?.id,
						idGondolaCaixa: gondolaArmazenamentoGrouped.gondolaArmazenamento?.idGondolaCaixa,
						idProduto: gondolaArmazenamentoGrouped.gondolaArmazenamento?.idProduto,
						produtoModel: ProdutoModel(
							id: gondolaArmazenamentoGrouped.produto?.id,
							idTributIcmsCustomCab: gondolaArmazenamentoGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: gondolaArmazenamentoGrouped.produto?.idTributGrupoTributario,
							nome: gondolaArmazenamentoGrouped.produto?.nome,
							descricao: gondolaArmazenamentoGrouped.produto?.descricao,
							gtin: gondolaArmazenamentoGrouped.produto?.gtin,
							codigoInterno: gondolaArmazenamentoGrouped.produto?.codigoInterno,
							valorCompra: gondolaArmazenamentoGrouped.produto?.valorCompra,
							valorVenda: gondolaArmazenamentoGrouped.produto?.valorVenda,
							codigoNcm: gondolaArmazenamentoGrouped.produto?.codigoNcm,
							estoqueMinimo: gondolaArmazenamentoGrouped.produto?.estoqueMinimo,
							estoqueMaximo: gondolaArmazenamentoGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: gondolaArmazenamentoGrouped.produto?.quantidadeEstoque,
							dataCadastro: gondolaArmazenamentoGrouped.produto?.dataCadastro,
						),
						quantidade: gondolaArmazenamentoGrouped.gondolaArmazenamento?.quantidade,
					)
				);
			}
			return gondolaArmazenamentoModelList;
		}
		return [];
	}


	GondolaCaixaGrouped toDrift(GondolaCaixaModel gondolaCaixaModel) {
		return GondolaCaixaGrouped(
			gondolaCaixa: GondolaCaixa(
				id: gondolaCaixaModel.id,
				idGondolaEstante: gondolaCaixaModel.idGondolaEstante,
				codigo: gondolaCaixaModel.codigo,
				altura: gondolaCaixaModel.altura,
				largura: gondolaCaixaModel.largura,
				profundidade: gondolaCaixaModel.profundidade,
			),
			gondolaArmazenamentoGroupedList: gondolaArmazenamentoModelToDrift(gondolaCaixaModel.gondolaArmazenamentoModelList),
		);
	}

	List<GondolaArmazenamentoGrouped> gondolaArmazenamentoModelToDrift(List<GondolaArmazenamentoModel>? gondolaArmazenamentoModelList) { 
		List<GondolaArmazenamentoGrouped> gondolaArmazenamentoGroupedList = [];
		if (gondolaArmazenamentoModelList != null) {
			for (var gondolaArmazenamentoModel in gondolaArmazenamentoModelList) {
				gondolaArmazenamentoGroupedList.add(
					GondolaArmazenamentoGrouped(
						gondolaArmazenamento: GondolaArmazenamento(
							id: gondolaArmazenamentoModel.id,
							idGondolaCaixa: gondolaArmazenamentoModel.idGondolaCaixa,
							idProduto: gondolaArmazenamentoModel.idProduto,
							quantidade: gondolaArmazenamentoModel.quantidade,
						),
					),
				);
			}
			return gondolaArmazenamentoGroupedList;
		}
		return [];
	}

		
}
