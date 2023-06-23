extends Node

# Gravity variable
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Respawn variables
var respawn_point

var player_position

# Game variables
var lv1_enable = true
var lv2_enable = false
var lv3_enable = false
var lv1_stars = 0
var lv2_stars = 0
var lv3_stars = 0
var lv1_in = false
var lv2_in = false
var lv1_col1 = false
var lv1_col2 = false
var lv1_col3 = false
var lv2_col1 = false
var lv2_col2 = false
var lv2_col3 = false
var lv3_col1 = false
var lv3_col2 = false
var lv3_col3 = false
var nickname = ""
var lifes = 3
var boss1_died
var boss2_died

# Save variables
var save_path = "user://.sbx64.dat"

# Load data
func loadsave():
	var file = File.new()
	if file.open_encrypted_with_pass(save_path, File.READ, "!@#$%¨*()_+123654789?     ...     By Bemttas&Martins") == OK:
		var data = file.get_line()
		file.close()
		var json = JSON.parse(data).result
		lv1_enable = json["lv1_enable"]
		lv2_enable = json["lv2_enable"]
		lv3_enable = json["lv3_enable"]
		lv1_stars = json["lv1_stars"]
		lv2_stars = json["lv2_stars"]
		lv3_stars = json["lv3_stars"]
		lv1_col1 = json["lv1_col1"]
		lv1_col2 = json["lv1_col2"]
		lv1_col3 = json["lv1_col3"]
		lv2_col1 = json["lv2_col1"]
		lv2_col2 = json["lv2_col2"]
		lv2_col3 = json["lv2_col3"]
		lv3_col1 = json["lv3_col1"]
		lv3_col2 = json["lv3_col2"]
		lv3_col3 = json["lv3_col3"]
		nickname = json["nickname"]

# Create new data
func createsave():
	var save_file = File.new()
	if save_file.file_exists(save_path):
		var dir = Directory.new()
		dir.remove(save_path)
	var data = {
		"lv1_enable": lv1_enable,
		"lv2_enable": lv2_enable,
		"lv3_enable": lv3_enable,
		"lv1_stars": lv1_stars,
		"lv2_stars": lv2_stars,
		"lv3_stars": lv3_stars,
		"lv1_col1": lv1_col1,
		"lv1_col2": lv1_col2,
		"lv1_col3": lv1_col3,
		"lv2_col1": lv2_col1,
		"lv2_col2": lv2_col2,
		"lv2_col3": lv2_col3,
		"lv3_col1": lv3_col1,
		"lv3_col2": lv3_col2,
		"lv3_col3": lv3_col3,
		"nickname": nickname
	}
	var json = JSON.print(data)
	var file = File.new()
	if file.open_encrypted_with_pass(save_path, File.WRITE, "!@#$%¨*()_+123654789?     ...     By Bemttas&Martins") == OK:
		file.store_string(json)
		file.close()
