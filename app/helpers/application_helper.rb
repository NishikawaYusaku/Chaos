module ApplicationHelper
  def page_title(title)
    base_title = 'にゅーぶい！'
    title.empty? ? base_title : title + " - " + base_title
  end

  def show_meta_tags
    assign_meta_tags if display_meta_tags.blank?
    display_meta_tags
  end

  def default_meta_tags
    {
      site: 'にゅーぶい！',
      title: 'VTuberの発見と布教が出来るサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'あなたのまだ知らない好みにあったVTuberに出会うことが出来ます。',
      keywords: 'VTuber,推し,配信',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@NewVtuber_info',
      }
    }
  end
  
  def assign_meta_tags(options = {})
    defaults = default_meta_tags
    options.reverse_merge!(defaults)
    site = options[:site]
    title = options[:title]
    description = options[:description]
    keywords = options[:keywords]
    image = options[:image].presence || image_url('ogp.png')
    configs = {
      separator: '|',
      reverse: true,
      site:,
      title:,
      description:,
      keywords:,
      canonical: request.original_url,
      icon: {
        href: image_url('ogp.png')
      },
      og: {
        type: 'website',
        title: title.presence || site,
        description:,
        url: request.original_url,
        image:,
        site_name: site
      },
      twitter: {
        site:,
        card: 'summary_large_image',
        image:
      }
    }
    set_meta_tags(configs)
  end
end
