class ContabilTermoDomain {
	ContabilTermoDomain._();

	static getAberturaEncerramento(String? aberturaEncerramento) { 
		switch (aberturaEncerramento) { 
			case '': 
			case 'A': 
				return 'Abertura'; 
			case 'E': 
				return 'Encerramento'; 
			default: 
				return null; 
		} 
	} 

	static setAberturaEncerramento(String? aberturaEncerramento) { 
		switch (aberturaEncerramento) { 
			case 'Abertura': 
				return 'A'; 
			case 'Encerramento': 
				return 'E'; 
			default: 
				return null; 
		} 
	}

}