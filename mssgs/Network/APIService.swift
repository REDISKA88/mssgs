import Foundation

class APIService {
    
    private var dataTask: URLSessionDataTask?
    private var baseUrl = "https://numero-logy-app.org.in/getMessages?offset="
    private var query = ""
    
    func getMessages(completion: @escaping (Result<Message, Error>) -> (Void)) {
        
        guard let url = URL(string: baseUrl+query) else { return }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let JSONData = try decoder.decode(Message.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(.success(JSONData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    func setQuery( _ newQuery: String) {
        guard newQuery.hashValue != query.hashValue else  { return }
        self.query = newQuery
    }
    
}
