//
//  JobsTarget.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Moya

enum JobTarget {
    case getJobs(page: Int, filterBy: FilterBy)
}

extension JobTarget: TargetType {
    
    var defaultPageSize: Int {
        return 12
    }
    
    var baseURL: URL {
        return URL(string: "https://api.cuatrokb.com/v1/empleado")!
    }
    
    var path: String {
        return "/jobs.json"
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case let .getJobs(page, filterBy):
            return .requestParameters(parameters: [
            "page": page,
            "PageSize": defaultPageSize,
            "JobCategory": filterBy.rawValue], encoding: URLEncoding.queryString)
        }
    }
}
