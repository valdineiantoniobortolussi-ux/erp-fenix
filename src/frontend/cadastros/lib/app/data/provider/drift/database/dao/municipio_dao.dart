import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'municipio_dao.g.dart';

@DriftAccessor(tables: [
	Municipios,
	Ufs,
])
class MunicipioDao extends DatabaseAccessor<AppDatabase> with _$MunicipioDaoMixin {
	final AppDatabase db;

	List<Municipio> municipioList = []; 
	List<MunicipioGrouped> municipioGroupedList = []; 

	MunicipioDao(this.db) : super(db);

	Future<List<Municipio>> getList() async {
		municipioList = await select(municipios).get();
		return municipioList;
	}

	Future<List<Municipio>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		municipioList = await (select(municipios)..where((t) => expression)).get();
		return municipioList;	 
	}

	Future<List<MunicipioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(municipios)
			.join([ 
				leftOuterJoin(ufs, ufs.id.equalsExp(municipios.idUf)), 
			]);

		if (field != null && field != '') { 
			final column = municipios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		municipioGroupedList = await query.map((row) {
			final municipio = row.readTableOrNull(municipios); 
			final uf = row.readTableOrNull(ufs); 

			return MunicipioGrouped(
				municipio: municipio, 
				uf: uf, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var municipioGrouped in municipioGroupedList) {
		//}		

		return municipioGroupedList;	
	}

	Future<Municipio?> getObject(dynamic pk) async {
		return await (select(municipios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Municipio?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM municipio WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Municipio;		 
	} 

	Future<MunicipioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MunicipioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.municipio = object.municipio!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(municipios).insert(object.municipio!);
			object.municipio = object.municipio!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MunicipioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(municipios).replace(object.municipio!);
		});	 
	} 

	Future<int> deleteObject(MunicipioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(municipios).delete(object.municipio!);
		});		
	}

	Future<void> insertChildren(MunicipioGrouped object) async {
	}
	
	Future<void> deleteChildren(MunicipioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from municipio").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}