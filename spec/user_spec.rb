require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do

      user = User.create(username: 'pablo', email: 'pablo@email.com', password: 'password123')

      connection = PG.connect(dbname: 'makersbnb_test')
      result = connection.query("SELECT * FROM users;")

      expect(user).to be_a User
      expect(user.id).to eq result.first['id']
      expect(user.email).to eq 'pablo@email.com'
    end
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      user = User.create(username: 'pablo', email: 'pablo@email.com', password: 'password123')

      expect(User.find(nil)).to eq nil
    end

    it 'finds a user by ID' do
      user = User.create(username: 'pablo', email: 'test@example.com', password: 'password123')
      result = User.find(user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end
end
