import 'package:drift/drift.dart';
import 'package:ged/app/data/provider/drift/database/database.dart';
import 'package:ged/app/data/provider/drift/database/database_imports.dart';

part 'ged_documento_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	GedDocumentoCabecalhos,
	GedDocumentoDetalhes,
	GedTipoDocumentos,
])
class GedDocumentoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$GedDocumentoCabecalhoDaoMixin {
	final AppDatabase db;

	List<GedDocumentoCabecalho> gedDocumentoCabecalhoList = []; 
	List<GedDocumentoCabecalhoGrouped> gedDocumentoCabecalhoGroupedList = []; 

	GedDocumentoCabecalhoDao(this.db) : super(db);

	Future<List<GedDocumentoCabecalho>> getList() async {
		gedDocumentoCabecalhoList = await select(gedDocumentoCabecalhos).get();
		return gedDocumentoCabecalhoList;
	}

	Future<List<GedDocumentoCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		gedDocumentoCabecalhoList = await (select(gedDocumentoCabecalhos)..where((t) => expression)).get();
		return gedDocumentoCabecalhoList;	 
	}

	Future<List<GedDocumentoCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(gedDocumentoCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = gedDocumentoCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		gedDocumentoCabecalhoGroupedList = await query.map((row) {
			final gedDocumentoCabecalho = row.readTableOrNull(gedDocumentoCabecalhos); 

			return GedDocumentoCabecalhoGrouped(
				gedDocumentoCabecalho: gedDocumentoCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var gedDocumentoCabecalhoGrouped in gedDocumentoCabecalhoGroupedList) {
			gedDocumentoCabecalhoGrouped.gedDocumentoDetalheGroupedList = [];
			final queryGedDocumentoDetalhe = ' id_ged_documento_cabecalho = ${gedDocumentoCabecalhoGrouped.gedDocumentoCabecalho!.id}';
			expression = CustomExpression<bool>(queryGedDocumentoDetalhe);
			final gedDocumentoDetalheList = await (select(gedDocumentoDetalhes)..where((t) => expression)).get();
			for (var gedDocumentoDetalhe in gedDocumentoDetalheList) {
				GedDocumentoDetalheGrouped gedDocumentoDetalheGrouped = GedDocumentoDetalheGrouped(
					gedDocumentoDetalhe: gedDocumentoDetalhe,
					gedTipoDocumento: await (select(gedTipoDocumentos)..where((t) => t.id.equals(gedDocumentoDetalhe.idGedTipoDocumento!))).getSingleOrNull(),
				);
				gedDocumentoCabecalhoGrouped.gedDocumentoDetalheGroupedList!.add(gedDocumentoDetalheGrouped);
			}

		}		

		return gedDocumentoCabecalhoGroupedList;	
	}

	Future<GedDocumentoCabecalho?> getObject(dynamic pk) async {
		return await (select(gedDocumentoCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<GedDocumentoCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM ged_documento_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as GedDocumentoCabecalho;		 
	} 

	Future<GedDocumentoCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(GedDocumentoCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.gedDocumentoCabecalho = object.gedDocumentoCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(gedDocumentoCabecalhos).insert(object.gedDocumentoCabecalho!);
			object.gedDocumentoCabecalho = object.gedDocumentoCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(GedDocumentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(gedDocumentoCabecalhos).replace(object.gedDocumentoCabecalho!);
		});	 
	} 

	Future<int> deleteObject(GedDocumentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(gedDocumentoCabecalhos).delete(object.gedDocumentoCabecalho!);
		});		
	}

	Future<void> insertChildren(GedDocumentoCabecalhoGrouped object) async {
		for (var gedDocumentoDetalheGrouped in object.gedDocumentoDetalheGroupedList!) {
			gedDocumentoDetalheGrouped.gedDocumentoDetalhe = gedDocumentoDetalheGrouped.gedDocumentoDetalhe?.copyWith(
				id: const Value(null),
				idGedDocumentoCabecalho: Value(object.gedDocumentoCabecalho!.id),
			);
			await into(gedDocumentoDetalhes).insert(gedDocumentoDetalheGrouped.gedDocumentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(GedDocumentoCabecalhoGrouped object) async {
		await (delete(gedDocumentoDetalhes)..where((t) => t.idGedDocumentoCabecalho.equals(object.gedDocumentoCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from ged_documento_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}