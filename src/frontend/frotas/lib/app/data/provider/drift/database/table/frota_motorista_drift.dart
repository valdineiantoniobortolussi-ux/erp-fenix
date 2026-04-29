import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';

@DataClassName("FrotaMotorista")
class FrotaMotoristas extends Table {
	@override
	String get tableName => 'frota_motorista';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get numeroCnh => text().named('numero_cnh').withLength(min: 0, max: 11).nullable()();
	TextColumn get cnhCategoria => text().named('cnh_categoria').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FrotaMotoristaGrouped {
	FrotaMotorista? frotaMotorista; 
	ViewPessoaColaborador? viewPessoaColaborador; 

  FrotaMotoristaGrouped({
		this.frotaMotorista, 
		this.viewPessoaColaborador, 

  });
}
