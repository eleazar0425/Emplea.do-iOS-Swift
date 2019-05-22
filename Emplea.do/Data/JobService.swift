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

class JobsService: JobDataSource {
    
    var provider: MoyaProvider<JobTarget>
    
    init(provider: MoyaProvider<JobTarget> = MoyaProvider<JobTarget>(plugins: [NetworkLoggerPlugin(verbose: false)])){
        self.provider = provider
    }
    
    func getJobs(page: Int, filterBy: FilterBy) -> Observable<Result<[Job], String>> {
        let target = JobTarget.getJobs(page: page, filterBy: filterBy)
        return provider.rx.request(target)
            .retry(3)
            .map(to: [Job].self)
            .asObservable()
            .map(Result.sucess)
            .catchError({ error -> Observable<Result<[Job], String>> in
                return .just(Result.error(error.localizedDescription))
            })
    }
}
