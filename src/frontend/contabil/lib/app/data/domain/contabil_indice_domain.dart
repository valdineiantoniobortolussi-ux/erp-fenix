class ContabilIndiceDomain {
	ContabilIndiceDomain._();

	static getPeriodicidade(String? periodicidade) { 
		switch (periodicidade) { 
			case '': 
			case 'D': 
				return 'Diário'; 
			case 'M': 
				return 'Mensal'; 
			default: 
				return null; 
		} 
	} 

	static setPeriodicidade(String? periodicidade) { 
		switch (periodicidade) { 
			case 'Diário': 
				return 'D'; 
			case 'Mensal': 
				return 'M'; 
			default: 
				return null; 
		} 
	}

}