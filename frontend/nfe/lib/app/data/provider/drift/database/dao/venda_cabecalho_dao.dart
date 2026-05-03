import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'venda_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	VendaCabecalhos,
])
class VendaCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$VendaCabecalhoDaoMixin {
	final AppDatabase db;

	List<VendaCabecalho> vendaCabecalhoList = []; 
	List<VendaCabecalhoGrouped> vendaCabecalhoGroupedList = []; 

	VendaCabecalhoDao(this.db) : super(db);

	Future<List<VendaCabecalho>> getList() async {
		vendaCabecalhoList = await select(vendaCabecalhos).get();
		return vendaCabecalhoList;
	}

	Future<List<VendaCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		vendaCabecalhoList = await (select(vendaCabecalhos)..where((t) => expression)).get();
		return vendaCabecalhoList;	 
	}

	Future<List<VendaCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(vendaCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = vendaCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		vendaCabecalhoGroupedList = await query.map((row) {
			final vendaCabecalho = row.readTableOrNull(vendaCabecalhos); 

			return VendaCabecalhoGrouped(
				vendaCabecalho: vendaCabecalho, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var vendaCabecalhoGrouped in vendaCabecalhoGroupedList) {
		//}		

		return vendaCabecalhoGroupedList;	
	}

	Future<VendaCabecalho?> getObject(dynamic pk) async {
		return await (select(vendaCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<VendaCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM venda_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as VendaCabecalho;		 
	} 

	Future<VendaCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.vendaCabecalho = object.vendaCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(vendaCabecalhos).insert(object.vendaCabecalho!);
			object.vendaCabecalho = object.vendaCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(vendaCabecalhos).replace(object.vendaCabecalho!);
		});	 
	} 

	Future<int> deleteObject(VendaCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(vendaCabecalhos).delete(object.vendaCabecalho!);
		});		
	}

	Future<void> insertChildren(VendaCabecalhoGrouped object) async {
	}
	
	Future<void> deleteChildren(VendaCabecalhoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from venda_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}