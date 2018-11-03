class CreateFirstPost < ActiveRecord::Migration
  def change
    title = 'Hello, World!'

    reversible do |dir|
      dir.up do
        Post.create!(
          title: title,
          content: ["I'm unemployed! I left my job as Director of Engineering "\
          "at [Thinkful](https://www.thinkful.com) last week, and I've been taking a break to relax, hike, "\
          "learn, and most importantly, make things. For the last 3.5 years, I've "\
          "been spending most of my engineering hours mending the [Bloc app](https://www.bloc.io) "\
          "and now it's time to built some new things from scratch. Expect to see web apps, mobile apps, "\
          "crafts, recipes, decorations, etc.",
          "I'm going to blog about my time off here at [meganmarie.io](meganmarie.io). This blog is built "\
          "with a quick Ruby (2.4.0) on Rails (5.0.2) implementation. More to come."].join("\n\n")
        )
      end

      dir.down do
        Post.find_by(title: title).destroy!
      end
    end
  end
end
