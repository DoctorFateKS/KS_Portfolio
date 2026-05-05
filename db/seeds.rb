Project.destroy_all

Project.create(
  title: "SkillEngine (en cours de développement)",
  role_jp: "フリーランス",
  role_description: "Freelance",
  github_url: "https://github.com/DoctorFateKS/SkillEn",
  demo_url: "#",
  tagline: "SaaS visant à faciliter la recherche d’emploi dans la tech en récupérant les skills dans les offres d’emplois pour les comparer à ceux des utilisateurs et offrir un score de compatibilité.",
  challenges: "Ambition de devenir l’outil référence de la recherche d’emploi en France.",
  stack: "Ruby, Ruby on Rails, API France Travail, Natural Language Processing",
  results: "Bientôt en production"
)

Project.create(
  title: "KS Portfolio",
  role_jp: "個人プロジェクト",
  role_description: "Projet Personnel",
  github_url: "https://github.com/DoctorFateKS/KS_Portfolio",
  demo_url: "https://kevinsaison.com/",
  tagline: "Application Ruby on Rails pour mettre en avant mes compétences, mes projets et mes écrits.",
  challenges: "Augmentation des prises de contact et de la visibilité.",
  stack: "Ruby, Ruby on Rails, Kamal, Docker, Serveur Hetzner",
  results: "Skills, Projets, Blog"
)

Project.create(
  title: "Sharefriends",
  role_jp: "主任開発者",
  role_description: "Lead Developer",
  github_url: "https://github.com/DoctorFateKS/Sharefriends",
  demo_url: "#",
  tagline: "Sharefriends est une application Ruby on Rails de rencontre amical basée sur les centres d’intérêts communs.",
  challenges: "Matching par centre d'intérêt – Un algorithme qui suggère des activités et des profils en fonction des passions",
  stack: "Ruby, Ruby on Rails, Hotwire, ActionCable",
  results: "Matching par centre d'intérêt, Messagerie temps-réél"
)

puts "Projets créé !"

Blog.destroy_all
