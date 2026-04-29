import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/data/domain/domain_imports.dart';

class EstoqueReajusteCabecalhoDriftProvider extends ProviderBase {

	Future<List<EstoqueReajusteCabecalhoModel>?> getList({Filter? filter}) async {
		List<EstoqueReajusteCabecalhoGrouped> estoqueReajusteCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				estoqueReajusteCabecalhoDriftList = await Session.database.estoqueReajusteCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				estoqueReajusteCabecalhoDriftList = await Session.database.estoqueReajusteCabecalhoDao.getGroupedList(); 
			}
			if (estoqueReajusteCabecalhoDriftList.isNotEmpty) {
				return toListModel(estoqueReajusteCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<EstoqueReajusteCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.estoqueReajusteCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueReajusteCabecalhoModel?>? insert(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) async {
		try {
			final lastPk = await Session.database.estoqueReajusteCabecalhoDao.insertObject(toDrift(estoqueReajusteCabecalhoModel));
			estoqueReajusteCabecalhoModel.id = lastPk;
			return estoqueReajusteCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<EstoqueReajusteCabecalhoModel?>? update(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) async {
		try {
			await Session.database.estoqueReajusteCabecalhoDao.updateObject(toDrift(estoqueReajusteCabecalhoModel));
			return estoqueReajusteCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.estoqueReajusteCabecalhoDao.deleteObject(toDrift(EstoqueReajusteCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<EstoqueReajusteCabecalhoModel> toListModel(List<EstoqueReajusteCabecalhoGrouped> estoqueReajusteCabecalhoDriftList) {
		List<EstoqueReajusteCabecalhoModel> listModel = [];
		for (var estoqueReajusteCabecalhoDrift in estoqueReajusteCabecalhoDriftList) {
			listModel.add(toModel(estoqueReajusteCabecalhoDrift)!);
		}
		return listModel;
	}	

	EstoqueReajusteCabecalhoModel? toModel(EstoqueReajusteCabecalhoGrouped? estoqueReajusteCabecalhoDrift) {
		if (estoqueReajusteCabecalhoDrift != null) {
			return EstoqueReajusteCabecalhoModel(
				id: estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.id,
				idColaborador: estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.idColaborador,
				dataReajuste: estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.dataReajuste,
				taxa: estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.taxa,
				tipoReajuste: EstoqueReajusteCabecalhoDomain.getTipoReajuste(estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.tipoReajuste),
				justificativa: estoqueReajusteCabecalhoDrift.estoqueReajusteCabecalho?.justificativa,
				estoqueReajusteDetalheModelList: estoqueReajusteDetalheDriftToModel(estoqueReajusteCabecalhoDrift.estoqueReajusteDetalheGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.id,
					nome: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.nome,
					tipo: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.tipo,
					email: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.email,
					site: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.site,
					cpfCnpj: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.rgIe,
					matricula: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.observacao,
					logradouro: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.logradouro,
					numero: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.numero,
					complemento: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.complemento,
					bairro: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.bairro,
					cidade: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.cidade,
					cep: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.cep,
					municipioIbge: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.municipioIbge,
					uf: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.uf,
					idPessoa: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.idCargo,
					idSetor: estoqueReajusteCabecalhoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<EstoqueReajusteDetalheModel> estoqueReajusteDetalheDriftToModel(List<EstoqueReajusteDetalheGrouped>? estoqueReajusteDetalheDriftList) { 
		List<EstoqueReajusteDetalheModel> estoqueReajusteDetalheModelList = [];
		if (estoqueReajusteDetalheDriftList != null) {
			for (var estoqueReajusteDetalheGrouped in estoqueReajusteDetalheDriftList) {
				estoqueReajusteDetalheModelList.add(
					EstoqueReajusteDetalheModel(
						id: estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.id,
						idEstoqueReajusteCabecalho: estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.idEstoqueReajusteCabecalho,
						idProduto: estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: estoqueReajusteDetalheGrouped.produto?.id,
							idProdutoSubgrupo: estoqueReajusteDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: estoqueReajusteDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: estoqueReajusteDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: estoqueReajusteDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: estoqueReajusteDetalheGrouped.produto?.idTributGrupoTributario,
							nome: estoqueReajusteDetalheGrouped.produto?.nome,
							descricao: estoqueReajusteDetalheGrouped.produto?.descricao,
							gtin: estoqueReajusteDetalheGrouped.produto?.gtin,
							codigoInterno: estoqueReajusteDetalheGrouped.produto?.codigoInterno,
							valorCompra: estoqueReajusteDetalheGrouped.produto?.valorCompra,
							valorVenda: estoqueReajusteDetalheGrouped.produto?.valorVenda,
							codigoNcm: estoqueReajusteDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: estoqueReajusteDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: estoqueReajusteDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: estoqueReajusteDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: estoqueReajusteDetalheGrouped.produto?.dataCadastro,
						),
						valorOriginal: estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.valorOriginal,
						valorReajuste: estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.valorReajuste,
					)
				);
			}
			return estoqueReajusteDetalheModelList;
		}
		return [];
	}


	EstoqueReajusteCabecalhoGrouped toDrift(EstoqueReajusteCabecalhoModel estoqueReajusteCabecalhoModel) {
		return EstoqueReajusteCabecalhoGrouped(
			estoqueReajusteCabecalho: EstoqueReajusteCabecalho(
				id: estoqueReajusteCabecalhoModel.id,
				idColaborador: estoqueReajusteCabecalhoModel.idColaborador,
				dataReajuste: estoqueReajusteCabecalhoModel.dataReajuste,
				taxa: estoqueReajusteCabecalhoModel.taxa,
				tipoReajuste: EstoqueReajusteCabecalhoDomain.setTipoReajuste(estoqueReajusteCabecalhoModel.tipoReajuste),
				justificativa: estoqueReajusteCabecalhoModel.justificativa,
			),
			estoqueReajusteDetalheGroupedList: estoqueReajusteDetalheModelToDrift(estoqueReajusteCabecalhoModel.estoqueReajusteDetalheModelList),
		);
	}

	List<EstoqueReajusteDetalheGrouped> estoqueReajusteDetalheModelToDrift(List<EstoqueReajusteDetalheModel>? estoqueReajusteDetalheModelList) { 
		List<EstoqueReajusteDetalheGrouped> estoqueReajusteDetalheGroupedList = [];
		if (estoqueReajusteDetalheModelList != null) {
			for (var estoqueReajusteDetalheModel in estoqueReajusteDetalheModelList) {
				estoqueReajusteDetalheGroupedList.add(
					EstoqueReajusteDetalheGrouped(
						estoqueReajusteDetalhe: EstoqueReajusteDetalhe(
							id: estoqueReajusteDetalheModel.id,
							idEstoqueReajusteCabecalho: estoqueReajusteDetalheModel.idEstoqueReajusteCabecalho,
							idProduto: estoqueReajusteDetalheModel.idProduto,
							valorOriginal: estoqueReajusteDetalheModel.valorOriginal,
							valorReajuste: estoqueReajusteDetalheModel.valorReajuste,
						),
					),
				);
			}
			return estoqueReajusteDetalheGroupedList;
		}
		return [];
	}

		
}
