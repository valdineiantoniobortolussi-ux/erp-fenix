import 'package:estoque/app/data/provider/drift/database/database_imports.dart';
import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/provider/provider_base.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/data/domain/domain_imports.dart';

class RequisicaoInternaCabecalhoDriftProvider extends ProviderBase {

	Future<List<RequisicaoInternaCabecalhoModel>?> getList({Filter? filter}) async {
		List<RequisicaoInternaCabecalhoGrouped> requisicaoInternaCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				requisicaoInternaCabecalhoDriftList = await Session.database.requisicaoInternaCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				requisicaoInternaCabecalhoDriftList = await Session.database.requisicaoInternaCabecalhoDao.getGroupedList(); 
			}
			if (requisicaoInternaCabecalhoDriftList.isNotEmpty) {
				return toListModel(requisicaoInternaCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<RequisicaoInternaCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.requisicaoInternaCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RequisicaoInternaCabecalhoModel?>? insert(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) async {
		try {
			final lastPk = await Session.database.requisicaoInternaCabecalhoDao.insertObject(toDrift(requisicaoInternaCabecalhoModel));
			requisicaoInternaCabecalhoModel.id = lastPk;
			return requisicaoInternaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<RequisicaoInternaCabecalhoModel?>? update(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) async {
		try {
			await Session.database.requisicaoInternaCabecalhoDao.updateObject(toDrift(requisicaoInternaCabecalhoModel));
			return requisicaoInternaCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.requisicaoInternaCabecalhoDao.deleteObject(toDrift(RequisicaoInternaCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<RequisicaoInternaCabecalhoModel> toListModel(List<RequisicaoInternaCabecalhoGrouped> requisicaoInternaCabecalhoDriftList) {
		List<RequisicaoInternaCabecalhoModel> listModel = [];
		for (var requisicaoInternaCabecalhoDrift in requisicaoInternaCabecalhoDriftList) {
			listModel.add(toModel(requisicaoInternaCabecalhoDrift)!);
		}
		return listModel;
	}	

	RequisicaoInternaCabecalhoModel? toModel(RequisicaoInternaCabecalhoGrouped? requisicaoInternaCabecalhoDrift) {
		if (requisicaoInternaCabecalhoDrift != null) {
			return RequisicaoInternaCabecalhoModel(
				id: requisicaoInternaCabecalhoDrift.requisicaoInternaCabecalho?.id,
				idColaborador: requisicaoInternaCabecalhoDrift.requisicaoInternaCabecalho?.idColaborador,
				dataRequisicao: requisicaoInternaCabecalhoDrift.requisicaoInternaCabecalho?.dataRequisicao,
				situacao: RequisicaoInternaCabecalhoDomain.getSituacao(requisicaoInternaCabecalhoDrift.requisicaoInternaCabecalho?.situacao),
				requisicaoInternaDetalheModelList: requisicaoInternaDetalheDriftToModel(requisicaoInternaCabecalhoDrift.requisicaoInternaDetalheGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.id,
					nome: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.nome,
					tipo: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.tipo,
					email: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.email,
					site: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.site,
					cpfCnpj: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.rgIe,
					matricula: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.observacao,
					logradouro: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.logradouro,
					numero: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.numero,
					complemento: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.complemento,
					bairro: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.bairro,
					cidade: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.cidade,
					cep: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.cep,
					municipioIbge: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.municipioIbge,
					uf: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.uf,
					idPessoa: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.idCargo,
					idSetor: requisicaoInternaCabecalhoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<RequisicaoInternaDetalheModel> requisicaoInternaDetalheDriftToModel(List<RequisicaoInternaDetalheGrouped>? requisicaoInternaDetalheDriftList) { 
		List<RequisicaoInternaDetalheModel> requisicaoInternaDetalheModelList = [];
		if (requisicaoInternaDetalheDriftList != null) {
			for (var requisicaoInternaDetalheGrouped in requisicaoInternaDetalheDriftList) {
				requisicaoInternaDetalheModelList.add(
					RequisicaoInternaDetalheModel(
						id: requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe?.id,
						idRequisicaoInternaCabecalho: requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe?.idRequisicaoInternaCabecalho,
						idProduto: requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe?.idProduto,
						produtoModel: ProdutoModel(
							id: requisicaoInternaDetalheGrouped.produto?.id,
							idProdutoSubgrupo: requisicaoInternaDetalheGrouped.produto?.idProdutoSubgrupo,
							idProdutoMarca: requisicaoInternaDetalheGrouped.produto?.idProdutoMarca,
							idProdutoUnidade: requisicaoInternaDetalheGrouped.produto?.idProdutoUnidade,
							idTributIcmsCustomCab: requisicaoInternaDetalheGrouped.produto?.idTributIcmsCustomCab,
							idTributGrupoTributario: requisicaoInternaDetalheGrouped.produto?.idTributGrupoTributario,
							nome: requisicaoInternaDetalheGrouped.produto?.nome,
							descricao: requisicaoInternaDetalheGrouped.produto?.descricao,
							gtin: requisicaoInternaDetalheGrouped.produto?.gtin,
							codigoInterno: requisicaoInternaDetalheGrouped.produto?.codigoInterno,
							valorCompra: requisicaoInternaDetalheGrouped.produto?.valorCompra,
							valorVenda: requisicaoInternaDetalheGrouped.produto?.valorVenda,
							codigoNcm: requisicaoInternaDetalheGrouped.produto?.codigoNcm,
							estoqueMinimo: requisicaoInternaDetalheGrouped.produto?.estoqueMinimo,
							estoqueMaximo: requisicaoInternaDetalheGrouped.produto?.estoqueMaximo,
							quantidadeEstoque: requisicaoInternaDetalheGrouped.produto?.quantidadeEstoque,
							dataCadastro: requisicaoInternaDetalheGrouped.produto?.dataCadastro,
						),
						quantidade: requisicaoInternaDetalheGrouped.requisicaoInternaDetalhe?.quantidade,
					)
				);
			}
			return requisicaoInternaDetalheModelList;
		}
		return [];
	}


	RequisicaoInternaCabecalhoGrouped toDrift(RequisicaoInternaCabecalhoModel requisicaoInternaCabecalhoModel) {
		return RequisicaoInternaCabecalhoGrouped(
			requisicaoInternaCabecalho: RequisicaoInternaCabecalho(
				id: requisicaoInternaCabecalhoModel.id,
				idColaborador: requisicaoInternaCabecalhoModel.idColaborador,
				dataRequisicao: requisicaoInternaCabecalhoModel.dataRequisicao,
				situacao: RequisicaoInternaCabecalhoDomain.setSituacao(requisicaoInternaCabecalhoModel.situacao),
			),
			requisicaoInternaDetalheGroupedList: requisicaoInternaDetalheModelToDrift(requisicaoInternaCabecalhoModel.requisicaoInternaDetalheModelList),
		);
	}

	List<RequisicaoInternaDetalheGrouped> requisicaoInternaDetalheModelToDrift(List<RequisicaoInternaDetalheModel>? requisicaoInternaDetalheModelList) { 
		List<RequisicaoInternaDetalheGrouped> requisicaoInternaDetalheGroupedList = [];
		if (requisicaoInternaDetalheModelList != null) {
			for (var requisicaoInternaDetalheModel in requisicaoInternaDetalheModelList) {
				requisicaoInternaDetalheGroupedList.add(
					RequisicaoInternaDetalheGrouped(
						requisicaoInternaDetalhe: RequisicaoInternaDetalhe(
							id: requisicaoInternaDetalheModel.id,
							idRequisicaoInternaCabecalho: requisicaoInternaDetalheModel.idRequisicaoInternaCabecalho,
							idProduto: requisicaoInternaDetalheModel.idProduto,
							quantidade: requisicaoInternaDetalheModel.quantidade,
						),
					),
				);
			}
			return requisicaoInternaDetalheGroupedList;
		}
		return [];
	}

		
}
