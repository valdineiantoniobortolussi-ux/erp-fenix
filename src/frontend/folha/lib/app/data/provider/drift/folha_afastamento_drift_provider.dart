import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaAfastamentoDriftProvider extends ProviderBase {

	Future<List<FolhaAfastamentoModel>?> getList({Filter? filter}) async {
		List<FolhaAfastamentoGrouped> folhaAfastamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaAfastamentoDriftList = await Session.database.folhaAfastamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaAfastamentoDriftList = await Session.database.folhaAfastamentoDao.getGroupedList(); 
			}
			if (folhaAfastamentoDriftList.isNotEmpty) {
				return toListModel(folhaAfastamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaAfastamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaAfastamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaAfastamentoModel?>? insert(FolhaAfastamentoModel folhaAfastamentoModel) async {
		try {
			final lastPk = await Session.database.folhaAfastamentoDao.insertObject(toDrift(folhaAfastamentoModel));
			folhaAfastamentoModel.id = lastPk;
			return folhaAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaAfastamentoModel?>? update(FolhaAfastamentoModel folhaAfastamentoModel) async {
		try {
			await Session.database.folhaAfastamentoDao.updateObject(toDrift(folhaAfastamentoModel));
			return folhaAfastamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaAfastamentoDao.deleteObject(toDrift(FolhaAfastamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaAfastamentoModel> toListModel(List<FolhaAfastamentoGrouped> folhaAfastamentoDriftList) {
		List<FolhaAfastamentoModel> listModel = [];
		for (var folhaAfastamentoDrift in folhaAfastamentoDriftList) {
			listModel.add(toModel(folhaAfastamentoDrift)!);
		}
		return listModel;
	}	

	FolhaAfastamentoModel? toModel(FolhaAfastamentoGrouped? folhaAfastamentoDrift) {
		if (folhaAfastamentoDrift != null) {
			return FolhaAfastamentoModel(
				id: folhaAfastamentoDrift.folhaAfastamento?.id,
				idColaborador: folhaAfastamentoDrift.folhaAfastamento?.idColaborador,
				idFolhaTipoAfastamento: folhaAfastamentoDrift.folhaAfastamento?.idFolhaTipoAfastamento,
				dataInicio: folhaAfastamentoDrift.folhaAfastamento?.dataInicio,
				dataFim: folhaAfastamentoDrift.folhaAfastamento?.dataFim,
				diasAfastado: folhaAfastamentoDrift.folhaAfastamento?.diasAfastado,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaAfastamentoDrift.viewPessoaColaborador?.id,
					nome: folhaAfastamentoDrift.viewPessoaColaborador?.nome,
					tipo: folhaAfastamentoDrift.viewPessoaColaborador?.tipo,
					email: folhaAfastamentoDrift.viewPessoaColaborador?.email,
					site: folhaAfastamentoDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaAfastamentoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaAfastamentoDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaAfastamentoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaAfastamentoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaAfastamentoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaAfastamentoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaAfastamentoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaAfastamentoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaAfastamentoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaAfastamentoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaAfastamentoDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaAfastamentoDrift.viewPessoaColaborador?.logradouro,
					numero: folhaAfastamentoDrift.viewPessoaColaborador?.numero,
					complemento: folhaAfastamentoDrift.viewPessoaColaborador?.complemento,
					bairro: folhaAfastamentoDrift.viewPessoaColaborador?.bairro,
					cidade: folhaAfastamentoDrift.viewPessoaColaborador?.cidade,
					cep: folhaAfastamentoDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaAfastamentoDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaAfastamentoDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaAfastamentoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaAfastamentoDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaAfastamentoDrift.viewPessoaColaborador?.idSetor,
				),
				folhaTipoAfastamentoModel: FolhaTipoAfastamentoModel(
					id: folhaAfastamentoDrift.folhaTipoAfastamento?.id,
					codigo: folhaAfastamentoDrift.folhaTipoAfastamento?.codigo,
					nome: folhaAfastamentoDrift.folhaTipoAfastamento?.nome,
					codigoEsocial: folhaAfastamentoDrift.folhaTipoAfastamento?.codigoEsocial,
					descricao: folhaAfastamentoDrift.folhaTipoAfastamento?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	FolhaAfastamentoGrouped toDrift(FolhaAfastamentoModel folhaAfastamentoModel) {
		return FolhaAfastamentoGrouped(
			folhaAfastamento: FolhaAfastamento(
				id: folhaAfastamentoModel.id,
				idColaborador: folhaAfastamentoModel.idColaborador,
				idFolhaTipoAfastamento: folhaAfastamentoModel.idFolhaTipoAfastamento,
				dataInicio: folhaAfastamentoModel.dataInicio,
				dataFim: folhaAfastamentoModel.dataFim,
				diasAfastado: folhaAfastamentoModel.diasAfastado,
			),
		);
	}

		
}
