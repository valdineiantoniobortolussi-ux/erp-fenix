import 'package:folha/app/data/provider/drift/database/database_imports.dart';
import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/provider/provider_base.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaRescisaoDriftProvider extends ProviderBase {

	Future<List<FolhaRescisaoModel>?> getList({Filter? filter}) async {
		List<FolhaRescisaoGrouped> folhaRescisaoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				folhaRescisaoDriftList = await Session.database.folhaRescisaoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				folhaRescisaoDriftList = await Session.database.folhaRescisaoDao.getGroupedList(); 
			}
			if (folhaRescisaoDriftList.isNotEmpty) {
				return toListModel(folhaRescisaoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FolhaRescisaoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.folhaRescisaoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaRescisaoModel?>? insert(FolhaRescisaoModel folhaRescisaoModel) async {
		try {
			final lastPk = await Session.database.folhaRescisaoDao.insertObject(toDrift(folhaRescisaoModel));
			folhaRescisaoModel.id = lastPk;
			return folhaRescisaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FolhaRescisaoModel?>? update(FolhaRescisaoModel folhaRescisaoModel) async {
		try {
			await Session.database.folhaRescisaoDao.updateObject(toDrift(folhaRescisaoModel));
			return folhaRescisaoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.folhaRescisaoDao.deleteObject(toDrift(FolhaRescisaoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FolhaRescisaoModel> toListModel(List<FolhaRescisaoGrouped> folhaRescisaoDriftList) {
		List<FolhaRescisaoModel> listModel = [];
		for (var folhaRescisaoDrift in folhaRescisaoDriftList) {
			listModel.add(toModel(folhaRescisaoDrift)!);
		}
		return listModel;
	}	

	FolhaRescisaoModel? toModel(FolhaRescisaoGrouped? folhaRescisaoDrift) {
		if (folhaRescisaoDrift != null) {
			return FolhaRescisaoModel(
				id: folhaRescisaoDrift.folhaRescisao?.id,
				idColaborador: folhaRescisaoDrift.folhaRescisao?.idColaborador,
				dataDemissao: folhaRescisaoDrift.folhaRescisao?.dataDemissao,
				dataPagamento: folhaRescisaoDrift.folhaRescisao?.dataPagamento,
				motivo: folhaRescisaoDrift.folhaRescisao?.motivo,
				motivoEsocial: folhaRescisaoDrift.folhaRescisao?.motivoEsocial,
				dataAvisoPrevio: folhaRescisaoDrift.folhaRescisao?.dataAvisoPrevio,
				diasAvisoPrevio: folhaRescisaoDrift.folhaRescisao?.diasAvisoPrevio,
				comprovouNovoEmprego: FolhaRescisaoDomain.getComprovouNovoEmprego(folhaRescisaoDrift.folhaRescisao?.comprovouNovoEmprego),
				dispensouEmpregado: FolhaRescisaoDomain.getDispensouEmpregado(folhaRescisaoDrift.folhaRescisao?.dispensouEmpregado),
				pensaoAlimenticia: folhaRescisaoDrift.folhaRescisao?.pensaoAlimenticia,
				pensaoAlimenticiaFgts: folhaRescisaoDrift.folhaRescisao?.pensaoAlimenticiaFgts,
				fgtsValorRescisao: folhaRescisaoDrift.folhaRescisao?.fgtsValorRescisao,
				fgtsSaldoBanco: folhaRescisaoDrift.folhaRescisao?.fgtsSaldoBanco,
				fgtsComplementoSaldo: folhaRescisaoDrift.folhaRescisao?.fgtsComplementoSaldo,
				fgtsCodigoAfastamento: folhaRescisaoDrift.folhaRescisao?.fgtsCodigoAfastamento,
				fgtsCodigoSaque: folhaRescisaoDrift.folhaRescisao?.fgtsCodigoSaque,
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: folhaRescisaoDrift.viewPessoaColaborador?.id,
					nome: folhaRescisaoDrift.viewPessoaColaborador?.nome,
					tipo: folhaRescisaoDrift.viewPessoaColaborador?.tipo,
					email: folhaRescisaoDrift.viewPessoaColaborador?.email,
					site: folhaRescisaoDrift.viewPessoaColaborador?.site,
					cpfCnpj: folhaRescisaoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: folhaRescisaoDrift.viewPessoaColaborador?.rgIe,
					matricula: folhaRescisaoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: folhaRescisaoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: folhaRescisaoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: folhaRescisaoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: folhaRescisaoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: folhaRescisaoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: folhaRescisaoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: folhaRescisaoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: folhaRescisaoDrift.viewPessoaColaborador?.observacao,
					logradouro: folhaRescisaoDrift.viewPessoaColaborador?.logradouro,
					numero: folhaRescisaoDrift.viewPessoaColaborador?.numero,
					complemento: folhaRescisaoDrift.viewPessoaColaborador?.complemento,
					bairro: folhaRescisaoDrift.viewPessoaColaborador?.bairro,
					cidade: folhaRescisaoDrift.viewPessoaColaborador?.cidade,
					cep: folhaRescisaoDrift.viewPessoaColaborador?.cep,
					municipioIbge: folhaRescisaoDrift.viewPessoaColaborador?.municipioIbge,
					uf: folhaRescisaoDrift.viewPessoaColaborador?.uf,
					idPessoa: folhaRescisaoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: folhaRescisaoDrift.viewPessoaColaborador?.idCargo,
					idSetor: folhaRescisaoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	FolhaRescisaoGrouped toDrift(FolhaRescisaoModel folhaRescisaoModel) {
		return FolhaRescisaoGrouped(
			folhaRescisao: FolhaRescisao(
				id: folhaRescisaoModel.id,
				idColaborador: folhaRescisaoModel.idColaborador,
				dataDemissao: folhaRescisaoModel.dataDemissao,
				dataPagamento: folhaRescisaoModel.dataPagamento,
				motivo: folhaRescisaoModel.motivo,
				motivoEsocial: folhaRescisaoModel.motivoEsocial,
				dataAvisoPrevio: folhaRescisaoModel.dataAvisoPrevio,
				diasAvisoPrevio: folhaRescisaoModel.diasAvisoPrevio,
				comprovouNovoEmprego: FolhaRescisaoDomain.setComprovouNovoEmprego(folhaRescisaoModel.comprovouNovoEmprego),
				dispensouEmpregado: FolhaRescisaoDomain.setDispensouEmpregado(folhaRescisaoModel.dispensouEmpregado),
				pensaoAlimenticia: folhaRescisaoModel.pensaoAlimenticia,
				pensaoAlimenticiaFgts: folhaRescisaoModel.pensaoAlimenticiaFgts,
				fgtsValorRescisao: folhaRescisaoModel.fgtsValorRescisao,
				fgtsSaldoBanco: folhaRescisaoModel.fgtsSaldoBanco,
				fgtsComplementoSaldo: folhaRescisaoModel.fgtsComplementoSaldo,
				fgtsCodigoAfastamento: folhaRescisaoModel.fgtsCodigoAfastamento,
				fgtsCodigoSaque: folhaRescisaoModel.fgtsCodigoSaque,
			),
		);
	}

		
}
