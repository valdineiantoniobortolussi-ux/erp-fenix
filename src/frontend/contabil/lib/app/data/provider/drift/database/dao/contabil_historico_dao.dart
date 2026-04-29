import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_historico_dao.g.dart';

@DriftAccessor(tables: [
	ContabilHistoricos,
])
class ContabilHistoricoDao extends DatabaseAccessor<AppDatabase> with _$ContabilHistoricoDaoMixin {
	final AppDatabase db;

	List<ContabilHistorico> contabilHistoricoList = []; 
	List<ContabilHistoricoGrouped> contabilHistoricoGroupedList = []; 

	ContabilHistoricoDao(this.db) : super(db);

	Future<List<ContabilHistorico>> getList() async {
		contabilHistoricoList = await select(contabilHistoricos).get();
		return contabilHistoricoList;
	}

	Future<List<ContabilHistorico>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilHistoricoList = await (select(contabilHistoricos)..where((t) => expression)).get();
		return contabilHistoricoList;	 
	}

	Future<List<ContabilHistoricoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilHistoricos)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilHistoricos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilHistoricoGroupedList = await query.map((row) {
			final contabilHistorico = row.readTableOrNull(contabilHistoricos); 

			return ContabilHistoricoGrouped(
				contabilHistorico: contabilHistorico, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilHistoricoGrouped in contabilHistoricoGroupedList) {
		//}		

		return contabilHistoricoGroupedList;	
	}

	Future<ContabilHistorico?> getObject(dynamic pk) async {
		return await (select(contabilHistoricos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilHistorico?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_historico WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilHistorico;		 
	} 

	Future<ContabilHistoricoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilHistoricoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilHistorico = object.contabilHistorico!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilHistoricos).insert(object.contabilHistorico!);
			object.contabilHistorico = object.contabilHistorico!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilHistoricoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilHistoricos).replace(object.contabilHistorico!);
		});	 
	} 

	Future<int> deleteObject(ContabilHistoricoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilHistoricos).delete(object.contabilHistorico!);
		});		
	}

	Future<void> insertChildren(ContabilHistoricoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilHistoricoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_historico").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}