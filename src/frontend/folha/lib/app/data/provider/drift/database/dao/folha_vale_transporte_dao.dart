import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_vale_transporte_dao.g.dart';

@DriftAccessor(tables: [
	FolhaValeTransportes,
	ViewPessoaColaboradors,
	EmpresaTransporteItinerarios,
])
class FolhaValeTransporteDao extends DatabaseAccessor<AppDatabase> with _$FolhaValeTransporteDaoMixin {
	final AppDatabase db;

	List<FolhaValeTransporte> folhaValeTransporteList = []; 
	List<FolhaValeTransporteGrouped> folhaValeTransporteGroupedList = []; 

	FolhaValeTransporteDao(this.db) : super(db);

	Future<List<FolhaValeTransporte>> getList() async {
		folhaValeTransporteList = await select(folhaValeTransportes).get();
		return folhaValeTransporteList;
	}

	Future<List<FolhaValeTransporte>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaValeTransporteList = await (select(folhaValeTransportes)..where((t) => expression)).get();
		return folhaValeTransporteList;	 
	}

	Future<List<FolhaValeTransporteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaValeTransportes)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaValeTransportes.idColaborador)), 
			]).join([ 
				leftOuterJoin(empresaTransporteItinerarios, empresaTransporteItinerarios.id.equalsExp(folhaValeTransportes.idEmpresaTranspItin)), 
			]);

		if (field != null && field != '') { 
			final column = folhaValeTransportes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaValeTransporteGroupedList = await query.map((row) {
			final folhaValeTransporte = row.readTableOrNull(folhaValeTransportes); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 
			final empresaTransporteItinerario = row.readTableOrNull(empresaTransporteItinerarios); 

			return FolhaValeTransporteGrouped(
				folhaValeTransporte: folhaValeTransporte, 
				viewPessoaColaborador: viewPessoaColaborador, 
				empresaTransporteItinerario: empresaTransporteItinerario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaValeTransporteGrouped in folhaValeTransporteGroupedList) {
		//}		

		return folhaValeTransporteGroupedList;	
	}

	Future<FolhaValeTransporte?> getObject(dynamic pk) async {
		return await (select(folhaValeTransportes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaValeTransporte?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_vale_transporte WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaValeTransporte;		 
	} 

	Future<FolhaValeTransporteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaValeTransporteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaValeTransporte = object.folhaValeTransporte!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaValeTransportes).insert(object.folhaValeTransporte!);
			object.folhaValeTransporte = object.folhaValeTransporte!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaValeTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaValeTransportes).replace(object.folhaValeTransporte!);
		});	 
	} 

	Future<int> deleteObject(FolhaValeTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaValeTransportes).delete(object.folhaValeTransporte!);
		});		
	}

	Future<void> insertChildren(FolhaValeTransporteGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaValeTransporteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_vale_transporte").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}