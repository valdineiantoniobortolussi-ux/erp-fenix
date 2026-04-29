class FrotaMotoristaDomain {
	FrotaMotoristaDomain._();

	static getCnhCategoria(String? cnhCategoria) { 
		switch (cnhCategoria) { 
			case '': 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			case 'D': 
				return 'D'; 
			case 'E': 
				return 'E'; 
			default: 
				return null; 
		} 
	} 

	static setCnhCategoria(String? cnhCategoria) { 
		switch (cnhCategoria) { 
			case 'A': 
				return 'A'; 
			case 'B': 
				return 'B'; 
			case 'C': 
				return 'C'; 
			case 'D': 
				return 'D'; 
			case 'E': 
				return 'E'; 
			default: 
				return null; 
		} 
	}

}