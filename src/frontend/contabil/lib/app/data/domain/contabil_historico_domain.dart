class ContabilHistoricoDomain {
	ContabilHistoricoDomain._();

	static getPedeComplemento(String? pedeComplemento) { 
		switch (pedeComplemento) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPedeComplemento(String? pedeComplemento) { 
		switch (pedeComplemento) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}