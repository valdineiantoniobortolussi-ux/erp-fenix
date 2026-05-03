import 'package:drift/drift.dart';
import 'package:vendas/app/data/provider/drift/database/database.dart';
import 'package:vendas/app/data/provider/drift/database/database_imports.dart';

part 'nota_fiscal_tipo_dao.g.dart';

@DriftAccessor(tables: [
	NotaFiscalTipos,
	NotaFiscalModelos,
])
class NotaFiscalTipoDao extends DatabaseAccessor<AppDatabase> with _$NotaFiscalTipoDaoMixin {
	final AppDatabase db;

	List<NotaFiscalTipo> notaFiscalTipoList = []; 
	List<NotaFiscalTipoGrouped> notaFiscalTipoGroupedList = []; 

	NotaFiscalTipoDao(this.db) : super(db);

	Future<List<NotaFiscalTipo>> getList() async {
		notaFiscalTipoList = await select(notaFiscalTipos).get();
		return notaFiscalTipoList;
	}

	Future<List<NotaFiscalTipo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		notaFiscalTipoList = await (select(notaFiscalTipos)..where((t) => expression)).get();
		return notaFiscalTipoList;	 
	}

	Future<List<NotaFiscalTipoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(notaFiscalTipos)
			.join([ 
				leftOuterJoin(notaFiscalModelos, notaFiscalModelos.id.equalsExp(notaFiscalTipos.idNotaFiscalModelo)), 
			]);

		if (field != null && field != '') { 
			final column = notaFiscalTipos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		notaFiscalTipoGroupedList = await query.map((row) {
			final notaFiscalTipo = row.readTableOrNull(notaFiscalTipos); 
			final notaFiscalModelo = row.readTableOrNull(notaFiscalModelos); 

			return NotaFiscalTipoGrouped(
				notaFiscalTipo: notaFiscalTipo, 
				notaFiscalModelo: notaFiscalModelo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var notaFiscalTipoGrouped in notaFiscalTipoGroupedList) {
		//}		

		return notaFiscalTipoGroupedList;	
	}

	Future<NotaFiscalTipo?> getObject(dynamic pk) async {
		return await (select(notaFiscalTipos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NotaFiscalTipo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nota_fiscal_tipo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NotaFiscalTipo;		 
	} 

	Future<NotaFiscalTipoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NotaFiscalTipoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.notaFiscalTipo = object.notaFiscalTipo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(notaFiscalTipos).insert(object.notaFiscalTipo!);
			object.notaFiscalTipo = object.notaFiscalTipo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NotaFiscalTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(notaFiscalTipos).replace(object.notaFiscalTipo!);
		});	 
	} 

	Future<int> deleteObject(NotaFiscalTipoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(notaFiscalTipos).delete(object.notaFiscalTipo!);
		});		
	}

	Future<void> insertChildren(NotaFiscalTipoGrouped object) async {
	}
	
	Future<void> deleteChildren(NotaFiscalTipoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nota_fiscal_tipo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}