import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/portfolio_models.dart';

/// Single source of truth for all content across the portfolio website.
/// Any updates to text, experience, solutions, skills, or links should be made here.
class PortfolioData {
  PortfolioData._();

  // ──────────────────────────── HERO SECTION ────────────────────────────
  static const String fullName = 'RUTVIK SHAH';
  static const String location = 'Ahmedabad, Gujarat, India';

  static const List<String> rotatingTitles = [
    'Senior Odoo Developer',
    'Odoo Functional Consultant',
    'Solution Architect',
    'Technical Team Lead',
  ];

  static const String tagline =
      'ERP architect with 5+ years building Odoo solutions for automobile dealerships, manufacturing and accounting.';

  static const String devResumePath =
      'assets/resumes/Rutvik_Shah_Developer_Resume.pdf';
  static const String functionalResumePath =
      'assets/resumes/Rutvik_Shah_Functional_Resume.pdf';

  // ──────────────────────────── STATS STRIP ────────────────────────────
  static const List<StatItem> stats = [
    StatItem(
      value: 5,
      suffix: '+',
      label: 'Years Experience',
      subtitle: 'Odoo ERP Development & Consulting',
      icon: FontAwesomeIcons.briefcase,
    ),
    StatItem(
      value: 4.0,
      suffix: '',
      label: 'Dealership Groups',
      subtitle: 'Enterprise Automobile Clients',
      icon: FontAwesomeIcons.car,
    ),
    StatItem(
      value: 700.0,
      suffix: '+',
      label: 'ERP Users',
      subtitle: 'Active daily enterprise users',
      icon: FontAwesomeIcons.users,
    ),
    StatItem(
      value: 1.0,
      suffix: '',
      label: 'ICICI Banking API',
      subtitle: 'Automated 2-way Reconciliation',
      icon: FontAwesomeIcons.buildingColumns,
    ),
    StatItem(
      value: 100.0,
      suffix: '%',
      label: 'GST Compliance',
      subtitle: 'GSTR-1, GSTR-3B & E-Way Bill',
      icon: FontAwesomeIcons.fileInvoiceDollar,
    ),
  ];

  // ──────────────────────────── ABOUT SECTION ──────────────────────────
  static const String devSummary =
      'Senior Odoo Developer with 5+ years of experience in Odoo ERP architecture, '
      'custom module development, and technical team leadership. Architected an '
      'Automobile Dealership ERP product deployed across 4 major dealership groups '
      'supporting 700+ users. Skilled in Odoo ORM, PostgreSQL database optimization, '
      'ICICI banking API integration, and cloud server administration.';

  static const String functionalSummary =
      'Odoo ERP Functional Consultant & Solution Architect with 5+ years of '
      'experience leading ERP implementations, business workflow design, and module '
      'configuration. Successfully managed the functional deployment of an Automobile '
      'Dealership ERP product across 4 major dealership groups supporting 700+ users. '
      'Experienced in requirement analysis, multi-branch financial accounting, GST '
      'compliance, and user training.';

  static const List<EducationItem> education = [
    EducationItem(
      degree: 'B.E. in Computer Engineering',
      institution: 'Government Engineering College, Modasa',
      location: 'Modasa, Gujarat',
      period: '2016 – 2020',
    ),
  ];

  static const List<LanguageItem> languages = [
    LanguageItem(language: 'English', proficiency: 'Full Professional'),
    LanguageItem(language: 'Gujarati', proficiency: 'Native Speaker'),
    LanguageItem(language: 'Hindi', proficiency: 'Fluent Working'),
  ];

  static const List<String> devHighlights = [
    'Odoo ORM & Custom Module Engineering',
    'PostgreSQL Query Optimization & Indexing',
    'ICICI Bank Automated API Integration',
    'Docker, Linux, & Production DevOps',
  ];

