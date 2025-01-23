require 'rails_helper'

RSpec.describe Image, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      image = build(:image)
      expect(image).to be_valid
      expect(image.errors).to be_empty
    end
  end

  describe "画像の関連付けに関するテスト" do
    it "postとの関連付けが正しく設定されていること" do
      image = build(:image)
      expect(image.post).to be_present
    end

    it "userとの関連付けが正しく設定されていること" do
      image = build(:image)
      expect(image.user).to be_present
    end
  end

  describe "依存関係の削除" do
    it "postが削除されると、関連するimageも削除されるか" do
      post = create(:post)
      image = create(:image, post: post)
      expect { post.destroy }.to change { Image.count }.by(-1)
    end
  end
end
