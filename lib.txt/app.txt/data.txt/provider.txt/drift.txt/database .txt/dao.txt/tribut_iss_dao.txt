import 'package:drift/drift.dart';
import 'package:tributacao/app/data/provider/drift/database/database.dart';
import 'package:tributacao/app/data/provider/drift/database/database_imports.dart';

part 'tribut_iss_dao.g.dart';

@DriftAccessor(tables: [
	TributIsss,
	TributOperacaoFiscals,
])
class TributIssDao extends DatabaseAccessor<AppDatabase> with _$TributIssDaoMixin {
	final AppDatabase db;

	List<TributIss> tributIssList = []; 
	List<TributIssGrouped> tributIssGroupedList = []; 

	TributIssDao(this.db) : super(db);

	Future<List<TributIss>> getList() async {
		tributIssList = await select(tributIsss).get();
		return tributIssList;
	}

	Future<List<TributIss>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tributIssList = await (select(tributIsss)..where((t) => expression)).get();
		return tributIssList;	 
	}

	Future<List<TributIssGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tributIsss)
			.join([ 
				leftOuterJoin(tributOperacaoFiscals, tributOperacaoFiscals.id.equalsExp(tributIsss.idTributOperacaoFiscal)), 
			]);

		if (field != null && field != '') { 
			final column = tributIsss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tributIssGroupedList = await query.map((row) {
			final tributIss = row.readTableOrNull(tributIsss); 
			final tributOperacaoFiscal = row.readTableOrNull(tributOperacaoFiscals); 

			return TributIssGrouped(
				tributIss: tributIss, 
				tributOperacaoFiscal: tributOperacaoFiscal, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tributIssGrouped in tributIssGroupedList) {
		//}		

		return tributIssGroupedList;	
	}

	Future<TributIss?> getObject(dynamic pk) async {
		return await (select(tributIsss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TributIss?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tribut_iss WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TributIss;		 
	} 

	Future<TributIssGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TributIssGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tributIss = object.tributIss!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tributIsss).insert(object.tributIss!);
			object.tributIss = object.tributIss!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TributIssGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tributIsss).replace(object.tributIss!);
		});	 
	} 

	Future<int> deleteObject(TributIssGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tributIsss).delete(object.tributIss!);
		});		
	}

	Future<void> insertChildren(TributIssGrouped object) async {
	}
	
	Future<void> deleteChildren(TributIssGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tribut_iss").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}