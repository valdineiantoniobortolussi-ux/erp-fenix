import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_nota_fiscal_entrada_dao.g.dart';

@DriftAccessor(tables: [
	FiscalNotaFiscalEntradas,
	NfeCabecalhos,
])
class FiscalNotaFiscalEntradaDao extends DatabaseAccessor<AppDatabase> with _$FiscalNotaFiscalEntradaDaoMixin {
	final AppDatabase db;

	List<FiscalNotaFiscalEntrada> fiscalNotaFiscalEntradaList = []; 
	List<FiscalNotaFiscalEntradaGrouped> fiscalNotaFiscalEntradaGroupedList = []; 

	FiscalNotaFiscalEntradaDao(this.db) : super(db);

	Future<List<FiscalNotaFiscalEntrada>> getList() async {
		fiscalNotaFiscalEntradaList = await select(fiscalNotaFiscalEntradas).get();
		return fiscalNotaFiscalEntradaList;
	}

	Future<List<FiscalNotaFiscalEntrada>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalNotaFiscalEntradaList = await (select(fiscalNotaFiscalEntradas)..where((t) => expression)).get();
		return fiscalNotaFiscalEntradaList;	 
	}

	Future<List<FiscalNotaFiscalEntradaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalNotaFiscalEntradas)
			.join([ 
				leftOuterJoin(nfeCabecalhos, nfeCabecalhos.id.equalsExp(fiscalNotaFiscalEntradas.idNfeCabecalho)), 
			]);

		if (field != null && field != '') { 
			final column = fiscalNotaFiscalEntradas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalNotaFiscalEntradaGroupedList = await query.map((row) {
			final fiscalNotaFiscalEntrada = row.readTableOrNull(fiscalNotaFiscalEntradas); 
			final nfeCabecalho = row.readTableOrNull(nfeCabecalhos); 

			return FiscalNotaFiscalEntradaGrouped(
				fiscalNotaFiscalEntrada: fiscalNotaFiscalEntrada, 
				nfeCabecalho: nfeCabecalho, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalNotaFiscalEntradaGrouped in fiscalNotaFiscalEntradaGroupedList) {
		//}		

		return fiscalNotaFiscalEntradaGroupedList;	
	}

	Future<FiscalNotaFiscalEntrada?> getObject(dynamic pk) async {
		return await (select(fiscalNotaFiscalEntradas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalNotaFiscalEntrada?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_nota_fiscal_entrada WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalNotaFiscalEntrada;		 
	} 

	Future<FiscalNotaFiscalEntradaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalNotaFiscalEntradaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalNotaFiscalEntrada = object.fiscalNotaFiscalEntrada!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalNotaFiscalEntradas).insert(object.fiscalNotaFiscalEntrada!);
			object.fiscalNotaFiscalEntrada = object.fiscalNotaFiscalEntrada!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalNotaFiscalEntradaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalNotaFiscalEntradas).replace(object.fiscalNotaFiscalEntrada!);
		});	 
	} 

	Future<int> deleteObject(FiscalNotaFiscalEntradaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalNotaFiscalEntradas).delete(object.fiscalNotaFiscalEntrada!);
		});		
	}

	Future<void> insertChildren(FiscalNotaFiscalEntradaGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalNotaFiscalEntradaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_nota_fiscal_entrada").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}