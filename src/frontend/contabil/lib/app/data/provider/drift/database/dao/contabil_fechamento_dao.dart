import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_fechamento_dao.g.dart';

@DriftAccessor(tables: [
	ContabilFechamentos,
])
class ContabilFechamentoDao extends DatabaseAccessor<AppDatabase> with _$ContabilFechamentoDaoMixin {
	final AppDatabase db;

	List<ContabilFechamento> contabilFechamentoList = []; 
	List<ContabilFechamentoGrouped> contabilFechamentoGroupedList = []; 

	ContabilFechamentoDao(this.db) : super(db);

	Future<List<ContabilFechamento>> getList() async {
		contabilFechamentoList = await select(contabilFechamentos).get();
		return contabilFechamentoList;
	}

	Future<List<ContabilFechamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilFechamentoList = await (select(contabilFechamentos)..where((t) => expression)).get();
		return contabilFechamentoList;	 
	}

	Future<List<ContabilFechamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilFechamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilFechamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilFechamentoGroupedList = await query.map((row) {
			final contabilFechamento = row.readTableOrNull(contabilFechamentos); 

			return ContabilFechamentoGrouped(
				contabilFechamento: contabilFechamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilFechamentoGrouped in contabilFechamentoGroupedList) {
		//}		

		return contabilFechamentoGroupedList;	
	}

	Future<ContabilFechamento?> getObject(dynamic pk) async {
		return await (select(contabilFechamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilFechamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_fechamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilFechamento;		 
	} 

	Future<ContabilFechamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilFechamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilFechamento = object.contabilFechamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilFechamentos).insert(object.contabilFechamento!);
			object.contabilFechamento = object.contabilFechamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilFechamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilFechamentos).replace(object.contabilFechamento!);
		});	 
	} 

	Future<int> deleteObject(ContabilFechamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilFechamentos).delete(object.contabilFechamento!);
		});		
	}

	Future<void> insertChildren(ContabilFechamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilFechamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_fechamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}