//
//  WelcomePresenterTests.swift
//  Authentication
//
//  Created by Raymond Law on 10/26/17.
//  Copyright (c) 2017 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import Authentication
import XCTest

class WelcomePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: WelcomePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupWelcomePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupWelcomePresenter()
  {
    sut = WelcomePresenter()
  }
  
  // MARK: Test doubles
  
  class WelcomeDisplayLogicSpy: WelcomeDisplayLogic
  {
    var displayLoginCalled = false
    var displayLoginViewModel: Welcome.Login.ViewModel!
    
    func displayLogin(viewModel: Welcome.Login.ViewModel)
    {
      displayLoginCalled = true
      displayLoginViewModel = viewModel
    }
  }
  
  // MARK: Tests
  
  func testPresentLoginOnSuccess()
  {
    // Given
    let spy = WelcomeDisplayLogicSpy()
    sut.viewController = spy
    let response = Welcome.Login.Response(success: true, username: "Ray")
    
    // When
    sut.presentLogin(response: response)
    
    // Then
    XCTAssertTrue(spy.displayLoginCalled, "presentLogin(response:) should ask the view controller to display the result")
    XCTAssertTrue(spy.displayLoginViewModel.success, "presentLogin(response:) should result in success")
    XCTAssertEqual(spy.displayLoginViewModel.greeting, "Hello Ray", "presentLogin(response:) should result in a normal greeting")
  }
  
  func testPresentLoginOnFailure()
  {
    // Given
    let spy = WelcomeDisplayLogicSpy()
    sut.viewController = spy
    let response = Welcome.Login.Response(success: false, username: nil)
    
    // When
    sut.presentLogin(response: response)
    
    // Then
    XCTAssertTrue(spy.displayLoginCalled, "presentLogin(response:) should ask the view controller to display the result")
    XCTAssertFalse(spy.displayLoginViewModel.success, "presentLogin(response:) should result in failure")
    XCTAssertEqual(spy.displayLoginViewModel.greeting, "", "presentLogin(response:) should result in an empty greeting")
  }
}
