/// Backend role titles the app switches on (`utils/types.py` `RoleType`).
/// Other titles (dynamic IG roles, staff roles) are ignored by the app.
abstract final class RoleTitles {
  static const student = 'Student';
  static const mentor = 'Mentor';
  static const enabler = 'Enabler';
  static const leadEnabler = 'Lead Enabler';
  static const campusLead = 'Campus Lead';
  static const zonalCampusLead = 'Zonal Campus Lead';
  static const districtCampusLead = 'District Campus Lead';
  static const company = 'Company';
}
