import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_grade_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueGrades,
	Produtos,
	EstoqueCors,
	EstoqueTamanhos,
	EstoqueSabors,
	EstoqueMarcas,
])
class EstoqueGradeDao extends DatabaseAccessor<AppDatabase> with _$EstoqueGradeDaoMixin {
	final AppDatabase db;

	List<EstoqueGrade> estoqueGradeList = []; 
	List<EstoqueGradeGrouped> estoqueGradeGroupedList = []; 

	EstoqueGradeDao(this.db) : super(db);

	Future<List<EstoqueGrade>> getList() async {
		estoqueGradeList = await select(estoqueGrades).get();
		return estoqueGradeList;
	}

	Future<List<EstoqueGrade>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueGradeList = await (select(estoqueGrades)..where((t) => expression)).get();
		return estoqueGradeList;	 
	}

	Future<List<EstoqueGradeGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueGrades)
			.join([ 
				leftOuterJoin(produtos, produtos.id.equalsExp(estoqueGrades.idProduto)), 
			]).join([ 
				leftOuterJoin(estoqueCors, estoqueCors.id.equalsExp(estoqueGrades.idEstoqueCor)), 
			]).join([ 
				leftOuterJoin(estoqueTamanhos, estoqueTamanhos.id.equalsExp(estoqueGrades.idEstoqueTamanho)), 
			]).join([ 
				leftOuterJoin(estoqueSabors, estoqueSabors.id.equalsExp(estoqueGrades.idEstoqueSabor)), 
			]).join([ 
				leftOuterJoin(estoqueMarcas, estoqueMarcas.id.equalsExp(estoqueGrades.idEstoqueMarca)), 
			]);

		if (field != null && field != '') { 
			final column = estoqueGrades.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueGradeGroupedList = await query.map((row) {
			final estoqueGrade = row.readTableOrNull(estoqueGrades); 
			final produto = row.readTableOrNull(produtos); 
			final estoqueCor = row.readTableOrNull(estoqueCors); 
			final estoqueTamanho = row.readTableOrNull(estoqueTamanhos); 
			final estoqueSabor = row.readTableOrNull(estoqueSabors); 
			final estoqueMarca = row.readTableOrNull(estoqueMarcas); 

			return EstoqueGradeGrouped(
				estoqueGrade: estoqueGrade, 
				produto: produto, 
				estoqueCor: estoqueCor, 
				estoqueTamanho: estoqueTamanho, 
				estoqueSabor: estoqueSabor, 
				estoqueMarca: estoqueMarca, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estoqueGradeGrouped in estoqueGradeGroupedList) {
		//}		

		return estoqueGradeGroupedList;	
	}

	Future<EstoqueGrade?> getObject(dynamic pk) async {
		return await (select(estoqueGrades)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueGrade?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_grade WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueGrade;		 
	} 

	Future<EstoqueGradeGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueGradeGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueGrade = object.estoqueGrade!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueGrades).insert(object.estoqueGrade!);
			object.estoqueGrade = object.estoqueGrade!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueGradeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueGrades).replace(object.estoqueGrade!);
		});	 
	} 

	Future<int> deleteObject(EstoqueGradeGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueGrades).delete(object.estoqueGrade!);
		});		
	}

	Future<void> insertChildren(EstoqueGradeGrouped object) async {
	}
	
	Future<void> deleteChildren(EstoqueGradeGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_grade").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}