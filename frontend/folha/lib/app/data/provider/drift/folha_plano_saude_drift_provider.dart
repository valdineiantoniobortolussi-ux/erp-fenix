import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaPlanoSaudeDriftProvider extends ProviderBase {

	Future<List<FolhaPlanoSaudeModel>?> getList({Filter? filter}) async {
		List<FolhaPlanoSaudeGrouped> folhaPlanoSaudeDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaPlanoSaudeDriftList = await Session.database.folhaPlanoSaudeDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaPlanoSaudeDriftList = await Session.database.folhaPlanoSaudeDao.getGroupedList(); 
			}
			if (folhaPlanoSaudeDriftList.isNotEmpty) {
				return toListModel(folhaPlanoSaudeDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaPlanoSaudeModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaPlanoSaudeDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaPlanoSaudeModel?>? insert(FolhaPlanoSaudeModel folhaPlanoSaudeModel) async {
		try {
			final lastPk = await Session.database.folhaPlanoSaudeDao.insertObject(toDrift(folhaPlanoSaudeModel));
			folhaPlanoSaudeModel.id = lastPk;
			return folhaPlanoSaudeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaPlanoSaudeModel?>? update(FolhaPlanoSaudeModel folhaPlanoSaudeModel) async {
		try {
			await Session.database.folhaPlanoSaudeDao.updateObject(toDrift(folhaPlanoSaudeModel));
			return folhaPlanoSaudeModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaPlanoSaudeDao.deleteObject(toDrift(FolhaPlanoSaudeModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaPlanoSaudeModel> toListModel(List<FolhaPlanoSaudeGrouped> folhaPlanoSaudeDriftList) {
		List<FolhaPlanoSaudeModel> listModel = [];
		for (var folhaPlanoSaudeDrift in folhaPlanoSaudeDriftList) {
			listModel.add(toModel(folhaPlanoSaudeDrift)!);
		}
		return listModel;
	}	

	FolhaPlanoSaudeModel? toModel(FolhaPlanoSaudeGrouped? folhaPlanoSaudeDrift) {
		if (folhaPlanoSaudeDrift != null) {
			return FolhaPlanoSaudeModel(
				id: folhaPlanoSaudeDrift.folhaPlanoSaude?.id,
				idOperadoraPlanoSaude: folhaPlanoSaudeDrift.folhaPlanoSaude?.idOperadoraPlanoSaude,
				idColaborador: folhaPlanoSaudeDrift.folhaPlanoSaude?.idColaborador,
				dataInicio: folhaPlanoSaudeDrift.folhaPlanoSaude?.dataInicio,
				beneficiario: FolhaPlanoSaudeDomain.getBeneficiario(folhaPlanoSaudeDrift.folhaPlanoSaude?.beneficiario),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaPlanoSaudeDrift.viewPessoaColaborador?.id,
					nome: folhaPlanoSaudeDrift.viewPessoaColaborador?.nome,
					tipo: folhaPlanoSaudeDrift.viewPessoaColaborador?.tipo,
					email: folhaPlanoSaudeDrift.viewPessoaColaborador?.email,
					site: folhaPlanoSaudeDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaPlanoSaudeDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaPlanoSaudeDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaPlanoSaudeDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaPlanoSaudeDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaPlanoSaudeDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaPlanoSaudeDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaPlanoSaudeDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaPlanoSaudeDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaPlanoSaudeDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaPlanoSaudeDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaPlanoSaudeDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaPlanoSaudeDrift.viewPessoaColaborador?.logradouro,
					numero: folhaPlanoSaudeDrift.viewPessoaColaborador?.numero,
					complemento: folhaPlanoSaudeDrift.viewPessoaColaborador?.complemento,
					bairro: folhaPlanoSaudeDrift.viewPessoaColaborador?.bairro,
					cidade: folhaPlanoSaudeDrift.viewPessoaColaborador?.cidade,
					cep: folhaPlanoSaudeDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaPlanoSaudeDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaPlanoSaudeDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaPlanoSaudeDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaPlanoSaudeDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaPlanoSaudeDrift.viewPessoaColaborador?.idSetor,
				),
				operadoraPlanoSaudeModel: OperadoraPlanoSaudeModel(
					id: folhaPlanoSaudeDrift.operadoraPlanoSaude?.id,
					nome: folhaPlanoSaudeDrift.operadoraPlanoSaude?.nome,
					registroAns: folhaPlanoSaudeDrift.operadoraPlanoSaude?.registroAns,
					classificacaoContabilConta: folhaPlanoSaudeDrift.operadoraPlanoSaude?.classificacaoContabilConta,
				),
			);
		} else {
			return null;
		}
	}


	FolhaPlanoSaudeGrouped toDrift(FolhaPlanoSaudeModel folhaPlanoSaudeModel) {
		return FolhaPlanoSaudeGrouped(
			folhaPlanoSaude: FolhaPlanoSaude(
				id: folhaPlanoSaudeModel.id,
				idOperadoraPlanoSaude: folhaPlanoSaudeModel.idOperadoraPlanoSaude,
				idColaborador: folhaPlanoSaudeModel.idColaborador,
				dataInicio: folhaPlanoSaudeModel.dataInicio,
				beneficiario: FolhaPlanoSaudeDomain.setBeneficiario(folhaPlanoSaudeModel.beneficiario),
			),
		);
	}

		
}
