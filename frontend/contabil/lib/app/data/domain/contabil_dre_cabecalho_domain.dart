class ContabilDreCabecalhoDomain {
	ContabilDreCabecalhoDomain._();

	static getPadrao(String? padrao) { 
		switch (padrao) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPadrao(String? padrao) { 
		switch (padrao) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}