def getVal(dictionary, keysWithDelimiter):
    result = dictionary
    listOfKeys = keysWithDelimiter.split("/")
    
    for key in listOfKeys:
        result = result.get(key, None)
        if result is None:
            break
    
    return result