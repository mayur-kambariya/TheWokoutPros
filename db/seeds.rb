# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    Category.find_or_create_by(community_id: 1, sort_priority: 1, url: 'miscellaneous')
    Category.find_or_create_by(community_id: 1, sort_priority: 1, url: 'supplements')
    Category.find_or_create_by(community_id: 1, sort_priority: 1, url: 'workout-slash-nutrition-plan')
    Category.find_or_create_by(community_id: 1, sort_priority: 1, url: 'nutrition-plan-only')
    Category.find_or_create_by(community_id: 1, sort_priority: 1, url: 'workout-plan-only')

    ListingShape.find_or_create_by(community_id: 1, name: 'offering-without-online-payment')
    ListingShape.find_or_create_by(community_id: 1, name: 'offering-with-online-payment')
    ListingShape.find_or_create_by(community_id: 1, name: 'request-info')

    CustomFieldOptionTitle.find_or_create_by(value: 'One Time Plan', user_id: 2)
    CustomFieldOptionTitle.find_or_create_by(value: 'Monthly Plan', user_id: 2)
    CustomFieldOptionTitle.find_or_create_by(value: '3 Month Plan', user_id: 2)
    CustomFieldOptionTitle.find_or_create_by(value: 'Yearly Plan', user_id: 2)
