from src.controller.login_controller import login_bp
from src.controller.pessoa_controller import pessoa_bp
from src.controller.colaborador_controller import colaborador_bp
from src.controller.papel_controller import papel_bp
from src.controller.funcao_controller import funcao_bp
from src.controller.estado_civil_controller import estado_civil_bp
from src.controller.cargo_controller import cargo_bp
from src.controller.setor_controller import setor_bp
from src.controller.colaborador_situacao_controller import colaborador_situacao_bp
from src.controller.tipo_admissao_controller import tipo_admissao_bp
from src.controller.colaborador_tipo_controller import colaborador_tipo_bp
from src.controller.produto_grupo_controller import produto_grupo_bp
from src.controller.produto_subgrupo_controller import produto_subgrupo_bp
from src.controller.produto_marca_controller import produto_marca_bp
from src.controller.produto_unidade_controller import produto_unidade_bp
from src.controller.produto_controller import produto_bp
from src.controller.banco_controller import banco_bp
from src.controller.banco_agencia_controller import banco_agencia_bp
from src.controller.banco_conta_caixa_controller import banco_conta_caixa_bp
from src.controller.cep_controller import cep_bp
from src.controller.uf_controller import uf_bp
from src.controller.municipio_controller import municipio_bp
from src.controller.ncm_controller import ncm_bp
from src.controller.cfop_controller import cfop_bp
from src.controller.cst_icms_controller import cst_icms_bp
from src.controller.cst_ipi_controller import cst_ipi_bp
from src.controller.cst_cofins_controller import cst_cofins_bp
from src.controller.cst_pis_controller import cst_pis_bp
from src.controller.csosn_controller import csosn_bp
from src.controller.cnae_controller import cnae_bp
from src.controller.pais_controller import pais_bp
from src.controller.nivel_formacao_controller import nivel_formacao_bp
from src.controller.tabela_preco_controller import tabela_preco_bp
from src.controller.tipo_relacionamento_controller import tipo_relacionamento_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.comissao_perfil_controller import comissao_perfil_bp
from src.controller.sindicato_controller import sindicato_bp
from src.controller.tribut_icms_custom_cab_controller import tribut_icms_custom_cab_bp
from src.controller.tribut_grupo_tributario_controller import tribut_grupo_tributario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(pessoa_bp)
		app.register_blueprint(colaborador_bp)
		app.register_blueprint(papel_bp)
		app.register_blueprint(funcao_bp)
		app.register_blueprint(estado_civil_bp)
		app.register_blueprint(cargo_bp)
		app.register_blueprint(setor_bp)
		app.register_blueprint(colaborador_situacao_bp)
		app.register_blueprint(tipo_admissao_bp)
		app.register_blueprint(colaborador_tipo_bp)
		app.register_blueprint(produto_grupo_bp)
		app.register_blueprint(produto_subgrupo_bp)
		app.register_blueprint(produto_marca_bp)
		app.register_blueprint(produto_unidade_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(banco_bp)
		app.register_blueprint(banco_agencia_bp)
		app.register_blueprint(banco_conta_caixa_bp)
		app.register_blueprint(cep_bp)
		app.register_blueprint(uf_bp)
		app.register_blueprint(municipio_bp)
		app.register_blueprint(ncm_bp)
		app.register_blueprint(cfop_bp)
		app.register_blueprint(cst_icms_bp)
		app.register_blueprint(cst_ipi_bp)
		app.register_blueprint(cst_cofins_bp)
		app.register_blueprint(cst_pis_bp)
		app.register_blueprint(csosn_bp)
		app.register_blueprint(cnae_bp)
		app.register_blueprint(pais_bp)
		app.register_blueprint(nivel_formacao_bp)
		app.register_blueprint(tabela_preco_bp)
		app.register_blueprint(tipo_relacionamento_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(comissao_perfil_bp)
		app.register_blueprint(sindicato_bp)
		app.register_blueprint(tribut_icms_custom_cab_bp)
		app.register_blueprint(tribut_grupo_tributario_bp)
		app.register_blueprint(login_bp)