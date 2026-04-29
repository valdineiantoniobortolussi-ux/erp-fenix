import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilConta")
class ContabilContas extends Table {
	@override
	String get tableName => 'contabil_conta';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPlanoConta => integer().named('id_plano_conta').nullable()();
	IntColumn get idPlanoContaRefSped => integer().named('id_plano_conta_ref_sped').nullable()();
	IntColumn get idContabilConta => integer().named('id_contabil_conta').nullable()();
	TextColumn get classificacao => text().named('classificacao').withLength(min: 0, max: 30).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get situacao => text().named('situacao').withLength(min: 0, max: 1).nullable()();
	TextColumn get natureza => text().named('natureza').withLength(min: 0, max: 1).nullable()();
	TextColumn get patrimonioResultado => text().named('patrimonio_resultado').withLength(min: 0, max: 1).nullable()();
	TextColumn get livroCaixa => text().named('livro_caixa').withLength(min: 0, max: 1).nullable()();
	TextColumn get dfc => text().named('dfc').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigoEfd => text().named('codigo_efd').withLength(min: 0, max: 2).nullable()();
	TextColumn get ordem => text().named('ordem').withLength(min: 0, max: 20).nullable()();
	TextColumn get codigoReduzido => text().named('codigo_reduzido').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilContaGrouped {
	ContabilConta? contabilConta; 
	PlanoConta? planoConta; 
	PlanoContaRefSped? planoContaRefSped; 

  ContabilContaGrouped({
		this.contabilConta, 
		this.planoConta, 
		this.planoContaRefSped, 

  });
}
