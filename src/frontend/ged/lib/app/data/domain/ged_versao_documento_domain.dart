class GedVersaoDocumentoDomain {
	GedVersaoDocumentoDomain._();

	static getAcao(String? acao) { 
		switch (acao) { 
			case '': 
			case 'I': 
				return 'Incluído'; 
			case 'A': 
				return 'Alterado'; 
			case 'E': 
				return 'Excluído'; 
			default: 
				return null; 
		} 
	} 

	static setAcao(String? acao) { 
		switch (acao) { 
			case 'Incluído': 
				return 'I'; 
			case 'Alterado': 
				return 'A'; 
			case 'Excluído': 
				return 'E'; 
			default: 
				return null; 
		} 
	}

}