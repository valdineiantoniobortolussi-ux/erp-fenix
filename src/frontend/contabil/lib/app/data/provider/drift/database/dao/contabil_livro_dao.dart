import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_livro_dao.g.dart';

@DriftAccessor(tables: [
	ContabilLivros,
	ContabilTermos,
])
class ContabilLivroDao extends DatabaseAccessor<AppDatabase> with _$ContabilLivroDaoMixin {
	final AppDatabase db;

	List<ContabilLivro> contabilLivroList = []; 
	List<ContabilLivroGrouped> contabilLivroGroupedList = []; 

	ContabilLivroDao(this.db) : super(db);

	Future<List<ContabilLivro>> getList() async {
		contabilLivroList = await select(contabilLivros).get();
		return contabilLivroList;
	}

	Future<List<ContabilLivro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilLivroList = await (select(contabilLivros)..where((t) => expression)).get();
		return contabilLivroList;	 
	}

	Future<List<ContabilLivroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilLivros)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilLivros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilLivroGroupedList = await query.map((row) {
			final contabilLivro = row.readTableOrNull(contabilLivros); 

			return ContabilLivroGrouped(
				contabilLivro: contabilLivro, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contabilLivroGrouped in contabilLivroGroupedList) {
			contabilLivroGrouped.contabilTermoGroupedList = [];
			final queryContabilTermo = ' id_contabil_livro = ${contabilLivroGrouped.contabilLivro!.id}';
			expression = CustomExpression<bool>(queryContabilTermo);
			final contabilTermoList = await (select(contabilTermos)..where((t) => expression)).get();
			for (var contabilTermo in contabilTermoList) {
				ContabilTermoGrouped contabilTermoGrouped = ContabilTermoGrouped(
					contabilTermo: contabilTermo,
				);
				contabilLivroGrouped.contabilTermoGroupedList!.add(contabilTermoGrouped);
			}

		}		

		return contabilLivroGroupedList;	
	}

	Future<ContabilLivro?> getObject(dynamic pk) async {
		return await (select(contabilLivros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilLivro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_livro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilLivro;		 
	} 

	Future<ContabilLivroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilLivroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilLivro = object.contabilLivro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilLivros).insert(object.contabilLivro!);
			object.contabilLivro = object.contabilLivro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilLivroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilLivros).replace(object.contabilLivro!);
		});	 
	} 

	Future<int> deleteObject(ContabilLivroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilLivros).delete(object.contabilLivro!);
		});		
	}

	Future<void> insertChildren(ContabilLivroGrouped object) async {
		for (var contabilTermoGrouped in object.contabilTermoGroupedList!) {
			contabilTermoGrouped.contabilTermo = contabilTermoGrouped.contabilTermo?.copyWith(
				id: const Value(null),
				idContabilLivro: Value(object.contabilLivro!.id),
			);
			await into(contabilTermos).insert(contabilTermoGrouped.contabilTermo!);
		}
	}
	
	Future<void> deleteChildren(ContabilLivroGrouped object) async {
		await (delete(contabilTermos)..where((t) => t.idContabilLivro.equals(object.contabilLivro!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_livro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}