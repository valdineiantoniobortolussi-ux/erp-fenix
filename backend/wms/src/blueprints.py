from src.controller.login_controller import login_bp
from src.controller.wms_recebimento_cabecalho_controller import wms_recebimento_cabecalho_bp
from src.controller.wms_caixa_controller import wms_caixa_bp
from src.controller.wms_ordem_separacao_cab_controller import wms_ordem_separacao_cab_bp
from src.controller.produto_controller import produto_bp
from src.controller.wms_agendamento_controller import wms_agendamento_bp
from src.controller.wms_parametro_controller import wms_parametro_bp
from src.controller.wms_rua_controller import wms_rua_bp
from src.controller.wms_estante_controller import wms_estante_bp
from src.controller.wms_expedicao_controller import wms_expedicao_bp
from src.controller.view_controle_acesso_controller import view_controle_acesso_bp
from src.controller.view_pessoa_usuario_controller import view_pessoa_usuario_bp

# Register the blueprints with the Flask application
def register_blueprints(app):
		app.register_blueprint(wms_recebimento_cabecalho_bp)
		app.register_blueprint(wms_caixa_bp)
		app.register_blueprint(wms_ordem_separacao_cab_bp)
		app.register_blueprint(produto_bp)
		app.register_blueprint(wms_agendamento_bp)
		app.register_blueprint(wms_parametro_bp)
		app.register_blueprint(wms_rua_bp)
		app.register_blueprint(wms_estante_bp)
		app.register_blueprint(wms_expedicao_bp)
		app.register_blueprint(view_controle_acesso_bp)
		app.register_blueprint(view_pessoa_usuario_bp)
		app.register_blueprint(login_bp)