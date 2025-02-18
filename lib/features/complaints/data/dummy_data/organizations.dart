/// Represents an organization in the system
class Organization {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String category;
  final String? website;
  final String? address;
  final String logoUrl;

  const Organization({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.category,
    this.website,
    this.address,
    required this.logoUrl,
  });
}

/// Dummy organizations data
final List<Organization> organizations = [
  // Banking
  Organization(
    id: 'bank-1',
    name: 'Global Trust Bank',
    email: 'complaints@gtbank.com',
    phone: '+1-555-0123',
    category: 'Banking',
    website: 'www.gtbank.com',
    address: '123 Financial District, NY',
    logoUrl: 'assets/logos/gtbank.png',
  ),
  Organization(
    id: 'bank-2',
    name: 'City Finance Bank',
    email: 'support@cityfinance.com',
    phone: '+1-555-0124',
    category: 'Banking',
    website: 'www.cityfinance.com',
    address: '456 Banking Ave, LA',
    logoUrl: 'assets/logos/cityfinance.png',
  ),
  // Add more banks...

  // Government
  Organization(
    id: 'gov-1',
    name: 'Department of Transportation',
    email: 'complaints@dot.gov',
    phone: '+1-555-0125',
    category: 'Government',
    website: 'www.dot.gov',
    address: '789 Government Plaza, DC',
    logoUrl: 'assets/logos/dot.png',
  ),
  Organization(
    id: 'gov-2',
    name: 'Social Security Administration',
    email: 'feedback@ssa.gov',
    phone: '+1-555-0126',
    category: 'Government',
    website: 'www.ssa.gov',
    address: '321 Federal Building, DC',
    logoUrl: 'assets/logos/ssa.png',
  ),
  // Add more government organizations...

  // Telecom
  Organization(
    id: 'tel-1',
    name: 'ConnectX Mobile',
    email: 'care@connectx.com',
    phone: '+1-555-0127',
    category: 'Telecom',
    website: 'www.connectx.com',
    address: '741 Tech Park, SF',
    logoUrl: 'assets/logos/connectx.png',
  ),
  // Add more telecom companies...

  // Add more banking organizations
  Organization(
    id: 'bank-3',
    name: 'Secure Savings Bank',
    email: 'support@securesavings.com',
    phone: '+1-555-0128',
    category: 'Banking',
    website: 'www.securesavings.com',
    address: '789 Financial Ave, Chicago',
    logoUrl: 'assets/logos/ssbank.png',
  ),
  Organization(
    id: 'bank-4',
    name: 'National Credit Union',
    email: 'complaints@ncu.com',
    phone: '+1-555-0129',
    category: 'Banking',
    website: 'www.ncu.com',
    address: '321 Credit Lane, Boston',
    logoUrl: 'assets/logos/ncu.png',
  ),

  // Add more government organizations
  Organization(
    id: 'gov-3',
    name: 'Department of Education',
    email: 'feedback@education.gov',
    phone: '+1-555-0130',
    category: 'Government',
    website: 'www.education.gov',
    address: '456 Education Plaza, DC',
    logoUrl: 'assets/logos/education.png',
  ),
  Organization(
    id: 'gov-4',
    name: 'Internal Revenue Service',
    email: 'support@irs.gov',
    phone: '+1-555-0131',
    category: 'Government',
    website: 'www.irs.gov',
    address: '789 Tax Court, DC',
    logoUrl: 'assets/logos/irs.png',
  ),

  // Add more telecom organizations
  Organization(
    id: 'tel-2',
    name: 'Global Communications',
    email: 'support@globalcomm.com',
    phone: '+1-555-0132',
    category: 'Telecom',
    website: 'www.globalcomm.com',
    address: '123 Network Ave, Dallas',
    logoUrl: 'assets/logos/globalcomm.png',
  ),
  Organization(
    id: 'tel-3',
    name: 'Fiber Connect',
    email: 'care@fiberconnect.com',
    phone: '+1-555-0133',
    category: 'Telecom',
    website: 'www.fiberconnect.com',
    address: '456 Broadband St, Seattle',
    logoUrl: 'assets/logos/fiberconnect.png',
  ),
];

// I'll continue with more organizations in the next message... 