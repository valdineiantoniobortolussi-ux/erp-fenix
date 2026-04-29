class WmsOrdemSeparacaoCabDomain {
	WmsOrdemSeparacaoCabDomain._();

	static getOrigem(String? origem) { 
		switch (origem) { 
			case '': 
			case 'P': 
				return 'Produção'; 
			case 'M': 
				return 'Matriz'; 
			case 'F': 
				return 'Filial'; 
			default: 
				return null; 
		} 
	} 

	static setOrigem(String? origem) { 
		switch (origem) { 
			case 'Produção': 
				return 'P'; 
			case 'Matriz': 
				return 'M'; 
			case 'Filial': 
				return 'F'; 
			default: 
				return null; 
		} 
	}

}