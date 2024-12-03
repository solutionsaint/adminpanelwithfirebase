import 'package:flutter/material.dart';

import 'package:location_app/screens/admin/admin_location_screen.dart';
import 'package:location_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:location_app/screens/admin/reception_enquiry_screen.dart';
import 'package:location_app/screens/admin/resolved_enquiry_screen.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String location = '/location';
  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';
  static const String resolvedEnquiry = '/resolved-enquiry';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      location: (context) => const AdminLocationScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen(),
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      resolvedEnquiry: (context) => const ResolvedEnquiryScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.location;
  }
}
