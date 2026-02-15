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

# --- BLOG ARTICLES ---
Blog.destroy_all

Blog.create!(
  title: "Deep Dive into Rails ActiveRecord Query Optimization",
  excerpt: "Learn how to identify and fix N+1 queries, leverage eager loading strategies, and use database indexes effectively to achieve 10x performance improvements.",
  content: "Rails provides a powerful ORM in ActiveRecord, but it can become a bottleneck if not used correctly. In this comprehensive guide, we'll explore advanced techniques for optimizing your database queries.

## The N+1 Query Problem

The most common performance issue in Rails applications is the 'N+1' query problem. This occurs when loading a collection of records and then querying for associated data within a loop.

Bad: users = User.all; users.each { |user| puts user.posts.count } # One query per user!

Good: users = User.includes(:posts).all; users.each { |user| puts user.posts.count } # No additional queries

## Using Indexes Effectively

Database indexes are crucial for query performance. They work like the index in a book—they allow the database to find data without scanning every record.

Always index foreign keys, columns used in WHERE clauses, and columns used in JOIN conditions. Monitor slow queries with Rails' query logs and database analysis tools.

## Indexing Strategy

Add indexes to your migrations using add_index. For composite queries, use multi-column indexes. Remember that indexes improve read performance but slightly slow down writes.

## Eager Loading Techniques

ActiveRecord provides several ways to eager load associations: includes, eager_load, and preload. Each has different use cases and performance characteristics depending on your query patterns.

## Conclusion

By applying these optimization techniques consistently, you can dramatically improve your Rails application's performance and provide better user experiences.",
  category: "Performance",
  tags: "Rails, ActiveRecord, PostgreSQL, Performance",
  published: true,
  view_count: 2847
)

Blog.create!(
  title: "Implementing Domain-Driven Design in Rails Applications",
  excerpt: "A practical guide to structuring complex Rails applications using DDD principles. Learn how to identify bounded contexts, create value objects, and implement aggregates.",
  content: "Domain-Driven Design (DDD) is a powerful approach to software development that emphasizes understanding the business domain. When applied thoughtfully to Rails applications, it can significantly improve code organization and maintainability.

## Understanding Bounded Contexts

A bounded context is a clearly defined boundary within which a particular model is valid and applicable. It separates different domains from each other.

In a typical e-commerce application, you might have separate bounded contexts for Product Catalog, Inventory, Orders, and Payments. Each context has its own models, validations, and business rules.

## Value Objects in Rails

Value Objects are immutable objects that represent a value in your domain. Unlike entities, they don't have an identity and are compared by their attributes.

Example: class Money with attributes for amount and currency enforces business rules about money.

## Implementing Aggregates

Aggregates are clusters of objects that act as a single unit. They enforce business rules and consistency boundaries. In Rails, you typically map aggregates to models.

An Order aggregate might contain Order Lines, Shipping Address, and Billing Address. The Order is the root aggregate that ensures consistency.

## Repository Pattern

Use repositories to abstract data persistence. Instead of calling ActiveRecord directly, inject repository dependencies into your domain objects.

By understanding these DDD concepts, you can build Rails applications that are more maintainable, testable, and aligned with your business domain.",
  category: "Architecture",
  tags: "DDD, Rails, Clean Architecture, Domain Design",
  published: true,
  view_count: 1923
)

