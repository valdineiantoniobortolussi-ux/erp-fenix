import 'package:ponto/app/data/provider/drift/database/database_imports.dart';
import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/provider/provider_base.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoAbonoDriftProvider extends ProviderBase {

	Future<List<PontoAbonoModel>?> getList({Filter? filter}) async {
		List<PontoAbonoGrouped> pontoAbonoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				pontoAbonoDriftList = await Session.database.pontoAbonoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				pontoAbonoDriftList = await Session.database.pontoAbonoDao.getGroupedList(); 
			}
			if (pontoAbonoDriftList.isNotEmpty) {
				return toListModel(pontoAbonoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<PontoAbonoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.pontoAbonoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoAbonoModel?>? insert(PontoAbonoModel pontoAbonoModel) async {
		try {
			final lastPk = await Session.database.pontoAbonoDao.insertObject(toDrift(pontoAbonoModel));
			pontoAbonoModel.id = lastPk;
			return pontoAbonoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<PontoAbonoModel?>? update(PontoAbonoModel pontoAbonoModel) async {
		try {
			await Session.database.pontoAbonoDao.updateObject(toDrift(pontoAbonoModel));
			return pontoAbonoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.pontoAbonoDao.deleteObject(toDrift(PontoAbonoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<PontoAbonoModel> toListModel(List<PontoAbonoGrouped> pontoAbonoDriftList) {
		List<PontoAbonoModel> listModel = [];
		for (var pontoAbonoDrift in pontoAbonoDriftList) {
			listModel.add(toModel(pontoAbonoDrift)!);
		}
		return listModel;
	}	

	PontoAbonoModel? toModel(PontoAbonoGrouped? pontoAbonoDrift) {
		if (pontoAbonoDrift != null) {
			return PontoAbonoModel(
				id: pontoAbonoDrift.pontoAbono?.id,
				idColaborador: pontoAbonoDrift.pontoAbono?.idColaborador,
				quantidade: pontoAbonoDrift.pontoAbono?.quantidade,
				utilizado: pontoAbonoDrift.pontoAbono?.utilizado,
				saldo: pontoAbonoDrift.pontoAbono?.saldo,
				dataCadastro: pontoAbonoDrift.pontoAbono?.dataCadastro,
				inicioUtilizacao: pontoAbonoDrift.pontoAbono?.inicioUtilizacao,
				dataValidade: pontoAbonoDrift.pontoAbono?.dataValidade,
				observacao: pontoAbonoDrift.pontoAbono?.observacao,
				pontoAbonoUtilizacaoModelList: pontoAbonoUtilizacaoDriftToModel(pontoAbonoDrift.pontoAbonoUtilizacaoGroupedList),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: pontoAbonoDrift.viewPessoaColaborador?.id,
					nome: pontoAbonoDrift.viewPessoaColaborador?.nome,
					tipo: pontoAbonoDrift.viewPessoaColaborador?.tipo,
					email: pontoAbonoDrift.viewPessoaColaborador?.email,
					site: pontoAbonoDrift.viewPessoaColaborador?.site,
					cpfCnpj: pontoAbonoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: pontoAbonoDrift.viewPessoaColaborador?.rgIe,
					matricula: pontoAbonoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: pontoAbonoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: pontoAbonoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: pontoAbonoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: pontoAbonoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: pontoAbonoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: pontoAbonoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: pontoAbonoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: pontoAbonoDrift.viewPessoaColaborador?.observacao,
					logradouro: pontoAbonoDrift.viewPessoaColaborador?.logradouro,
					numero: pontoAbonoDrift.viewPessoaColaborador?.numero,
					complemento: pontoAbonoDrift.viewPessoaColaborador?.complemento,
					bairro: pontoAbonoDrift.viewPessoaColaborador?.bairro,
					cidade: pontoAbonoDrift.viewPessoaColaborador?.cidade,
					cep: pontoAbonoDrift.viewPessoaColaborador?.cep,
					municipioIbge: pontoAbonoDrift.viewPessoaColaborador?.municipioIbge,
					uf: pontoAbonoDrift.viewPessoaColaborador?.uf,
					idPessoa: pontoAbonoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: pontoAbonoDrift.viewPessoaColaborador?.idCargo,
					idSetor: pontoAbonoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}

	List<PontoAbonoUtilizacaoModel> pontoAbonoUtilizacaoDriftToModel(List<PontoAbonoUtilizacaoGrouped>? pontoAbonoUtilizacaoDriftList) { 
		List<PontoAbonoUtilizacaoModel> pontoAbonoUtilizacaoModelList = [];
		if (pontoAbonoUtilizacaoDriftList != null) {
			for (var pontoAbonoUtilizacaoGrouped in pontoAbonoUtilizacaoDriftList) {
				pontoAbonoUtilizacaoModelList.add(
					PontoAbonoUtilizacaoModel(
						id: pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao?.id,
						idPontoAbono: pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao?.idPontoAbono,
						dataUtilizacao: pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao?.dataUtilizacao,
						observacao: pontoAbonoUtilizacaoGrouped.pontoAbonoUtilizacao?.observacao,
					)
				);
			}
			return pontoAbonoUtilizacaoModelList;
		}
		return [];
	}


	PontoAbonoGrouped toDrift(PontoAbonoModel pontoAbonoModel) {
		return PontoAbonoGrouped(
			pontoAbono: PontoAbono(
				id: pontoAbonoModel.id,
				idColaborador: pontoAbonoModel.idColaborador,
				quantidade: pontoAbonoModel.quantidade,
				utilizado: pontoAbonoModel.utilizado,
				saldo: pontoAbonoModel.saldo,
				dataCadastro: pontoAbonoModel.dataCadastro,
				inicioUtilizacao: pontoAbonoModel.inicioUtilizacao,
				dataValidade: pontoAbonoModel.dataValidade,
				observacao: pontoAbonoModel.observacao,
			),
			pontoAbonoUtilizacaoGroupedList: pontoAbonoUtilizacaoModelToDrift(pontoAbonoModel.pontoAbonoUtilizacaoModelList),
		);
	}

	List<PontoAbonoUtilizacaoGrouped> pontoAbonoUtilizacaoModelToDrift(List<PontoAbonoUtilizacaoModel>? pontoAbonoUtilizacaoModelList) { 
		List<PontoAbonoUtilizacaoGrouped> pontoAbonoUtilizacaoGroupedList = [];
		if (pontoAbonoUtilizacaoModelList != null) {
			for (var pontoAbonoUtilizacaoModel in pontoAbonoUtilizacaoModelList) {
				pontoAbonoUtilizacaoGroupedList.add(
					PontoAbonoUtilizacaoGrouped(
						pontoAbonoUtilizacao: PontoAbonoUtilizacao(
							id: pontoAbonoUtilizacaoModel.id,
							idPontoAbono: pontoAbonoUtilizacaoModel.idPontoAbono,
							dataUtilizacao: pontoAbonoUtilizacaoModel.dataUtilizacao,
							observacao: pontoAbonoUtilizacaoModel.observacao,
						),
					),
				);
			}
			return pontoAbonoUtilizacaoGroupedList;
		}
		return [];
	}

		
}
