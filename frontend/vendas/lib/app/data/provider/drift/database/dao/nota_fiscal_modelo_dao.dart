import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

part 'nota_fiscal_modelo_dao.g.dart';

@DriftAccessor(tables: [
	NotaFiscalModelos,
])
class NotaFiscalModeloDao extends DatabaseAccessor<AppDatabase> with _$NotaFiscalModeloDaoMixin {
	final AppDatabase db;

	List<NotaFiscalModelo> notaFiscalModeloList = []; 
	List<NotaFiscalModeloGrouped> notaFiscalModeloGroupedList = []; 

	NotaFiscalModeloDao(this.db) : super(db);

	Future<List<NotaFiscalModelo>> getList() async {
		notaFiscalModeloList = await select(notaFiscalModelos).get();
		return notaFiscalModeloList;
	}

	Future<List<NotaFiscalModelo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		notaFiscalModeloList = await (select(notaFiscalModelos)..where((t) => expression)).get();
		return notaFiscalModeloList;	 
	}

	Future<List<NotaFiscalModeloGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(notaFiscalModelos)
			.join([]);

		if (field != null && field != '') { 
			final column = notaFiscalModelos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		notaFiscalModeloGroupedList = await query.map((row) {
			final notaFiscalModelo = row.readTableOrNull(notaFiscalModelos); 

			return NotaFiscalModeloGrouped(
				notaFiscalModelo: notaFiscalModelo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var notaFiscalModeloGrouped in notaFiscalModeloGroupedList) {
		//}		

		return notaFiscalModeloGroupedList;	
	}

	Future<NotaFiscalModelo?> getObject(dynamic pk) async {
		return await (select(notaFiscalModelos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NotaFiscalModelo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nota_fiscal_modelo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NotaFiscalModelo;		 
	} 

	Future<NotaFiscalModeloGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NotaFiscalModeloGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.notaFiscalModelo = object.notaFiscalModelo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(notaFiscalModelos).insert(object.notaFiscalModelo!);
			object.notaFiscalModelo = object.notaFiscalModelo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NotaFiscalModeloGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(notaFiscalModelos).replace(object.notaFiscalModelo!);
		});	 
	} 

	Future<int> deleteObject(NotaFiscalModeloGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(notaFiscalModelos).delete(object.notaFiscalModelo!);
		});		
	}

	Future<void> insertChildren(NotaFiscalModeloGrouped object) async {
	}
	
	Future<void> deleteChildren(NotaFiscalModeloGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nota_fiscal_modelo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}