class SpedContabilDomain {
	SpedContabilDomain._();

	static getFormaEscrituracao(String? formaEscrituracao) { 
		switch (formaEscrituracao) { 
			case '': 
			case 'G': 
				return 'G-Diário Geral'; 
			case 'R': 
				return 'R-Diário com Escrituração Resumida'; 
			case 'A': 
				return 'A-Diário Auxiliar'; 
			case 'Z': 
				return 'Z-Razão Auxiliar'; 
			case 'B': 
				return 'B-Livro de Balancetes Diários e Balanços'; 
			default: 
				return null; 
		} 
	} 

	static setFormaEscrituracao(String? formaEscrituracao) { 
		switch (formaEscrituracao) { 
			case 'G-Diário Geral': 
				return 'G'; 
			case 'R-Diário com Escrituração Resumida': 
				return 'R'; 
			case 'A-Diário Auxiliar': 
				return 'A'; 
			case 'Z-Razão Auxiliar': 
				return 'Z'; 
			case 'B-Livro de Balancetes Diários e Balanços': 
				return 'B'; 
			default: 
				return null; 
		} 
	}

}