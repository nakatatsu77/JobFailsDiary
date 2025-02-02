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
      charset: "utf-8",
      description: "職場でのやらかしエピソードを投稿するアプリです",
      canonical: request.original_url,
      og: {
        site_name: "バイトやらかしにっき",
        title: "バイトやらかしにっき",
        description: "職場でのやらかしエピソードを投稿するアプリです",
        type: "website",
        url: request.original_url,
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
