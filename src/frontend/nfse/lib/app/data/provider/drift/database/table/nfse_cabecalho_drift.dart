import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/provider/drift/database/database_imports.dart';

@DataClassName("NfseCabecalho")
class NfseCabecalhos extends Table {
	@override
	String get tableName => 'nfse_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCliente => integer().named('id_cliente').nullable()();
	IntColumn get idOsAbertura => integer().named('id_os_abertura').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 15).nullable()();
	TextColumn get codigoVerificacao => text().named('codigo_verificacao').withLength(min: 0, max: 9).nullable()();
	DateTimeColumn get dataHoraEmissao => dateTime().named('data_hora_emissao').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 6).nullable()();
	TextColumn get numeroSubstituida => text().named('numero_substituida').withLength(min: 0, max: 15).nullable()();
	TextColumn get naturezaOperacao => text().named('natureza_operacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get regimeEspecialTributacao => text().named('regime_especial_tributacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get optanteSimplesNacional => text().named('optante_simples_nacional').withLength(min: 0, max: 1).nullable()();
	TextColumn get incentivadorCultural => text().named('incentivador_cultural').withLength(min: 0, max: 1).nullable()();
	TextColumn get numeroRps => text().named('numero_rps').withLength(min: 0, max: 15).nullable()();
	TextColumn get serieRps => text().named('serie_rps').withLength(min: 0, max: 5).nullable()();
	TextColumn get tipoRps => text().named('tipo_rps').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataEmissaoRps => dateTime().named('data_emissao_rps').nullable()();
	TextColumn get outrasInformacoes => text().named('outras_informacoes').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfseCabecalhoGrouped {
	NfseCabecalho? nfseCabecalho; 
	List<NfseDetalheGrouped>? nfseDetalheGroupedList; 
	List<NfseIntermediarioGrouped>? nfseIntermediarioGroupedList; 
	ViewPessoaCliente? viewPessoaCliente; 
	OsAbertura? osAbertura; 

  NfseCabecalhoGrouped({
		this.nfseCabecalho, 
		this.nfseDetalheGroupedList, 
		this.nfseIntermediarioGroupedList, 
		this.viewPessoaCliente, 
		this.osAbertura, 

  });
}
