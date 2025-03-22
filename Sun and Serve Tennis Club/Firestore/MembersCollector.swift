import FirebaseFirestore


struct MembersModel {
    let name: String
    let surname: String?
    let email: String?
    let reservations: Array<Timestamp>?
}

final class MembersCollector {
    // Singleton
    static let shared = MembersCollector()

    private let db: Firestore

    init() {
        db = Firestore.firestore()
    }
    
    func addMember(name: String, surname: String, email: String) async {
        // Add a new document with a generated ID
        do {
          let ref = try await db.collection("members").addDocument(data: [
            "name": name,
            "surname": surname,
            "email": email,
            "reservations": []
          ])
          print("Document added with ID: \(ref.documentID)")
        } catch {
          print("Error adding document: \(error)")
        }
    }
    
    func getMemberName(email: String) async -> String {
        do {
          let querySnapshot = try await db.collection("members").whereField("email", isEqualTo: email)
            .getDocuments()
          for document in querySnapshot.documents {
              print(document.data()["name"])
              if let name = document.data()["name"] as? String {
                  return name
              } else {
                  return "Unknown"
              }
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        return ""
    }
    func getMemberDocumentId(email: String) async -> String {
        do {
          let querySnapshot = try await db.collection("members").whereField("email", isEqualTo: email)
            .getDocuments()
          for document in querySnapshot.documents {
              print(document.documentID)
              return document.documentID
          }
        } catch {
          print("Error getting documents: \(error)")
        }
        return ""
    }
    
    func addReservation(for email: String, time: Timestamp) async {
        let documentId = await getMemberDocumentId(email: email)
        let memberRef = db.collection("members").document(documentId)
        do {
//            try await memberRef.updateData(["reservations": time])
            try await memberRef.updateData(["reservations": FieldValue.arrayUnion([time])])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    func getReservations(for email: String) async -> Array<Timestamp> {
        do {
          let querySnapshot = try await db.collection("members").whereField("email", isEqualTo: email)
            .getDocuments()
          for document in querySnapshot.documents {
              if let reservations = document.data()["reservations"] as? Array<Timestamp> {
                  return reservations
              } else {
                  return []
              }
          }
        } catch {
          print("Error getting reservations: \(error)")
            return []
        }
        
        return []
    }
    
    func deleteReservation(for email: String, time: Timestamp) async {
        do {
            let documentId = await getMemberDocumentId(email: email)
            let memberRef = db.collection("members").document(documentId)
            
            try await memberRef.updateData([
                "reservations": FieldValue.arrayRemove([time])
            ])
            
            print("Reservation successfully deleted")
        } catch {
            print("Error deleting reservation: \(error)")
        }
    }
}
