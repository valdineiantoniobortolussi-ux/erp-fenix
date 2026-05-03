class FolhaRescisaoDomain {
	FolhaRescisaoDomain._();

	static getComprovouNovoEmprego(String? comprovouNovoEmprego) { 
		switch (comprovouNovoEmprego) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setComprovouNovoEmprego(String? comprovouNovoEmprego) { 
		switch (comprovouNovoEmprego) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getDispensouEmpregado(String? dispensouEmpregado) { 
		switch (dispensouEmpregado) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDispensouEmpregado(String? dispensouEmpregado) { 
		switch (dispensouEmpregado) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}