//
//  JobsViewModel.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/21/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import Foundation
import RxSwift
import Action


protocol JobsVieModelInput {
    var loadMore: BehaviorSubject<Bool> { get }
    
    var filterByAction: Action<FilterBy, Void> { get }
    
    func refresh()
}

protocol JobsViewModelOutput {
    var jobs: Observable<[Job]>! { get }
    
    var filterBy: Observable<FilterBy>! { get }
    
    var isLoading: Observable<Bool>! { get }
}


protocol JobsViewModelType {
    var inputs: JobsVieModelInput { get }
    var outputs: JobsViewModelOutput { get }
}


class JobsViewModel: JobsVieModelInput, JobsViewModelOutput, JobsViewModelType {
    //MARK: inputs
    var loadMore = BehaviorSubject<Bool>(value: false)
    
    lazy var filterByAction: Action<FilterBy, Void> =  {
        Action<FilterBy, Void> { [unowned self] filterBy in
            
            self.filterByProperty.onNext(filterBy)
            
            self.refresh()
            
            return .empty()
        }
    }()
    
    
    //MARK: outputs
    var jobs: Observable<[Job]>!
    
    var filterBy: Observable<FilterBy>!
    
    var isLoading: Observable<Bool>!
    
    
    //MARK: inputs & outputs
    var inputs: JobsVieModelInput { return self }
    
    var outputs: JobsViewModelOutput { return self }
    
    //MARK: properties
    private let filterByProperty = BehaviorSubject<FilterBy>(value: .none)
    private let isLoadingProperty = BehaviorSubject<Bool>(value: true)
    private var jobsArray = [Job]()
    private let service: JobsService
    private var currentPage = 1
    
    init(service: JobsService = JobsService()){
        self.service = service
        
        isLoading = isLoadingProperty.asObservable()
        filterBy = filterByProperty.asObservable()
        
        let firstRequest = Observable.combineLatest(isLoading, filterBy)
            .flatMapLatest { [unowned self] isLoading, filterBy -> Observable<[Job]> in
                guard isLoading else { return .empty() }
                return self.service.getJobs(page: self.currentPage, filterBy: filterBy)
                    .flatMap{ result -> Observable<[Job]> in
                        switch result {
                        case let .sucess(jobs):
                            return .just(jobs)
                        case .error(_):
                            self.isLoadingProperty.onNext(false)
                            return .empty()
                        }
                    }
        }
        
        let nextRequest = Observable.combineLatest(loadMore, filterBy)
            .flatMapLatest { [unowned self] loadMore, filterBy -> Observable<[Job]> in
                guard loadMore else { return .empty() }
                self.currentPage+=1
                return self.service.getJobs(page: self.currentPage, filterBy: filterBy)
                    .flatMap{ result -> Observable<[Job]> in
                        switch result {
                        case let .sucess(jobs):
                            return .just(jobs)
                        case .error(_):
                            self.isLoadingProperty.onNext(false)
                            return .empty()
                        }
                }
        }
        
        jobs = Observable.merge(firstRequest, nextRequest)
            .map{ [unowned self] jobs -> [Job] in
                for job in jobs {
                    self.jobsArray.append(job)
                }
                self.isLoadingProperty.onNext(false)
                return self.jobsArray
        }
    }
    
    func refresh() {
        isLoadingProperty.onNext(true)
        self.currentPage = 1
        self.jobsArray = []
    }
}
