import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaLancamentoCabecalhoDriftProvider extends ProviderBase {

	Future<List<FolhaLancamentoCabecalhoModel>?> getList({Filter? filter}) async {
		List<FolhaLancamentoCabecalhoGrouped> folhaLancamentoCabecalhoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaLancamentoCabecalhoDriftList = await Session.database.folhaLancamentoCabecalhoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaLancamentoCabecalhoDriftList = await Session.database.folhaLancamentoCabecalhoDao.getGroupedList(); 
			}
			if (folhaLancamentoCabecalhoDriftList.isNotEmpty) {
				return toListModel(folhaLancamentoCabecalhoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaLancamentoCabecalhoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaLancamentoCabecalhoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaLancamentoCabecalhoModel?>? insert(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) async {
		try {
			final lastPk = await Session.database.folhaLancamentoCabecalhoDao.insertObject(toDrift(folhaLancamentoCabecalhoModel));
			folhaLancamentoCabecalhoModel.id = lastPk;
			return folhaLancamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaLancamentoCabecalhoModel?>? update(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) async {
		try {
			await Session.database.folhaLancamentoCabecalhoDao.updateObject(toDrift(folhaLancamentoCabecalhoModel));
			return folhaLancamentoCabecalhoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaLancamentoCabecalhoDao.deleteObject(toDrift(FolhaLancamentoCabecalhoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaLancamentoCabecalhoModel> toListModel(List<FolhaLancamentoCabecalhoGrouped> folhaLancamentoCabecalhoDriftList) {
		List<FolhaLancamentoCabecalhoModel> listModel = [];
		for (var folhaLancamentoCabecalhoDrift in folhaLancamentoCabecalhoDriftList) {
			listModel.add(toModel(folhaLancamentoCabecalhoDrift)!);
		}
		return listModel;
	}	

	FolhaLancamentoCabecalhoModel? toModel(FolhaLancamentoCabecalhoGrouped? folhaLancamentoCabecalhoDrift) {
		if (folhaLancamentoCabecalhoDrift != null) {
			return FolhaLancamentoCabecalhoModel(
				id: folhaLancamentoCabecalhoDrift.folhaLancamentoCabecalho?.id,
				idColaborador: folhaLancamentoCabecalhoDrift.folhaLancamentoCabecalho?.idColaborador,
				competencia: folhaLancamentoCabecalhoDrift.folhaLancamentoCabecalho?.competencia,
				tipo: FolhaLancamentoCabecalhoDomain.getTipo(folhaLancamentoCabecalhoDrift.folhaLancamentoCabecalho?.tipo),
				folhaLancamentoDetalheModelList: folhaLancamentoDetalheDriftToModel(folhaLancamentoCabecalhoDrift.folhaLancamentoDetalheGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.id,
					nome: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.nome,
					tipo: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.tipo,
					email: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.email,
					site: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.logradouro,
					numero: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.numero,
					complemento: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.complemento,
					bairro: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.bairro,
					cidade: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.cidade,
					cep: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaLancamentoCabecalhoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<FolhaLancamentoDetalheModel> folhaLancamentoDetalheDriftToModel(List<FolhaLancamentoDetalheGrouped>? folhaLancamentoDetalheDriftList) { 
		List<FolhaLancamentoDetalheModel> folhaLancamentoDetalheModelList = [];
		if (folhaLancamentoDetalheDriftList != null) {
			for (var folhaLancamentoDetalheGrouped in folhaLancamentoDetalheDriftList) {
				folhaLancamentoDetalheModelList.add(
					FolhaLancamentoDetalheModel(
						id: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.id,
						idFolhaLancamentoCabecalho: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.idFolhaLancamentoCabecalho,
						idFolhaEvento: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.idFolhaEvento,
						folhaEventoModel: FolhaEventoModel(
							id: folhaLancamentoDetalheGrouped.folhaEvento?.id,
							codigo: folhaLancamentoDetalheGrouped.folhaEvento?.codigo,
							nome: folhaLancamentoDetalheGrouped.folhaEvento?.nome,
							descricao: folhaLancamentoDetalheGrouped.folhaEvento?.descricao,
							baseCalculo: folhaLancamentoDetalheGrouped.folhaEvento?.baseCalculo,
							tipo: folhaLancamentoDetalheGrouped.folhaEvento?.tipo,
							unidade: folhaLancamentoDetalheGrouped.folhaEvento?.unidade,
							taxa: folhaLancamentoDetalheGrouped.folhaEvento?.taxa,
							rubricaEsocial: folhaLancamentoDetalheGrouped.folhaEvento?.rubricaEsocial,
							codIncidenciaPrevidencia: folhaLancamentoDetalheGrouped.folhaEvento?.codIncidenciaPrevidencia,
							codIncidenciaIrrf: folhaLancamentoDetalheGrouped.folhaEvento?.codIncidenciaIrrf,
							codIncidenciaFgts: folhaLancamentoDetalheGrouped.folhaEvento?.codIncidenciaFgts,
							codIncidenciaSindicato: folhaLancamentoDetalheGrouped.folhaEvento?.codIncidenciaSindicato,
							repercuteDsr: folhaLancamentoDetalheGrouped.folhaEvento?.repercuteDsr,
							repercute13: folhaLancamentoDetalheGrouped.folhaEvento?.repercute13,
							repercuteFerias: folhaLancamentoDetalheGrouped.folhaEvento?.repercuteFerias,
							repercuteAviso: folhaLancamentoDetalheGrouped.folhaEvento?.repercuteAviso,
						),
						origem: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.origem,
						provento: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.provento,
						desconto: folhaLancamentoDetalheGrouped.folhaLancamentoDetalhe?.desconto,
					)
				);
			}
			return folhaLancamentoDetalheModelList;
		}
		return [];
	}


	FolhaLancamentoCabecalhoGrouped toDrift(FolhaLancamentoCabecalhoModel folhaLancamentoCabecalhoModel) {
		return FolhaLancamentoCabecalhoGrouped(
			folhaLancamentoCabecalho: FolhaLancamentoCabecalho(
				id: folhaLancamentoCabecalhoModel.id,
				idColaborador: folhaLancamentoCabecalhoModel.idColaborador,
				competencia: folhaLancamentoCabecalhoModel.competencia,
				tipo: FolhaLancamentoCabecalhoDomain.setTipo(folhaLancamentoCabecalhoModel.tipo),
			),
			folhaLancamentoDetalheGroupedList: folhaLancamentoDetalheModelToDrift(folhaLancamentoCabecalhoModel.folhaLancamentoDetalheModelList),
		);
	}

	List<FolhaLancamentoDetalheGrouped> folhaLancamentoDetalheModelToDrift(List<FolhaLancamentoDetalheModel>? folhaLancamentoDetalheModelList) { 
		List<FolhaLancamentoDetalheGrouped> folhaLancamentoDetalheGroupedList = [];
		if (folhaLancamentoDetalheModelList != null) {
			for (var folhaLancamentoDetalheModel in folhaLancamentoDetalheModelList) {
				folhaLancamentoDetalheGroupedList.add(
					FolhaLancamentoDetalheGrouped(
						folhaLancamentoDetalhe: FolhaLancamentoDetalhe(
							id: folhaLancamentoDetalheModel.id,
							idFolhaLancamentoCabecalho: folhaLancamentoDetalheModel.idFolhaLancamentoCabecalho,
							idFolhaEvento: folhaLancamentoDetalheModel.idFolhaEvento,
							origem: folhaLancamentoDetalheModel.origem,
							provento: folhaLancamentoDetalheModel.provento,
							desconto: folhaLancamentoDetalheModel.desconto,
						),
					),
				);
			}
			return folhaLancamentoDetalheGroupedList;
		}
		return [];
	}

		
}
