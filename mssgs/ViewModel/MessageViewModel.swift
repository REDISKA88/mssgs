import Foundation
import UIKit

class MessageViewModel {
    private let apiService = APIService()
    var returnedMessages: [String] = []
    private var offsetQuery = ""
    
   
    
    func fetchMessages(by query: String?, forVC: MsgVC, completion: @escaping () -> ()){
        if let query = query {
            apiService.setQuery(query)
            offsetQuery = query
        }

        apiService.getMessages { [weak self] (result) in
            switch result {
            case .success(let messages):
                let msg = messages.result
                self?.returnedMessages = msg
                completion()
            case .failure:
                DispatchQueue.main.async {
                    forVC.present(forVC.alert, animated: true)
                }
            }
        }
    }
    
    
}

