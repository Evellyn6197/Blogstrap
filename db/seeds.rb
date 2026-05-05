Article.delete_all

user = User.first
text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."

p 'Iniciando ...'
    Category.all.each do | category |
        30.times do
            Article.create!(
                title: "Article #{rand(10000)}",
                body: text,
                category_id: category.id,
                user_id: user.id,
                created_at: rand(365).days.ago
            )
        end
    end
p 'Terminou ...'
