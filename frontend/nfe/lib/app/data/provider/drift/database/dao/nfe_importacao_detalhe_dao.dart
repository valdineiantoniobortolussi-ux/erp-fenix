import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'nfe_importacao_detalhe_dao.g.dart';

@DriftAccessor(tables: [
	NfeImportacaoDetalhes,
	NfeDeclaracaoImportacaos,
])
class NfeImportacaoDetalheDao extends DatabaseAccessor<AppDatabase> with _$NfeImportacaoDetalheDaoMixin {
	final AppDatabase db;

	List<NfeImportacaoDetalhe> nfeImportacaoDetalheList = []; 
	List<NfeImportacaoDetalheGrouped> nfeImportacaoDetalheGroupedList = []; 

	NfeImportacaoDetalheDao(this.db) : super(db);

	Future<List<NfeImportacaoDetalhe>> getList() async {
		nfeImportacaoDetalheList = await select(nfeImportacaoDetalhes).get();
		return nfeImportacaoDetalheList;
	}

	Future<List<NfeImportacaoDetalhe>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		nfeImportacaoDetalheList = await (select(nfeImportacaoDetalhes)..where((t) => expression)).get();
		return nfeImportacaoDetalheList;	 
	}

	Future<List<NfeImportacaoDetalheGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(nfeImportacaoDetalhes)
			.join([ 
				leftOuterJoin(nfeDeclaracaoImportacaos, nfeDeclaracaoImportacaos.id.equalsExp(nfeImportacaoDetalhes.idNfeDeclaracaoImportacao)), 
			]);

		if (field != null && field != '') { 
			final column = nfeImportacaoDetalhes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		nfeImportacaoDetalheGroupedList = await query.map((row) {
			final nfeImportacaoDetalhe = row.readTableOrNull(nfeImportacaoDetalhes); 
			final nfeDeclaracaoImportacao = row.readTableOrNull(nfeDeclaracaoImportacaos); 

			return NfeImportacaoDetalheGrouped(
				nfeImportacaoDetalhe: nfeImportacaoDetalhe, 
				nfeDeclaracaoImportacao: nfeDeclaracaoImportacao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var nfeImportacaoDetalheGrouped in nfeImportacaoDetalheGroupedList) {
		//}		

		return nfeImportacaoDetalheGroupedList;	
	}

	Future<NfeImportacaoDetalhe?> getObject(dynamic pk) async {
		return await (select(nfeImportacaoDetalhes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<NfeImportacaoDetalhe?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM nfe_importacao_detalhe WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as NfeImportacaoDetalhe;		 
	} 

	Future<NfeImportacaoDetalheGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(NfeImportacaoDetalheGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.nfeImportacaoDetalhe = object.nfeImportacaoDetalhe!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(nfeImportacaoDetalhes).insert(object.nfeImportacaoDetalhe!);
			object.nfeImportacaoDetalhe = object.nfeImportacaoDetalhe!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(NfeImportacaoDetalheGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(nfeImportacaoDetalhes).replace(object.nfeImportacaoDetalhe!);
		});	 
	} 

	Future<int> deleteObject(NfeImportacaoDetalheGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(nfeImportacaoDetalhes).delete(object.nfeImportacaoDetalhe!);
		});		
	}

	Future<void> insertChildren(NfeImportacaoDetalheGrouped object) async {
	}
	
	Future<void> deleteChildren(NfeImportacaoDetalheGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from nfe_importacao_detalhe").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}