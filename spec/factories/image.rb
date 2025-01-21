FactoryBot.define do
  factory :image do
    # デフォルトのimage_urlには仮のファイルを設定
    image_url { Rack::Test::UploadedFile.new(Rails.root.join("app/assets/images/post_placeholder.png"), "image/png") }
    association :post
    association :user, factory: :user
  end
end
