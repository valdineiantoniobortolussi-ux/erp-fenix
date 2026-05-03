import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'ferias_periodo_aquisitivo_dao.g.dart';

@DriftAccessor(tables: [
	FeriasPeriodoAquisitivos,
	ViewPessoaColaboradors,
])
class FeriasPeriodoAquisitivoDao extends DatabaseAccessor<AppDatabase> with _$FeriasPeriodoAquisitivoDaoMixin {
	final AppDatabase db;

	List<FeriasPeriodoAquisitivo> feriasPeriodoAquisitivoList = []; 
	List<FeriasPeriodoAquisitivoGrouped> feriasPeriodoAquisitivoGroupedList = []; 

	FeriasPeriodoAquisitivoDao(this.db) : super(db);

	Future<List<FeriasPeriodoAquisitivo>> getList() async {
		feriasPeriodoAquisitivoList = await select(feriasPeriodoAquisitivos).get();
		return feriasPeriodoAquisitivoList;
	}

	Future<List<FeriasPeriodoAquisitivo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		feriasPeriodoAquisitivoList = await (select(feriasPeriodoAquisitivos)..where((t) => expression)).get();
		return feriasPeriodoAquisitivoList;	 
	}

	Future<List<FeriasPeriodoAquisitivoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(feriasPeriodoAquisitivos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(feriasPeriodoAquisitivos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = feriasPeriodoAquisitivos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		feriasPeriodoAquisitivoGroupedList = await query.map((row) {
			final feriasPeriodoAquisitivo = row.readTableOrNull(feriasPeriodoAquisitivos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FeriasPeriodoAquisitivoGrouped(
				feriasPeriodoAquisitivo: feriasPeriodoAquisitivo, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var feriasPeriodoAquisitivoGrouped in feriasPeriodoAquisitivoGroupedList) {
		//}		

		return feriasPeriodoAquisitivoGroupedList;	
	}

	Future<FeriasPeriodoAquisitivo?> getObject(dynamic pk) async {
		return await (select(feriasPeriodoAquisitivos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FeriasPeriodoAquisitivo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ferias_periodo_aquisitivo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FeriasPeriodoAquisitivo;		 
	} 

	Future<FeriasPeriodoAquisitivoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FeriasPeriodoAquisitivoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.feriasPeriodoAquisitivo = object.feriasPeriodoAquisitivo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(feriasPeriodoAquisitivos).insert(object.feriasPeriodoAquisitivo!);
			object.feriasPeriodoAquisitivo = object.feriasPeriodoAquisitivo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FeriasPeriodoAquisitivoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(feriasPeriodoAquisitivos).replace(object.feriasPeriodoAquisitivo!);
		});	 
	} 

	Future<int> deleteObject(FeriasPeriodoAquisitivoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(feriasPeriodoAquisitivos).delete(object.feriasPeriodoAquisitivo!);
		});		
	}

	Future<void> insertChildren(FeriasPeriodoAquisitivoGrouped object) async {
	}
	
	Future<void> deleteChildren(FeriasPeriodoAquisitivoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ferias_periodo_aquisitivo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}