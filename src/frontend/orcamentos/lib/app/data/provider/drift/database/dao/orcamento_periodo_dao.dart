import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';
import 'package:orcamentos/app/data/provider/drift/database/database_imports.dart';

part 'orcamento_periodo_dao.g.dart';

@DriftAccessor(tables: [
	OrcamentoPeriodos,
])
class OrcamentoPeriodoDao extends DatabaseAccessor<AppDatabase> with _$OrcamentoPeriodoDaoMixin {
	final AppDatabase db;

	List<OrcamentoPeriodo> orcamentoPeriodoList = []; 
	List<OrcamentoPeriodoGrouped> orcamentoPeriodoGroupedList = []; 

	OrcamentoPeriodoDao(this.db) : super(db);

	Future<List<OrcamentoPeriodo>> getList() async {
		orcamentoPeriodoList = await select(orcamentoPeriodos).get();
		return orcamentoPeriodoList;
	}

	Future<List<OrcamentoPeriodo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		orcamentoPeriodoList = await (select(orcamentoPeriodos)..where((t) => expression)).get();
		return orcamentoPeriodoList;	 
	}

	Future<List<OrcamentoPeriodoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(orcamentoPeriodos)
			.join([]);

		if (field != null && field != '') { 
			final column = orcamentoPeriodos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		orcamentoPeriodoGroupedList = await query.map((row) {
			final orcamentoPeriodo = row.readTableOrNull(orcamentoPeriodos); 

			return OrcamentoPeriodoGrouped(
				orcamentoPeriodo: orcamentoPeriodo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var orcamentoPeriodoGrouped in orcamentoPeriodoGroupedList) {
		//}		

		return orcamentoPeriodoGroupedList;	
	}

	Future<OrcamentoPeriodo?> getObject(dynamic pk) async {
		return await (select(orcamentoPeriodos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OrcamentoPeriodo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM orcamento_periodo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OrcamentoPeriodo;		 
	} 

	Future<OrcamentoPeriodoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OrcamentoPeriodoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.orcamentoPeriodo = object.orcamentoPeriodo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(orcamentoPeriodos).insert(object.orcamentoPeriodo!);
			object.orcamentoPeriodo = object.orcamentoPeriodo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OrcamentoPeriodoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(orcamentoPeriodos).replace(object.orcamentoPeriodo!);
		});	 
	} 

	Future<int> deleteObject(OrcamentoPeriodoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(orcamentoPeriodos).delete(object.orcamentoPeriodo!);
		});		
	}

	Future<void> insertChildren(OrcamentoPeriodoGrouped object) async {
	}
	
	Future<void> deleteChildren(OrcamentoPeriodoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from orcamento_periodo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}