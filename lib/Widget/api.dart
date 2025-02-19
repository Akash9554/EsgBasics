class ApiEndPoints {
  static const String baseUrl = 'https://ellatangenterprises.com/demoo/esg/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = 'registration';
  final String login = 'login';
  final String change_password= 'change_password';
  final String profile = 'get_profile';
  final String forgetpassword= 'forgot_password';
  final String edit_profile=  'edit_profile';
  final String update_device_token = 'update_device_token';
  final String verify_otp = 'verify_otp';
  final String farmer_form_create= 'farmer_form_create';
  final String farmer_form_list= 'farmer_form_list';
  final String farmer_form_delete= 'farmer_form_delete';
  final String setting = 'setting';
  final String ginner_incomming_cotton_batch= 'ginner_incomming_cotton_batch';

  final String ginner_incomming_cotton_batch_create_invoice= 'ginner_incomming_cotton_batch_create_invoice';
  final String farmer_form_approve_reject= 'farmer_form_approve_reject';
  final String ginner_form_create_spinner= 'ginner_form_create_spinner';
  final String spinner_ginner_invoice= 'spinner_ginner_invoice';
  final String spinner_create_invoice= 'spinner_create_invoice';
  final String ginner_approve_reject_spinner_invoice= 'ginner_approve_reject_spinner_invoice';
  final String spinner_create_form= 'spinner_create_form';
  final String textile_spinner_form_list= 'textile_spinner_form';
  final String textile_create_invoice= 'textile_create_invoice';
  final String textile_create_form= 'textile_create_form';
  final String textile_approve_reject_garment_invoice= 'textile_approve_reject_garment_invoice';
  final String garment_textile_form= 'garment_textile_form';
  final String garment_create_invoice= 'garment_create_invoice';
  final String garment_create_form= 'garment_create_form';
  final String deleteuser= 'deleteUser';
  final String spinner_approve_reject_textile_invoice= 'spinner_approve_reject_textile_invoice';

}






