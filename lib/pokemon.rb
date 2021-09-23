class Pokemon
    attr_accessor :name, :type
    attr_reader :id, :db

    def initialize name:, type:, id: nil, db:
        @name = name
        @type = type
        @id = id
        @db = db
    end

    def self.save name, type, db
        sql = "INSERT INTO pokemon (name, type)
            VALUES (?, ?);"
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find id, db
        sql = "SELECT * FROM pokemon WHERE id = ?;"
        poke_data = db.execute(sql, id)[0]
        Pokemon.new(id: poke_data[0], name: poke_data[1], type: poke_data[2], db: db)
    end
end