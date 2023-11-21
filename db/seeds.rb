# Define users
john_doe = User.create(name: 'John Doe', email: 'user1@example.com', password: '@Password1')
jane_doe = User.create(name: 'Jane Doe', email: 'user2@example.com', password: '@Password1')

# Create groups
group1 = Group.create(name: 'Group 1', icon: 'https://avatars.githubusercontent.com/u/130570844?s=40&v=4', user: john_doe)
group2 = Group.create(name: 'Group 2', icon: 'https://avatars.githubusercontent.com/u/130570844?s=40&v=4', user: jane_doe)

# Create payments associated with groups
Payment.create(name: 'Payment for Group 1 - 1', amount: 50.25, author: john_doe, groups: [group1])
Payment.create(name: 'Payment for Group 2 - 1', amount: 75.50, author: jane_doe, groups: [group2])
