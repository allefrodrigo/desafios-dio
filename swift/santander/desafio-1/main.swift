let firstName: String = "Steve"
var lastName: String? = "Jobs"
var haveResult: String

if let lastName = lastName {
    haveResult = lastName
    print("\(firstName) \(lastName)")
} else {
    haveResult = "Wozniak"
    print("\(firstName) \(haveResult)")
}

print(haveResult)