class RequisicaoInternaCabecalhoDomain {
	RequisicaoInternaCabecalhoDomain._();

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case 'A': 
				return 'Aberta'; 
			case 'D': 
				return 'Deferida'; 
			case 'I': 
				return 'Indeferida'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case 'Aberta': 
				return 'A'; 
			case 'Deferida': 
				return 'D'; 
			case 'Indeferida': 
				return 'I'; 
			default: 
				return null; 
		} 
	}

}