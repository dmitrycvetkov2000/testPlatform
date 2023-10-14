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

enum NetworkError: Error {
    case badURL
    case otherError(Int)
    case noData
    case noDecode
}

final class APIManager {
    static let shared = APIManager()
    private init() {}
    private let jsonDecoder = JSONDecoder()
    var pathForImageStr = "https://image.tmdb.org/t/p/w500/"
    
    func getListOfMovie(completion: @escaping (Result<Movie, NetworkError>) -> Void) {
        let request = ApiType.getListOfMovie.request
        
        guard let request = request else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [jsonDecoder] data, response, error in
            
            if error != nil {
                if let httpResponse = response as? HTTPURLResponse {
                    completion(.failure(.otherError(httpResponse.statusCode)))
                } else {
                    completion(.failure(.otherError(-1)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try jsonDecoder.decode(Movie.self, from: data)
                completion(.success(result))
            } catch {
                return completion(.failure(.noDecode))
            }
        }
        task.resume()
    }
    
    func getDetailInfoAboutMovie(id: Int, completion: @escaping (DetailMovie?) -> Void) {
        let request = ApiType.getDetailInfoAboutMovie(id: id).request
        
        guard let request = request else { return }
        
        let task = URLSession.shared.dataTask(with: request) { [jsonDecoder] data, response, error in
            if let data = data, let detail = try? jsonDecoder.decode(DetailMovie.self, from: data) {
                completion(detail)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: "\(pathForImageStr)\(urlString)") else { return }
        
        if let image = CacheManager.shared.getData(key: urlString as NSString) as? UIImage {
            completion(image)
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
