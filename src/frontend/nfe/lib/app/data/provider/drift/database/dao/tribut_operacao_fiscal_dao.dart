import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'tribut_operacao_fiscal_dao.g.dart';

@DriftAccessor(tables: [
	TributOperacaoFiscals,
])
class TributOperacaoFiscalDao extends DatabaseAccessor<AppDatabase> with _$TributOperacaoFiscalDaoMixin {
	final AppDatabase db;

	List<TributOperacaoFiscal> tributOperacaoFiscalList = []; 
	List<TributOperacaoFiscalGrouped> tributOperacaoFiscalGroupedList = []; 

	TributOperacaoFiscalDao(this.db) : super(db);

	Future<List<TributOperacaoFiscal>> getList() async {
		tributOperacaoFiscalList = await select(tributOperacaoFiscals).get();
		return tributOperacaoFiscalList;
	}

	Future<List<TributOperacaoFiscal>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tributOperacaoFiscalList = await (select(tributOperacaoFiscals)..where((t) => expression)).get();
		return tributOperacaoFiscalList;	 
	}

	Future<List<TributOperacaoFiscalGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tributOperacaoFiscals)
			.join([]);

		if (field != null && field != '') { 
			final column = tributOperacaoFiscals.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tributOperacaoFiscalGroupedList = await query.map((row) {
			final tributOperacaoFiscal = row.readTableOrNull(tributOperacaoFiscals); 

			return TributOperacaoFiscalGrouped(
				tributOperacaoFiscal: tributOperacaoFiscal, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tributOperacaoFiscalGrouped in tributOperacaoFiscalGroupedList) {
		//}		

		return tributOperacaoFiscalGroupedList;	
	}

	Future<TributOperacaoFiscal?> getObject(dynamic pk) async {
		return await (select(tributOperacaoFiscals)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TributOperacaoFiscal?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tribut_operacao_fiscal WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TributOperacaoFiscal;		 
	} 

	Future<TributOperacaoFiscalGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TributOperacaoFiscalGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tributOperacaoFiscal = object.tributOperacaoFiscal!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tributOperacaoFiscals).insert(object.tributOperacaoFiscal!);
			object.tributOperacaoFiscal = object.tributOperacaoFiscal!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TributOperacaoFiscalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tributOperacaoFiscals).replace(object.tributOperacaoFiscal!);
		});	 
	} 

	Future<int> deleteObject(TributOperacaoFiscalGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tributOperacaoFiscals).delete(object.tributOperacaoFiscal!);
		});		
	}

	Future<void> insertChildren(TributOperacaoFiscalGrouped object) async {
	}
	
	Future<void> deleteChildren(TributOperacaoFiscalGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tribut_operacao_fiscal").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}