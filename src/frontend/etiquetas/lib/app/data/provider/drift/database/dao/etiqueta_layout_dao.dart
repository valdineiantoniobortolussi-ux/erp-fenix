import 'package:drift/drift.dart';
import 'package:etiquetas/app/data/provider/drift/database/database.dart';
import 'package:etiquetas/app/data/provider/drift/database/database_imports.dart';

part 'etiqueta_layout_dao.g.dart';

@DriftAccessor(tables: [
	EtiquetaLayouts,
	EtiquetaTemplates,
	EtiquetaFormatoPapels,
])
class EtiquetaLayoutDao extends DatabaseAccessor<AppDatabase> with _$EtiquetaLayoutDaoMixin {
	final AppDatabase db;

	List<EtiquetaLayout> etiquetaLayoutList = []; 
	List<EtiquetaLayoutGrouped> etiquetaLayoutGroupedList = []; 

	EtiquetaLayoutDao(this.db) : super(db);

	Future<List<EtiquetaLayout>> getList() async {
		etiquetaLayoutList = await select(etiquetaLayouts).get();
		return etiquetaLayoutList;
	}

	Future<List<EtiquetaLayout>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		etiquetaLayoutList = await (select(etiquetaLayouts)..where((t) => expression)).get();
		return etiquetaLayoutList;	 
	}

	Future<List<EtiquetaLayoutGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(etiquetaLayouts)
			.join([ 
				leftOuterJoin(etiquetaFormatoPapels, etiquetaFormatoPapels.id.equalsExp(etiquetaLayouts.idFormatoPapel)), 
			]);

		if (field != null && field != '') { 
			final column = etiquetaLayouts.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		etiquetaLayoutGroupedList = await query.map((row) {
			final etiquetaLayout = row.readTableOrNull(etiquetaLayouts); 
			final etiquetaFormatoPapel = row.readTableOrNull(etiquetaFormatoPapels); 

			return EtiquetaLayoutGrouped(
				etiquetaLayout: etiquetaLayout, 
				etiquetaFormatoPapel: etiquetaFormatoPapel, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var etiquetaLayoutGrouped in etiquetaLayoutGroupedList) {
			etiquetaLayoutGrouped.etiquetaTemplateGroupedList = [];
			final queryEtiquetaTemplate = ' id_etiqueta_layout = ${etiquetaLayoutGrouped.etiquetaLayout!.id}';
			expression = CustomExpression<bool>(queryEtiquetaTemplate);
			final etiquetaTemplateList = await (select(etiquetaTemplates)..where((t) => expression)).get();
			for (var etiquetaTemplate in etiquetaTemplateList) {
				EtiquetaTemplateGrouped etiquetaTemplateGrouped = EtiquetaTemplateGrouped(
					etiquetaTemplate: etiquetaTemplate,
				);
				etiquetaLayoutGrouped.etiquetaTemplateGroupedList!.add(etiquetaTemplateGrouped);
			}

		}		

		return etiquetaLayoutGroupedList;	
	}

	Future<EtiquetaLayout?> getObject(dynamic pk) async {
		return await (select(etiquetaLayouts)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EtiquetaLayout?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM etiqueta_layout WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EtiquetaLayout;		 
	} 

	Future<EtiquetaLayoutGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EtiquetaLayoutGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.etiquetaLayout = object.etiquetaLayout!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(etiquetaLayouts).insert(object.etiquetaLayout!);
			object.etiquetaLayout = object.etiquetaLayout!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EtiquetaLayoutGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(etiquetaLayouts).replace(object.etiquetaLayout!);
		});	 
	} 

	Future<int> deleteObject(EtiquetaLayoutGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(etiquetaLayouts).delete(object.etiquetaLayout!);
		});		
	}

	Future<void> insertChildren(EtiquetaLayoutGrouped object) async {
		for (var etiquetaTemplateGrouped in object.etiquetaTemplateGroupedList!) {
			etiquetaTemplateGrouped.etiquetaTemplate = etiquetaTemplateGrouped.etiquetaTemplate?.copyWith(
				id: const Value(null),
				idEtiquetaLayout: Value(object.etiquetaLayout!.id),
			);
			await into(etiquetaTemplates).insert(etiquetaTemplateGrouped.etiquetaTemplate!);
		}
	}
	
	Future<void> deleteChildren(EtiquetaLayoutGrouped object) async {
		await (delete(etiquetaTemplates)..where((t) => t.idEtiquetaLayout.equals(object.etiquetaLayout!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from etiqueta_layout").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}