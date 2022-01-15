import Foundation

final class HomeServiceImpl: HomeService {
    let session = URLSession.shared
    
    func getBeerList(page: Int, completion: @escaping ([HomeModel]) -> ()) {
        let request = URLRequest(url: URL(string: "https://api.punkapi.com/v2/beers?per_page=25&page=\(page)")!)
        let task = session.dataTask(with: request) { (data, _, _) in
            guard let data = data,
                  let response = try? JSONDecoder().decode([HomeModel].self, from: data) else {
                      completion([])
                      return
                  }
            completion(response)
        }
        task.resume()
    }
}
