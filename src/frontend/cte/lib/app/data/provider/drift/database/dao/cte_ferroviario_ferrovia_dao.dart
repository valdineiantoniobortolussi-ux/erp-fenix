import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_ferroviario_ferrovia_dao.g.dart';

@DriftAccessor(tables: [
	CteFerroviarioFerrovias,
	CteFerroviarios,
])
class CteFerroviarioFerroviaDao extends DatabaseAccessor<AppDatabase> with _$CteFerroviarioFerroviaDaoMixin {
	final AppDatabase db;

	List<CteFerroviarioFerrovia> cteFerroviarioFerroviaList = []; 
	List<CteFerroviarioFerroviaGrouped> cteFerroviarioFerroviaGroupedList = []; 

	CteFerroviarioFerroviaDao(this.db) : super(db);

	Future<List<CteFerroviarioFerrovia>> getList() async {
		cteFerroviarioFerroviaList = await select(cteFerroviarioFerrovias).get();
		return cteFerroviarioFerroviaList;
	}

	Future<List<CteFerroviarioFerrovia>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteFerroviarioFerroviaList = await (select(cteFerroviarioFerrovias)..where((t) => expression)).get();
		return cteFerroviarioFerroviaList;	 
	}

	Future<List<CteFerroviarioFerroviaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteFerroviarioFerrovias)
			.join([ 
				leftOuterJoin(cteFerroviarios, cteFerroviarios.id.equalsExp(cteFerroviarioFerrovias.idCteFerroviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteFerroviarioFerrovias.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteFerroviarioFerroviaGroupedList = await query.map((row) {
			final cteFerroviarioFerrovia = row.readTableOrNull(cteFerroviarioFerrovias); 
			final cteFerroviario = row.readTableOrNull(cteFerroviarios); 

			return CteFerroviarioFerroviaGrouped(
				cteFerroviarioFerrovia: cteFerroviarioFerrovia, 
				cteFerroviario: cteFerroviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteFerroviarioFerroviaGrouped in cteFerroviarioFerroviaGroupedList) {
		//}		

		return cteFerroviarioFerroviaGroupedList;	
	}

	Future<CteFerroviarioFerrovia?> getObject(dynamic pk) async {
		return await (select(cteFerroviarioFerrovias)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteFerroviarioFerrovia?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_ferroviario_ferrovia WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteFerroviarioFerrovia;		 
	} 

	Future<CteFerroviarioFerroviaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteFerroviarioFerroviaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteFerroviarioFerrovia = object.cteFerroviarioFerrovia!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteFerroviarioFerrovias).insert(object.cteFerroviarioFerrovia!);
			object.cteFerroviarioFerrovia = object.cteFerroviarioFerrovia!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteFerroviarioFerroviaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteFerroviarioFerrovias).replace(object.cteFerroviarioFerrovia!);
		});	 
	} 

	Future<int> deleteObject(CteFerroviarioFerroviaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteFerroviarioFerrovias).delete(object.cteFerroviarioFerrovia!);
		});		
	}

	Future<void> insertChildren(CteFerroviarioFerroviaGrouped object) async {
	}
	
	Future<void> deleteChildren(CteFerroviarioFerroviaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_ferroviario_ferrovia").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}