extends Node
signal configuracoes_atualizadas

const SAVE_PATH = "user://config.cfg"
var dados = {
	"fullscreen": false,
	"vsync": true,
	"tela": false,
	"brilho": 50,
	"vol_geral": 50,
	"sfx": 50,
	"layout": {},
	}

func salvar_no_disco():
	var config = ConfigFile.new()
	config.set_value("opcoes", "geral", dados)
	config.save(SAVE_PATH)
	#print("Arquivo salvo via Autoload!")

func carregar_do_disco():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		dados = config.get_value("opcoes", "geral", dados)
	
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if dados.vsync else DisplayServer.VSYNC_DISABLED)
	
	if dados.tela: # Se 'tela' (o botão do modo pixel) estiver marcado
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	else:
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	
	configuracoes_atualizadas.emit()

func _ready():
	carregar_do_disco()
