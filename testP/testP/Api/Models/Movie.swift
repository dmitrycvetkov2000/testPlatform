//
//  Movie.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import Foundation

// MARK: - Movie
struct Movie: Decodable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    // MARK: - Result
    struct Result: Decodable {
        let backdropPath: String?
        let id: Int?
        let originalTitle, overview: String?
        let popularity: Double?
        let posterPath, releaseDate, title: String?
        let video: Bool?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
        }
    }
}


