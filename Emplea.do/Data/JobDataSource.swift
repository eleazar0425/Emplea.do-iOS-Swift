//
//  JobsDataSource.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift

protocol JobDataSource {
    func getJobs(page: Int, filterBy: FilterBy) -> Observable<[Job]>
}
