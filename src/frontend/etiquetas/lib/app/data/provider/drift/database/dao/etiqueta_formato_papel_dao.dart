import 'package:drift/drift.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';
import 'package:etiquetas/app/data/provider/drift/database/database_imports.dart';

part 'etiqueta_formato_papel_dao.g.dart';

@DriftAccessor(tables: [
	EtiquetaFormatoPapels,
])
class EtiquetaFormatoPapelDao extends DatabaseAccessor<AppDatabase> with _$EtiquetaFormatoPapelDaoMixin {
	final AppDatabase db;

	List<EtiquetaFormatoPapel> etiquetaFormatoPapelList = []; 
	List<EtiquetaFormatoPapelGrouped> etiquetaFormatoPapelGroupedList = []; 

	EtiquetaFormatoPapelDao(this.db) : super(db);

	Future<List<EtiquetaFormatoPapel>> getList() async {
		etiquetaFormatoPapelList = await select(etiquetaFormatoPapels).get();
		return etiquetaFormatoPapelList;
	}

	Future<List<EtiquetaFormatoPapel>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		etiquetaFormatoPapelList = await (select(etiquetaFormatoPapels)..where((t) => expression)).get();
		return etiquetaFormatoPapelList;	 
	}

	Future<List<EtiquetaFormatoPapelGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(etiquetaFormatoPapels)
			.join([]);

		if (field != null && field != '') { 
			final column = etiquetaFormatoPapels.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		etiquetaFormatoPapelGroupedList = await query.map((row) {
			final etiquetaFormatoPapel = row.readTableOrNull(etiquetaFormatoPapels); 

			return EtiquetaFormatoPapelGrouped(
				etiquetaFormatoPapel: etiquetaFormatoPapel, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var etiquetaFormatoPapelGrouped in etiquetaFormatoPapelGroupedList) {
		//}		

		return etiquetaFormatoPapelGroupedList;	
	}

	Future<EtiquetaFormatoPapel?> getObject(dynamic pk) async {
		return await (select(etiquetaFormatoPapels)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EtiquetaFormatoPapel?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM etiqueta_formato_papel WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EtiquetaFormatoPapel;		 
	} 

	Future<EtiquetaFormatoPapelGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EtiquetaFormatoPapelGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.etiquetaFormatoPapel = object.etiquetaFormatoPapel!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(etiquetaFormatoPapels).insert(object.etiquetaFormatoPapel!);
			object.etiquetaFormatoPapel = object.etiquetaFormatoPapel!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EtiquetaFormatoPapelGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(etiquetaFormatoPapels).replace(object.etiquetaFormatoPapel!);
		});	 
	} 

	Future<int> deleteObject(EtiquetaFormatoPapelGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(etiquetaFormatoPapels).delete(object.etiquetaFormatoPapel!);
		});		
	}

	Future<void> insertChildren(EtiquetaFormatoPapelGrouped object) async {
	}
	
	Future<void> deleteChildren(EtiquetaFormatoPapelGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from etiqueta_formato_papel").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}