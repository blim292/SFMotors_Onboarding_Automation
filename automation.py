# prompt users for rows necessary.
# get data from excel
# store each users credentials into lists
# use data in list to automate onboarding

print("Which row/s would you like to get data from? Enter q to quit.")
userInput = ""
rowList = []
while userInput != 'q':
    print("What row?")
    userInput = input()
    if userInput == 'q':
        print("Ok. Rows added.")
        break;
    rowList.append(userInput)

print(rowList)
