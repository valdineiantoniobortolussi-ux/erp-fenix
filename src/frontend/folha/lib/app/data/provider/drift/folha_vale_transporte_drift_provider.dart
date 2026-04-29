import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaValeTransporteDriftProvider extends ProviderBase {

	Future<List<FolhaValeTransporteModel>?> getList({Filter? filter}) async {
		List<FolhaValeTransporteGrouped> folhaValeTransporteDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaValeTransporteDriftList = await Session.database.folhaValeTransporteDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaValeTransporteDriftList = await Session.database.folhaValeTransporteDao.getGroupedList(); 
			}
			if (folhaValeTransporteDriftList.isNotEmpty) {
				return toListModel(folhaValeTransporteDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaValeTransporteModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaValeTransporteDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaValeTransporteModel?>? insert(FolhaValeTransporteModel folhaValeTransporteModel) async {
		try {
			final lastPk = await Session.database.folhaValeTransporteDao.insertObject(toDrift(folhaValeTransporteModel));
			folhaValeTransporteModel.id = lastPk;
			return folhaValeTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaValeTransporteModel?>? update(FolhaValeTransporteModel folhaValeTransporteModel) async {
		try {
			await Session.database.folhaValeTransporteDao.updateObject(toDrift(folhaValeTransporteModel));
			return folhaValeTransporteModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaValeTransporteDao.deleteObject(toDrift(FolhaValeTransporteModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaValeTransporteModel> toListModel(List<FolhaValeTransporteGrouped> folhaValeTransporteDriftList) {
		List<FolhaValeTransporteModel> listModel = [];
		for (var folhaValeTransporteDrift in folhaValeTransporteDriftList) {
			listModel.add(toModel(folhaValeTransporteDrift)!);
		}
		return listModel;
	}	

	FolhaValeTransporteModel? toModel(FolhaValeTransporteGrouped? folhaValeTransporteDrift) {
		if (folhaValeTransporteDrift != null) {
			return FolhaValeTransporteModel(
				id: folhaValeTransporteDrift.folhaValeTransporte?.id,
				idColaborador: folhaValeTransporteDrift.folhaValeTransporte?.idColaborador,
				idEmpresaTranspItin: folhaValeTransporteDrift.folhaValeTransporte?.idEmpresaTranspItin,
				quantidade: folhaValeTransporteDrift.folhaValeTransporte?.quantidade,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaValeTransporteDrift.viewPessoaColaborador?.id,
					nome: folhaValeTransporteDrift.viewPessoaColaborador?.nome,
					tipo: folhaValeTransporteDrift.viewPessoaColaborador?.tipo,
					email: folhaValeTransporteDrift.viewPessoaColaborador?.email,
					site: folhaValeTransporteDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaValeTransporteDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaValeTransporteDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaValeTransporteDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaValeTransporteDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaValeTransporteDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaValeTransporteDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaValeTransporteDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaValeTransporteDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaValeTransporteDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaValeTransporteDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaValeTransporteDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaValeTransporteDrift.viewPessoaColaborador?.logradouro,
					numero: folhaValeTransporteDrift.viewPessoaColaborador?.numero,
					complemento: folhaValeTransporteDrift.viewPessoaColaborador?.complemento,
					bairro: folhaValeTransporteDrift.viewPessoaColaborador?.bairro,
					cidade: folhaValeTransporteDrift.viewPessoaColaborador?.cidade,
					cep: folhaValeTransporteDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaValeTransporteDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaValeTransporteDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaValeTransporteDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaValeTransporteDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaValeTransporteDrift.viewPessoaColaborador?.idSetor,
				),
				empresaTransporteItinerarioModel: EmpresaTransporteItinerarioModel(
					id: folhaValeTransporteDrift.empresaTransporteItinerario?.id,
					idEmpresaTransporte: folhaValeTransporteDrift.empresaTransporteItinerario?.idEmpresaTransporte,
					nome: folhaValeTransporteDrift.empresaTransporteItinerario?.nome,
					tarifa: folhaValeTransporteDrift.empresaTransporteItinerario?.tarifa,
					trajeto: folhaValeTransporteDrift.empresaTransporteItinerario?.trajeto,
				),
			);
		} else {
			return null;
		}
	}


	FolhaValeTransporteGrouped toDrift(FolhaValeTransporteModel folhaValeTransporteModel) {
		return FolhaValeTransporteGrouped(
			folhaValeTransporte: FolhaValeTransporte(
				id: folhaValeTransporteModel.id,
				idColaborador: folhaValeTransporteModel.idColaborador,
				idEmpresaTranspItin: folhaValeTransporteModel.idEmpresaTranspItin,
				quantidade: folhaValeTransporteModel.quantidade,
			),
		);
	}

		
}
