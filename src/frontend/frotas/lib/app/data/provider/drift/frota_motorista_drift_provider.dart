import 'package:frotas/app/data/provider/drift/database/database_imports.dart';
import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/provider/provider_base.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/data/domain/domain_imports.dart';

class FrotaMotoristaDriftProvider extends ProviderBase {

	Future<List<FrotaMotoristaModel>?> getList({Filter? filter}) async {
		List<FrotaMotoristaGrouped> frotaMotoristaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				frotaMotoristaDriftList = await Session.database.frotaMotoristaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				frotaMotoristaDriftList = await Session.database.frotaMotoristaDao.getGroupedList(); 
			}
			if (frotaMotoristaDriftList.isNotEmpty) {
				return toListModel(frotaMotoristaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FrotaMotoristaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.frotaMotoristaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaMotoristaModel?>? insert(FrotaMotoristaModel frotaMotoristaModel) async {
		try {
			final lastPk = await Session.database.frotaMotoristaDao.insertObject(toDrift(frotaMotoristaModel));
			frotaMotoristaModel.id = lastPk;
			return frotaMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FrotaMotoristaModel?>? update(FrotaMotoristaModel frotaMotoristaModel) async {
		try {
			await Session.database.frotaMotoristaDao.updateObject(toDrift(frotaMotoristaModel));
			return frotaMotoristaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.frotaMotoristaDao.deleteObject(toDrift(FrotaMotoristaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FrotaMotoristaModel> toListModel(List<FrotaMotoristaGrouped> frotaMotoristaDriftList) {
		List<FrotaMotoristaModel> listModel = [];
		for (var frotaMotoristaDrift in frotaMotoristaDriftList) {
			listModel.add(toModel(frotaMotoristaDrift)!);
		}
		return listModel;
	}	

	FrotaMotoristaModel? toModel(FrotaMotoristaGrouped? frotaMotoristaDrift) {
		if (frotaMotoristaDrift != null) {
			return FrotaMotoristaModel(
				id: frotaMotoristaDrift.frotaMotorista?.id,
				idColaborador: frotaMotoristaDrift.frotaMotorista?.idColaborador,
				nome: frotaMotoristaDrift.frotaMotorista?.nome,
				numeroCnh: frotaMotoristaDrift.frotaMotorista?.numeroCnh,
				cnhCategoria: FrotaMotoristaDomain.getCnhCategoria(frotaMotoristaDrift.frotaMotorista?.cnhCategoria),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: frotaMotoristaDrift.viewPessoaColaborador?.id,
					nome: frotaMotoristaDrift.viewPessoaColaborador?.nome,
					tipo: frotaMotoristaDrift.viewPessoaColaborador?.tipo,
					email: frotaMotoristaDrift.viewPessoaColaborador?.email,
					site: frotaMotoristaDrift.viewPessoaColaborador?.site,
					cpfCnpj: frotaMotoristaDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: frotaMotoristaDrift.viewPessoaColaborador?.rgIe,
					matricula: frotaMotoristaDrift.viewPessoaColaborador?.matricula,
					dataCadastro: frotaMotoristaDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: frotaMotoristaDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: frotaMotoristaDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: frotaMotoristaDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: frotaMotoristaDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: frotaMotoristaDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: frotaMotoristaDrift.viewPessoaColaborador?.ctpsUf,
					observacao: frotaMotoristaDrift.viewPessoaColaborador?.observacao,
					logradouro: frotaMotoristaDrift.viewPessoaColaborador?.logradouro,
					numero: frotaMotoristaDrift.viewPessoaColaborador?.numero,
					complemento: frotaMotoristaDrift.viewPessoaColaborador?.complemento,
					bairro: frotaMotoristaDrift.viewPessoaColaborador?.bairro,
					cidade: frotaMotoristaDrift.viewPessoaColaborador?.cidade,
					cep: frotaMotoristaDrift.viewPessoaColaborador?.cep,
					municipioIbge: frotaMotoristaDrift.viewPessoaColaborador?.municipioIbge,
					uf: frotaMotoristaDrift.viewPessoaColaborador?.uf,
					idPessoa: frotaMotoristaDrift.viewPessoaColaborador?.idPessoa,
					idCargo: frotaMotoristaDrift.viewPessoaColaborador?.idCargo,
					idSetor: frotaMotoristaDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	FrotaMotoristaGrouped toDrift(FrotaMotoristaModel frotaMotoristaModel) {
		return FrotaMotoristaGrouped(
			frotaMotorista: FrotaMotorista(
				id: frotaMotoristaModel.id,
				idColaborador: frotaMotoristaModel.idColaborador,
				nome: frotaMotoristaModel.nome,
				numeroCnh: frotaMotoristaModel.numeroCnh,
				cnhCategoria: FrotaMotoristaDomain.setCnhCategoria(frotaMotoristaModel.cnhCategoria),
			),
		);
	}

		
}
