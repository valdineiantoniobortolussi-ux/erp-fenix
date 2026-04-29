import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'folha_rescisao_dao.g.dart';

@DriftAccessor(tables: [
	FolhaRescisaos,
	ViewPessoaColaboradors,
])
class FolhaRescisaoDao extends DatabaseAccessor<AppDatabase> with _$FolhaRescisaoDaoMixin {
	final AppDatabase db;

	List<FolhaRescisao> folhaRescisaoList = []; 
	List<FolhaRescisaoGrouped> folhaRescisaoGroupedList = []; 

	FolhaRescisaoDao(this.db) : super(db);

	Future<List<FolhaRescisao>> getList() async {
		folhaRescisaoList = await select(folhaRescisaos).get();
		return folhaRescisaoList;
	}

	Future<List<FolhaRescisao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		folhaRescisaoList = await (select(folhaRescisaos)..where((t) => expression)).get();
		return folhaRescisaoList;	 
	}

	Future<List<FolhaRescisaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(folhaRescisaos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(folhaRescisaos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = folhaRescisaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		folhaRescisaoGroupedList = await query.map((row) {
			final folhaRescisao = row.readTableOrNull(folhaRescisaos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FolhaRescisaoGrouped(
				folhaRescisao: folhaRescisao, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var folhaRescisaoGrouped in folhaRescisaoGroupedList) {
		//}		

		return folhaRescisaoGroupedList;	
	}

	Future<FolhaRescisao?> getObject(dynamic pk) async {
		return await (select(folhaRescisaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FolhaRescisao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM folha_rescisao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FolhaRescisao;		 
	} 

	Future<FolhaRescisaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FolhaRescisaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.folhaRescisao = object.folhaRescisao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(folhaRescisaos).insert(object.folhaRescisao!);
			object.folhaRescisao = object.folhaRescisao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FolhaRescisaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(folhaRescisaos).replace(object.folhaRescisao!);
		});	 
	} 

	Future<int> deleteObject(FolhaRescisaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(folhaRescisaos).delete(object.folhaRescisao!);
		});		
	}

	Future<void> insertChildren(FolhaRescisaoGrouped object) async {
	}
	
	Future<void> deleteChildren(FolhaRescisaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from folha_rescisao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}