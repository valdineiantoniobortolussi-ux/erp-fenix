import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_fechamento_dao.g.dart';

@DriftAccessor(tables: [
	FolhaFechamentos,
])
class FolhaFechamentoDao extends DatabaseAccessor<AppDatabase> with _$FolhaFechamentoDaoMixin {
	final AppDatabase db;

	List<FolhaFechamento> folhaFechamentoList = []; 
	List<FolhaFechamentoGrouped> folhaFechamentoGroupedList = []; 

	FolhaFechamentoDao(this.db) : super(db);

	Future<List<FolhaFechamento>> getList() async {
		folhaFechamentoList = await select(folhaFechamentos).get();
		return folhaFechamentoList;
	}

	Future<List<FolhaFechamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaFechamentoList = await (select(folhaFechamentos)..where((t) => expression)).get();
		return folhaFechamentoList;	 
	}

	Future<List<FolhaFechamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaFechamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = folhaFechamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaFechamentoGroupedList = await query.map((row) {
			final folhaFechamento = row.readTableOrNull(folhaFechamentos); 

			return FolhaFechamentoGrouped(
				folhaFechamento: folhaFechamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaFechamentoGrouped in folhaFechamentoGroupedList) {
		//}		

		return folhaFechamentoGroupedList;	
	}

	Future<FolhaFechamento?> getObject(dynamic pk) async {
		return await (select(folhaFechamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaFechamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_fechamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaFechamento;		 
	} 

	Future<FolhaFechamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaFechamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaFechamento = object.folhaFechamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaFechamentos).insert(object.folhaFechamento!);
			object.folhaFechamento = object.folhaFechamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaFechamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaFechamentos).replace(object.folhaFechamento!);
		});	 
	} 

	Future<int> deleteObject(FolhaFechamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaFechamentos).delete(object.folhaFechamento!);
		});		
	}

	Future<void> insertChildren(FolhaFechamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaFechamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_fechamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}