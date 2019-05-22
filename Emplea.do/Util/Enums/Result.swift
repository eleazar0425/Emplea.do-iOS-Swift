//
//  Result.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/22/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation

enum Result<T, E> {
    case sucess(T), error(E)
}
