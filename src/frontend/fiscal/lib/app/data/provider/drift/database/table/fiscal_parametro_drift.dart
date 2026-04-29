import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FiscalParametro")
class FiscalParametros extends Table {
	@override
	String get tableName => 'fiscal_parametro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFiscalEstadualPorte => integer().named('id_fiscal_estadual_porte').nullable()();
	IntColumn get idFiscalEstadualRegime => integer().named('id_fiscal_estadual_regime').nullable()();
	IntColumn get idFiscalMunicipalRegime => integer().named('id_fiscal_municipal_regime').nullable()();
	TextColumn get vigencia => text().named('vigencia').withLength(min: 0, max: 7).nullable()();
	TextColumn get descricaoVigencia => text().named('descricao_vigencia').withLength(min: 0, max: 100).nullable()();
	TextColumn get criterioLancamento => text().named('criterio_lancamento').withLength(min: 0, max: 1).nullable()();
	TextColumn get apuracao => text().named('apuracao').withLength(min: 0, max: 1).nullable()();
	TextColumn get microempreeIndividual => text().named('microempree_individual').withLength(min: 0, max: 1).nullable()();
	TextColumn get calcPisCofinsEfd => text().named('calc_pis_cofins_efd').withLength(min: 0, max: 2).nullable()();
	TextColumn get simplesCodigoAcesso => text().named('simples_codigo_acesso').withLength(min: 0, max: 50).nullable()();
	TextColumn get simplesTabela => text().named('simples_tabela').withLength(min: 0, max: 1).nullable()();
	TextColumn get simplesAtividade => text().named('simples_atividade').withLength(min: 0, max: 2).nullable()();
	TextColumn get perfilSped => text().named('perfil_sped').withLength(min: 0, max: 1).nullable()();
	TextColumn get apuracaoConsolidada => text().named('apuracao_consolidada').withLength(min: 0, max: 1).nullable()();
	TextColumn get substituicaoTributaria => text().named('substituicao_tributaria').withLength(min: 0, max: 1).nullable()();
	TextColumn get formaCalculoIss => text().named('forma_calculo_iss').withLength(min: 0, max: 2).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalParametroGrouped {
	FiscalParametro? fiscalParametro; 
	List<FiscalInscricoesSubstitutasGrouped>? fiscalInscricoesSubstitutasGroupedList; 
	FiscalEstadualRegime? fiscalEstadualRegime; 
	FiscalEstadualPorte? fiscalEstadualPorte; 
	FiscalMunicipalRegime? fiscalMunicipalRegime; 

  FiscalParametroGrouped({
		this.fiscalParametro, 
		this.fiscalInscricoesSubstitutasGroupedList, 
		this.fiscalEstadualRegime, 
		this.fiscalEstadualPorte, 
		this.fiscalMunicipalRegime, 

  });
}
