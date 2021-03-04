class Tweet
    attr_accessor :author, :content
    attr_reader :id

    def initialize(attributes = {})
        #binding.pry
        @id = attributes["id"]
        @author = attributes["author"]
        @content = attributes["content"]
    end

    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS tweets (
                id INTEGER PRIMARY KEY,
                author TEXT,
                content TEXT
            );
        SQL

        DB[:conn].execute(sql)
    end

    # save INSERT DATA
    def save
        # exists in my db, update record
        # binding.pry
        if self.class.find(@id)
            sql = <<-SQL
                UPDATE tweets
                SET content = ?, author = ?
                WHERE id = ?
            SQL

            DB[:conn].execute(sql, @content, @author, @id)
        # new record, doesn't exist in my db
        else
            sql = <<-SQL
                INSERT INTO tweets (author, content)
                VALUES (?, ?);
            SQL

            DB[:conn].execute(sql, @author, @content)
        end
        self
    end

    def self.create(attributes)
        new(attributes).save
    end

    # self.all
    def self.all
        sql = "SELECT * FROM tweets;"

        DB[:conn].execute(sql).map {|row| self.new(row)}
    end

    # find argument of id
    def self.find(arg)
        # binding.pry
        sql = "SELECT * FROM tweets WHERE id = ?;"

        tweet = DB[:conn].execute(sql, arg)[0]
        self.new(tweet) if tweet
    end
end