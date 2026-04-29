class PatrimEstadoConservacaoDomain {
	PatrimEstadoConservacaoDomain._();

	static getCodigo(String? codigo) { 
		switch (codigo) { 
			case '': 
			case '1': 
				return '1=Novo'; 
			case '2': 
				return '2=Bom'; 
			case '3': 
				return '3=Recuperável'; 
			case '4': 
				return '4=Inservível'; 
			default: 
				return null; 
		} 
	} 

	static setCodigo(String? codigo) { 
		switch (codigo) { 
			case '1=Novo': 
				return '1'; 
			case '2=Bom': 
				return '2'; 
			case '3=Recuperável': 
				return '3'; 
			case '4=Inservível': 
				return '4'; 
			default: 
				return null; 
		} 
	}

}