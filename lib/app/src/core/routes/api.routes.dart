class ApiRoutes {
  static String get baseUrl => _productionBaseUrl;
  static const String API_VERSION = "v1";

  //Homologation

  //Production
  static const String _productionBaseUrl =
      "http://cglael-001-site4.gtempurl.com/api/$API_VERSION/";

//----------------------------------------------------------------------------

//LOGIN
  static const String authAuthenticate = "Auth";

//----------------------------------------------------------------------------

//COMPANY
  static const String getCompanys = "Company";
  static const String addCompany = "Company";
  static const String updateCompany = "Company";

  static String getCompanyByCode(int idCompany) => "Company/$idCompany";

  static String deleteCompanyByCode(int idCompany) => "Company/$idCompany";

//----------------------------------------------------------------------------

//DISTRIBUTOR
  static String getDistributors(int status) => "Distributor/$status";

  static String getDistributorByCode(int idDistributor) =>
      "Distributor/$idDistributor";
  static const String addDistributor = "Distributor";
  static const String updateDistributor = "Distributor";

//----------------------------------------------------------------------------

//DRUG
  static const String getDrugs = "Drug";
  static const String updateDrug = "Drug";
  static const String addDrug = "Drug";

  static String getDrugByCode(int idDrug) => "Drug/$idDrug";

  static String deleteDrugByCode(int idDrug) => "Drug/$idDrug";

//----------------------------------------------------------------------------

//PRESCRIPTION
  static const String getPrescriptions = "Prescription";
  static const String addPrescription = "Prescription";

  static String getPrescriptionByCode(int idPrescription) =>
      "Prescription/$idPrescription";

  static String deletePrescriptionByCode(int idPrescription) =>
      "Prescription/$idPrescription";

//----------------------------------------------------------------------------

//USER
  static String addUser(String cnpj) => "User/$cnpj";

//----------------------------------------------------------------------------

//RECOVERY PASSWORD
  static const String sendEmail = 'RecoverPassMail';
  static const String replacePassByCode = 'ReplacePassByCode';
//----------------------------------------------------------------------------

}