  static const List<String> functionalHighlights = [
    'Multi-Branch Dealership Accounting',
    'Automotive Deal & Gatepass Workflow Design',
    'Statutory GST (GSTR-1 / 3B) Configuration',
    'User Training, SOPs & Implementation Leadership',
  ];

  // ────────────────────────── EXPERIENCE SECTION ─────────────────────────
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      company: 'Sunray Datalinks Pvt. Ltd.',
      period: 'Feb 2023 – Present',
      location: 'Ahmedabad, Gujarat, India',
      devTitle: 'Senior Software Engineer, Team Lead',
      functionalTitle: 'Lead Odoo Functional Consultant & Project Lead',
      technologies: [
        'Odoo 14/15/16/17',
        'Python',
        'PostgreSQL',
        'ICICI Banking API',
        'Docker',
        'Linux',
        'QWeb Reports',
        'Git',
      ],
      devBullets: [
        'Architected & built complete Odoo Dealership product (4 groups, 700+ users): vehicle sales deals, hold amounts, gatepasses, and multi-branch accounting.',
        'Directed end-to-end Odoo solutions with clean, maintainable architecture and strict adherence to enterprise design patterns.',
        'Built Manufacturing modules: BOM, Work Order tracking, and automated production scheduling.',
        'Configured GSTR-1, GSTR-3B, Balance Sheet, and P&L reports compliant with Indian taxation laws.',
        'Led customization and technical enhancement of CRM, Sales, Inventory, Purchase, and Maintenance modules.',
        'Integrated ICICI banking API, payment gateways, E-Way Bill, and QR solutions for automated bank reconciliation.',
        'ORM query optimization, database indexing, and server performance tuning to eliminate bottlenecks under high concurrency.',
        'Designed PostgreSQL relational structures & complex ORM logic for high-volume transactions.',
        'Managed Docker deployments, Linux server configuration, Git workflows, and cloud server stability.',
        'Engineered Python automation scripts for synchronized price catalogue updates and third-party data pipelines.',
      ],
      functionalBullets: [
        'Led functional rollout of Dealership ERP across 4 groups (700+ users): vehicle sales deals, booking refunds, gatepasses, and multi-branch vouchers.',
        'Conducted thorough requirement analysis & mapped complex business rules to native and custom Odoo workflows across Sales, CRM, Inventory, Purchase, and Accounting.',
        'Configured GST accounting, multi-branch cash/bank voucher workflows, and automated bank reconciliation via ICICI API.',
        'Modeled manufacturing business flows: BOM creation, routing, work orders, and production scheduling.',
        'Created Standard Operating Procedures (SOPs), comprehensive user guides, and conducted in-depth training sessions for branch staff and accountants.',
        'Collaborated closely with C-suite stakeholders, branch managers, and engineering teams to guarantee on-time delivery with zero disruption to daily sales.',
      ],
    ),
    ExperienceItem(
      company: 'Geminate Consultancy Services',
      period: 'Nov 2022 – Jan 2023',
      location: 'Ahmedabad, Gujarat, India',
      devTitle: 'Python Developer Intern',
      functionalTitle: 'Functional Business Analyst Intern',
      technologies: [
        'Python',
        'Odoo Base',
        'PostgreSQL',
        'XML/QWeb',
        'Agile/Scrum',
      ],
      devBullets: [
        'Independently developed Odoo base modules emphasizing modularity, stability, and reusability across client instances.',
        'Contributed actively to Agile development sprints, code reviews, and Git version control workflows.',
        'Engineered unit test cases and assisted senior engineers in resolving legacy module conflicts during version migrations.',
      ],
      functionalBullets: [
        'Gathered and analyzed client business requirements, translating organizational needs into formal functional specification documents.',
        'Documented functional specifications, user stories, and acceptance criteria for ERP development sprints.',
        'Assisted in User Acceptance Testing (UAT), bug triage, and client onboarding sessions.',
        'Participated in sprint planning, retrospectives, and cross-functional alignment meetings.',
      ],
    ),
  ];

  // ──────────────────────── FLAGSHIP PRODUCT SECTION ──────────────────────
  static const String flagshipTitle = 'Automobile Dealership ERP';
  static const String flagshipSubtitle =
      'Comprehensive Multi-Branch Automotive Management Suite on Odoo';
  static const String flagshipDescription =
      'An enterprise ERP platform engineered to run end-to-end multi-branch automobile dealerships. '
      'From showroom vehicle booking and financier hold releases to gatepass issuance, GST tax invoicing, '
      'and automated ICICI bank reconciliation, this system handles the complete vehicle sales lifecycle.';

  static const List<String> flagshipBadges = [
    '4 Dealership Groups',
    '700+ Active Users',
    'Multi-Branch Architecture',
    'GST & E-Way Bill Ready',
    'ICICI 2-Way Bank Sync',
  ];

  static const List<FlagshipStep> flagshipSteps = [
    FlagshipStep(
      step: 1,
      title: 'Vehicle Deal',
      subtitle: 'Quotation & Vehicle Configuration',
      devNote:
          'Custom vehicle variant models with chassis/engine number tracking and automated price calculators.',
      functionalNote:
          'Customer inquiry capture, accessory bundling, exchange valuation, and initial sales agreement.',
      icon: FontAwesomeIcons.carSide,
    ),
    FlagshipStep(
      step: 2,
      title: 'Hold Amount',
      subtitle: 'Down Payment & Financier Holds',
      devNote:
          'Ledger hold locking mechanism preventing vehicle double-allocation until financer sanction.',
      functionalNote:
          'Financier hypothecation management, token hold receipts, and cancellation refund policies.',
      icon: FontAwesomeIcons.vault,
    ),
    FlagshipStep(
      step: 3,
      title: 'Booking & Refund',
      subtitle: 'Order Confirmation & Vouchers',
      devNote:
          'Automated receipt generation linked with bank journals and approval state machines.',
      functionalNote:
          'Down-payment receipt processing, branch-level voucher generation, and structured refund approvals.',
      icon: FontAwesomeIcons.receipt,
    ),
    FlagshipStep(
      step: 4,
      title: 'Gatepass Issuance',
      subtitle: 'Pre-Delivery Inspection (PDI) & Dispatch',
      devNote:
          'QR-code enabled security gatepass with instant validation against real-time payment status.',
      functionalNote:
          'Vehicle delivery checklists, insurance verification, registration documentation, and gate clearance.',
      icon: FontAwesomeIcons.idCard,
    ),
    FlagshipStep(
      step: 5,
      title: 'Multi-Branch Accounting',
      subtitle: 'Consolidated Ledgers & GST Invoicing',
      devNote:
          'Automated inter-branch debit/credit vouchers, multi-company record rules, and GSTR reporting tables.',
      functionalNote:
          'Branch P&L tracking, tax invoices with E-Way Bill, journal entries, and automated commission payouts.',
      icon: FontAwesomeIcons.chartLine,
    ),
    FlagshipStep(
      step: 6,
      title: 'Bank Reconciliation',
      subtitle: 'Direct ICICI Banking API Integration',
      devNote:
          'Secure webhook listeners, payload encryption, automated statement parsing, and batch reconcile jobs.',
      functionalNote:
          'Instant reconciliation of customer RTGS/NEFT/UPI deposits against outstanding dealership ledgers.',
      icon: FontAwesomeIcons.buildingColumns,
    ),
  ];

  // ──────────────────────── KEY SOLUTIONS SECTION ─────────────────────────
  static const List<SolutionItem> solutions = [
    // Developer Solutions
    SolutionItem(
      id: 'busy_tally_wizard',
      title: 'Busy / Tally Import Wizard',
      subtitle: 'High-Volume Financial Voucher Migration Engine',
      description:
          'Custom Python import engine architected to migrate hundreds of thousands of backdated financial vouchers from Busy and Tally into Odoo with strict transaction-date validation and balance integrity safeguards.',
      category: ProfileViewMode.developer,
      icon: FontAwesomeIcons.fileImport,
      badges: ['Python', 'PostgreSQL', 'Batch Processing', 'Data Integrity'],
      highlights: [
        'Strict transaction-date validation preserving chronological ledger accuracy',
        'Memory-optimized chunked batch parsing handling 100k+ records per session',
        'Automatic ledger balance verification before final database commit',
        'Comprehensive error-logging with rollback on critical discrepancies',
      ],
    ),
    SolutionItem(
      id: 'dynamic_security_rules',
      title: 'Dynamic Security Rules Engine',
      subtitle: 'Multi-Company & Branch-Level Access Control',
      description:
          'Dynamic multi-company record rules and granular permission layers designed to prevent data leakage between distinct dealership franchises sharing a single multi-tenant Odoo instance.',
      category: ProfileViewMode.developer,
      icon: FontAwesomeIcons.shieldHalved,
      badges: ['Odoo ORM', 'Record Rules', 'Multi-Tenancy', 'Security'],
      highlights: [
        'Dynamic domain evaluation based on user current company & branch context',
        'Field-level access control on cost price, margins, and customer contact info',
        'Eliminated cross-branch data leaks while preserving central HQ consolidated views',
        'Zero query overhead through indexed branch identification keys',
      ],
    ),
    SolutionItem(
      id: 'qweb_report_engine',
      title: 'Custom QWeb Report Engine',
      subtitle: 'Tax Invoices, Gatepasses & Payment Vouchers',
      description:
          'Modular QWeb templating system delivering pixel-perfect Tax Invoices, Delivery Challans, and Payment Vouchers featuring dynamic company branding, multi-page overflow control, and QR codes.',
      category: ProfileViewMode.developer,
      icon: FontAwesomeIcons.fileLines,
      badges: ['XML', 'QWeb', 'Wkhtmltopdf', 'Dynamic Templating'],
      highlights: [
        'Dynamic company branding, logo headers, and GST statutory disclosures',
        'Bilingual legal terms and conditions with dynamic branch footer details',
        'Embedded dynamic QR codes for E-Invoice and UPI payment scanning',
        'Optimized CSS layout ensuring consistent PDF output without page clipping',
      ],
    ),

    // Functional Solutions
    SolutionItem(
      id: 'multi_branch_accounting',
      title: 'Multi-Branch Dealership Accounting',
      subtitle: 'Decentralized Operations, Centralized Financial Control',
      description:
          'Comprehensive Chart of Accounts and voucher approval hierarchy customized for automotive retail. Enables branch accountants to handle everyday cash/bank vouchers while HQ maintains unified fiscal oversight.',
      category: ProfileViewMode.functional,
      icon: FontAwesomeIcons.scaleBalanced,
      badges: ['Accounting', 'Multi-Branch', 'Workflows', 'Internal Controls'],
      highlights: [
        'Automated inter-branch clearing accounts for vehicle inventory transfers',
        'Structured hold release journal entries synchronized with financier approvals',
        'Branch-wise Cash/Bank balance reconciliation and petty cash controls',
        'Real-time P&L and Balance Sheet segmentation by individual showroom location',
      ],
    ),
    SolutionItem(
      id: 'trade_in_scrappage',
      title: 'Trade-In & Scrappage Workflow',
      subtitle: 'Old Vehicle Valuation & Government Scrappage Incentives',
      description:
          'Streamlined workflow mapping for vehicle exchange deals, valuation inspections, trade-in pricing adjustments, and statutory government scrappage bonus policy claims.',
      category: ProfileViewMode.functional,
      icon: FontAwesomeIcons.repeat,
      badges: ['Automotive', 'Workflow Design', 'Appraisal', 'Govt Schemes'],
      highlights: [
        'Step-by-step 25-point evaluation checklist for pre-owned trade-in cars',
        'Automated adjustment of trade-in value against new vehicle quotation down payment',
        'Scrappage certificate documentation handling for state road tax rebate claims',
        'Inventory handover and refurbishing cost tracking integration',
      ],
    ),
    SolutionItem(
      id: 'data_migration_validation',
      title: 'Data Migration & Validation Framework',
      subtitle: 'Legacy Cleanup, Master Imports & Balance Verification',
      description:
          'End-to-end functional methodology for transitioning legacy dealership systems to Odoo without operational downtime, ensuring pristine opening balances and deduplicated customer records.',
      category: ProfileViewMode.functional,
      icon: FontAwesomeIcons.database,
      badges: ['Data Migration', 'UAT', 'Master Data', 'Change Management'],
      highlights: [
        'Customer and supplier master data deduplication and GSTIN validation',
        'Vehicle chassis master and spare-parts opening inventory physical audit alignment',
        'Trial balance reconciliation between legacy software and Odoo opening vouchers',
        'Structured change-management training ensuring smooth staff transition',
      ],
    ),
  ];

  // ──────────────────────────── SKILLS SECTION ────────────────────────────
  // Explicitly formatted as grouped chips/tags without fake percentages
  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      categoryName: 'Languages & Frameworks',
      icon: FontAwesomeIcons.code,
      skills: [
        'Python',
        'Odoo ORM (v14–v17)',
        'JavaScript',
        'SQL',
        'XML / QWeb',
        'HTML5 / CSS3',
      ],
    ),
    SkillGroup(
      categoryName: 'Backend & Databases',
      icon: FontAwesomeIcons.server,
      skills: [
        'PostgreSQL',
        'Database Indexing',
        'Query Optimization',
        'RESTful APIs',
        'JSON-RPC',
        'Webhooks',
      ],
    ),
    SkillGroup(
      categoryName: 'Tools & DevOps',
      icon: FontAwesomeIcons.screwdriverWrench,
      skills: [
        'Git & GitHub',
        'Linux Administration (Ubuntu)',
        'Docker & Containers',
        'Nginx Reverse Proxy',
        'Postman',
        'VS Code / PyCharm',
      ],
    ),
    SkillGroup(
      categoryName: 'Functional Domains',
      icon: FontAwesomeIcons.sitemap,
      skills: [
        'Automobile Dealership (DMS)',
        'Manufacturing & BOM',
        'Financial Accounting & Ledgers',
        'Inventory & Supply Chain',
        'Sales & CRM Pipelines',
        'Purchasing & Vendor Management',
      ],
    ),
    SkillGroup(
      categoryName: 'Statutory & Banking',
      icon: FontAwesomeIcons.indianRupeeSign,
      skills: [
        'GST Compliance (GSTR-1, GSTR-3B)',
        'E-Way Bill Generation',
        'ICICI Banking API Integration',
        'Automated Bank Reconciliation',
        'Multi-Branch Cash & Bank Vouchers',
        'E-Invoicing (NIC Portal)',
      ],
    ),
    SkillGroup(
      categoryName: 'Implementation & Leadership',
      icon: FontAwesomeIcons.userTie,
      skills: [
        'Requirement Analysis & Gap Fit',
        'Business Workflow Modeling',
        'User Acceptance Testing (UAT)',
        'SOPs & User Documentation',
        'End-User Training',
        'Technical Team Leadership',
      ],
    ),
  ];

  // ───────────────────────── CORE STRENGTHS ──────────────────────────────
  static const List<CoreStrength> coreStrengths = [
    CoreStrength(
      title: 'Technical Proficiency',
      subtitle: 'Odoo ORM & System Architecture',
      description:
          'Deep expertise in Python, Odoo ORM, and PostgreSQL. Proven ability to design scalable modular architectures, write clean maintainable code, and eliminate query bottlenecks in high-concurrency enterprise deployments.',
      icon: FontAwesomeIcons.microchip,
    ),
    CoreStrength(
      title: 'ERP Infrastructure',
      subtitle: 'Scalability & DevOps Security',
      description:
          'Comprehensive command over production Linux environments, Dockerized deployments, database failover configurations, multi-branch security rules, and third-party banking/statutory API pipelines.',
      icon: FontAwesomeIcons.networkWired,
    ),
    CoreStrength(
      title: 'Process Analysis',
      subtitle: 'Domain Mapping & Solution Design',
      description:
          'Adept at translating intricate automobile dealership, manufacturing, and multi-branch accounting workflows into frictionless ERP configurations, bridging functional business demands with technical engineering.',
      icon: FontAwesomeIcons.diagramProject,
    ),
    CoreStrength(
      title: 'Team Leadership',
      subtitle: 'Mentorship & On-Time Delivery',
      description:
          'Proven track record leading technical teams, orchestrating Agile sprints, establishing coding standards, mentoring junior engineers, and maintaining strong alignment with enterprise client stakeholders.',
      icon: FontAwesomeIcons.usersGear,
    ),
  ];

  // ─────────────────────── ODOO MARKETPLACE SECTION ───────────────────────
  static const String marketplaceTitle = 'Odoo Apps Store Contributions';
  static const String marketplaceSubtitle =
      'Publishing reusable community and enterprise modules';
  static const String marketplaceDescription =
      'Leveraging real-world business challenges from enterprise implementations to design, build, '
      'and publish robust reusable modules on the official Odoo Apps Store.';

  static const List<String> marketplaceHighlights = [
    'Designed and published reusable modules on the official Odoo Apps Store',
    'Transformed complex real-world client requirements into streamlined plug-and-play apps',
    'Provided prompt technical guidance and troubleshooting support to global Odoo users',
    'Maintained continuous version upgrades, documentation, and customer query resolution',
  ];

  // ──────────────────────── PERSONAL PROJECT SECTION ──────────────────────
  static const String projectName = 'New Vision Design';
  static const String projectSubtitle =
      'Comprehensive Service Portal for Home Reconstruction';

  static const String projectDevDescription =
      'Architected and implemented a high-performance service portal for residential renovation and reconstruction. '
      'Built a robust Python/Odoo backend with customized search and ranking algorithms, dynamic quoting calculators, '
      'and real-time project milestone tracking connected to customer dashboards.';

  static const String projectFunctionalDescription =
      'Formulated end-to-end functional workflow specifications for home reconstruction project lifecycles. '
      'Designed an intuitive customer service portal covering contractor bidding, material selection catalogues, '
      'staged milestone approvals, payment escrow releases, and inspection sign-offs.';

  static const List<String> projectDevTech = [
    'Python',
    'Odoo Backend',
    'PostgreSQL',
    'Search Algorithms',
    'REST APIs',
  ];

  static const List<String> projectFunctionalHighlights = [
    'Customer Portal Workflows',
    'Milestone Sign-Off Logic',
    'Contractor Bidding Rules',
    'Payment Schedule Triggers',
  ];

  // ──────────────────────────── CONTACT SECTION ───────────────────────────
  static const String contactTitle = 'Let\'s Discuss Your ERP Strategy';
  static const String contactSubtitle =
      'Available for full-time senior technical roles, solution architect engagements, and enterprise Odoo consulting.';

  static const String email = 'shahrutvik1399@gmail.com';
  static const String phone = '+91 7202080956';
  static const String phoneClean = '+917202080956';
  static const String linkedin =
      'https://www.linkedin.com/in/rutvik-shah-898b34208?';
  static const String github = 'https://github.com/Rutvik1399';
  static const String odooAppsUrl =
      'https://apps.odoo.com/apps/modules/browse?author=Rutvik%20Shah';

  static const String footerCopyright =
      '© 2026 Rutvik Shah. All rights reserved.';
  static const String footerTag = 'Built with Flutter Web';
}
