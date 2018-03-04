require "rails_helper"

describe User do
  describe "#password=" do
    example "文字列を与えると、hashed_passwordは長さ60の文字列になる" do
      user = User.new
      user.password = "dummy"
      expect(user.hashed_password).to be_kind_of(String)
      expect(user.hashed_password.size).to eq(60)
    end

    example "nilを与えると、hashed_passwordはnilになる" do
      user = User.new
      user.password = nil
      expect(user.hashed_password).to be_nil
    end
  end
end
