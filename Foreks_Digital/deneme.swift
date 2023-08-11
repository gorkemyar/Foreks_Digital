//protocol LoginNavigation: AnyObject {
//  func goToRiskInformation()
//  func goToLoginSMSVerification(successHandler: (()-> Void)?)
//  func goToLoginOTPVerfication(successHandler: (()-> Void)?)
//  func goToMyPage()
//  func initMainTabBar()
//}
//
//class LoginCoordinator: Coordinator {
//  weak var parentCoordinator: Coordinator?
//  var children: [Coordinator] = []
//  var navigationController: UINavigationController
//  var authService: AuthenticationService?
//  var keepFlowHandler: (()-> Void)?
//  init(
//    navigationController: UINavigationController,
//    keepFlowHandler: (()-> Void)?
//  ) {
//    self.navigationController = navigationController
//    self.keepFlowHandler = keepFlowHandler
//  }
//
//  func start() {
//    let vc = LoginViewController.instantiateViewController()
//    self.authService = AuthServiceFactory.create()
//    vc.viewModel = LoginViewModel(
//      navigation: self,
//      authService: self.authService!,
//      keepFlowHandler: self.keepFlowHandler
//    )
//    vc.viewModel.finishFlow = { [weak self] in
//      self?.parentCoordinator?.childDidFinish(self)
//    }
//    navigationController.pushViewController(vc, animated: true)
//  }
//  deinit {
//    parentCoordinator?.childDidFinish(self)
//  }
//
//}
//extension LoginCoordinator: LoginNavigation {
//  func goToRiskInformation() {
//    let coordinator = RiskInformationCoordinator(
//      navigationController: self.navigationController
//    )
//    coordinator.parentCoordinator = self
//    children.append(coordinator)
//    coordinator.start()
//  }
//  func goToLoginSMSVerification(
//    successHandler: (()-> Void)?
//  ) {
//    guard let authService else { return }
//    let coordinator = LoginSMSVerificationCoordinator(
//      navigationController: self.navigationController,
//      authService: authService,
//      successHandler: successHandler
//    )
//    coordinator.parentCoordinator = self
//    children.append(coordinator)
//    coordinator.start()
//  }
//  func goToLoginOTPVerfication(
//    successHandler: (()-> Void)?
//  ) {
//    guard let authService else { return }
//    let coordinator = LoginOTPVerificationCoordinator(
//      navigationController: self.navigationController,
//      authService: authService,
//      successHandler: successHandler
//    )
//    coordinator.parentCoordinator = self
//    children.append(coordinator)
//    coordinator.start()
//  }
//}
