import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

part 'contrato_template_dao.g.dart';

@DriftAccessor(tables: [
	ContratoTemplates,
])
class ContratoTemplateDao extends DatabaseAccessor<AppDatabase> with _$ContratoTemplateDaoMixin {
	final AppDatabase db;

	List<ContratoTemplate> contratoTemplateList = []; 
	List<ContratoTemplateGrouped> contratoTemplateGroupedList = []; 

	ContratoTemplateDao(this.db) : super(db);

	Future<List<ContratoTemplate>> getList() async {
		contratoTemplateList = await select(contratoTemplates).get();
		return contratoTemplateList;
	}

	Future<List<ContratoTemplate>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contratoTemplateList = await (select(contratoTemplates)..where((t) => expression)).get();
		return contratoTemplateList;	 
	}

	Future<List<ContratoTemplateGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contratoTemplates)
			.join([]);

		if (field != null && field != '') { 
			final column = contratoTemplates.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contratoTemplateGroupedList = await query.map((row) {
			final contratoTemplate = row.readTableOrNull(contratoTemplates); 

			return ContratoTemplateGrouped(
				contratoTemplate: contratoTemplate, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contratoTemplateGrouped in contratoTemplateGroupedList) {
		//}		

		return contratoTemplateGroupedList;	
	}

	Future<ContratoTemplate?> getObject(dynamic pk) async {
		return await (select(contratoTemplates)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContratoTemplate?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contrato_template WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContratoTemplate;		 
	} 

	Future<ContratoTemplateGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContratoTemplateGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contratoTemplate = object.contratoTemplate!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contratoTemplates).insert(object.contratoTemplate!);
			object.contratoTemplate = object.contratoTemplate!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContratoTemplateGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contratoTemplates).replace(object.contratoTemplate!);
		});	 
	} 

	Future<int> deleteObject(ContratoTemplateGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contratoTemplates).delete(object.contratoTemplate!);
		});		
	}

	Future<void> insertChildren(ContratoTemplateGrouped object) async {
	}
	
	Future<void> deleteChildren(ContratoTemplateGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contrato_template").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}