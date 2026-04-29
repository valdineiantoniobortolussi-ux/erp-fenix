import 'package:ged/app/data/provider/drift/database/database_imports.dart';
import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/provider/provider_base.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class GedVersaoDocumentoDriftProvider extends ProviderBase {

	Future<List<GedVersaoDocumentoModel>?> getList({Filter? filter}) async {
		List<GedVersaoDocumentoGrouped> gedVersaoDocumentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				gedVersaoDocumentoDriftList = await Session.database.gedVersaoDocumentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				gedVersaoDocumentoDriftList = await Session.database.gedVersaoDocumentoDao.getGroupedList(); 
			}
			if (gedVersaoDocumentoDriftList.isNotEmpty) {
				return toListModel(gedVersaoDocumentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<GedVersaoDocumentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.gedVersaoDocumentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedVersaoDocumentoModel?>? insert(GedVersaoDocumentoModel gedVersaoDocumentoModel) async {
		try {
			final lastPk = await Session.database.gedVersaoDocumentoDao.insertObject(toDrift(gedVersaoDocumentoModel));
			gedVersaoDocumentoModel.id = lastPk;
			return gedVersaoDocumentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<GedVersaoDocumentoModel?>? update(GedVersaoDocumentoModel gedVersaoDocumentoModel) async {
		try {
			await Session.database.gedVersaoDocumentoDao.updateObject(toDrift(gedVersaoDocumentoModel));
			return gedVersaoDocumentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.gedVersaoDocumentoDao.deleteObject(toDrift(GedVersaoDocumentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<GedVersaoDocumentoModel> toListModel(List<GedVersaoDocumentoGrouped> gedVersaoDocumentoDriftList) {
		List<GedVersaoDocumentoModel> listModel = [];
		for (var gedVersaoDocumentoDrift in gedVersaoDocumentoDriftList) {
			listModel.add(toModel(gedVersaoDocumentoDrift)!);
		}
		return listModel;
	}	

	GedVersaoDocumentoModel? toModel(GedVersaoDocumentoGrouped? gedVersaoDocumentoDrift) {
		if (gedVersaoDocumentoDrift != null) {
			return GedVersaoDocumentoModel(
				id: gedVersaoDocumentoDrift.gedVersaoDocumento?.id,
				idGedDocumentoDetalhe: gedVersaoDocumentoDrift.gedVersaoDocumento?.idGedDocumentoDetalhe,
				idColaborador: gedVersaoDocumentoDrift.gedVersaoDocumento?.idColaborador,
				acao: GedVersaoDocumentoDomain.getAcao(gedVersaoDocumentoDrift.gedVersaoDocumento?.acao),
				versao: gedVersaoDocumentoDrift.gedVersaoDocumento?.versao,
				dataVersao: gedVersaoDocumentoDrift.gedVersaoDocumento?.dataVersao,
				horaVersao: gedVersaoDocumentoDrift.gedVersaoDocumento?.horaVersao,
				hashArquivo: gedVersaoDocumentoDrift.gedVersaoDocumento?.hashArquivo,
				caminho: gedVersaoDocumentoDrift.gedVersaoDocumento?.caminho,
				gedDocumentoDetalheModel: GedDocumentoDetalheModel(
					id: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.id,
					idGedDocumentoCabecalho: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.idGedDocumentoCabecalho,
					idGedTipoDocumento: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.idGedTipoDocumento,
					nome: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.nome,
					descricao: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.descricao,
					palavrasChave: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.palavrasChave,
					podeExcluir: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.podeExcluir,
					podeAlterar: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.podeAlterar,
					assinado: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.assinado,
					dataFimVigencia: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.dataFimVigencia,
					dataExclusao: gedVersaoDocumentoDrift.gedDocumentoDetalhe?.dataExclusao,
				),
				viewPessoaColaboradorModel: ViewPessoaColaboradorModel(
					id: gedVersaoDocumentoDrift.viewPessoaColaborador?.id,
					nome: gedVersaoDocumentoDrift.viewPessoaColaborador?.nome,
					tipo: gedVersaoDocumentoDrift.viewPessoaColaborador?.tipo,
					email: gedVersaoDocumentoDrift.viewPessoaColaborador?.email,
					site: gedVersaoDocumentoDrift.viewPessoaColaborador?.site,
					cpfCnpj: gedVersaoDocumentoDrift.viewPessoaColaborador?.cpfCnpj,
					rgIe: gedVersaoDocumentoDrift.viewPessoaColaborador?.rgIe,
					matricula: gedVersaoDocumentoDrift.viewPessoaColaborador?.matricula,
					dataCadastro: gedVersaoDocumentoDrift.viewPessoaColaborador?.dataCadastro,
					dataAdmissao: gedVersaoDocumentoDrift.viewPessoaColaborador?.dataAdmissao,
					dataDemissao: gedVersaoDocumentoDrift.viewPessoaColaborador?.dataDemissao,
					ctpsNumero: gedVersaoDocumentoDrift.viewPessoaColaborador?.ctpsNumero,
					ctpsSerie: gedVersaoDocumentoDrift.viewPessoaColaborador?.ctpsSerie,
					ctpsDataExpedicao: gedVersaoDocumentoDrift.viewPessoaColaborador?.ctpsDataExpedicao,
					ctpsUf: gedVersaoDocumentoDrift.viewPessoaColaborador?.ctpsUf,
					observacao: gedVersaoDocumentoDrift.viewPessoaColaborador?.observacao,
					logradouro: gedVersaoDocumentoDrift.viewPessoaColaborador?.logradouro,
					numero: gedVersaoDocumentoDrift.viewPessoaColaborador?.numero,
					complemento: gedVersaoDocumentoDrift.viewPessoaColaborador?.complemento,
					bairro: gedVersaoDocumentoDrift.viewPessoaColaborador?.bairro,
					cidade: gedVersaoDocumentoDrift.viewPessoaColaborador?.cidade,
					cep: gedVersaoDocumentoDrift.viewPessoaColaborador?.cep,
					municipioIbge: gedVersaoDocumentoDrift.viewPessoaColaborador?.municipioIbge,
					uf: gedVersaoDocumentoDrift.viewPessoaColaborador?.uf,
					idPessoa: gedVersaoDocumentoDrift.viewPessoaColaborador?.idPessoa,
					idCargo: gedVersaoDocumentoDrift.viewPessoaColaborador?.idCargo,
					idSetor: gedVersaoDocumentoDrift.viewPessoaColaborador?.idSetor,
				),
			);
		} else {
			return null;
		}
	}


	GedVersaoDocumentoGrouped toDrift(GedVersaoDocumentoModel gedVersaoDocumentoModel) {
		return GedVersaoDocumentoGrouped(
			gedVersaoDocumento: GedVersaoDocumento(
				id: gedVersaoDocumentoModel.id,
				idGedDocumentoDetalhe: gedVersaoDocumentoModel.idGedDocumentoDetalhe,
				idColaborador: gedVersaoDocumentoModel.idColaborador,
				acao: GedVersaoDocumentoDomain.setAcao(gedVersaoDocumentoModel.acao),
				versao: gedVersaoDocumentoModel.versao,
				dataVersao: gedVersaoDocumentoModel.dataVersao,
				horaVersao: Util.removeMask(gedVersaoDocumentoModel.horaVersao),
				hashArquivo: gedVersaoDocumentoModel.hashArquivo,
				caminho: gedVersaoDocumentoModel.caminho,
			),
		);
	}

		
}
