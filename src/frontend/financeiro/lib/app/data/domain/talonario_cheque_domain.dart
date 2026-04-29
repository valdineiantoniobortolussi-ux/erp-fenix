class TalonarioChequeDomain {
	TalonarioChequeDomain._();

	static getStatusTalao(String? statusTalao) { 
		switch (statusTalao) { 
			case '': 
			case '0': 
				return 'Normal'; 
			case '1': 
				return 'Cancelado'; 
			case '2': 
				return 'Extraviado'; 
			case '3': 
				return 'Utilizado'; 
			default: 
				return null; 
		} 
	} 

	static setStatusTalao(String? statusTalao) { 
		switch (statusTalao) { 
			case 'Normal': 
				return '0'; 
			case 'Cancelado': 
				return '1'; 
			case 'Extraviado': 
				return '2'; 
			case 'Utilizado': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}