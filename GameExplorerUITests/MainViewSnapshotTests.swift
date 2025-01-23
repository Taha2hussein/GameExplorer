////
////  MainViewSnapshotTests.swift
////  GameExplorerUITests
////
////  Created by Taha Hussein on 23/01/2025.
////
//
//import Foundation
//import SnapshotTesting
//import XCTest
//@testable import Ga
//
//final class MainViewSnapshotTests: XCTestCase {
//    func testMainViewDefaultState() {
//        let viewModel = MainViewModel(gameRepository: MockGamesRepository())
//        let view = MainView()
//            .environmentObject(viewModel)
//
//        let host = UIHostingController(rootView: view)
//        host.view.frame = UIScreen.main.bounds
//
//        assertSnapshot(matching: host, as: .image)
//    }
//
//    func testMainViewLoadingState() {
//        let viewModel = MainViewModel(gameRepository: MockGamesRepository())
//        viewModel.isLoading = true
//        let view = MainView()
//            .environmentObject(viewModel)
//
//        let host = UIHostingController(rootView: view)
//        host.view.frame = UIScreen.main.bounds
//
//        assertSnapshot(matching: host, as: .image)
//    }
//}
