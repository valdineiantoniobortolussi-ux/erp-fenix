import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';
import 'package:cte/app/data/provider/drift/database/database_imports.dart';

part 'cte_ferroviario_vagao_dao.g.dart';

@DriftAccessor(tables: [
	CteFerroviarioVagaos,
	CteFerroviarios,
])
class CteFerroviarioVagaoDao extends DatabaseAccessor<AppDatabase> with _$CteFerroviarioVagaoDaoMixin {
	final AppDatabase db;

	List<CteFerroviarioVagao> cteFerroviarioVagaoList = []; 
	List<CteFerroviarioVagaoGrouped> cteFerroviarioVagaoGroupedList = []; 

	CteFerroviarioVagaoDao(this.db) : super(db);

	Future<List<CteFerroviarioVagao>> getList() async {
		cteFerroviarioVagaoList = await select(cteFerroviarioVagaos).get();
		return cteFerroviarioVagaoList;
	}

	Future<List<CteFerroviarioVagao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		cteFerroviarioVagaoList = await (select(cteFerroviarioVagaos)..where((t) => expression)).get();
		return cteFerroviarioVagaoList;	 
	}

	Future<List<CteFerroviarioVagaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(cteFerroviarioVagaos)
			.join([ 
				leftOuterJoin(cteFerroviarios, cteFerroviarios.id.equalsExp(cteFerroviarioVagaos.idCteFerroviario)), 
			]);

		if (field != null && field != '') { 
			final column = cteFerroviarioVagaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		cteFerroviarioVagaoGroupedList = await query.map((row) {
			final cteFerroviarioVagao = row.readTableOrNull(cteFerroviarioVagaos); 
			final cteFerroviario = row.readTableOrNull(cteFerroviarios); 

			return CteFerroviarioVagaoGrouped(
				cteFerroviarioVagao: cteFerroviarioVagao, 
				cteFerroviario: cteFerroviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var cteFerroviarioVagaoGrouped in cteFerroviarioVagaoGroupedList) {
		//}		

		return cteFerroviarioVagaoGroupedList;	
	}

	Future<CteFerroviarioVagao?> getObject(dynamic pk) async {
		return await (select(cteFerroviarioVagaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CteFerroviarioVagao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM cte_ferroviario_vagao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CteFerroviarioVagao;		 
	} 

	Future<CteFerroviarioVagaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CteFerroviarioVagaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.cteFerroviarioVagao = object.cteFerroviarioVagao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(cteFerroviarioVagaos).insert(object.cteFerroviarioVagao!);
			object.cteFerroviarioVagao = object.cteFerroviarioVagao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CteFerroviarioVagaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(cteFerroviarioVagaos).replace(object.cteFerroviarioVagao!);
		});	 
	} 

	Future<int> deleteObject(CteFerroviarioVagaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(cteFerroviarioVagaos).delete(object.cteFerroviarioVagao!);
		});		
	}

	Future<void> insertChildren(CteFerroviarioVagaoGrouped object) async {
	}
	
	Future<void> deleteChildren(CteFerroviarioVagaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from cte_ferroviario_vagao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}