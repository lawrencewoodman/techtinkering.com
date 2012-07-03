require 'liquid'

module TagDirFilter

  # Return Tag directory for a tag
  def tag_dir(tag)
    tag.to_s.gsub(/[^[:alnum:]_-]/, '').downcase
  end

end

Liquid::Template.register_filter(TagDirFilter)
