class ContabilLivroDomain {
	ContabilLivroDomain._();

	static getFormaEscrituracao(String? formaEscrituracao) { 
		switch (formaEscrituracao) { 
			case '': 
			case '0': 
				return 'Diário Geral'; 
			case '1': 
				return 'Diário com Escrituração Resumida'; 
			case '2': 
				return 'Diário Auxiliar'; 
			case '3': 
				return 'Razão Auxiliar'; 
			case '4': 
				return 'Livro de Balancetes Diários e Balanços'; 
			default: 
				return null; 
		} 
	} 

	static setFormaEscrituracao(String? formaEscrituracao) { 
		switch (formaEscrituracao) { 
			case 'Diário Geral': 
				return '0'; 
			case 'Diário com Escrituração Resumida': 
				return '1'; 
			case 'Diário Auxiliar': 
				return '2'; 
			case 'Razão Auxiliar': 
				return '3'; 
			case 'Livro de Balancetes Diários e Balanços': 
				return '4'; 
			default: 
				return null; 
		} 
	}

}