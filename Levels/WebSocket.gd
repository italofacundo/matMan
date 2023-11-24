extends Node

var txt = ''
var client
var connected = false

signal left
signal right
signal center
signal up
signal down
signal confirm

const ip = "192.168.242.127"
const port = 80

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected Godot!")

func _process(delta):
	if connected and not client.is_connected_to_host():
		 connected = false
	else:
		_readWebSocket()
		

func _readWebSocket():
	while client.get_available_bytes() > 0:
		var message = client.get_utf8_string(client.get_available_bytes())
		
		if message == null:
			continue	
		elif message.length() > 0:
			for i in message:	
				if i == '\n':
					_messageInterpreter(txt)
					txt = ''
				else:
					txt += i

var lastCommand = ''
func _messageInterpreter(txt):
	var command = txt
	
	if command == "Left" and lastCommand != "Left":
		lastCommand = "Left"
		emit_signal("left")
		
	if command == "Right" and lastCommand != "Right":
		lastCommand = "Right"
		emit_signal("right")
		
	if command == "Center" and lastCommand != "Center":
		lastCommand = "Center"
		emit_signal("center")
			  
	if command == "Up" and lastCommand != "Up":
		lastCommand = "Up"
		emit_signal("up")
		
	if command == "Down" and lastCommand != "Down":
		lastCommand = "Down"
		emit_signal("down")
		
	if command == "Pressed button 1":
		emit_signal("confirm")
