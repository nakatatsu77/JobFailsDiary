module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :success then "bg-primary"
    when :danger  then "bg-error"
    else "bg-info"
    end
  end

  def default_meta_tags
    {
      site: "バイトやらかしにっき",
      title: "バイトやらかしにっき",
      reverse: true,
      separator: "|",
      charset: "utf-8",
      description: "職場でのやらかしエピソードを投稿するアプリです",
      canonical: "https://job-fails-diary.com/",
      og: {
        site_name: "バイトやらかしにっき",
        title: "バイトやらかしにっき",
        description: "職場でのやらかしエピソードを投稿するアプリです",
        type: "website",
        url: "https://job-fails-diary.com/",
        image: image_url("post_placeholder.png"),
        local: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        site: "@https://x.com/WebTatsuya0707",
        image: image_url("post_placeholder.png")
      }
    }
  end
end
