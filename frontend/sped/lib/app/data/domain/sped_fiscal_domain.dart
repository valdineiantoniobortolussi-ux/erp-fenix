class SpedFiscalDomain {
	SpedFiscalDomain._();

	static getPerfilApresentacao(String? perfilApresentacao) { 
		switch (perfilApresentacao) { 
			case '': 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			default: 
				return null; 
		} 
	} 

	static setPerfilApresentacao(String? perfilApresentacao) { 
		switch (perfilApresentacao) { 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			default: 
				return null; 
		} 
	}

}