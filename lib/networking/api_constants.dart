class ApiConstant {
  ApiConstant._();
  static String baseUrl = "http://3.6.63.31:2202"; //live
  // static String baseUrl = 'https://localhost:44338'; //local
  static const login = '/api/Registration/SaveSigin';
  static const register = '/api/Registration/SaveRegister';
  static const getDashboardList = '/api/Registration/GetDashBoardList';
  static const getRegister = '/api/Registration/GetRegister';
  static const getOtp = '/api/Registration/GetSMSOTP';
  static const verityOtp = '/api/Registration/VerifyOTP';
  static const getExcelFormat = '/api/DataMigration/DocumentDownload';
  static const approveProfile = '/api/Registration/UpdateApproval';
  static const uploadImage = '/api/Registration/AssocyUpload';
  static const getImage = '/api/Registration/getDMSImg';
  static const getAllCompanies = '/api/Registration/GetAllCompanies';
  static const checkNumberAvailability =
      '/api/Registration/MobileNumberUniqueness';
  static const updateProfile = '/api/Registration/UpdateProfile';

  //**************separate api url******************//
  static const getPostalAddress = 'http://www.postalpincode.in/api/pincode/';
  //**************separate api url******************//
}
