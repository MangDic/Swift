//
//  Midea.swift
//  MovieForm
//
//  Created by 이명직 on 2021/07/23.
//

import Foundation
import UIKit

struct media: Codable {
    let categories: [detail]
    
    private enum CodingKeys: String, CodingKey {
        case categories
    }
}

struct detail: Codable {
    let description: String
    let sources: String
    let subtitle: String
    var thumb: String
    let title: String
    
    private enum CodingKeys: String, CodingKey {
        case description, sources, subtitle, thumb, title
    }
}


extension media {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = (try? values.decode([detail].self, forKey: .categories)) ?? [detail(description: "null", sources: "null", subtitle: "null", thumb: "null", title: "null")]
    }
}

extension detail{
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = (try? values.decode(String.self, forKey: .description)) ?? "null"
        sources = (try? values.decode(String.self, forKey: .sources)) ?? "null"
        subtitle = (try? values.decode(String.self, forKey: .subtitle)) ?? "null"
        thumb = (try? values.decode(String.self, forKey: .thumb)) ?? "null"
        title = (try? values.decode(String.self, forKey: .title)) ?? "null"
    }
}
