import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

part 'fiscal_parametro_dao.g.dart';

@DriftAccessor(tables: [
	FiscalParametros,
	FiscalInscricoesSubstitutass,
	FiscalEstadualRegimes,
	FiscalEstadualPortes,
	FiscalMunicipalRegimes,
])
class FiscalParametroDao extends DatabaseAccessor<AppDatabase> with _$FiscalParametroDaoMixin {
	final AppDatabase db;

	List<FiscalParametro> fiscalParametroList = []; 
	List<FiscalParametroGrouped> fiscalParametroGroupedList = []; 

	FiscalParametroDao(this.db) : super(db);

	Future<List<FiscalParametro>> getList() async {
		fiscalParametroList = await select(fiscalParametros).get();
		return fiscalParametroList;
	}

	Future<List<FiscalParametro>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		fiscalParametroList = await (select(fiscalParametros)..where((t) => expression)).get();
		return fiscalParametroList;	 
	}

	Future<List<FiscalParametroGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(fiscalParametros)
			.join([ 
				leftOuterJoin(fiscalEstadualRegimes, fiscalEstadualRegimes.id.equalsExp(fiscalParametros.idFiscalEstadualRegime)), 
			]).join([ 
				leftOuterJoin(fiscalEstadualPortes, fiscalEstadualPortes.id.equalsExp(fiscalParametros.idFiscalEstadualPorte)), 
			]).join([ 
				leftOuterJoin(fiscalMunicipalRegimes, fiscalMunicipalRegimes.id.equalsExp(fiscalParametros.idFiscalMunicipalRegime)), 
			]);

		if (field != null && field != '') { 
			final column = fiscalParametros.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		fiscalParametroGroupedList = await query.map((row) {
			final fiscalParametro = row.readTableOrNull(fiscalParametros); 
			final fiscalEstadualRegime = row.readTableOrNull(fiscalEstadualRegimes); 
			final fiscalEstadualPorte = row.readTableOrNull(fiscalEstadualPortes); 
			final fiscalMunicipalRegime = row.readTableOrNull(fiscalMunicipalRegimes); 

			return FiscalParametroGrouped(
				fiscalParametro: fiscalParametro, 
				fiscalEstadualRegime: fiscalEstadualRegime, 
				fiscalEstadualPorte: fiscalEstadualPorte, 
				fiscalMunicipalRegime: fiscalMunicipalRegime, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var fiscalParametroGrouped in fiscalParametroGroupedList) {
			fiscalParametroGrouped.fiscalInscricoesSubstitutasGroupedList = [];
			final queryFiscalInscricoesSubstitutas = ' id_fiscal_parametros = ${fiscalParametroGrouped.fiscalParametro!.id}';
			expression = CustomExpression<bool>(queryFiscalInscricoesSubstitutas);
			final fiscalInscricoesSubstitutasList = await (select(fiscalInscricoesSubstitutass)..where((t) => expression)).get();
			for (var fiscalInscricoesSubstitutas in fiscalInscricoesSubstitutasList) {
				FiscalInscricoesSubstitutasGrouped fiscalInscricoesSubstitutasGrouped = FiscalInscricoesSubstitutasGrouped(
					fiscalInscricoesSubstitutas: fiscalInscricoesSubstitutas,
				);
				fiscalParametroGrouped.fiscalInscricoesSubstitutasGroupedList!.add(fiscalInscricoesSubstitutasGrouped);
			}

		}		

		return fiscalParametroGroupedList;	
	}

	Future<FiscalParametro?> getObject(dynamic pk) async {
		return await (select(fiscalParametros)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FiscalParametro?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM fiscal_parametro WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FiscalParametro;		 
	} 

	Future<FiscalParametroGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FiscalParametroGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.fiscalParametro = object.fiscalParametro!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(fiscalParametros).insert(object.fiscalParametro!);
			object.fiscalParametro = object.fiscalParametro!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FiscalParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(fiscalParametros).replace(object.fiscalParametro!);
		});	 
	} 

	Future<int> deleteObject(FiscalParametroGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(fiscalParametros).delete(object.fiscalParametro!);
		});		
	}

	Future<void> insertChildren(FiscalParametroGrouped object) async {
		for (var fiscalInscricoesSubstitutasGrouped in object.fiscalInscricoesSubstitutasGroupedList!) {
			fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas = fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas?.copyWith(
				id: const Value(null),
				idFiscalParametros: Value(object.fiscalParametro!.id),
			);
			await into(fiscalInscricoesSubstitutass).insert(fiscalInscricoesSubstitutasGrouped.fiscalInscricoesSubstitutas!);
		}
	}
	
	Future<void> deleteChildren(FiscalParametroGrouped object) async {
		await (delete(fiscalInscricoesSubstitutass)..where((t) => t.idFiscalParametros.equals(object.fiscalParametro!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from fiscal_parametro").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}