from src.controller.login_controller import login_bp
from src.controller.produto_grupo_controller import produto_grupo_bp
from src.controller.produto_subgrupo_controller import produto_subgrupo_bp
from src.controller.produto_marca_controller import produto_marca_bp
from src.controller.produto_unidade_controller import produto_unidade_bp
from src.controller.os_abertura_controller import os_abertura_bp
from src.controller.os_status_controller import os_status_bp
from src.controller.os_equipamento_controller import os_equipamento_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_cliente_controller import view_pessoa_cliente_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(produto_grupo_bp)
		app.register_blueprint(produto_subgrupo_bp)
		app.register_blueprint(produto_marca_bp)
		app.register_blueprint(produto_unidade_bp)
		app.register_blueprint(os_abertura_bp)
		app.register_blueprint(os_status_bp)
		app.register_blueprint(os_equipamento_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_cliente_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)