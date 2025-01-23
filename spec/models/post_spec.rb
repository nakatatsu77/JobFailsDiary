require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      post = build(:post)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end
    it "bodyがない場合にバリデーションが機能してinvalidになるか" do
      post_without_body = build(:post, body: "")
      expect(post_without_body).to be_invalid
      expect(post_without_body.errors[:body]).to eq [ "を入力してください" ]
    end
    it "bodyが65536文字以上の場合にバリデーションが機能してinvalidになるか" do
      post = build(:post, body: 'a' * 65536)
      expect(post).to be_invalid
      expect(post.errors[:body]).to eq [ "は65535文字以内で入力してください" ]
    end
  end
end
