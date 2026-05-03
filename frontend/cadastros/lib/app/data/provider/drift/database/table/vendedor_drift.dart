import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Vendedor")
class Vendedors extends Table {
	@override
	String get tableName => 'vendedor';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	IntColumn get idComissaoPerfil => integer().named('id_comissao_perfil').nullable()();
	RealColumn get comissao => real().named('comissao').nullable()();
	RealColumn get metaVenda => real().named('meta_venda').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class VendedorGrouped {
	Vendedor? vendedor; 
	ComissaoPerfil? comissaoPerfil; 

  VendedorGrouped({
		this.vendedor, 
		this.comissaoPerfil, 

  });
}
