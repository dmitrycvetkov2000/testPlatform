//
//  APIManager.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

enum ApiType {
    case getListOfMovie
    case getDetailInfoAboutMovie(id: Int)
    
    var baseURL: String {
        "https://api.themoviedb.org/3/movie/"
    }
    
    var headers: [String: String] {
        switch self {
        case .getListOfMovie, .getDetailInfoAboutMovie:
            return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MjZiYzM5NGNjYTQzYTA4YWVhYWYxMmU1NzNjMDg2ZiIsInN1YiI6IjY1MDA4ODhkNjc0M2ZhMDExZDg5ZDljNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eBhHvAhofYaGXnqEAD6igpIaOik5KnbSmKyemwxQREA"]
        }
    }
    
    var path: String {
        switch self {
        case .getListOfMovie:
            return "popular"
        case .getDetailInfoAboutMovie(let id):
            return String(id)
        }
    }
    
    var request: URLRequest? {
        let url = URL(string: path, relativeTo: URL(string: baseURL))
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        switch self {
        case .getListOfMovie, .getDetailInfoAboutMovie:
            request.httpMethod = "GET"
            return request
        }
        
    }
}

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func getListOfMovie(completion: @escaping (Movie?) -> Void) {
        let request = ApiType.getListOfMovie.request
        
        guard let request = request else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) {
                    completion(movie)
                } else {
                    completion(nil)
                }

        }
        task.resume()
    }
    
    func getDetailInfoAboutMovie(id: Int, completion: @escaping (DetailMovie?) -> Void) {
        let request = ApiType.getDetailInfoAboutMovie(id: id).request

        guard let request = request else { return }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let detail = try? JSONDecoder().decode(DetailMovie.self, from: data) {
                completion(detail)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let _ = CacheManager.shared.getData(key: urlString as NSString) as? UIImage {
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }
    }
}
