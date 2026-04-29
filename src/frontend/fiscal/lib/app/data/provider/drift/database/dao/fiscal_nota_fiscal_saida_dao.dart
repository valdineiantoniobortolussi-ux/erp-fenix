import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_nota_fiscal_saida_dao.g.dart';

@DriftAccessor(tables: [
	FiscalNotaFiscalSaidas,
	NfeCabecalhos,
])
class FiscalNotaFiscalSaidaDao extends DatabaseAccessor<AppDatabase> with _$FiscalNotaFiscalSaidaDaoMixin {
	final AppDatabase db;

	List<FiscalNotaFiscalSaida> fiscalNotaFiscalSaidaList = []; 
	List<FiscalNotaFiscalSaidaGrouped> fiscalNotaFiscalSaidaGroupedList = []; 

	FiscalNotaFiscalSaidaDao(this.db) : super(db);

	Future<List<FiscalNotaFiscalSaida>> getList() async {
		fiscalNotaFiscalSaidaList = await select(fiscalNotaFiscalSaidas).get();
		return fiscalNotaFiscalSaidaList;
	}

	Future<List<FiscalNotaFiscalSaida>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalNotaFiscalSaidaList = await (select(fiscalNotaFiscalSaidas)..where((t) => expression)).get();
		return fiscalNotaFiscalSaidaList;	 
	}

	Future<List<FiscalNotaFiscalSaidaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalNotaFiscalSaidas)
			.join([ 
				leftOuterJoin(nfeCabecalhos, nfeCabecalhos.id.equalsExp(fiscalNotaFiscalSaidas.idNfeCabecalho)), 
			]);

		if (field != null && field != '') { 
			final column = fiscalNotaFiscalSaidas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalNotaFiscalSaidaGroupedList = await query.map((row) {
			final fiscalNotaFiscalSaida = row.readTableOrNull(fiscalNotaFiscalSaidas); 
			final nfeCabecalho = row.readTableOrNull(nfeCabecalhos); 

			return FiscalNotaFiscalSaidaGrouped(
				fiscalNotaFiscalSaida: fiscalNotaFiscalSaida, 
				nfeCabecalho: nfeCabecalho, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var fiscalNotaFiscalSaidaGrouped in fiscalNotaFiscalSaidaGroupedList) {
		//}		

		return fiscalNotaFiscalSaidaGroupedList;	
	}

	Future<FiscalNotaFiscalSaida?> getObject(dynamic pk) async {
		return await (select(fiscalNotaFiscalSaidas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalNotaFiscalSaida?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_nota_fiscal_saida WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalNotaFiscalSaida;		 
	} 

	Future<FiscalNotaFiscalSaidaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalNotaFiscalSaidaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalNotaFiscalSaida = object.fiscalNotaFiscalSaida!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalNotaFiscalSaidas).insert(object.fiscalNotaFiscalSaida!);
			object.fiscalNotaFiscalSaida = object.fiscalNotaFiscalSaida!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalNotaFiscalSaidaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalNotaFiscalSaidas).replace(object.fiscalNotaFiscalSaida!);
		});	 
	} 

	Future<int> deleteObject(FiscalNotaFiscalSaidaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalNotaFiscalSaidas).delete(object.fiscalNotaFiscalSaida!);
		});		
	}

	Future<void> insertChildren(FiscalNotaFiscalSaidaGrouped object) async {
	}
	
	Future<void> deleteChildren(FiscalNotaFiscalSaidaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_nota_fiscal_saida").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}