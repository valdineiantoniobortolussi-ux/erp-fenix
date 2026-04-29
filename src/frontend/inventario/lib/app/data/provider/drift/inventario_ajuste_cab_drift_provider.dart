import 'package:inventario/app/data/provider/drift/database/database_imports.dart';
import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/data/provider/provider_base.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/data/domain/domain_imports.dart';

class InventarioAjusteCabDriftProvider extends ProviderBase {

	Future<List<InventarioAjusteCabModel>?> getList({Filter? filter}) async {
		List<InventarioAjusteCabGrouped> inventarioAjusteCabDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				inventarioAjusteCabDriftList = await Session.database.inventarioAjusteCabDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				inventarioAjusteCabDriftList = await Session.database.inventarioAjusteCabDao.getGroupedList(); 
			}
			if (inventarioAjusteCabDriftList.isNotEmpty) {
				return toListModel(inventarioAjusteCabDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<InventarioAjusteCabModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.inventarioAjusteCabDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<InventarioAjusteCabModel?>? insert(InventarioAjusteCabModel inventarioAjusteCabModel) async {
		try {
			final lastPk = await Session.database.inventarioAjusteCabDao.insertObject(toDrift(inventarioAjusteCabModel));
			inventarioAjusteCabModel.id = lastPk;
			return inventarioAjusteCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<InventarioAjusteCabModel?>? update(InventarioAjusteCabModel inventarioAjusteCabModel) async {
		try {
			await Session.database.inventarioAjusteCabDao.updateObject(toDrift(inventarioAjusteCabModel));
			return inventarioAjusteCabModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.inventarioAjusteCabDao.deleteObject(toDrift(InventarioAjusteCabModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<InventarioAjusteCabModel> toListModel(List<InventarioAjusteCabGrouped> inventarioAjusteCabDriftList) {
		List<InventarioAjusteCabModel> listModel = [];
		for (var inventarioAjusteCabDrift in inventarioAjusteCabDriftList) {
			listModel.add(toModel(inventarioAjusteCabDrift)!);
		}
		return listModel;
	}	

	InventarioAjusteCabModel? toModel(InventarioAjusteCabGrouped? inventarioAjusteCabDrift) {
		if (inventarioAjusteCabDrift != null) {
			return InventarioAjusteCabModel(
				id: inventarioAjusteCabDrift.inventarioAjusteCab?.id,
				idViewPessoaColaborador: inventarioAjusteCabDrift.inventarioAjusteCab?.idViewPessoaColaborador,
				dataAjuste: inventarioAjusteCabDrift.inventarioAjusteCab?.dataAjuste,
				tipo: InventarioAjusteCabDomain.getTipo(inventarioAjusteCabDrift.inventarioAjusteCab?.tipo),
				taxa: inventarioAjusteCabDrift.inventarioAjusteCab?.taxa,
				justificativa: inventarioAjusteCabDrift.inventarioAjusteCab?.justificativa,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: inventarioAjusteCabDrift.viewPessoaColaborador?.id,
					nome: inventarioAjusteCabDrift.viewPessoaColaborador?.nome,
					tipo: inventarioAjusteCabDrift.viewPessoaColaborador?.tipo,
					email: inventarioAjusteCabDrift.viewPessoaColaborador?.email,
					site: inventarioAjusteCabDrift.viewPessoaColaborador?.site,
					cpfCnpj: inventarioAjusteCabDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: inventarioAjusteCabDrift.viewPessoaColaborador?.rgIe,
					matricula: inventarioAjusteCabDrift.viewPessoaColaborador?.matricula,
					dataCadastro: inventarioAjusteCabDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: inventarioAjusteCabDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: inventarioAjusteCabDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: inventarioAjusteCabDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: inventarioAjusteCabDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: inventarioAjusteCabDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: inventarioAjusteCabDrift.viewPessoaColaborador?.ctpsUf,
					observacao: inventarioAjusteCabDrift.viewPessoaColaborador?.observacao,
					logradouro: inventarioAjusteCabDrift.viewPessoaColaborador?.logradouro,
					numero: inventarioAjusteCabDrift.viewPessoaColaborador?.numero,
					complemento: inventarioAjusteCabDrift.viewPessoaColaborador?.complemento,
					bairro: inventarioAjusteCabDrift.viewPessoaColaborador?.bairro,
					cidade: inventarioAjusteCabDrift.viewPessoaColaborador?.cidade,
					cep: inventarioAjusteCabDrift.viewPessoaColaborador?.cep,
					municipioIbge: inventarioAjusteCabDrift.viewPessoaColaborador?.municipioIbge,
					uf: inventarioAjusteCabDrift.viewPessoaColaborador?.uf,
					idPessoa: inventarioAjusteCabDrift.viewPessoaColaborador?.idPessoa,
					idCargo: inventarioAjusteCabDrift.viewPessoaColaborador?.idCargo,
					idSetor: inventarioAjusteCabDrift.viewPessoaColaborador?.idSetor,
				),
				inventarioAjusteDetModelList: inventarioAjusteDetDriftToModel(inventarioAjusteCabDrift.inventarioAjusteDetGroupedList),
			);
		} else {
			return null;
		}
	}

	List<InventarioAjusteDetModel> inventarioAjusteDetDriftToModel(List<InventarioAjusteDetGrouped>? inventarioAjusteDetDriftList) { 
		List<InventarioAjusteDetModel> inventarioAjusteDetModelList = [];
		if (inventarioAjusteDetDriftList != null) {
			for (var inventarioAjusteDetGrouped in inventarioAjusteDetDriftList) {
				inventarioAjusteDetModelList.add(
					InventarioAjusteDetModel(
						id: inventarioAjusteDetGrouped.inventarioAjusteDet?.id,
						idInventarioAjusteCab: inventarioAjusteDetGrouped.inventarioAjusteDet?.idInventarioAjusteCab,
						idProduto: inventarioAjusteDetGrouped.inventarioAjusteDet?.idProduto,
						produtoModel: ProdutoModel(
							id: inventarioAjusteDetGrouped.produto?.id,
							idTributIcmsCustomCab: inventarioAjusteDetGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: inventarioAjusteDetGrouped.produto?.idTributGrupoTributario,
							nome: inventarioAjusteDetGrouped.produto?.nome,
							descricao: inventarioAjusteDetGrouped.produto?.descricao,
							gtin: inventarioAjusteDetGrouped.produto?.gtin,
							codigoInterno: inventarioAjusteDetGrouped.produto?.codigoInterno,
							valorCompra: inventarioAjusteDetGrouped.produto?.valorCompra,
							valorVenda: inventarioAjusteDetGrouped.produto?.valorVenda,
							codigoNcm: inventarioAjusteDetGrouped.produto?.codigoNcm,
							estoqueMinimo: inventarioAjusteDetGrouped.produto?.estoqueMinimo,
							estoqueMaximo: inventarioAjusteDetGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: inventarioAjusteDetGrouped.produto?.quantidadeEstoque,
							dataCadastro: inventarioAjusteDetGrouped.produto?.dataCadastro,
						),
						valorOriginal: inventarioAjusteDetGrouped.inventarioAjusteDet?.valorOriginal,
						valorReajuste: inventarioAjusteDetGrouped.inventarioAjusteDet?.valorReajuste,
					)
				);
			}
			return inventarioAjusteDetModelList;
		}
		return [];
	}


	InventarioAjusteCabGrouped toDrift(InventarioAjusteCabModel inventarioAjusteCabModel) {
		return InventarioAjusteCabGrouped(
			inventarioAjusteCab: InventarioAjusteCab(
				id: inventarioAjusteCabModel.id,
				idViewPessoaColaborador: inventarioAjusteCabModel.idViewPessoaColaborador,
				dataAjuste: inventarioAjusteCabModel.dataAjuste,
				tipo: InventarioAjusteCabDomain.setTipo(inventarioAjusteCabModel.tipo),
				taxa: inventarioAjusteCabModel.taxa,
				justificativa: inventarioAjusteCabModel.justificativa,
			),
			inventarioAjusteDetGroupedList: inventarioAjusteDetModelToDrift(inventarioAjusteCabModel.inventarioAjusteDetModelList),
		);
	}

	List<InventarioAjusteDetGrouped> inventarioAjusteDetModelToDrift(List<InventarioAjusteDetModel>? inventarioAjusteDetModelList) { 
		List<InventarioAjusteDetGrouped> inventarioAjusteDetGroupedList = [];
		if (inventarioAjusteDetModelList != null) {
			for (var inventarioAjusteDetModel in inventarioAjusteDetModelList) {
				inventarioAjusteDetGroupedList.add(
					InventarioAjusteDetGrouped(
						inventarioAjusteDet: InventarioAjusteDet(
							id: inventarioAjusteDetModel.id,
							idInventarioAjusteCab: inventarioAjusteDetModel.idInventarioAjusteCab,
							idProduto: inventarioAjusteDetModel.idProduto,
							valorOriginal: inventarioAjusteDetModel.valorOriginal,
							valorReajuste: inventarioAjusteDetModel.valorReajuste,
						),
					),
				);
			}
			return inventarioAjusteDetGroupedList;
		}
		return [];
	}

		
}
