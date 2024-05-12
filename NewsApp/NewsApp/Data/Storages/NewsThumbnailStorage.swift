//
//  NewsThumbnailStorage.swift
//  NewsApp
//
//  Created by YouDongwoo on 2024/05/12.
//

import UIKit
import Combine

protocol NewsThumbnailStorage {
    func fetch(id: String) -> AnyPublisher<UIImage?, Error>
    func save(id: String, image: UIImage)
}
