import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/provider/provider_base.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinConfiguracaoBoletoDriftProvider extends ProviderBase {

	Future<List<FinConfiguracaoBoletoModel>?> getList({Filter? filter}) async {
		List<FinConfiguracaoBoletoGrouped> finConfiguracaoBoletoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				finConfiguracaoBoletoDriftList = await Session.database.finConfiguracaoBoletoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				finConfiguracaoBoletoDriftList = await Session.database.finConfiguracaoBoletoDao.getGroupedList(); 
			}
			if (finConfiguracaoBoletoDriftList.isNotEmpty) {
				return toListModel(finConfiguracaoBoletoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<FinConfiguracaoBoletoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.finConfiguracaoBoletoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinConfiguracaoBoletoModel?>? insert(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) async {
		try {
			final lastPk = await Session.database.finConfiguracaoBoletoDao.insertObject(toDrift(finConfiguracaoBoletoModel));
			finConfiguracaoBoletoModel.id = lastPk;
			return finConfiguracaoBoletoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<FinConfiguracaoBoletoModel?>? update(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) async {
		try {
			await Session.database.finConfiguracaoBoletoDao.updateObject(toDrift(finConfiguracaoBoletoModel));
			return finConfiguracaoBoletoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.finConfiguracaoBoletoDao.deleteObject(toDrift(FinConfiguracaoBoletoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<FinConfiguracaoBoletoModel> toListModel(List<FinConfiguracaoBoletoGrouped> finConfiguracaoBoletoDriftList) {
		List<FinConfiguracaoBoletoModel> listModel = [];
		for (var finConfiguracaoBoletoDrift in finConfiguracaoBoletoDriftList) {
			listModel.add(toModel(finConfiguracaoBoletoDrift)!);
		}
		return listModel;
	}	

	FinConfiguracaoBoletoModel? toModel(FinConfiguracaoBoletoGrouped? finConfiguracaoBoletoDrift) {
		if (finConfiguracaoBoletoDrift != null) {
			return FinConfiguracaoBoletoModel(
				id: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.id,
				idBancoContaCaixa: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.idBancoContaCaixa,
				instrucao01: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.instrucao01,
				instrucao02: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.instrucao02,
				caminhoArquivoRemessa: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.caminhoArquivoRemessa,
				caminhoArquivoRetorno: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.caminhoArquivoRetorno,
				caminhoArquivoLogotipo: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.caminhoArquivoLogotipo,
				caminhoArquivoPdf: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.caminhoArquivoPdf,
				mensagem: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.mensagem,
				localPagamento: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.localPagamento,
				layoutRemessa: FinConfiguracaoBoletoDomain.getLayoutRemessa(finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.layoutRemessa),
				aceite: FinConfiguracaoBoletoDomain.getAceite(finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.aceite),
				especie: FinConfiguracaoBoletoDomain.getEspecie(finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.especie),
				carteira: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.carteira,
				codigoConvenio: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.codigoConvenio,
				codigoCedente: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.codigoCedente,
				taxaMulta: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.taxaMulta,
				taxaJuro: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.taxaJuro,
				diasProtesto: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.diasProtesto,
				nossoNumeroAnterior: finConfiguracaoBoletoDrift.finConfiguracaoBoleto?.nossoNumeroAnterior,
				bancoContaCaixaModel: BancoContaCaixaModel(
					id: finConfiguracaoBoletoDrift.bancoContaCaixa?.id,
					idBancoAgencia: finConfiguracaoBoletoDrift.bancoContaCaixa?.idBancoAgencia,
					numero: finConfiguracaoBoletoDrift.bancoContaCaixa?.numero,
					digito: finConfiguracaoBoletoDrift.bancoContaCaixa?.digito,
					nome: finConfiguracaoBoletoDrift.bancoContaCaixa?.nome,
					tipo: finConfiguracaoBoletoDrift.bancoContaCaixa?.tipo,
					descricao: finConfiguracaoBoletoDrift.bancoContaCaixa?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	FinConfiguracaoBoletoGrouped toDrift(FinConfiguracaoBoletoModel finConfiguracaoBoletoModel) {
		return FinConfiguracaoBoletoGrouped(
			finConfiguracaoBoleto: FinConfiguracaoBoleto(
				id: finConfiguracaoBoletoModel.id,
				idBancoContaCaixa: finConfiguracaoBoletoModel.idBancoContaCaixa,
				instrucao01: finConfiguracaoBoletoModel.instrucao01,
				instrucao02: finConfiguracaoBoletoModel.instrucao02,
				caminhoArquivoRemessa: finConfiguracaoBoletoModel.caminhoArquivoRemessa,
				caminhoArquivoRetorno: finConfiguracaoBoletoModel.caminhoArquivoRetorno,
				caminhoArquivoLogotipo: finConfiguracaoBoletoModel.caminhoArquivoLogotipo,
				caminhoArquivoPdf: finConfiguracaoBoletoModel.caminhoArquivoPdf,
				mensagem: finConfiguracaoBoletoModel.mensagem,
				localPagamento: finConfiguracaoBoletoModel.localPagamento,
				layoutRemessa: FinConfiguracaoBoletoDomain.setLayoutRemessa(finConfiguracaoBoletoModel.layoutRemessa),
				aceite: FinConfiguracaoBoletoDomain.setAceite(finConfiguracaoBoletoModel.aceite),
				especie: FinConfiguracaoBoletoDomain.setEspecie(finConfiguracaoBoletoModel.especie),
				carteira: finConfiguracaoBoletoModel.carteira,
				codigoConvenio: finConfiguracaoBoletoModel.codigoConvenio,
				codigoCedente: finConfiguracaoBoletoModel.codigoCedente,
				taxaMulta: finConfiguracaoBoletoModel.taxaMulta,
				taxaJuro: finConfiguracaoBoletoModel.taxaJuro,
				diasProtesto: finConfiguracaoBoletoModel.diasProtesto,
				nossoNumeroAnterior: finConfiguracaoBoletoModel.nossoNumeroAnterior,
			),
		);
	}

		
}
