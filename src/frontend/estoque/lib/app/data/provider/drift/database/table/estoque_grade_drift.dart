import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("EstoqueGrade")
class EstoqueGrades extends Table {
	@override
	String get tableName => 'estoque_grade';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	IntColumn get idEstoqueMarca => integer().named('id_estoque_marca').nullable()();
	IntColumn get idEstoqueSabor => integer().named('id_estoque_sabor').nullable()();
	IntColumn get idEstoqueTamanho => integer().named('id_estoque_tamanho').nullable()();
	IntColumn get idEstoqueCor => integer().named('id_estoque_cor').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 50).nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueGradeGrouped {
	EstoqueGrade? estoqueGrade; 
	Produto? produto; 
	EstoqueCor? estoqueCor; 
	EstoqueTamanho? estoqueTamanho; 
	EstoqueSabor? estoqueSabor; 
	EstoqueMarca? estoqueMarca; 

  EstoqueGradeGrouped({
		this.estoqueGrade, 
		this.produto, 
		this.estoqueCor, 
		this.estoqueTamanho, 
		this.estoqueSabor, 
		this.estoqueMarca, 

  });
}
