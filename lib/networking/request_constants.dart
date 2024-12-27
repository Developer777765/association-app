class RequestConstant {
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 100;
  static late final int commpanyId;
  static String? commpanyPath;

  static const int locationId = 8;
  static const String applicationId = "MTERP";

  static const nonLoginUserId = "267";
  static const nonLoginAgentId = "3903";
  static const nonLoginCreatedBy = "Customer";
  static String customerUniqueId = '';
}

class ResponseConstant {
  static const int successCode = 200;
  static const int unAuthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;
  static const String success = "Success";
}

// var Imn = 9;
// var rh = Env.tmdbApiKey;
