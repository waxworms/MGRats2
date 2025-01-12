extends VBoxContainer
onready var userField = get_node("UsernameField")
onready var passField= get_node("PasswordField")
var userFlag
var passFlag

func checkUserAgainstDB(userEntered):
	pass

func checkPassAgainstDB(passEntered):
	pass

func _on_LogInButt_button_up():
	if userField.text=='' and passField.text=='':
		print("Username or password field empty")
	else:
		userFlag = checkUserAgainstDB(userField.text)
		if userFlag:
			passFlag = checkPassAgainstDB(passField.text)
			if passFlag:
				print("Login successful")
			else:
				print("Wrong password")
		else:
				print("Username does not exist")
