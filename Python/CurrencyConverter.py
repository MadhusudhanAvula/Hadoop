#https://www.youtube.com/watch?v=5vfgirGPvD4&t=5s 
#want to convert USD to Euro or viceversa
# 1USD = 0.91EURO
def currencyConvert():
	userChoice = raw_input("What do you wan to convert? \n 1) USD > Euro \n2) Euro > USD \n")
	
	if userChoice == "1":
		userUSD = input("Enter the amount in the USD you want to convert \n")
		Euro = userUSD * 0.91
		print "$ %0.2f" %userUSD, "=%0.2f" %Euro, "Euro"
		print"----------------------------------------"
		doAgain()
	elif userChoice == "2":
		userEuro = input("Enter the amount in the Euro you want to convert \n")
		USD = userEuro * 1.09
		print "%0.2f" %userEuro, "Euro = $ %0.2f" %USD
		print"----------------------------------------"
		doAgain()
	else:
		print "Error: You entered invalid information. please try again"
currencyConvert()

def doAgain():
	userDoAgain = raw_input("Would you like to convert again? \n1) Yes \n2) No \n")
	if userDoAgain == "1":
		currencyConvert()
	elif userDoAgain == "2":
		print "Thank you for using this program"
	else:
		print "Error: You entered invalid information. please try again"
		doAgain()