Blog.create!(
  title: "Building Real-Time Features with Hotwire and ActionCable",
  excerpt: "Step-by-step tutorial on implementing live updates, notifications, and collaborative features using modern Rails technologies.",
  content: "Hotwire makes it easy to build modern, fast web applications with HTML over the wire. Combined with ActionCable, you can create real-time features that feel responsive and engaging.

## Getting Started with Turbo Streams

Turbo Streams allow you to broadcast HTML updates to multiple clients in real-time. This is perfect for notifications, live comments, or collaborative features.

Add turbo_stream_from method to your view to subscribe to broadcasts. Then use broadcast_to in your model to send updates.

## ActionCable Channels

ActionCable provides a framework for working with WebSockets in Rails. Channels are the highest level of organization in ActionCable.

Channels handle subscriptions and can broadcast messages to all connected clients. They make real-time communication feel natural and Rails-like.

## Real-World Example

Building a collaborative editor requires syncing changes across multiple clients. With Hotwire and ActionCable, this becomes straightforward and performant.

Users can see each other's edits in real-time without page refreshes. The server handles conflict resolution and persistence.

## Integration with Forms

Turbo forms automatically handle error cases and nested attributes. This makes building complex forms with real-time validation straightforward.

By mastering these technologies, you can build Rails applications that provide a modern, real-time user experience.",
  category: "Tutorial",
  tags: "Hotwire, Turbo, ActionCable, Real-time",
  published: true,
  view_count: 1543
)

Blog.create!(
  title: "Mastering Ruby Metaprogramming: A Practical Guide",
  excerpt: "Explore the power of Ruby's metaprogramming capabilities with real-world examples. Learn when to use these advanced techniques.",
  content: "Ruby's metaprogramming capabilities are both powerful and dangerous. This guide walks you through practical examples and best practices.

## Method Missing

method_missing is called when an object receives a message it doesn't know how to respond to. This is useful for creating flexible APIs.

Use it to create dynamic method handling for attributes or database columns that don't exist as Ruby methods.

## Define Method

define_method allows you to create methods dynamically at runtime. This is useful for generating accessor methods or building DSLs.

Example: Loop through an array of attribute names and create getter methods for each one dynamically.

## Metaprogramming Best Practices

1. Use modules and concerns for sharing behavior
2. Avoid metaprogramming for simple tasks
3. Always provide clear documentation
4. Test thoroughly
5. Consider performance implications
6. Prefer explicit over implicit
7. Document the metaprogramming clearly

## Common Use Cases

Metaprogramming is great for building DSLs, creating flexible APIs, and reducing boilerplate code. But it can make code harder to understand.

When used wisely, metaprogramming can greatly enhance code expressiveness and reduce duplication without sacrificing readability.",
  category: "Deep-Dive",
  tags: "Ruby, Metaprogramming, Advanced",
  published: true,
  view_count: 987
)

Blog.create!(
  title: "Testing Strategies for Complex Rails Applications",
  excerpt: "A comprehensive look at testing strategies including unit tests, integration tests, and system tests for robust Rails applications.",
  content: "Testing is crucial for building reliable Rails applications. This guide covers different testing strategies and when to use each one.

## Unit Testing Models

Model tests verify business logic in isolation. They're fast and focused on a single concern.

Test validations, associations, callbacks, and custom methods. Use factories to create test data that's easy to maintain and reason about.

## Integration Testing Controllers

Integration tests verify how multiple components work together. They're slower but catch real-world issues.

Test the full request/response cycle. Verify that controllers properly instantiate models, render views, and handle errors.

## System Testing

System tests simulate user behavior with a browser. They're the slowest but catch UI/UX issues that unit and integration tests might miss.

Use them sparingly for critical user journeys. They're valuable for testing JavaScript interactions and real browser compatibility.

## Testing Best Practices

1. Follow the testing pyramid: many unit tests, fewer integration tests, few system tests
2. Test behavior, not implementation
3. Use fixtures or factories for consistent test data
4. Keep tests focused and readable
5. Aim for 80% code coverage
6. Make failing tests informative
7. Test both happy path and sad path

## Continuous Integration

Use CI/CD pipelines to run tests on every commit. This catches regressions early and ensures code quality.

By implementing a comprehensive testing strategy, you can confidently refactor and deploy your Rails applications.",
  category: "Testing",
  tags: "RSpec, TDD, Testing, Quality",
  published: false,
  view_count: 0
)

puts "Blog articles créés avec succès !"
