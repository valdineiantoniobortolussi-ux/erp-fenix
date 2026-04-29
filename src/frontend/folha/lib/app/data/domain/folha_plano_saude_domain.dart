class FolhaPlanoSaudeDomain {
	FolhaPlanoSaudeDomain._();

	static getBeneficiario(String? beneficiario) { 
		switch (beneficiario) { 
			case '': 
			case '1': 
				return '1=Somente Colaborador'; 
			case '2': 
				return '2=Colaborador e Dependentes'; 
			case '3': 
				return '3=Somente Dependentes'; 
			default: 
				return null; 
		} 
	} 

	static setBeneficiario(String? beneficiario) { 
		switch (beneficiario) { 
			case '1=Somente Colaborador': 
				return '1'; 
			case '2=Colaborador e Dependentes': 
				return '2'; 
			case '3=Somente Dependentes': 
				return '3'; 
			default: 
				return null; 
		} 
	}

}