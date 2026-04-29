import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_lancamento_padrao_dao.g.dart';

@DriftAccessor(tables: [
	ContabilLancamentoPadraos,
])
class ContabilLancamentoPadraoDao extends DatabaseAccessor<AppDatabase> with _$ContabilLancamentoPadraoDaoMixin {
	final AppDatabase db;

	List<ContabilLancamentoPadrao> contabilLancamentoPadraoList = []; 
	List<ContabilLancamentoPadraoGrouped> contabilLancamentoPadraoGroupedList = []; 

	ContabilLancamentoPadraoDao(this.db) : super(db);

	Future<List<ContabilLancamentoPadrao>> getList() async {
		contabilLancamentoPadraoList = await select(contabilLancamentoPadraos).get();
		return contabilLancamentoPadraoList;
	}

	Future<List<ContabilLancamentoPadrao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilLancamentoPadraoList = await (select(contabilLancamentoPadraos)..where((t) => expression)).get();
		return contabilLancamentoPadraoList;	 
	}

	Future<List<ContabilLancamentoPadraoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilLancamentoPadraos)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilLancamentoPadraos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilLancamentoPadraoGroupedList = await query.map((row) {
			final contabilLancamentoPadrao = row.readTableOrNull(contabilLancamentoPadraos); 

			return ContabilLancamentoPadraoGrouped(
				contabilLancamentoPadrao: contabilLancamentoPadrao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contabilLancamentoPadraoGrouped in contabilLancamentoPadraoGroupedList) {
		//}		

		return contabilLancamentoPadraoGroupedList;	
	}

	Future<ContabilLancamentoPadrao?> getObject(dynamic pk) async {
		return await (select(contabilLancamentoPadraos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilLancamentoPadrao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_lancamento_padrao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilLancamentoPadrao;		 
	} 

	Future<ContabilLancamentoPadraoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilLancamentoPadraoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilLancamentoPadrao = object.contabilLancamentoPadrao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilLancamentoPadraos).insert(object.contabilLancamentoPadrao!);
			object.contabilLancamentoPadrao = object.contabilLancamentoPadrao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilLancamentoPadraoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilLancamentoPadraos).replace(object.contabilLancamentoPadrao!);
		});	 
	} 

	Future<int> deleteObject(ContabilLancamentoPadraoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilLancamentoPadraos).delete(object.contabilLancamentoPadrao!);
		});		
	}

	Future<void> insertChildren(ContabilLancamentoPadraoGrouped object) async {
	}
	
	Future<void> deleteChildren(ContabilLancamentoPadraoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_lancamento_padrao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}