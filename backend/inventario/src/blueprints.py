from src.controller.login_controller import login_bp
from src.controller.inventario_contagem_cab_controller import inventario_contagem_cab_bp
from src.controller.inventario_ajuste_cab_controller import inventario_ajuste_cab_bp
from src.controller.produto_controller import produto_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp
from src.controller.view_pessoa_colaborador_controller import view_pessoa_colaborador_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(inventario_contagem_cab_bp)
		app.register_blueprint(inventario_ajuste_cab_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(view_pessoa_colaborador_bp)
		app.register_blueprint(login_bp)