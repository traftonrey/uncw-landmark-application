class Site {
  const Site(
      {required this.name, required this.description, required this.reference});

  final String name;
  final String description;
  final String reference;
}

final List<Site> sites = [
  const Site(
    name: "Cogdon Hall",
    description:
        "Cogdon Hall hosts the computer science department and Management Information Systems program of the Cameron School of Business.",
    reference: "CIS",
  ),
  const Site(
    name: "Dobo Hall",
    description:
        "Dobo Hall hosts the Marine Biology, Biology, Chemistry, and Biochemistry departments",
    reference: "dobo_hall",
  ),
  const Site(
    name: "Fisher Student Center",
    description:
        "Fisher student center hosts campus actvities and involvement centers",
    reference: "fisher_student_center",
  ),
];
