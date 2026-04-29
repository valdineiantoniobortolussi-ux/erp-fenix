import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_livro_dao.g.dart';

@DriftAccessor(tables: [
	FiscalLivros,
	FiscalTermos,
])
class FiscalLivroDao extends DatabaseAccessor<AppDatabase> with _$FiscalLivroDaoMixin {
	final AppDatabase db;

	List<FiscalLivro> fiscalLivroList = []; 
	List<FiscalLivroGrouped> fiscalLivroGroupedList = []; 

	FiscalLivroDao(this.db) : super(db);

	Future<List<FiscalLivro>> getList() async {
		fiscalLivroList = await select(fiscalLivros).get();
		return fiscalLivroList;
	}

	Future<List<FiscalLivro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalLivroList = await (select(fiscalLivros)..where((t) => expression)).get();
		return fiscalLivroList;	 
	}

	Future<List<FiscalLivroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalLivros)
			.join([]);

		if (field != null && field != '') { 
			final column = fiscalLivros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalLivroGroupedList = await query.map((row) {
			final fiscalLivro = row.readTableOrNull(fiscalLivros); 

			return FiscalLivroGrouped(
				fiscalLivro: fiscalLivro, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var fiscalLivroGrouped in fiscalLivroGroupedList) {
			fiscalLivroGrouped.fiscalTermoGroupedList = [];
			final queryFiscalTermo = ' id_fiscal_livro = ${fiscalLivroGrouped.fiscalLivro!.id}';
			expression = CustomExpression<bool>(queryFiscalTermo);
			final fiscalTermoList = await (select(fiscalTermos)..where((t) => expression)).get();
			for (var fiscalTermo in fiscalTermoList) {
				FiscalTermoGrouped fiscalTermoGrouped = FiscalTermoGrouped(
					fiscalTermo: fiscalTermo,
				);
				fiscalLivroGrouped.fiscalTermoGroupedList!.add(fiscalTermoGrouped);
			}

		}		

		return fiscalLivroGroupedList;	
	}

	Future<FiscalLivro?> getObject(dynamic pk) async {
		return await (select(fiscalLivros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalLivro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_livro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalLivro;		 
	} 

	Future<FiscalLivroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalLivroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalLivro = object.fiscalLivro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalLivros).insert(object.fiscalLivro!);
			object.fiscalLivro = object.fiscalLivro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalLivroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalLivros).replace(object.fiscalLivro!);
		});	 
	} 

	Future<int> deleteObject(FiscalLivroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalLivros).delete(object.fiscalLivro!);
		});		
	}

	Future<void> insertChildren(FiscalLivroGrouped object) async {
		for (var fiscalTermoGrouped in object.fiscalTermoGroupedList!) {
			fiscalTermoGrouped.fiscalTermo = fiscalTermoGrouped.fiscalTermo?.copyWith(
				id: const Value(null),
				idFiscalLivro: Value(object.fiscalLivro!.id),
			);
			await into(fiscalTermos).insert(fiscalTermoGrouped.fiscalTermo!);
		}
	}
	
	Future<void> deleteChildren(FiscalLivroGrouped object) async {
		await (delete(fiscalTermos)..where((t) => t.idFiscalLivro.equals(object.fiscalLivro!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_livro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}