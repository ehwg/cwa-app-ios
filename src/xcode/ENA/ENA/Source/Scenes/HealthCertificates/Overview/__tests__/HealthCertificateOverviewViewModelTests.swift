////
// 🦠 Corona-Warn-App
//

import XCTest
@testable import ENA

class HealthCertificateOverviewViewModelTests: XCTestCase {

	func testGIVEN_HealthCertificateOverviewViewModel_THEN_SetupIstCorrect() {
		// GIVEN
		let viewModel = HealthCertificateOverviewViewModel(healthCertificateService: service)

		// THEN
		XCTAssertEqual(viewModel.numberOfSections, 6)
		XCTAssertEqual(viewModel.numberOfRows(in: 0), 1)
		XCTAssertEqual(viewModel.numberOfRows(in: 1), 0)
		XCTAssertEqual(viewModel.numberOfRows(in: 2), 1)
		XCTAssertEqual(viewModel.numberOfRows(in: 3), 0)
		XCTAssertEqual(viewModel.numberOfRows(in: 4), 0)
		XCTAssertEqual(viewModel.numberOfRows(in: 5), 1)
	}

	func testGIVEN_requestTestCertificate_THEN_noErrorIsSet() {
		// GIVEN
		let viewModel = HealthCertificateOverviewViewModel(healthCertificateService: service)
		service.registerAndExecuteTestCertificateRequest(
			coronaTestType: .pcr,
			registrationToken: "registrationToken",
			registrationDate: Date(),
			retryExecutionIfCertificateIsPending: false
		)

		viewModel.retryTestCertificateRequest(at: IndexPath(row: 0, section: 0))

		// THEN
		XCTAssertNil(viewModel.$testCertificateRequestError.value)
	}

	// MARK: - Private

	private let service: HealthCertificateService = {
		HealthCertificateService(
			store: MockTestStore(),
			client: ClientMock(),
			appConfiguration: CachedAppConfigurationMock()
		)
	}()


}
