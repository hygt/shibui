// Authored by DeepSeek

#import "shibui.typ": *
#import "@preview/fontawesome:0.6.2": fa-icon

#let contact-icon(name, solid: false) = fa-icon(
  name,
  solid: solid,
  size: 10pt,
  top-edge: "baseline",
)

#set page(numbering: "1 / 1") // optional

#resume(
  name: "Elliot Alderson",
  role: "Cyber Security Engineer",
  contacts: (
    (icon: contact-icon("envelope"), text: "elliot@allsafe.example", link: "mailto:elliot@allsafe.example"),
    (icon: contact-icon("phone"), text: "+1 (201) 555-0147", link: "tel:+12015550147"),
    (icon: contact-icon("key"), text: "PGP 0xD34DB33F"),
    (icon: contact-icon("globe"), text: "whoismrrobot.com", link: "https://whoismrrobot.com"),
    (icon: contact-icon("home"), text: "New York, NY"),
  ),
)[
  #summary[
    Security engineer with eight years in offensive and defensive work, most of it done alone and at night.
    I find the holes other people have already signed off on, then write the tooling that closes them.
    No smartphone, no social media, no meetings before noon.
  ]

  #section("Employment")

  #job(
    "Cyber Security Engineer",
    company: "E Corp",
    location: "New York, NY",
    team: "Information Security",
    dates: "Jun 2015 – Present",
    body: [
      Endpoint and network security for a 400,000-employee conglomerate, on a team of eleven that I keep reassuring myself is not compromised.

      - Cut unresolved critical findings by 62% in the first year by automating triage and, where possible, deleting the software that generated them.
      - Built a Kafka and Elasticsearch correlation pipeline that brought mean time to detect from days down to eleven minutes.
      - Led the internal review of the 5/9 data loss. The findings were classified, unclassified, then reclassified. I kept a copy.
      - Wrote the "Assume Breach" training module; 11,000 employees completed it, four remembered it.
    ],
  )

  #job(
    "Cyber Security Engineer",
    company: "Allsafe Cybersecurity",
    location: "New York, NY",
    team: "Incident Response",
    dates: "Mar 2014 – Jun 2015",
    body: [
      Penetration tests, incident response, and client-facing reports for clients in finance, healthcare, and one conglomerate we should have declined.

      - Contained a 400 Gbps DDoS against a Fortune 500 client in under nine minutes; their CTO called it "a Tuesday."
      - Automated report generation, taking a four-hour deliverable down to twenty minutes and most of the meetings with it.
      - Maintained the firm's internal risk register, which is a polite name for a list of things nobody intended to fix.
      - Mentored two junior analysts in exploit development. Both are very good now, and one of them is slightly worried about me.
    ],
  )

  #job(
    "Network Technician",
    company: "Washington Township School District",
    location: "Washington Township, NJ",
    team: "IT Support",
    dates: "Jun 2007 – Feb 2010",
    body: [
      - Kept 400 Windows XP machines, three broken projectors, and one very patient librarian running.
      - Wrote a login script the district still uses, because nobody has been brave enough to replace it.
      - Dismantled and rebuilt every machine in the building at least once, including the ones that were working.
    ],
  )

  #pagebreak(weak: true)

  #section("Selected Work")

  #project(
    "fsociety",
    description: [
      Distributed intrusion framework. One payload, 71 million consumer debt records deleted, and one conglomerate briefly honest.
      The coalition declined credit; I take questions in person.
    ],
  )

  #project(
    "Steel Mountain",
    description: [
      Physical assessment, 2015. Entered through the climate control system and documented the building's single point of failure,
      which was also its only point of cooling.
    ],
  )

  #project(
    "Red Wheelbarrow",
    description: [
      Encrypted journal, three volumes, self-published, zero readers. Widely considered a doorstop; it is not.
    ],
  )

  #section("Education")

  #education(
    "GED",
    "State of New Jersey",
    location: "Trenton, NJ",
    dates: "2006",
  )

  #education(
    "Systems & cryptography",
    "Carnegie Mellon University (one semester)",
    location: "Pittsburgh, PA",
    dates: "2006 – 2007",
  )

  #section("Certifications")

  #skill("OSCP", "Offensive Security Certified Professional · 2013")
  #skill("GPEN", "GIAC Penetration Tester · 2012")
  #skill("CISSP", "Lapsed 2016, by choice. A certificate has never stopped an intrusion.")
  #skill("Clearance", "None. Several agencies would disagree.")

  #section("Skills")
  #skills-table(
    ("Offensive", "Defensive", "Engineering", "Tooling", "Languages"),
    widths: (1.25fr, 1.15fr, 1fr, 1fr, 0.9fr),
    (
      ("Penetration testing", "Incident response", "Python", "Metasploit", "English"),
      ("Exploit development", "Digital forensics", "C", "Nmap", none),
      ("Social engineering", "Threat hunting", "Ruby", "Burp Suite", none),
      ("Physical access", "Malware analysis", "Bash", "Wireshark", none),
    )
  )

  #section("Notes")

  #skill("Availability", "Nights and weekends. Most weeks that is when the interesting traffic is.")
  #skill("References", "Three, all of whom will tell you I am difficult and correct.")
  #skill("Constraints", "No smartphone, no social media, no client data outside the building. Ask before adding me to a group chat.")
]
