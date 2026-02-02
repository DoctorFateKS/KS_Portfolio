Project.destroy_all

# --- SHAREFRIENDS ---
share_friends = Project.create!(
  title: "ShareFriends",
  tagline: "Recréer du lien social par l'affinité : la plateforme qui combat l'isolement.",
  context: "L'isolement social touche des millions de personnes. Les applications actuelles privilégient l'apparence ou le dating. ShareFriends a été conçu pour offrir un espace sécurisé où le matching par centres d'intérêt permet de créer des amitiés authentiques et durables.",
  role_description: "Fullstack",
  stack: "Ruby, Ruby on Rails, PostgreSQL, Hotwire, Action Cable, Heroku",
  usage_decisions: "Conception de l'algorithme de matching affinitaire; Design de l'interface utilisateur (UI/UX) inclusive; Développement de la messagerie temps réel",
  challenges: "Garantir la sécurité des utilisateurs vulnérables; Maintenir une latence faible sur les salons de groupe",
  solutions: "Pundit : Pour une gestion granulaire des autorisations; ActionCable pour gérer les messages simultanés",
  impact_quote: "ShareFriends a été développé en tant que projet final pour Le Wagon. Ce fut une très bonne première experience dans le développement d'applications en équipe.",
  github_url: "https://github.com/DoctorFateKS/Sharefriends",
  demo_url: "https://www.youtube.com/watch?v=_X8sagC3y8U",
  featured: true,
  status: "Mis en avant"
)

path_sf = Rails.root.join("app/assets/images/sharefriends.jpg")
if File.exist?(path_sf)
  share_friends.banner.attach(io: File.open(path_sf), filename: "sharefriends.jpg", content_type: "image/jpeg")
end

# --- SKILLEN ---
skillen = Project.create!( # On stocke le projet dans la variable 'skillen'
  title: "SkillEn",
  tagline: "L'emploi par la compétence : connectez votre potentiel aux opportunités réelles.",
  context: "Le marché de l'emploi est souvent saturé d'offres illisibles. SkillEn automatise l'analyse des offres de France Travail pour proposer un matching basé sur le savoir-faire.",
  role_description: "Fullstack",
  stack: "Ruby on Rails, PostgreSQL, API France Travail, Nokogiri / Regex, Sidekiq, Hotwire",
  usage_decisions: "Intégration API France Travail; Moteur d'extraction; Scoring de compatibilité",
  challenges: "Extraire des mots-clés pertinents; Gérer les limites de requêtes API",
  solutions: "Analyse textuelle Regex; Mise en cache ActiveJob",
  impact_quote: "SkillEn est un projet ambitieux qui lie l'analyse de données à l'expérience utilisateur.",
  featured: true,
  status: "En développement"
)

path_sk = Rails.root.join("app/assets/images/skillen3.jpg")
if File.exist?(path_sk)
  skillen.banner.attach(io: File.open(path_sk), filename: "skillen3.jpg", content_type: "image/jpeg")
end

puts "Projets créés avec succès !"
