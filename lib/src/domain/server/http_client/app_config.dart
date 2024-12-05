
import '../../../global/constants/enum.dart';

enum AppConfig {
  base,
  baseImage,
  logInUrl,
  userProfileImgUrl,
  signatureImgUrl,
  userProfileUrl,
  companyInfoUrl,
  changePasswordUrl,
  emailSendOtpUrl,
  otpCodeUrl,
  resetPasswordUrl,

  requisitionListUrl,
  vehicleTypeListUrl,
  divisionUrl,
  districtUrl,
  sectionListUrl,
  employeeListUrl,
  requisitionSubmitUrl,

  deptHeadRequisitionListUrl,
  directoryRequisitionListUrl,
  dgmRequisitionListUrl,
  tsoRequisitionListUrl,

  forwardTsoUrl,
  approvalTsoUrl,
  rejectRequisitionUrl,
  vehicleListUrl,
  driverListUrl,
  assignDriverUrl,

  noticeUrl,
  sliderListUrl,

}

extension AppUrlExtention on AppConfig {
  static String _baseUrl = "";
  // static String _baseImageUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";
        // _baseImageUrl = "";
        break;
      case UrlLink.isDev:
        _baseUrl = "https://brrivms.softwaresale.xyz";
        // _baseImageUrl = "https://brrivms.softwaresale.xyz";

        break;
      case UrlLink.isLocalServer:
        _baseUrl = "";
        // _baseImageUrl = "";
        break;
    }
  }

  String get url {
    switch (this) {
      case AppConfig.base:
        return _baseUrl;
      case AppConfig.baseImage:
        return "";

    /// ==/@ Auth Api Url @/==
      case AppConfig.logInUrl:
        return '/api/login';
      case AppConfig.userProfileImgUrl:
        return '/api/image/update';
      case AppConfig.signatureImgUrl:
        return '/api/signature/update';
      case AppConfig.userProfileUrl:
        return '/api/profile';
      case AppConfig.companyInfoUrl:
        return '/api/brri/info';
      case AppConfig.changePasswordUrl:
        return '/api/change/password';
      case AppConfig.emailSendOtpUrl:
        return '/api/password/request/otp';
      case AppConfig.otpCodeUrl:
        return '/api/password/validate/otp';
      case AppConfig.resetPasswordUrl:
        return '/api/password/reset/password';



      case AppConfig.requisitionListUrl:
        return '/api/employee/requisition/list';
      case AppConfig.vehicleTypeListUrl:
        return '/api/vehicle/type';
      case AppConfig.divisionUrl:
        return '/api/division';
      case AppConfig.districtUrl:
        return '/api/district';
      case AppConfig.sectionListUrl:
        return '/api/section/list';
      case AppConfig.employeeListUrl:
        return '/api/employee/list';
      case AppConfig.requisitionSubmitUrl:
        return '/api/requisition/submit';

      case AppConfig.deptHeadRequisitionListUrl:
        return '/api/requisition/list/head';
      case AppConfig.directoryRequisitionListUrl:
        return '/api/requisition/list/director';
      case AppConfig.dgmRequisitionListUrl:
        return '/api/employee/requisition/list/dgm';
      case AppConfig.tsoRequisitionListUrl:
        return '/api/employee/requisition/list/tso';
      case AppConfig.forwardTsoUrl:
        return '/api/requisition/forward/tso';
      case AppConfig.approvalTsoUrl:
        return '/api/requisition/approve/tso';
      case AppConfig.rejectRequisitionUrl:
        return '/api/reject/requisition';
      case AppConfig.vehicleListUrl:
        return '/api/vehicle/list';
      case AppConfig.driverListUrl:
        return '/api/driver/list';
      case AppConfig.assignDriverUrl:
        return '/api/vehicle/assign';

      case AppConfig.noticeUrl:
        return '/api/notice/list';
      case AppConfig.sliderListUrl:
        return '/api/slider/list';



      default:
    }
    return "";
  }
}
