from src.controller.login_controller import login_bp
from src.controller.requisicao_interna_cabecalho_controller import requisicao_interna_cabecalho_bp
from src.controller.estoque_reajuste_cabecalho_controller import estoque_reajuste_cabecalho_bp
from src.controller.produto_grupo_controller import produto_grupo_bp
from src.controller.produto_subgrupo_controller import produto_subgrupo_bp
from src.controller.produto_marca_controller import produto_marca_bp
from src.controller.produto_unidade_controller import produto_unidade_bp
from src.controller.produto_controller import produto_bp
from src.controller.estoque_cor_controller import estoque_cor_bp
from src.controller.estoque_tamanho_controller import estoque_tamanho_bp
from src.controller.estoque_sabor_controller import estoque_sabor_bp
from src.controller.estoque_marca_controller import estoque_marca_bp
from src.controller.estoque_grade_controller import estoque_grade_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(requisicao_interna_cabecalho_bp)
		app.register_blueprint(estoque_reajuste_cabecalho_bp)
		app.register_blueprint(produto_grupo_bp)
		app.register_blueprint(produto_subgrupo_bp)
		app.register_blueprint(produto_marca_bp)
		app.register_blueprint(produto_unidade_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(estoque_cor_bp)
		app.register_blueprint(estoque_tamanho_bp)
		app.register_blueprint(estoque_sabor_bp)
		app.register_blueprint(estoque_marca_bp)
		app.register_blueprint(estoque_grade_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)