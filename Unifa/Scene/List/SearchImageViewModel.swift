//
//  SearchImageViewModel.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx

// MARK: - Search Image ViewModel
class SearchImageViewModel: NSObject, CommonViewModelProtocol {

    // MARK: - Properties
    var input:Input!
    var output: Output!
    
    // MARK: - Input Processing Subjects
    private let searchTextSubject = PublishSubject<String>()
    private let selectedImageSubject = PublishSubject<Photo>()
    private let nextPageRequestSubject = PublishSubject<Void>()

    // MARK: - Output Processing Subjects
    private let sectionsSubject = PublishSubject<[PhotoSection]>()
    private let didPreviewScreenRequestSubject = PublishSubject<Src>()
    
    var apiClient: APIServiceProtocol
    
    private let hasNextPageRelay = BehaviorRelay<Bool>(value: false)
   
    init(apiClient: APIServiceProtocol) {
        self.apiClient = apiClient
        super.init()
        makeIO()
        bind()
    }
}

// MARK: - Input and Output
 extension SearchImageViewModel {
    
     struct Input {
         let searchText: AnyObserver<String>
         let selectedImage: AnyObserver<Photo>
         let nextPageRequest: AnyObserver<Void>
     }
     
     struct Output {
         let sections: Driver<[PhotoSection]>
         let didPreviewScreenRequest: Driver<Src>
     }
     
     private func makeIO() {
         input = Input(
            searchText: searchTextSubject.asObserver(),
            selectedImage: selectedImageSubject.asObserver(),
            nextPageRequest: nextPageRequestSubject.asObserver()
         )
         
         output = Output(
            sections: sectionsSubject.asDriver(onErrorJustReturn: []),
            didPreviewScreenRequest: didPreviewScreenRequestSubject.asDriver(onErrorJustReturn: Src(medium: "", large2x: ""))
         )
     }
}

// MARK: Bind
extension SearchImageViewModel {
    
    func bind() {
        
        let currentPageRelay = BehaviorRelay<Int>(value: 1)
        
        let sharedCurrentPage = currentPageRelay
            .share(replay: 1)
 
        let sharedSearchText = searchTextSubject
            .share(replay: 1)
        
        let nextPageRequest = nextPageRequestSubject
            .withLatestFrom(hasNextPageRelay)
            .filter { $0 }
            .share(replay: 1)
        
        let nextPageSearch = nextPageRequest
            .withLatestFrom(searchTextSubject)
        
        nextPageSearch
            .withLatestFrom(sharedCurrentPage)
            .map { $0 + 1 }
            .bind(to: currentPageRelay)
            .disposed(by: rx.disposeBag)
        
        sharedSearchText
            .withLatestFrom(sharedCurrentPage) { (query: $0, page: $1) }
            .flatMapLatest { [weak self] tuple -> Observable<SearchedImage> in
                guard let self else { return .empty() }
                return self.fetchImage(with: tuple.query, page: tuple.page)
            }
            .map { [PhotoSection(id: $0.page, items: $0.photos)] }
            .bind(to: sectionsSubject)
            .disposed(by: rx.disposeBag)
        
        nextPageSearch
            .withLatestFrom(sharedCurrentPage) { (query: $0, page: $1) }
            .flatMapLatest { [weak self] tuple -> Observable<SearchedImage> in
                guard let self else { return .empty() }
                return self.fetchImage(with: tuple.query, page: tuple.page)
            }
            .map { [PhotoSection(id: $0.page, items: $0.photos)] }
            .withLatestFrom(sectionsSubject) { new, old in
                var copy = old
                copy.append(contentsOf: new)
                return copy
            }
            .bind(to: sectionsSubject)
            .disposed(by: rx.disposeBag)
        
        selectedImageSubject
            .map { $0.src }
            .bind(to: didPreviewScreenRequestSubject)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - API
extension SearchImageViewModel {
    private func fetchImage(with query: String, page: Int) -> Observable<SearchedImage> {
        let request = SearchImageRequest(query: query, page: page)
        return apiClient.request(request, decoder: JSONDecoder())
            .do(onNext: { [unowned self] image in
                self.hasNextPageRelay.accept(image.nextPage != nil)
            })
    }
}

// MARK: - PhotoSection
struct PhotoSection: IdentifiableType {
    var id: Int
    var items: [Photo]
    
    var identity: String {
        "photo-section-\(id)"
    }
}

// MARK: - PhotoSection + AnimatableSectionModelType
extension PhotoSection: AnimatableSectionModelType {
    init(original: PhotoSection, items: [Photo]) {
        self = original
        self.items = items
    }
}
