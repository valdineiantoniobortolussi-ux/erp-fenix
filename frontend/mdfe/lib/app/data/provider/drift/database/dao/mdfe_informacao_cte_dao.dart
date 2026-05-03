import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_informacao_cte_dao.g.dart';

@DriftAccessor(tables: [
	MdfeInformacaoCtes,
	MdfeMunicipioDescarregas,
])
class MdfeInformacaoCteDao extends DatabaseAccessor<AppDatabase> with _$MdfeInformacaoCteDaoMixin {
	final AppDatabase db;

	List<MdfeInformacaoCte> mdfeInformacaoCteList = []; 
	List<MdfeInformacaoCteGrouped> mdfeInformacaoCteGroupedList = []; 

	MdfeInformacaoCteDao(this.db) : super(db);

	Future<List<MdfeInformacaoCte>> getList() async {
		mdfeInformacaoCteList = await select(mdfeInformacaoCtes).get();
		return mdfeInformacaoCteList;
	}

	Future<List<MdfeInformacaoCte>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeInformacaoCteList = await (select(mdfeInformacaoCtes)..where((t) => expression)).get();
		return mdfeInformacaoCteList;	 
	}

	Future<List<MdfeInformacaoCteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeInformacaoCtes)
			.join([ 
				leftOuterJoin(mdfeMunicipioDescarregas, mdfeMunicipioDescarregas.id.equalsExp(mdfeInformacaoCtes.idMdfeMunicipioDescarrega)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeInformacaoCtes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeInformacaoCteGroupedList = await query.map((row) {
			final mdfeInformacaoCte = row.readTableOrNull(mdfeInformacaoCtes); 
			final mdfeMunicipioDescarrega = row.readTableOrNull(mdfeMunicipioDescarregas); 

			return MdfeInformacaoCteGrouped(
				mdfeInformacaoCte: mdfeInformacaoCte, 
				mdfeMunicipioDescarrega: mdfeMunicipioDescarrega, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeInformacaoCteGrouped in mdfeInformacaoCteGroupedList) {
		//}		

		return mdfeInformacaoCteGroupedList;	
	}

	Future<MdfeInformacaoCte?> getObject(dynamic pk) async {
		return await (select(mdfeInformacaoCtes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeInformacaoCte?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_informacao_cte WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeInformacaoCte;		 
	} 

	Future<MdfeInformacaoCteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeInformacaoCteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeInformacaoCte = object.mdfeInformacaoCte!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeInformacaoCtes).insert(object.mdfeInformacaoCte!);
			object.mdfeInformacaoCte = object.mdfeInformacaoCte!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeInformacaoCteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeInformacaoCtes).replace(object.mdfeInformacaoCte!);
		});	 
	} 

	Future<int> deleteObject(MdfeInformacaoCteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeInformacaoCtes).delete(object.mdfeInformacaoCte!);
		});		
	}

	Future<void> insertChildren(MdfeInformacaoCteGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeInformacaoCteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_informacao_cte").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}