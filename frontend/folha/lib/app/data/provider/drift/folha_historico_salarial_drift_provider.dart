import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaHistoricoSalarialDriftProvider extends ProviderBase {

	Future<List<FolhaHistoricoSalarialModel>?> getList({Filter? filter}) async {
		List<FolhaHistoricoSalarialGrouped> folhaHistoricoSalarialDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaHistoricoSalarialDriftList = await Session.database.folhaHistoricoSalarialDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaHistoricoSalarialDriftList = await Session.database.folhaHistoricoSalarialDao.getGroupedList(); 
			}
			if (folhaHistoricoSalarialDriftList.isNotEmpty) {
				return toListModel(folhaHistoricoSalarialDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaHistoricoSalarialModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaHistoricoSalarialDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaHistoricoSalarialModel?>? insert(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) async {
		try {
			final lastPk = await Session.database.folhaHistoricoSalarialDao.insertObject(toDrift(folhaHistoricoSalarialModel));
			folhaHistoricoSalarialModel.id = lastPk;
			return folhaHistoricoSalarialModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaHistoricoSalarialModel?>? update(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) async {
		try {
			await Session.database.folhaHistoricoSalarialDao.updateObject(toDrift(folhaHistoricoSalarialModel));
			return folhaHistoricoSalarialModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaHistoricoSalarialDao.deleteObject(toDrift(FolhaHistoricoSalarialModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaHistoricoSalarialModel> toListModel(List<FolhaHistoricoSalarialGrouped> folhaHistoricoSalarialDriftList) {
		List<FolhaHistoricoSalarialModel> listModel = [];
		for (var folhaHistoricoSalarialDrift in folhaHistoricoSalarialDriftList) {
			listModel.add(toModel(folhaHistoricoSalarialDrift)!);
		}
		return listModel;
	}	

	FolhaHistoricoSalarialModel? toModel(FolhaHistoricoSalarialGrouped? folhaHistoricoSalarialDrift) {
		if (folhaHistoricoSalarialDrift != null) {
			return FolhaHistoricoSalarialModel(
				id: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.id,
				idColaborador: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.idColaborador,
				competencia: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.competencia,
				salarioAtual: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.salarioAtual,
				percentualAumento: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.percentualAumento,
				salarioNovo: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.salarioNovo,
				validoAPartir: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.validoAPartir,
				motivo: folhaHistoricoSalarialDrift.folhaHistoricoSalarial?.motivo,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaHistoricoSalarialDrift.viewPessoaColaborador?.id,
					nome: folhaHistoricoSalarialDrift.viewPessoaColaborador?.nome,
					tipo: folhaHistoricoSalarialDrift.viewPessoaColaborador?.tipo,
					email: folhaHistoricoSalarialDrift.viewPessoaColaborador?.email,
					site: folhaHistoricoSalarialDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaHistoricoSalarialDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaHistoricoSalarialDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaHistoricoSalarialDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaHistoricoSalarialDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaHistoricoSalarialDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaHistoricoSalarialDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaHistoricoSalarialDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaHistoricoSalarialDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaHistoricoSalarialDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaHistoricoSalarialDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaHistoricoSalarialDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaHistoricoSalarialDrift.viewPessoaColaborador?.logradouro,
					numero: folhaHistoricoSalarialDrift.viewPessoaColaborador?.numero,
					complemento: folhaHistoricoSalarialDrift.viewPessoaColaborador?.complemento,
					bairro: folhaHistoricoSalarialDrift.viewPessoaColaborador?.bairro,
					cidade: folhaHistoricoSalarialDrift.viewPessoaColaborador?.cidade,
					cep: folhaHistoricoSalarialDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaHistoricoSalarialDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaHistoricoSalarialDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaHistoricoSalarialDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaHistoricoSalarialDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaHistoricoSalarialDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	FolhaHistoricoSalarialGrouped toDrift(FolhaHistoricoSalarialModel folhaHistoricoSalarialModel) {
		return FolhaHistoricoSalarialGrouped(
			folhaHistoricoSalarial: FolhaHistoricoSalarial(
				id: folhaHistoricoSalarialModel.id,
				idColaborador: folhaHistoricoSalarialModel.idColaborador,
				competencia: Util.removeMask(folhaHistoricoSalarialModel.competencia),
				salarioAtual: folhaHistoricoSalarialModel.salarioAtual,
				percentualAumento: folhaHistoricoSalarialModel.percentualAumento,
				salarioNovo: folhaHistoricoSalarialModel.salarioNovo,
				validoAPartir: Util.removeMask(folhaHistoricoSalarialModel.validoAPartir),
				motivo: folhaHistoricoSalarialModel.motivo,
			),
		);
	}

		
}
