import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaLancamentoComissaoDriftProvider extends ProviderBase {

	Future<List<FolhaLancamentoComissaoModel>?> getList({Filter? filter}) async {
		List<FolhaLancamentoComissaoGrouped> folhaLancamentoComissaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaLancamentoComissaoDriftList = await Session.database.folhaLancamentoComissaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaLancamentoComissaoDriftList = await Session.database.folhaLancamentoComissaoDao.getGroupedList(); 
			}
			if (folhaLancamentoComissaoDriftList.isNotEmpty) {
				return toListModel(folhaLancamentoComissaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaLancamentoComissaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaLancamentoComissaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaLancamentoComissaoModel?>? insert(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) async {
		try {
			final lastPk = await Session.database.folhaLancamentoComissaoDao.insertObject(toDrift(folhaLancamentoComissaoModel));
			folhaLancamentoComissaoModel.id = lastPk;
			return folhaLancamentoComissaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaLancamentoComissaoModel?>? update(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) async {
		try {
			await Session.database.folhaLancamentoComissaoDao.updateObject(toDrift(folhaLancamentoComissaoModel));
			return folhaLancamentoComissaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaLancamentoComissaoDao.deleteObject(toDrift(FolhaLancamentoComissaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaLancamentoComissaoModel> toListModel(List<FolhaLancamentoComissaoGrouped> folhaLancamentoComissaoDriftList) {
		List<FolhaLancamentoComissaoModel> listModel = [];
		for (var folhaLancamentoComissaoDrift in folhaLancamentoComissaoDriftList) {
			listModel.add(toModel(folhaLancamentoComissaoDrift)!);
		}
		return listModel;
	}	

	FolhaLancamentoComissaoModel? toModel(FolhaLancamentoComissaoGrouped? folhaLancamentoComissaoDrift) {
		if (folhaLancamentoComissaoDrift != null) {
			return FolhaLancamentoComissaoModel(
				id: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.id,
				idColaborador: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.idColaborador,
				competencia: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.competencia,
				vencimento: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.vencimento,
				baseCalculo: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.baseCalculo,
				valorComissao: folhaLancamentoComissaoDrift.folhaLancamentoComissao?.valorComissao,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaLancamentoComissaoDrift.viewPessoaColaborador?.id,
					nome: folhaLancamentoComissaoDrift.viewPessoaColaborador?.nome,
					tipo: folhaLancamentoComissaoDrift.viewPessoaColaborador?.tipo,
					email: folhaLancamentoComissaoDrift.viewPessoaColaborador?.email,
					site: folhaLancamentoComissaoDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaLancamentoComissaoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaLancamentoComissaoDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaLancamentoComissaoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaLancamentoComissaoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaLancamentoComissaoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaLancamentoComissaoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaLancamentoComissaoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaLancamentoComissaoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaLancamentoComissaoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaLancamentoComissaoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaLancamentoComissaoDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaLancamentoComissaoDrift.viewPessoaColaborador?.logradouro,
					numero: folhaLancamentoComissaoDrift.viewPessoaColaborador?.numero,
					complemento: folhaLancamentoComissaoDrift.viewPessoaColaborador?.complemento,
					bairro: folhaLancamentoComissaoDrift.viewPessoaColaborador?.bairro,
					cidade: folhaLancamentoComissaoDrift.viewPessoaColaborador?.cidade,
					cep: folhaLancamentoComissaoDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaLancamentoComissaoDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaLancamentoComissaoDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaLancamentoComissaoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaLancamentoComissaoDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaLancamentoComissaoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	FolhaLancamentoComissaoGrouped toDrift(FolhaLancamentoComissaoModel folhaLancamentoComissaoModel) {
		return FolhaLancamentoComissaoGrouped(
			folhaLancamentoComissao: FolhaLancamentoComissao(
				id: folhaLancamentoComissaoModel.id,
				idColaborador: folhaLancamentoComissaoModel.idColaborador,
				competencia: Util.removeMask(folhaLancamentoComissaoModel.competencia),
				vencimento: folhaLancamentoComissaoModel.vencimento,
				baseCalculo: folhaLancamentoComissaoModel.baseCalculo,
				valorComissao: folhaLancamentoComissaoModel.valorComissao,
			),
		);
	}

		
}
