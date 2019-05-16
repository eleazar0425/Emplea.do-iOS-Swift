//
//  JobsService.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ModelMapper

class JobsService: JobsDataSource {
    
    var provider: MoyaProvider<JobsTarget>
    
    init(provider: MoyaProvider<JobsTarget> = MoyaProvider<JobsTarget>()){
        self.provider = provider
    }
    
    func getJobs(page: Int, filterBy: FilterBy) -> Observable<[Job]> {
        guard let target = JobsTarget.instantiate(page: page, rawValue: filterBy.rawValue) else { fatalError("Invalid or unsoported filter provided") }
        
        return provider.rx.request(target)
            .retry(2)
            .map(to: [Job].self)
            .asObservable()
    }
}
