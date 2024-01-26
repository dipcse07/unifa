//
//  PreviewViewModelTest.swift
//  Unifa
//
//  Created by intel on 2024/01/26.
//

@testable import Unifa
import XCTest
import RxSwift
import RxCocoa
import RxTest
import NSObject_Rx

// MARK: - Preview View Model Test
class PreviewViewModelTests: XCTestCase {

    func testImageSubjectReceivesValue() throws{

        let scheduler = TestScheduler(initialClock: 0)
        // Arrange
        let src = Src(
            medium: "https://example.com/img.jpg",
            large2x: "https://example.com/img2.jpg"
        )
        
        let viewModel = PreviewViewModel(src: src)
        let observable = scheduler.createColdObservable([
            .next(10, ())
        ])

        // input
        observable
            .bind(to: viewModel.input.viewDidAppear)
            .disposed(by: rx.disposeBag)

        // Assert
        let observer = scheduler.createObserver(String.self)
        
        viewModel
            .output
            .imageUrl
            .drive(observer)
            .disposed(by: rx.disposeBag)
        
        scheduler.start()
        let expected: [Recorded<Event<String>>] = [
            .next(10, src.large2x)
        ]
        
        XCTAssertEqual(observer.events, expected)
    }

}
