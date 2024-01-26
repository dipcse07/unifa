//
//  PreviewViewModel.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import RxSwift
import RxCocoa

class PreviewViewModel: NSObject, CommonViewModelProtocol {

    // MARK: - Properties
    var input: Input!
    var output: Output!

    // MARK: - Input Processing Subjects
    private let viewDidAppearSubject = PublishSubject<Void>()

    // MARK: - Output Processing Subjects
    private let imageUrlSubject = PublishSubject<String>()
    
    private let src: Src

    init(src: Src) {
        self.src = src
        super.init()
        makeIO()
        bind()
    }
}

// MARK: - Input and Output
extension PreviewViewModel {

    struct Input {
        let viewDidAppear: AnyObserver<Void>
    }

    struct Output {
        let imageUrl: Driver<String>
    }

    private func makeIO() {
        input = Input(
            viewDidAppear: viewDidAppearSubject.asObserver()
        )

        output = Output(
            imageUrl: imageUrlSubject.asDriver(onErrorJustReturn: "")
        )
    }
}

// MARK: Bind
extension PreviewViewModel {

    func bind() {
        viewDidAppearSubject
            .compactMap { [weak self] _ -> String? in
                guard let self else { return nil }
                return self.src.large2x
            }
            .bind(to: imageUrlSubject)
            .disposed(by: rx.disposeBag)
    }
       
}
