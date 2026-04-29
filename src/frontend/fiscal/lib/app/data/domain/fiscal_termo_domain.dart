class FiscalTermoDomain {
	FiscalTermoDomain._();

	static getAberturaEncerramento(String? aberturaEncerramento) { 
		switch (aberturaEncerramento) { 
			case '': 
			case '0': 
				return 'Abertura'; 
			case '1': 
				return 'Encerramento'; 
			default: 
				return null; 
		} 
	} 

	static setAberturaEncerramento(String? aberturaEncerramento) { 
		switch (aberturaEncerramento) { 
			case 'Abertura': 
				return '0'; 
			case 'Encerramento': 
				return '1'; 
			default: 
				return null; 
		} 
	}

}