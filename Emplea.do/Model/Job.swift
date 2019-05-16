//
//  Job.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import Mapper

class Job: Mappable {
    
    var title, link, uri, company, location, date, category, type: String
    
    required init(map: Mapper) throws {
        try title = map.from("jobTitle")
        try link = map.from("JobLink")
        try uri = map.from("JobURI")
        try company = map.from("jobCompany")
        try location = map.from("jobLocation")
        try date = map.from("jobDate")
        try category = map.from("jobCategory")
        try type = map.from("jobType")
    }
}
