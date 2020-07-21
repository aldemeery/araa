# Araa

Capstone Project of the Ruby on Rails Curriculum in Microverse.

The project consisted of creating an MVP of an app that works similar to Twitter. With the implementation of the following functionalities:

- Users log in only with username (proper authentication was not a requirement).
- Before a user logs in they can only see the Log in/Sign up page.
- When they log in they have full access to the app.
- Users can post tweets.
- Users can follow other users.
- Users can unfollow other users.
- Users can add a profile photo and a profile cover image
- They must upload the images while signing up.
- The app is an MVP of the full product - with the full graphical design, but only basic features that can be extended in the future.

The Live Version - [Araa](https://araa-app.herokuapp.com/signup)

Design: [Twitter Redesign](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details), by [Gregoire Vella](https://www.behance.net/gregoirevella)

## Home page

![Homepage](/screenshots/homepage.png?raw=true "Homepage")

## Profile page

![Profile page](/screenshots/profile.png?raw=true "Profile page")

## Built With

- Ruby (version 2.6.4)
- Ruby on Rails (version 5.2.4)

- Gems
  - gem 'pg'
  - gem 'rspec'
  - gem 'carrierwave'

## Usage

Clone the repository to your machine and cd into the directory

```
$ git clone https://github.com/aldemeery/araa.git
$ cd araa
$ rails db:migrate
```

Use the following command to start the rails server then visit: http://localhost:3000 to use the app

```
$ rails s
```

Run RSpec tests

```
$ rails db:migrate RAILS_ENV=test
$ bundle exec rspec
```

## N+1 Problem

In the application, each User has a collection of Followings objects (database rows). In other words, User → Following is a one-to-many relationship.
And then each Following has a User who is being followed by a given User.

Now, when presenting a user information along with people they follow, the naive implementation would do the following:

```sql
SELECT * FROM followings WHERE follower_id = ?
```

And then for each Following:

```sql
SELECT * FROM users WHERE id = ?;
```

In other words, you have one select for the Followings, and then N additional selects, where N is the total number of other users followed.

Rails solves this by performing **Eager Loading** on associations, and example of this in the application is in the `users_controller.rb`

```ruby
def show
  @user = User.includes(followers: :follower, followings: :followed).find(@user.id)
  # ...
end
```

## Authors

👤 **Osama Aldemeery**

- Github: [@aldemeery](https://github.com/aldemeery)
- Linkedin: [osamaaldemeery](https://linkedin.com/in/osamaaldemeery)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/aldemeery/araa/issues).

## Acknowledgments

- [Microverse](https://www.microverse.org/)
- [Gregoire Vella](https://www.behance.net/gregoirevella)
