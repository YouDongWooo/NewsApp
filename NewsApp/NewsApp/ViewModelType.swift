//
//  ViewModelType.swift
//  NewsApp
//
//  Created by dwyou on 2024/05/12.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
