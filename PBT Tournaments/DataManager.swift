
import SwiftUI
import Firebase


let impact = UIImpactFeedbackGenerator(style: .light)


class DataManager: ObservableObject {
    @Published var tournaments: [Tournaments] = []

    
    init() {
        fetchAll()
    }
    
    func fetchAll() {
        fetchTournaments()
    }
    
    func fetchTournaments() {
        tournaments.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Tournaments")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["uid"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let publicCode = data["publicCode"] as? String ?? ""
                    let privateCode = data["privateCode"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let slots = data["slots"] as? Int ?? 0
                    
                    let appending = Tournaments(id: id, name: name, time: time, location: location, publicCode: publicCode, privateCode: privateCode, slots: slots, description: description)
                    self.tournaments.append(appending)
                }
            }
        }
    }
    
    func addTournament(name: String, time: String, location: String, slots: String, description: String) {
        
        //let documentID = "\(defaults.string(forKey: "email") ?? "empty") - \(title)"
        func randomString(length: Int) -> String {
          let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
        }
        
        var publicCode = ""
        
        
        while true {
            var theCode = randomString(length: 6)
            var isValid = false
            var checker = [""]
            
            for thing in tournaments {
                checker.append(thing.publicCode)
            }
            if !checker.contains(theCode) {
                publicCode = theCode
                
                break
            }
        }
        
        let documentID = "\(name)-\(publicCode)"
        
        let db = Firestore.firestore()
        let ref = db.collection("Tournaments").document(documentID)
        ref.setData(["uid": documentID, "name": name, "time": time, "location": location, "publicCode": publicCode, "privateCode": "\(publicCode)\(randomString(length: 3))", "description": description]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func removeMeditation(documentID: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Completions").document(documentID)
        ref.delete() { error in
            if let error = error {
                print("Error removing document: \(error.localizedDescription)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    /*
    private func getDocument() {
        //Get specific document from current user
        let docRef = Firestore.firestore()
            .collection("Dogs")
            .document(Auth.auth().currentUser?.uid ?? "")
        
        // Get data
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            let dataDescription = document.data()
            print(dataDescription?["firstname"] ?? "")
        }
    }*/
}


class FirestoreDocument: ObservableObject {
    @Published var documentData: [String: Any] = [:]
    
    private var db = Firestore.firestore()
    
    func getDocumentById(collection: String, documentId: String) {
        let docRef = db.collection(collection).document(documentId)
        
        docRef.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists else {
                print("Document notfound")
                return
            }
            if let data = documentSnapshot.data() {
                DispatchQueue.main.async {
                    self.documentData = data
                }
            } else {
                print("Document data is empty.")
            }
        }
    }
}


