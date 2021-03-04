class Seed
    def self.seed_data
        10.times do
            Tweet.new({
                "content" => Faker::TvShows::MichaelScott.quote,
                "author" => "Michael Scott"
            }).save
        end

        10.times do
            Tweet.new({
                "content" => Faker::Quote.yoda,
                "author" => "Yoda"
            }).save
        end
    end
end