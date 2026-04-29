from src.controller.login_controller import login_bp
from src.controller.pcp_op_cabecalho_controller import pcp_op_cabecalho_bp
from src.controller.pcp_servico_controller import pcp_servico_bp
from src.controller.produto_controller import produto_bp
from src.controller.patrim_bem_controller import patrim_bem_bp
from src.controller.pcp_instrucao_controller import pcp_instrucao_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(pcp_op_cabecalho_bp)
		app.register_blueprint(pcp_servico_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(patrim_bem_bp)
		app.register_blueprint(pcp_instrucao_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)