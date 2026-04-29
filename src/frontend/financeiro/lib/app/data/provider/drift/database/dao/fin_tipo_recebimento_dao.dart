import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';
import 'package:financeiro/app/data/provider/drift/database/database_imports.dart';

part 'fin_tipo_recebimento_dao.g.dart';

@DriftAccessor(tables: [
	FinTipoRecebimentos,
])
class FinTipoRecebimentoDao extends DatabaseAccessor<AppDatabase> with _$FinTipoRecebimentoDaoMixin {
	final AppDatabase db;

	List<FinTipoRecebimento> finTipoRecebimentoList = []; 
	List<FinTipoRecebimentoGrouped> finTipoRecebimentoGroupedList = []; 

	FinTipoRecebimentoDao(this.db) : super(db);

	Future<List<FinTipoRecebimento>> getList() async {
		finTipoRecebimentoList = await select(finTipoRecebimentos).get();
		return finTipoRecebimentoList;
	}

	Future<List<FinTipoRecebimento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		finTipoRecebimentoList = await (select(finTipoRecebimentos)..where((t) => expression)).get();
		return finTipoRecebimentoList;	 
	}

	Future<List<FinTipoRecebimentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(finTipoRecebimentos)
			.join([]);

		if (field != null && field != '') { 
			final column = finTipoRecebimentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		finTipoRecebimentoGroupedList = await query.map((row) {
			final finTipoRecebimento = row.readTableOrNull(finTipoRecebimentos); 

			return FinTipoRecebimentoGrouped(
				finTipoRecebimento: finTipoRecebimento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var finTipoRecebimentoGrouped in finTipoRecebimentoGroupedList) {
		//}		

		return finTipoRecebimentoGroupedList;	
	}

	Future<FinTipoRecebimento?> getObject(dynamic pk) async {
		return await (select(finTipoRecebimentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FinTipoRecebimento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fin_tipo_recebimento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FinTipoRecebimento;		 
	} 

	Future<FinTipoRecebimentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FinTipoRecebimentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.finTipoRecebimento = object.finTipoRecebimento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(finTipoRecebimentos).insert(object.finTipoRecebimento!);
			object.finTipoRecebimento = object.finTipoRecebimento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FinTipoRecebimentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(finTipoRecebimentos).replace(object.finTipoRecebimento!);
		});	 
	} 

	Future<int> deleteObject(FinTipoRecebimentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(finTipoRecebimentos).delete(object.finTipoRecebimento!);
		});		
	}

	Future<void> insertChildren(FinTipoRecebimentoGrouped object) async {
	}
	
	Future<void> deleteChildren(FinTipoRecebimentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fin_tipo_recebimento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}