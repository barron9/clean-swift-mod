//
//  WelcomeInteractor.swift
//  Authentication
//
//  Created by Raymond Law on 10/26/17.
//  Copyright (c) 2017 Clean Swift LLC. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore
{
  var presenter: WelcomePresentationLogic?
  var worker = WelcomeWorker()
  var isLoggedIn = false
  
  // MARK: Login
  
  func login(request: Welcome.Login.Request)
  {
    worker.login(email: request.email, password: request.password) { (success, username) in
      self.isLoggedIn = success
      let response = Welcome.Login.Response(success: success, username: username)
      self.presenter?.presentLogin(response: response)
    }
  }
}
