//
//  DataProvider.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import Foundation

// MARK: - DataProvider
class DataProvider<T> {
    
    fileprivate var currentPage = 0
    let pageSize: Int
    fileprivate var isFetchingFromServer = false
    fileprivate var noMoreData = false
    
    private(set) var data = [T]()
    
    fileprivate init(pageSize: Int) {
        self.pageSize = pageSize
    }
    
    func getData(onCompletion: @escaping () -> Void, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        guard !isFetchingFromServer,
              !noMoreData
        else {
            onCompletion()
            return
        }
        fetchData(onCompletion: onCompletion, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    fileprivate func fetchData(onCompletion: @escaping () -> Void, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        isFetchingFromServer = true
    }
    
    var theresMoreData: Bool {
        return !noMoreData
    }
    
    var isFetchingData: Bool {
        return isFetchingFromServer
    }
    
    func resetData() {
        currentPage = 0
        noMoreData = false
        isFetchingFromServer = false
        data.removeAll()
    }
    
    fileprivate func addData(_ data: [T]) {
        self.data.append(contentsOf: data)
    }
}

// MARK: - CharactersProvider
class CharactersProvider: DataProvider<Character> {
    
    static let shared = CharactersProvider()
    
    private init() {
        super.init(pageSize: 15)
    }
    
    override fileprivate func fetchData(onCompletion: @escaping () -> Void, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        super.fetchData(onCompletion: onCompletion, onSuccess: onSuccess, onFailure: onFailure)
        MarvelAPIClient.default.getCharacters(pageNumber: currentPage, pageSize: pageSize) {
            onCompletion()
            self.isFetchingFromServer = false
        } onSuccess: { characters in
            self.addData(characters)
            if characters.count != self.pageSize {
                self.noMoreData = true
            }
            self.currentPage += 1
            onSuccess()
        } onFailure: { error in
            onFailure(error)
        }
    }
}

// MARK: - EventsProvider
class EventsProvider: DataProvider<Event> {
    
    static let shared = EventsProvider()
    
    private init() {
        super.init(pageSize: 25)
    }
    
    override fileprivate func fetchData(onCompletion: @escaping () -> Void, onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        super.fetchData(onCompletion: onCompletion, onSuccess: onSuccess, onFailure: onFailure)
        MarvelAPIClient.default.getEvents(pageNumber: currentPage, pageSize: pageSize) {
            onCompletion()
            self.isFetchingFromServer = false
        } onSuccess: { events in
            self.addData(events)
            if events.count != self.pageSize {
                self.noMoreData = true
            }
            self.currentPage += 1
            onSuccess()
        } onFailure: { error in
            onFailure(error)
        }
    }
}
