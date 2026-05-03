class ChequeDomain {
	ChequeDomain._();

	static getStatusCheque(String? statusCheque) { 
		switch (statusCheque) { 
			case '': 
			case '0': 
				return 'Em Ser'; 
			case '1': 
				return 'Baixado'; 
			case '2': 
				return 'Utilizado'; 
			case '3': 
				return 'Compensado'; 
			case '4': 
				return 'Cancelado'; 
			case '5': 
				return 'Sustado'; 
			default: 
				return null; 
		} 
	} 

	static setStatusCheque(String? statusCheque) { 
		switch (statusCheque) { 
			case 'Em Ser': 
				return '0'; 
			case 'Baixado': 
				return '1'; 
			case 'Utilizado': 
				return '2'; 
			case 'Compensado': 
				return '3'; 
			case 'Cancelado': 
				return '4'; 
			case 'Sustado': 
				return '5'; 
			default: 
				return null; 
		} 
	}

}